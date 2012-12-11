<cfparam name="Attributes.ActivityID" default="" />

<cfquery name="qGetAllowCommentsFlag" datasource="#Application.Settings.DSN#">
	SELECT AllowCommentFlag
    FROM ce_Activity_PubGeneral
    WHERE ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfset Attributes.AllowCommentsFlag = qGetAllowCommentsFlag.AllowCommentFlag>