<cfparam name="Attributes.ActivityID" default="" />

<cfquery name="qAssessments" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID, Name
    FROM ce_Assessment
    WHERE ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>