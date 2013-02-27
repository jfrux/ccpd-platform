<cfcomponent displayname="fix missing data from logs">
	<cffunction name="fixAttendees" access="remote" output="yes">
		<cfquery name="qRecords" datasource="#application.settings.dsn#">
			/*  
			COMPLETED ATTENDEES
			*/
			SELECT 
				DISTINCT
				completedate = MAX(visitdate),
				personid=right(querystrings,6),
				activityid=Replace(left(querystrings,16),'ActivityID=','') 
			FROM
				ce_iislog
			WHERE scriptpath LIKE '%Public.Cert%'
			GROUP BY right(querystrings,6),Replace(left(querystrings,16),'ActivityID=','')
		</cfquery>
		<cfdump var="#qRecords#">
		<cfloop query="qRecords">
			<cfset createobject("component","ccpdadminnew._com.AJAX_Activity").saveAttendee(qRecords.ActivityID,qRecords.PersonID)>
		</cfloop>
	</cffunction>
	
	<cffunction name="addAnnexRecords" access="remote" output="yes">
		<cfquery name="qRecords" datasource="#application.settings.dsn#">
			SELECT activityID FROM ce_Activity
			WHERE deletedFlag='N'
			ORDER BY activityID
		</cfquery>
		
		<cfloop query="qRecords">
			<cfquery name="qCheck" datasource="#application.settings.dsn#">
				SELECT count(*) As OtherCount FROM ce_activity_other
				WHERE activityid=<cfqueryparam value="#qRecords.activityId#" cfsqltype="cf_sql_integer" />
			</cfquery>
			<cfif qCheck.OtherCount EQ 0>
				<cfquery name="qInsert" datasource="#application.settings.dsn#">
					INSERT INTO ce_activity_other (
						activityId
					) VALUES (
						<cfqueryparam value="#qRecords.activityID#" cfsqltype="cf_sql_integer" />
					)
				</cfquery>
			</cfif>
		</cfloop>
	</cffunction>
</cfcomponent>