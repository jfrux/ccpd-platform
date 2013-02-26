<cfparam name="Attributes.ActivityID" default="" />

<cfif Attributes.ActivityID NEQ "">
	<cfquery name="qPublishedSites" datasource="#Application.Settings.DSN#">
        SELECT 	SiteID
        FROM ce_Activity_Site
        WHERE	ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />
    </cfquery>
    
    <cfset PublishedSitesList = "">
    
    <cfloop query="qPublishedSites">
    	<cfset PublishedSitesList = ListAppend(PublishedSitesList, qPublishedSites.SiteID,",")>
    </cfloop>
</cfif>