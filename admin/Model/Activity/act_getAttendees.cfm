<cfparam name="attributes.status" type="numeric" default="0" />

<cfset qAttendees = Application.activityAttendee.getAttendees(ActivityID=Attributes.ActivityID,DeletedFlag="N")>

<!--- TOTALATTENDEELIST IS USED FOR SELECTING ALL ATTENDEES IN AN ACTIVITY --->
<cfset TotalAttendeeList = "">
<cfset totalCount = qAttendees.recordCount>
<cfset completeCount = 0>
<cfset failCount = 0>
<cfset progressCount = 0>
<cfset registeredCount = 0>

<cfloop query="qAttendees">
	<cfset TotalAttendeeList = ListAppend(TotalAttendeeList, qAttendees.PersonID,",")>
    
    <cfswitch expression="#qAttendees.statusId#">
    	<cfcase value="1">
        	<cfset completeCount++>
        </cfcase>
        <cfcase value="2">
        	<cfset progressCount++>
        </cfcase>
        <cfcase value="3">
        	<cfset registeredCount++>
        </cfcase>
        <cfcase value="4">
        	<cfset failCount++>
        </cfcase>
    </cfswitch>
</cfloop>

<cfif attributes.status EQ 0 AND getToken(cookie.USER_AttendeeStatus,1,"|") EQ attributes.activityid>
	<cfset attributes.status = getToken(cookie.USER_AttendeeStatus,2,"|")>
</cfif>

<cfif attributes.status GT 0>
    <cfquery name="qTempAttendees" dbtype="query">
    	SELECT *
        FROM qAttendees
        WHERE qAttendees.statusId = <cfqueryparam value="#attributes.status#" cfsqltype="cf_sql_integer" />
	</cfquery>
    
    <cfset qAttendees = qTempAttendees>
</cfif>

<cfset AttendeePager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
<cfset AttendeePager.setQueryToPaginate(qAttendees)>
<cfset AttendeePager.setBaseLink("#myself#Activity.Attendees?ActivityID=#Attributes.ActivityID#&status=#attributes.status#") />
<cfset AttendeePager.setItemsPerPage(15) />
<cfset AttendeePager.setUrlPageIndicator("page") />
<cfset AttendeePager.setShowNumericLinks(true) />
<cfset AttendeePager.setClassName("green") />