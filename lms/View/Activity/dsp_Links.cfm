<cfparam name="Session.PersonID" default="" />

<cfoutput>
<cfif Session.PersonID GT 0>
	<cfif qLinks.RecordCount GT 0>
		<!--- GET ATTENDEE'S ACTIVITY STATUS --->
        <cfset AttendeeStatus = Application.ActivityAttendee.getActivityStatus(ActivityID=Attributes.ActivityID,PersonID=Session.PersoniD)>
    
        <cfif PretestStatus EQ 1 AND AttendeeStatus NEQ "Terminated" AND AttendeeStatus NEQ "">
            <cfloop query="qLinks">
                <div class="ComponentBox">
                <a href="<cfif Left(qLinks.ExternalURL,4) NEQ "http">http://</cfif>#qLinks.ExternalURL#" target="_blank">#qLinks.DisplayName#</a><br />
                <sub>#qLinks.Description#</sub>
                </div>
            </cfloop>
        <cfelseif PretestStatus NEQ 1 OR AttendeeStatus EQ "Terminated">
            <cfloop query="qLinks">
                <div class="ComponentBox">
                <a href="javascript://">#qLinks.DisplayName#</a><br />
                <sub>#qLinks.Description#</sub>
                </div>
            </cfloop>
        </cfif>
    <cfelse>
    	<div class="ComponentBox">
        	There are no links to be displayed.
        </div>
    </cfif>
<cfelse>
	<cfif qLinks.RecordCount GT 0>
        <cfloop query="qLinks">
            <div class="ComponentBox">
            <a href="javascript://">#qLinks.DisplayName#</a><br />
            <sub>#qLinks.Description#</sub>
            </div>
        </cfloop>
    <cfelse>
    	<div class="ComponentBox">
        	There are no links to be displayed.
        </div>
    </cfif>
</cfif>

</cfoutput>