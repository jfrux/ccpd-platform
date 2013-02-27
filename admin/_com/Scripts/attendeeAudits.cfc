<cfcomponent displayname="Attendee Audits">
	<cffunction name="assessCounts" access="remote" output="yes">
		<cfquery name="qData" datasource="#application.settings.dsn#">
			WITH CTE_Stats AS (
				SELECT
					Att.AttendeeID,
					Att.ActivityID,
					Att.PersonID,
					/* TOTAL EVALS FOR ACTIVITY */
					ActivityEvals = (
									SELECT 
										COUNT(PubComponentID) AS EvalCount
									FROM ce_Activity_PubComponent
									WHERE     
										(ActivityID = A.activityId) AND 
										(ComponentID = 5) AND 
										(DeletedFlag='N')),
					
					/* TOTAL POST TESTS FOR ACTIVITY */
					ActivityPostTests = (SELECT     COUNT(PubComponentID) AS PostTestCount
										FROM         ce_Activity_PubComponent
										WHERE     (ActivityID = A.activityId) AND (ComponentID = 11) AND DeletedFlag='N'),
					
					/* TOTAL POST TEST RESULTS FOR ATTENDEE */
					PostTestResults = (SELECT     count(APC.AssessmentID)
										FROM         ce_Activity_PubComponent AS APC INNER JOIN
															  ce_AssessResult AS AR ON AR.AssessmentID = APC.AssessmentID
										WHERE     (APC.ComponentID=11) AND (APC.DeletedFlag = 'N') AND (AR.ResultStatusID = 1) AND (AR.DeletedFlag = 'N') AND (APC.ActivityID = A.ActivityID) AND (AR.PersonID=Att.PersonID)),
					
					/* TOTAL EVAL RESULTS FOR ATTENDEE */
					EvalResults = (SELECT     count(APC.AssessmentID)
									FROM         ce_Activity_PubComponent AS APC INNER JOIN
														  ce_AssessResult AS AR ON AR.AssessmentID = APC.AssessmentID
									WHERE     (APC.ComponentID=5) AND (APC.DeletedFlag = 'N') AND (AR.ResultStatusID = 1) AND (AR.DeletedFlag = 'N') AND (APC.ActivityID = A.ActivityID) AND (AR.PersonID=Att.PersonID))
					FROM          
					ce_Attendee AS Att 
				INNER JOIN
					ce_Activity AS A ON Att.ActivityID = A.ActivityID
				WHERE      
					(A.StatusID IN (1, 2, 3)) and
					(Att.StatusID IN (2)) AND  
					(A.ActivityTypeID = 2) AND 
					(A.DeletedFlag = 'N')
			),CTE_StatsTotaled AS (
				SELECT 
					AttendeeID,
					ActivityID,
					PersonID,
					ActivityEvals,
					ActivityPostTests,
					PostTestResults,
					EvalResults,
					
					TotalAssess = ActivityEvals + ActivityPostTests,
					TotalResults = PostTestResults + EvalResults,
					
					TotalMissing = (ActivityEvals + ActivityPostTests)-(PostTestResults + EvalResults)
				FROM CTE_Stats
			) 
			SELECT Act.ActivityID,Act.Title,Per.DisplayName,Att.completeDate,Att.created,AttStat.*
			FROM 
				CTE_StatsTotaled AS AttStat 
			INNER JOIN 
				ce_Activity As Act ON Act.activityId = AttStat.ActivityID
			INNER JOIN 
				ce_Person As Per ON Per.personId = AttStat.personId 
			INNER JOIN 
				ce_Attendee As Att ON Att.attendeeId = AttStat.attendeeId 
			WHERE 
				TotalMissing = 0
		</cfquery>
		
		
		<cfloop query="qData">
			<cfquery name="qUpdate" datasource="#application.settings.dsn#">
				UPDATE ce_Attendee SET statusId=1,completeDate=#createODBCDateTime(qData.created)#,updated=#createODBCdateTime(now())#,updatedBy=169841
				WHERE attendeeId=<cfqueryparam value="#qData.attendeeId#" cfsqltype="cf_sql_integer" />
			</cfquery>
			<!---
			<cfset application.email.send(EmailStyleID=5,ToAttendeeID=qData.attendeeId,ToActivityID=qData.activityId,ToPersonID=qData.personId,ToCreditID=1) />--->
		</cfloop>
		done.
		<cfdump var="#qData#"><cfabort>
	</cffunction>
	
	<cffunction name="assessCompleter" access="remote" output="yes">
		<cfquery name="qData" datasource="#application.settings.dsn#">
			DECLARE @unanswerThreshold int;
			
			SET @unanswerThreshold = 10;
			
			WITH CTE_Attendees AS (
				SELECT 
					att.AttendeeID,
					att.ActivityID,
					Per.DisplayName,
					act.Title,
					att.PersonID,
					Result.ResultID,
					Assess.assessmentId,
					Comp.Name As AssessType,
					Result.ResultStatusId,
					Result.created As AssessStartDate,
					ARS.Name As ResultStatus
				FROM ce_Attendee AS Att
				INNER JOIN ce_Activity AS Act ON Att.ActivityID=Act.ActivityID
				INNER JOIN ce_Person AS Per ON Per.personId=Att.personId
				INNER JOIN ce_Activity_PubComponent AS Assess ON Assess.ActivityID=Att.ActivityID AND Assess.ComponentID IN (5,11)
				INNER JOIN ce_Sys_Component AS Comp ON Comp.ComponentID=Assess.ComponentID
				INNER JOIN ce_AssessResult AS Result ON Result.AssessmentID=Assess.AssessmentID AND Result.PersonID=Att.PersonID
				INNER JOIN ce_Sys_AssessResultStatus AS ARS ON ARS.ResultStatusID=Result.ResultStatusID
				WHERE 
				Att.StatusID=2 AND 
				Act.StatusID IN (1,2,3) AND 
				Result.ResultStatusID NOT IN (1,3,5) AND /* Don't care if they completed, passed, or failed */
				Act.ActivityTypeID=2 AND 
				Att.DeletedFlag='N' AND
				Act.DeletedFlag='N'
			), 
			
			/* SUB TOTALS */
			CTE_Stats AS (
				SELECT 
					Atts.*,
			
					TotalRequiredQ = (SELECT Count(Q.QuestionID) FROM ce_AssessQuestion AS Q WHERE (Q.QuestionTypeID NOT IN (5, 6, 7)) AND Q.AssessmentID=Atts.AssessmentID AND Q.RequiredFlag='Y' AND Q.DeletedFlag='N'),
					TotalAnsweredQ = (SELECT Count(A.AnswerID) FROM ce_AssessQuestion AS Q INNER JOIN ce_AssessAnswer AS A ON A.QuestionID=Q.QuestionID WHERE (Q.QuestionTypeID NOT IN (5, 6, 7)) AND Q.AssessmentID=Atts.AssessmentID AND Q.RequiredFlag='Y' AND Q.DeletedFlag='N' AND A.ResultID=Atts.ResultID AND  A.DeletedFlag='N')
				FROM 
				CTE_Attendees AS Atts
			), CTE_Totals AS (
			
			/* TOTALS */		
			SELECT 
				ActivityID,
				ResultID,
				Title,
				PersonID,
				DisplayName,
				AssessType = CASE 
				WHEN AssessType = 'Assessment (Post)' THEN 'Post Test'
				WHEN AssessType = 'Assessment (Eval)' THEN 'Survey'
				END,ResultStatus,
				ResultInProgressDate = AssessStartDate,
				TotalRequiredQ As TotalQuestions,
				TotalAnsweredQ As TotalAnswered,
				TotalUnanswered = (TotalRequiredQ-TotalAnsweredQ) ,
				TotalPercUnanswered = CASE 
				WHEN TotalAnsweredQ > 0 THEN
					((convert(numeric(5,2),(TotalAnsweredQ))/convert(numeric(5,2),TotalRequiredQ))*100)
				ELSE
					0.0
				END,
				AssessStartDate
			FROM CTE_Stats AS Atts) 
			
				/* THRESHOLD FILTER */
				SELECT * FROM CTE_Totals
				WHERE 
				TotalPercUnanswered >= @unanswerThreshold AND AssessType='Survey'
				ORDER BY AssessType DESC,TotalPercUnanswered DESC,Title,ResultInProgressDate
		</cfquery>
		
		
		<cfloop query="qData">
			<cfquery name="qUpdate" datasource="#application.settings.dsn#">
				UPDATE ce_AssessResult SET resultStatusId=1,updated=#createODBCdateTime(now())#
				WHERE ResultID=<cfqueryparam value="#qData.ResultID#" cfsqltype="cf_sql_integer" />
			</cfquery>
		</cfloop>
		done.
		<cfdump var="#qData#"><cfabort>
	</cffunction>
</cfcomponent>
