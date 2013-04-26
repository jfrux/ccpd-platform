<cfquery name="email_logs" datasource="#application.settings.dsn#">
  SELECT * FROM email_logs as E
  INNER JOIN users as U on E.user_id = U.personid
  WHERE activity_id=<cfqueryparam value="#attributes.activityid#" cfsqltype="cf_sql_integer" />
  ORDER BY updated_at DESC
</cfquery>