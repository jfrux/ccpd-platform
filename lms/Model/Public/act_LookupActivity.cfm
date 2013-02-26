<!--- DETERMINE ACTIVITY ID BY ID --->
<cfif NOT isNumeric(Attributes.ActivityID)>
	<cfquery name="qLookup" datasource="#Application.Settings.DSN#">
    	SELECT ActivityID
        FROM ce_Activity_PubGeneral
        WHERE LinkName=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_varchar" />
    </cfquery>
    <cfif qLookup.RecordCount EQ 1>
        <cfset Attributes.ActivityID = qLookup.ActivityID>
    <cfelse>
        INVALID ACTIVITY!
        <cfabort>
    </cfif>
</cfif>