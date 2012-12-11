<cfparam name="Attributes.ActivityID" default="" />

<cfif Attributes.ActivityID NEQ "">
	<cfset qStatements = Application.Com.ActivityCreditGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,DeletedFlag="N")>
    
    <cfloop query="qStatements">
    	<cfif find("%activityType%", qStatements.creditStatement)>
        	<cfquery name="qActivityType"  datasource="#application.settings.dsn#">
            	SELECT
                	name
                FROM
                	ce_sys_activityType
                WHERE
                	activityTypeId = <cfqueryparam value="#attributes.activityTypeId#" cfsqltype="cf_sql_integer" />
            </cfquery>
            
	    	<cfset qStatements.creditStatement = replace(qStatements.creditStatement, "%activityType%", qActivityType.name, "all")>
        </cfif>
    </cfloop>
</cfif>