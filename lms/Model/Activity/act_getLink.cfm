<cfparam name="Attributes.ActivityID" />
<cfparam name="Attributes.Component" />

<cfquery name="qGetLink" datasource="#Application.Settings.DSN#">
SELECT     DisplayName, Description, ExternalURL, Created, CreatedBy, Updated, UpdatedBy, Deleted, DeletedFlag
FROM         ce_Activity_PubComponent
WHERE     (PubComponentID = <cfqueryparam value="#Attributes.Component#" cfsqltype="cf_sql_integer" />) AND (ComponentID = 10)
</cfquery>