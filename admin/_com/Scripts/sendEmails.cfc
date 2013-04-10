<cfcomponent displayname="resend emails per activity">
	<cffunction name="run" access="remote" output="yes">
		<cfargument name="activityIds" type="string" required="yes" />
		
    	<cfquery name="qAttendees" datasource="#application.settings.dsn#">
        	SELECT 
    				* 
    			FROM ce_attendee
          WHERE <!---
				ActivityID IN (#arguments.activityIds#) AND --->
				attendeeId IN (298038,298494) AND
				deletedFlag='N' AND 
				StatusID=1
        </cfquery>
        
        <cfloop query="qAttendees">
        	<cfset application.email.send(EmailStyleID=5,messageText="Due to an error in our system, many certificate emails did not get dispatched properly.  If you receive this in duplicate, please ignore or save for your reference.",ToAttendeeID=qAttendees.AttendeeID,ToActivityID=qAttendees.activityId,ToPersonID=qAttendees.PersonId,ToCreditID=1) />
        </cfloop>
    </cffunction>
</cfcomponent>