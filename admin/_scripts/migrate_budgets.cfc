<cfcomponent name="migrate budget to ledger">
	<cffunction name="run">
		<cfquery name="q" datasource="#application.settings.dsn#">
		SELECT     budget.BudgetID, budget.ActivityID, budget.Description, budget.Amount, type.Name, budget.EntryTypeID,budget.created,budget.createdBy
		FROM         ceschema.ce_Activity_FinBudget AS budget INNER JOIN
			  ceschema.ce_Sys_EntryType AS type ON budget.EntryTypeID = type.EntryTypeID
		WHERE     (budget.DeletedFlag = 'N') AND (budget.Amount < 0)
		</cfquery>
		
		<cfloop query="q">
			<cfquery name="ins" datasource="#application.settings.dsn#">
				INSERT INTO ce_Activity_FinLedger (
					activityId,
					entryDate,
					description,
					entryTypeId,
					amount,
					created,
					createdBy
				) VALUES (
					<cfqueryparam value="#q.activityId#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#q.created#" cfsqltype="cf_sql_timestamp" />,
					<cfqueryparam value="#q.description#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#q.entryTypeId#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#q.amount#" cfsqltype="cf_sql_float" />,
					
					<cfqueryparam value="#q.created#" cfsqltype="cf_sql_timestamp" />,
					
					<cfqueryparam value="#q.createdBy#" cfsqltype="cf_sql_integer" />
				)
			</cfquery>
		</cfloop>
	</cffunction>
</cfcomponent>