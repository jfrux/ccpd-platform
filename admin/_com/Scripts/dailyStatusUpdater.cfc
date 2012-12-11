<cfcomponent displayname="Daily Attendee Status Changes" output="no">
	<cffunction name="Run" output="no" access="remote" returntype="string" returnformat="plain">
		<cfargument name="sendEmail" type="string" default="1" required="no" />
		<cfquery name="qUpdater" datasource="#Application.Settings.DSN#">
			SELECT Attendee.*,
				activity.startdate,activity.enddate+'23:59:59' As EndDate,Person.Email 
			FROM ceschema.ce_Attendee As Attendee
			LEFT JOIN ceschema.ce_person AS Person ON Person.personid = Attendee.personid
			LEFT JOIN ceschema.ce_activity AS Activity ON Activity.activityID = attendee.activityid
			WHERE     
			( Attendee.AttendeeID IN
				(SELECT
					Att.AttendeeID
				FROM          
					ceschema.ce_Attendee AS Att 
				INNER JOIN
					ceschema.ce_Activity AS A ON Att.ActivityID = A.ActivityID
				WHERE      
					(A.StatusID IN (1, 2, 3)) AND 
					(A.ActivityTypeID <> 2) AND 
					(A.DeletedFlag = 'N') AND  
					(A.EndDate < GETDATE())))
			AND
				 Attendee.DeletedFlag='N'
				AND  
				Attendee.StatusID <> 1
			AND Attendee.created > '1/1/2008 00:00:00'
			
			OR
			
			(AttendeeID IN
				(SELECT
					Att.AttendeeID
				FROM          
					ceschema.ce_Attendee AS Att 
				INNER JOIN
					ceschema.ce_Activity AS A ON Att.ActivityID = A.ActivityID
				WHERE      
					(A.StatusID IN (1, 2, 3)) AND 
					(A.ActivityTypeID <> 2) AND
					(A.DeletedFlag = 'N') AND
					(A.EndDate < GETDATE())))
			AND
			 Attendee.DeletedFlag='N'
			AND Attendee.StatusID = 1
			AND  Attendee.CompleteDate NOT BETWEEN activity.startDate AND activity.endDate + '23:59:59'
			AND Attendee.created > '1/1/2007 00:00:00'
			ORDER BY activityId
		</cfquery>
		
		<cfloop query="qUpdater">
			<cfquery name="qUpdate" datasource="#application.settings.dsn#">
				UPDATE 
					ce_Attendee
				SET
					StatusID = 1, 
					CheckOut = GETDATE(),
					CompleteDate = #createODBCDateTime('#dateFormat(qUpdater.endDate,'mm/dd/yyyy')# 00:00:00')#,
					Updated=getDate(),
					UpdatedBy=169841
				WHERE attendeeId=#qUpdater.attendeeId#
			</cfquery>
			
			<cfif arguments.sendEmail GT 0>
			<cftry>
				<cfset application.email.send(EmailStyleID=5,ToAttendeeID=qUpdater.AttendeeID,ToActivityID=qUpdater.activityId,ToPersonID=qUpdater.PersonID,ToCreditID=1) />
				
				<cfcatch type="any">
				
				</cfcatch>
			</cftry>
			</cfif>
		</cfloop>
		<cfdump var="#qUpdater#"><cfabort>
		<cflog text="Status Updater ran successfully." file="ccpd_script_log">
	</cffunction>
</cfcomponent>