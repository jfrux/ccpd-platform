<cfcomponent displayname="Answer Dump" output="no">
	<cffunction name="getQuestions" access="public" returntype="query">
		<cfargument name="assessmentId" type="numeric" required="yes" />
		<cfset var qQuestions = "">
		
		<cfquery name="qQuestions" datasource="#Application.Settings.DSN#">
			DECLARE @assessId int;
			SET @assessId = <cfqueryparam value="#arguments.AssessmentID#" cfsqltype="cf_sql_integer" />;
			
			SELECT     
				Q.QuestionID, 
				Q.LabelText, 
				Q.QuestionTypeId,
				QT.Name AS QuestionType,
				dbo.HTMLDecode(Q.VC1) AS VC1,
				dbo.HTMLDecode(Q.VC2) AS VC2,
				dbo.HTMLDecode(Q.VC3) AS VC3,
				dbo.HTMLDecode(Q.VC4) AS VC4,
				dbo.HTMLDecode(Q.VC5) AS VC5,
				dbo.HTMLDecode(Q.VC6) AS VC6,
				dbo.HTMLDecode(Q.VC7) AS VC7,
				dbo.HTMLDecode(Q.VC8) AS VC8,
				dbo.HTMLDecode(Q.VC9) AS VC9,
				dbo.HTMLDecode(Q.VC10) AS VC10,
				Q.DeletedFlag
			FROM        
				ce_AssessQuestion AS Q 
			INNER JOIN
				ce_Sys_AssessQuestionType AS QT ON Q.QuestionTypeID = QT.QuestionTypeID
			WHERE
				/* CAPTIONS */
				(
					(Q.AssessmentID = @assessId) AND 
					(Q.DeletedFlag='N') AND
					(Q.QuestionTypeId IN (5,6,7))
				)
					OR
				/* QUESTIONS W/ ANSWERS */
				(
					(Q.AssessmentID = @assessId) AND 
					(Q.DeletedFlag='N') AND 
					(SELECT Count(AnswerID) FROM ce_AssessAnswer As AA WHERE AA.QuestionID=Q.QuestionID) > 0
					OR
					(Q.questiontypeId NOT IN (5,6,7)) AND 
					(Q.AssessmentID = @assessId) AND 
					(Q.DeletedFlag='Y') AND 
					(SELECT Count(AnswerID) FROM ce_AssessAnswer As AA WHERE AA.QuestionID=Q.QuestionID) > 0
				)
			ORDER BY Q.Sort
		</cfquery>
		
		<cfreturn qQuestions />
	</cffunction>
	
	<cffunction name="getAssessInfo" access="public" returntype="query">
		<cfargument name="assessmentId" type="numeric" required="yes" />
		<cfset var qAssessInfo = "">
		<cfquery name="qAssessInfo" datasource="#Application.Settings.DSN#">
			SELECT     
				ass.assessmentid,
            	ActivityTitle = Act.Title, 
                AssessmentName = Ass.Name, 
                AssessType = AsT.Name
			FROM
            	ce_Assessment AS Ass 
            INNER JOIN
			  	ce_Activity AS Act ON Ass.ActivityID = Act.ActivityID 
            INNER JOIN
			  	ce_Sys_AssessType AS AsT ON Ass.AssessTypeID = AsT.AssessTypeID
			 WHERE 
             	AssessmentID=<cfqueryparam value="#arguments.AssessmentID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfreturn qAssessInfo />
	</cffunction>
	
	<cffunction name="Run" access="remote" output="yes" returnformat="plain">
		<cfargument name="startDate" type="string" required="no" default="1/1/1970 00:00:00">
		<cfargument name="endDate" type="string" required="no" default="#dateAdd('yyyy',10,now())#">
		<cfargument name="assessmentId" type="numeric" required="yes">
		<cfargument name="reportLabel" type="string" required="no" default="">
		<cfargument name="showDeleted" required="no" default="false">
		
		<cfset var qAssessInfo = getAssessInfo(arguments.assessmentId)>
		<cfset var startDateTime = arguments.startDate />
		<cfset var endDateTime = arguments.endDate />
        
		<cfset Request.Questions = getQuestions(arguments.assessmentId)>
		<cfset startDateTime = dateFormat(startDateTime,'mm/dd/yyyy') & " 00:00:00" />
		<cfset endDateTime = dateFormat(endDateTime,'mm/dd/yyyy') & " 23:59:59" />
        
        <cfif NOT isBoolean(arguments.showDeleted)>
        	<cfswitch expression="#arguments.showDeleted#">
            	<cfcase value="on">
                	<cfset arguments.showDeleted = true>
                </cfcase>
                <cfdefaultcase>
                	<cfset arguments.showDeleted = false>
                </cfdefaultcase>
            </cfswitch>
        </cfif>
        
		<cfquery name="Results" datasource="#Application.Settings.DSN#">
			DECLARE @assessId int, 
			@startDate datetime, 
			@endDate datetime
			
			SET @assessId = <cfqueryparam value="#arguments.assessmentid#" cfsqltype="cf_sql_integer" />;
			SET @startDate = <cfqueryparam value="#startDateTime#" cfsqltype="cf_sql_timestamp" />;
			SET @endDate = <cfqueryparam value="#endDateTime#" cfsqltype="cf_sql_timestamp" />;
			
			WITH CTE_Totals AS (
				SELECT 
					Attendee.AttendeeID,
					MAX(Result.Score) maxScore,
					MAX(Result.resultId) As resultId
					FROM         
						ce_AssessResult AS Result 
						INNER JOIN
						ce_Sys_AssessResultStatus AS ResultStatus ON Result.ResultStatusID = ResultStatus.ResultStatusID 
						INNER JOIN
						ce_Person AS Person ON Result.PersonID = Person.PersonID 
						INNER JOIN
						ce_Assessment ON Result.AssessmentID = ce_Assessment.AssessmentID 
						INNER JOIN
						ce_Attendee AS Attendee ON ce_Assessment.ActivityID = Attendee.ActivityID AND Result.PersonID = Attendee.PersonID
						INNER JOIN 
						ce_Sys_AttendeeStatus AS AttStatus ON AttStatus.attendeeStatusId = attendee.statusid
					WHERE 
						0 = 0 
						AND (Result.AssessmentID = @assessId) 
						AND (Result.DeletedFlag = 'N')
						AND (Result.resultStatusId NOT IN (2))
						AND (Attendee.DeletedFlag = 'N')
						AND (Attendee.CompleteDate BETWEEN @startDate AND @endDate)
					OR
						0 = 0 
						AND (Result.AssessmentID = @assessId) 
						AND (Result.DeletedFlag = 'N')
						AND (Result.resultstatusId NOT IN (2))
						AND (Attendee.DeletedFlag = 'N')
						AND (Attendee.Created BETWEEN @startDate AND @endDate)
					GROUP BY Attendee.AttendeeId
			) 
			SELECT 
				Result.ResultID, 
				UPPER(Person.FirstName) AS FirstName,
				UPPER(Person.LastName) AS LastName,
				Person.CertName AS CertName,
				UPPER(ResultStatus.Name) AS AssessStatus,
				UPPER(AttStatus.Name) AS AttendStatus,
				MDFlag = CASE Attendee.MDFlag
					WHEN 'Y' THEN 1
					ELSE 0
				END,
				Attendee.AttendeeID,
				Result.Created As ResultDate,
				Attendee.CompleteDate As AttendCompleteDate,
				Attendee.Created As AttendCreated
			FROM
				CTE_Totals As CTETotal
				INNER JOIN
					ce_AssessResult AS Result ON CTETotal.resultId=result.resultid
				INNER JOIN
					  ce_Sys_AssessResultStatus AS ResultStatus ON Result.ResultStatusID = ResultStatus.ResultStatusID 
				INNER JOIN
					  ce_Person AS Person ON Result.PersonID = Person.PersonID 
				INNER JOIN
					  ce_Assessment ON Result.AssessmentID = ce_Assessment.AssessmentID 
				INNER JOIN
					  ce_Attendee AS Attendee ON ce_Assessment.ActivityID = Attendee.ActivityID AND Result.PersonID = Attendee.PersonID
				INNER JOIN 
					ce_Sys_AttendeeStatus AS AttStatus ON AttStatus.attendeeStatusId = attendee.statusid
			ORDER BY AttStatus.Name,Attendee.CompleteDate,Attendee.Created
		</cfquery>
		
		<cfquery name="qTally" datasource="#application.settings.dsn#">
			<!---/****** Script for SelectTopNRows command from SSMS  ******/
			UPDATE ce_AssessAnswer
			SET VC1=dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC1))))
			WHERE updated > '2/15/2012 9:20:00'
			
			GO
			
			/****** Script for SelectTopNRows command from SSMS  ******/
			UPDATE ce_AssessQuestion
			SET
			
				  [vc1] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC1))))
				  ,[vc2] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC2))))
				  ,[vc3] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC3))))
				  ,[vc4] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC4))))
				  ,[vc5] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC5))))
				  ,[vc6] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC6))))
				  ,[vc7] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC7))))
				  ,[vc8] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC8))))
				  ,[vc9] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC9))))
				  ,[vc10] = dbo.ReplaceInvChar(LTrim(Rtrim(dbo.HTMLDecode(VC10))))
			  FROM [CCPD_PROD].[ceschema].[ce_AssessQuestion]
			  WHERE updated > '2/15/2012 9:20:00'
			
			GO--->
			DECLARE @assessId int, 
			@startDate datetime, 
			@endDate datetime
			
			SET @assessId = <cfqueryparam value="#arguments.assessmentid#" cfsqltype="cf_sql_integer" />;
			SET @startDate = <cfqueryparam value="#startDateTime#" cfsqltype="cf_sql_timestamp" />;
			SET @endDate = <cfqueryparam value="#endDateTime#" cfsqltype="cf_sql_timestamp" />;
			
			WITH CTE_Totals AS (
				SELECT  
					AQ.QuestionID,
					vc1Count = COUNT((CASE 
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC1,
								'^') > 0 THEN AQ.VC1
					END
					)),
					vc2Count = COUNT((CASE
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC2,
								'^') > 0 THEN AQ.VC2
					END)),
					vc3Count = COUNT((CASE
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC3,
								'^') > 0 THEN AQ.VC3
					END)),
					vc4Count = COUNT((CASE
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC4,
								'^') > 0 THEN AQ.VC4
					END)),
					vc5Count = COUNT((CASE
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC5,
								'^') > 0 THEN AQ.VC5
					END)),
					vc6Count = COUNT((CASE
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC6,
								'^') > 0 THEN AQ.VC6
					END)),
					vc7Count = COUNT((CASE
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC7,
								'^') > 0 THEN AQ.VC7
					END)),
					vc8Count = COUNT((CASE
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC8,
								'^') > 0 THEN AQ.VC8
					END)),
					vc9Count = COUNT((CASE
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC9,
								'^') > 0 THEN AQ.VC9
					END)),
					vc10Count = COUNT((CASE
						WHEN dbo.listFind(
								AA.VC1,
								AQ.VC10,
								'^') > 0 THEN AQ.VC10
					END))
				FROM         
					ce_AssessQuestion AS AQ 
				INNER JOIN
					ce_AssessAnswer AS AA ON AQ.QuestionID = AA.QuestionID 
				INNER JOIN
					ce_Assessment AS Ass ON AQ.AssessmentID = Ass.AssessmentID
				INNER JOIN 
					ce_AssessResult AS AR ON AR.ResultId = AA.ResultId
				INNER JOIN
					  ce_Person AS Person ON AR.PersonID = Person.PersonID
				INNER JOIN
					ce_Attendee AS Att ON Ass.ActivityID = Att.ActivityID AND AR.PersonID = Att.PersonID
				INNER JOIN
					(SELECT 
						Attendee.AttendeeID,
						MAX(Result.Score) maxScore,
						MAX(Result.resultId) As resultId
						FROM         
							ce_AssessResult AS Result 
							INNER JOIN
							ce_Sys_AssessResultStatus AS ResultStatus ON Result.ResultStatusID = ResultStatus.ResultStatusID 
							INNER JOIN
							ce_Person AS Person ON Result.PersonID = Person.PersonID 
							INNER JOIN
							ce_Assessment ON Result.AssessmentID = ce_Assessment.AssessmentID 
							INNER JOIN
							ce_Attendee AS Attendee ON ce_Assessment.ActivityID = Attendee.ActivityID AND Result.PersonID = Attendee.PersonID
							INNER JOIN 
							ce_Sys_AttendeeStatus AS AttStatus ON AttStatus.attendeeStatusId = attendee.statusid
						WHERE 
							0 = 0 
							AND (Result.AssessmentID = @assessId) 
							AND (Result.DeletedFlag = 'N')
						AND (Result.resultStatusId NOT IN (2))
							AND (Attendee.DeletedFlag = 'N')
							AND (Attendee.CompleteDate BETWEEN @startDate AND @endDate)
						OR
							0 = 0 
							AND (Result.AssessmentID = @assessId) 
							AND (Result.DeletedFlag = 'N')
						AND (Result.resultStatusId NOT IN (2))
							AND (Attendee.DeletedFlag = 'N')
							AND (Attendee.Created BETWEEN @startDate AND @endDate)
						GROUP BY Attendee.AttendeeId) As Derived ON Derived.ResultId = AR.ResultID
				WHERE 
					0 = 0
					AND AQ.DeletedFlag='N'
					AND AA.DeletedFlag='N'
					AND Ass.DeletedFlag='N'
					AND Att.DeletedFlag='N'
					AND Att.StatusId=1
					AND Ass.assessmentid = @assessId
					AND (Att.CompleteDate BETWEEN @startDate AND @endDate)
				GROUP BY AQ.QuestionID
				) 
				SELECT 
					A.AssessmentID,
					Assessment = A.Name,
					AssessType = AT.Name,
					Q.QuestionID,
					Question = Q.LabelText,
					Q.QuestionTypeID,
					totalCount = (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count),
					vc1Label = Q.vc1,
					vc1Count,
					vc2Label = Q.vc2,
					vc2Count,
					vc3Label = Q.vc3,
					vc3Count,
					vc4Label = Q.vc4,
					vc4Count,
					vc5Label = Q.vc5,
					vc5Count,
					vc6Label = Q.vc6,
					vc6Count,
					vc7Label = Q.vc7,
					vc7Count,
					vc8Label = Q.vc8,
					vc8Count,
					vc9Label = Q.vc9,
					vc9Count,
					vc10Label = Q.vc10,
					vc10Count,
					vc1Perc = 
					CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc1Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100)
					END,
					vc2Perc = CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc2Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100)
						END,
					vc3Perc = CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc3Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100)
						END,
					vc4Perc = CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc4Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100)  
						END,
					vc5Perc = CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc5Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
						END,
					vc6Perc = CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc6Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
						END ,
					vc7Perc = CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc7Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
						END,
					vc8Perc = CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc8Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
						END,
					vc9Perc = CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc9Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
						END,
					vc10Perc = CASE
						WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
						ELSE (convert(numeric(5,2),vc10Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
						END
				FROM CTE_Totals As T 
				INNER JOIN ce_AssessQuestion As Q ON Q.QuestionID=T.QuestionID
				INNER JOIN ce_Assessment As A ON Q.AssessmentID = A.AssessmentID
				INNER JOIN ce_Sys_AssessType As AT ON A.AssessTypeID = AT.AssessTypeID
				ORDER BY Q.Sort
		</cfquery>
        
		<cfquery name="qAnswers" datasource="#Application.Settings.DSN#">
			SELECT     AnswerID, ResultID, AssessmentID, QuestionID, I1, I2, dbo.HTMLDecode(VC1) As VC1, dbo.HTMLDecode(VC2) As VC2, DT1, DT2, TXT1, TXT2, CorrectFlag, Created, Updated, Deleted, DeletedFlag
			FROM         ce_AssessAnswer
			WHERE     (AssessmentID = <cfqueryparam value="#arguments.AssessmentID#" cfsqltype="cf_sql_integer" />) 
		</cfquery>
		
		<!--- Import POI Library --->
		<cfimport taglib="/_poi/" prefix="poi" />
		
		<!--- Create Report Folder variable --->
		<cfset ReportPath = ExpandPath("#Application.Settings.RootPath#/_reports/18/")>
		
		<!--- Check if the report folder exists yet --->

		<cfif NOT DirectoryExists("#ReportPath#")>
			<cfdirectory action="Create" directory="#ReportPath#">
		</cfif>
		
		<cfset ReportFileName = "result-#Application.UDF.StripAllBut(LCase(left(qAssessInfo.AssessType,4)),'abcdefghijklmnopqrstuvwxyz',false)#-#UCASE(arguments.reportLabel)#_#arguments.AssessmentID##DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#.xlsx">
		<cfset ReportFileName = lcase(ReportFileName)>
		<cfset ColumnCount = 5+Request.Questions.RecordCount> <!--- Add how many extra columns for like Name and Status --->

		<!--- Start Building Excel file --->
		<poi:document name="Request.ExcelData" file="#ReportPath##ReportFileName#" type="XSSF">
			<poi:classes>
				<poi:class name="title" style="font-family: arial; vertical-align:middle; color: ##000; font-size:12pt; font-weight:bold;  background-color: PALE_BLUE; border-top: 3px BLACK; border-bottom:3px BLACK; border-left: 2px BLACK; border-right:2px BLACK;" />
				<poi:class name="headers" style="font-family: arial ; color: WHITE; padding:3px; background-color:BLACK;  font-size: 10pt; font-weight: bold; border: 5px BLACK;" />
				<poi:class name="question" style="font-family: arial ; color: ##000 ;  font-size: 10pt; height:20px; font-weight:bold; vertical-align:middle;" />
				<poi:class name="caption1" style="font-family: arial ; color: ##000 ;  font-size: 14pt; height:20px; font-weight:bold;" />
				<poi:class name="caption2" style="font-family: arial ; color: ##000 ;  font-size: 12pt; height:20px; font-weight:bold;" />
				<poi:class name="caption3" style="font-family: arial ; color: ##000 ;  font-size: 10pt; height:20px; font-weight:bold;" />
			</poi:classes>
			
			<poi:sheets>
				<poi:sheet name="Assess Answers" orientation="landscape">
					<poi:columns>
						<poi:column style="width:200px;vertical-align:middle; padding:0 0 0 4px;text-align:center;" />
						<poi:column style="width:60px;vertical-align:middle; padding:0 0 0 4px;text-align:center;" />
						<poi:column style="width:150px;vertical-align:middle; padding:0 0 0 4px;text-align:center;" />
						<poi:column style="width:150px;vertical-align:middle; padding:0 0 0 4px;text-align:center;" />
						<poi:column style="width:150px;vertical-align:middle; padding:0 0 0 4px;text-align:center;" />
						<cfloop query="Request.Questions">							
							<cfif (NOT request.questions.deletedFlag EQ "Y" AND NOT arguments.showDeleted)>
							<poi:column style="width:150px;vertical-align:middle; padding:0 0 0 4px;" />
							</cfif>
						</cfloop>
					</poi:columns>
					
					<poi:row class="title">
						<poi:cell value="#UCASE(arguments.reportLabel)# #left(UCASE(qAssessInfo.AssessType),4)# [#dateFormat(arguments.startDate,'mm/dd/yyyy')#] - [#dateFormat(arguments.endDate,'mm/dd/yyyy')#] #Left(qAssessInfo.ActivityTitle,100) & "..."#" colspan="#ColumnCount#" style="text-align:left;" />
					</poi:row>
					
					<poi:row class="headers">
						<poi:cell value="LastName, FirstName" style="vertical-align:bottom;" />
						<poi:cell value="Is MD?" style="vertical-align:bottom;" />
						<poi:cell value="Attendee Status" style="vertical-align:bottom;" />
						<poi:cell value="Attendee Status Date" style="vertical-align:bottom;" />
						<poi:cell value="Assessment Status" style="vertical-align:bottom;" />
						<cfloop query="Request.Questions">
							<cfif request.questions.deletedFlag EQ "Y">
								<cfset headercellstyle = "background-color:##d20000;vertical-align:bottom;" />
							<cfelseif listFindNoCase('5,6,7',request.questions.questionTypeId)>
								<cfset headercellstyle = "background-color:##EEEEEE;vertical-align:bottom;color:##555555;font-style:italic; border: 5px ##EEEEEE;" />
							<cfelse>
								<cfset headercellstyle = "vertical-align:bottom;" />
							</cfif>
							<cfif (request.questions.deletedFlag NEQ "Y")>
							<poi:cell value="#Request.Questions.LabelText#" style="#headercellstyle#" />
							</cfif>
						</cfloop>
					</poi:row>
					
					<cfloop query="Results">
						<cfquery name="Answers" dbtype="query">
						SELECT QuestionID,VC1 FROM qAnswers WHERE (ResultID = <cfqueryparam value="#Results.ResultID#" cfsqltype="cf_sql_integer" />)
						</cfquery>
						
						
					<poi:row class="data">
						<poi:cell value="#Results.LastName#, #Results.FirstName#" />
						<cfif results.MDflag>
							<cfset statusStyle = "color:black;font-weight:bold;">
						<cfelse>
							<cfset statusStyle = "color:gray;font-weight:normal;">
						</cfif>
						<poi:cell value="#YesNoFormat(Results.MDFlag)#" style="text-align:center;#statusStyle#" />
						<cfswitch expression="#Results.AttendStatus#">
							<cfcase value="COMPLETE">
								<cfset statusStyle = "color:GREEN;font-weight:bold;">
							</cfcase>
							<cfcase value="IN PROGRESS">
								<cfset statusStyle = "color:ORANGE;font-weight:bold;">
							</cfcase>
							<cfdefaultcase>
								<cfset statusStyle = "color:GRAY;">
							</cfdefaultcase>
						</cfswitch>
						<poi:cell value="#Results.AttendStatus#" style="text-align:center;#statusStyle#" />
						<cfif Results.AttendStatus EQ "COMPLETE">
							<poi:cell value="#DateFormat(Results.AttendCompleteDate,'mm/dd/yyyy')#" style="text-align:center;" />
						<cfelse>
							<poi:cell value="#DateFormat(Results.AttendCreated,'mm/dd/yyyy')#" style="text-align:center;" />
						</cfif>
						<cfswitch expression="#Results.AssessStatus#">
							<cfcase value="COMPLETE">
								<cfset statusStyle = "color:GREEN;font-weight:bold;">
							</cfcase>
							<cfcase value="IN PROGRESS">
								<cfset statusStyle = "color:ORANGE;font-weight:bold;">
							</cfcase>
							<cfdefaultcase>
								<cfset statusStyle = "color:GRAY;">
							</cfdefaultcase>
						</cfswitch>
						<poi:cell value="#Results.AssessStatus#" style="text-align:center;#statusStyle#" />
						<!---<cfif Results.ResultID EQ 5177>
								<cfdump var="#Request.Questions#">
								<cfabort>
							</cfif>--->
						<cfloop query="Request.Questions">
							<cfset prepend = "">
							<cfset append = "">
							
							<cfif (request.questions.deletedFlag NEQ "Y")>
								<cfswitch expression="#Request.Questions.QuestionTypeId#">
									<cfcase value="1"> <!--- Multiple Choice (Single Answer) --->
										<cfset cellStyle = "text-align:center;">
									</cfcase>
									<cfcase value="3"> <!--- Text (Single Line) --->
										<cfset prepend = "'">
										<cfset append = "'">
										<cfset cellStyle = "text-align:center;color:GREY_50_PERCENT;font-style:italic;">
									</cfcase>
									<cfcase value="4"> <!--- Text (Multi Line) --->
										<cfset prepend = "'">
										<cfset append = "'">
										<cfset cellStyle = "text-align:left;color:GREY_50_PERCENT;font-style:italic;">
									</cfcase>
									<cfcase value="9"> <!--- Rating (1-5,Agree/Disagree) --->
										<cfset cellStyle = "text-align:center;">
									</cfcase>
									<cfcase value="11"> <!--- Rating (1-5,Effective/Not Effective) --->
										<cfset cellStyle = "text-align:center;">
									</cfcase>
									<cfcase value="2"> <!--- Rating (1-5,Like/Dislike)--->
										<cfset cellStyle = "text-align:center;">
									</cfcase>
									
									<cfcase value="5"> <!--- Rating (1-5,Like/Dislike)--->
										<cfset cellStyle = "text-align:center; background-color:##EEEEEE;">
									</cfcase>
									
									<cfcase value="6"> <!--- Rating (1-5,Like/Dislike)--->
										<cfset cellStyle = "text-align:center; background-color:##EEEEEE;">
									</cfcase>
									
									<cfcase value="7"> <!--- Rating (1-5,Like/Dislike)--->
										<cfset cellStyle = "text-align:center; background-color:##EEEEEE;">
									</cfcase>
									
									<cfdefaultcase> <!--- all others --->
										<cfset cellStyle = "text-align:center;">
									</cfdefaultcase>
								</cfswitch>
								
								<cfif request.questions.deletedFlag EQ "Y">
									<cfset cellstyle = cellstyle & "background-color:##ffe2e2;" />
								</cfif>
								
								<cfif NOT listFindNoCase('5,6,7',Request.Questions.QuestionTypeId)>
									<cfquery name="Answer" dbtype="query">
										SELECT VC1 FROM Answers WHERE QuestionID=<cfqueryparam value="#Request.Questions.QuestionID#" cfsqltype="cf_sql_integer" />
									</cfquery>
									
									<cfif len(trim(Answer.VC1)) EQ 0>
										<cfset prepend = "">
										<cfset append = "">
									</cfif>
									<cfif isNumeric(Answer.VC1)>
										<poi:cell value="#Answer.VC1#" type="numeric" numberformat="0" style="#cellStyle#" />
									<cfelse>
										<poi:cell value="#prepend##Answer.VC1##append#" style="#cellStyle#" />
									</cfif>
								<cfelse>
										<poi:cell value="" style="#cellStyle#" />
								</cfif>
							</cfif>
						</cfloop>
					</poi:row>
					</cfloop>
				</poi:sheet>
                
				<!--- SET LIST OF QUESTION TYPE EXCLUSIONS --->
                <cfset QuestionTypeExclusions = "Caption 1,Caption 2,Caption 3">

                <poi:sheet name="Data Tally Report" orientation="landscape">
                    <poi:columns>
						<poi:column style="width:50px;" />
						<poi:column style="width:200px; text-align:right;" />
						<poi:column style="width:450px;" />
					</poi:columns>
                    
                    <poi:row class="title">
						<poi:cell value="#UCASE(arguments.reportLabel)# #left(UCASE(qAssessInfo.AssessType),4)# TALLY [#dateFormat(arguments.startDate,'mm/dd/yyyy')#] - [#dateFormat(arguments.endDate,'mm/dd/yyyy')#] #Left(qAssessInfo.ActivityTitle,100) & "..."#" colspan="3" />
					</poi:row>
                    
                    <poi:row class="headers">
						<poi:cell value="" />
						<poi:cell value="Question / Caption" />
						<poi:cell value="Count / Percentage" style="background-color:##333333;" />
					</poi:row>
                    
					<cfloop query="request.questions">
						<cfswitch expression="#request.questions.questiontypeid#">
							<cfcase value="5">
								<cfset className="caption1">
							</cfcase>
							<cfcase value="6">
								<cfset className="caption2">
							</cfcase>
							<cfcase value="7">
								<cfset className="caption3">
							</cfcase>
							<cfdefaultcase>
								<cfset className="question">
							</cfdefaultcase>
						</cfswitch>
						
						<cfif NOT listFind('5,6,7',request.questions.questiontypeid)>
							<cfquery name="qTallyRow" dbtype="query">
							SELECT * FROM qTally
							WHERE questionId = #request.questions.questionid#
							</cfquery>
							
							<poi:row class="#className#">
								<poi:cell value="#qTallyRow.Question#" colspan="3" style="background-color:##BBBBBB;" />
							</poi:row>
							
							<cfloop from="1" to="10" index="i">
								<cfset optionLabel = evaluate('qTallyRow.vc#i#Label')>
								<cfset optionCount = evaluate('qTallyRow.vc#i#Count')>
								<cfset optionPerc = evaluate('qTallyRow.vc#i#Perc')>
								<cfset totalCount = qTallyRow.totalCount>
								
								<!--- ADDED 'questionType NEQ 4' DUE TO TEXT ENTRY QUESTION TYPES BEING SAVED AS A DIFFERENT QUESTION TYPE (WITH SELECT ANSWER VALUES) FIRST // JS 04/29/2011 --->
								<cfif len(trim(optionLabel)) GT 0 AND NOT listFind("3,4", questionTypeId)>
									<poi:row class="options" style="background-color:##DDDDDD;border-top:2px solid ##888888;border-bottom:2px solid ##888888;">
										<poi:cell value="" />
										<poi:cell value="#optionLabel#" />
										<poi:cell value="#Round(optionPerc)#% (#optionCount#)" style="background-color:##F7F7F7;border-left:2px solid ##AAAAAA;" />
									</poi:row>
								<cfelse>
									<cfif i EQ 1>
										<poi:row class="#className#">
											<poi:cell value="" />
											<poi:cell value="" />
											<poi:cell value="Text answers contained on first sheet." style="font-style:italic;color:##666666;" />
										</poi:row>
									</cfif>
								</cfif>
							</cfloop>
							<cfif NOT listFind("3,4",questionTypeId)>
								<poi:row class="options" style="background-color:##DDDDDD;border-top:2px solid ##888888;border-bottom:2px solid ##888888;">
									<poi:cell value="" />
									<poi:cell value="TOTAL RESPONSES:" />
									<poi:cell value="#totalCount#" style="background-color:##F7F7F7;border-left:2px solid ##AAAAAA;" />
								</poi:row>
							</cfif>
						<cfelse>
							<poi:row class="#className#">
								<poi:cell value="#request.questions.labelText#" colspan="3" style="height:20px;padding:0;margin:0;background-color:##BBBBBB;" />
							</poi:row>
						</cfif>
					</cfloop>
                </poi:sheet>
			</poi:sheets>
		</poi:document>
		
		
        <cflog text="Assessment Report generated." file="ccpd_report_log">
		
		<cfheader name="Content-Type" value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
		<cfheader name="Content-Disposition" value="attachment; filename=#ReportFileName#">
		<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#ReportPath##ReportFileName#" deletefile="No">
	</cffunction>
</cfcomponent>