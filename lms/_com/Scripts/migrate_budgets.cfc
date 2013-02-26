<cfcomponent name="migrate budget to ledger">
	<cffunction name="run" access="remote">
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
	
	<cffunction name="backfill_expenses" access="remote">
		<cfquery name="q" datasource="#application.settings.dsn#">
		WITH CTE_Finances (activityid,endDate,amount) AS (
		SELECT 
		  S.ActivityID,
		  A.endDate,
		  SUM(S.Amount) As amount
		FROM [CCPD_PROD].[ceschema].[ce_Activity_FinSupport] As S
		INNER JOIN 
		ceschema.ce_activity As A ON A.activityId=S.activityId
		WHERE [SupportTypeID] = 1 AND A.activityTypeId = 2 AND startDate BETWEEN '1/1/2011' and '12/31/2011 23:59:59' AND S.deletedFlag='N'
		GROUP BY S.ActivityID,A.EndDate
		) SELECT 
		activityId,
		  endDate As EntryDate,
		  'Total expenses for course.' As [Description],
		  'Total Expense' As Memo,
		  amount,
		  12 As entryTypeId,
		  getDate() as created,
		  1 As createdBy FROM CTE_Finances
		</cfquery>
		
		<cfloop query="q">
			<cfquery name="ins" datasource="#application.settings.dsn#">
				INSERT INTO ce_Activity_FinLedger (
					activityId,
					entryDate,
					description,
					memo,
					entryTypeId,
					amount,
					created,
					createdBy
				) VALUES (
					<cfqueryparam value="#q.activityId#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#q.entryDate#" cfsqltype="cf_sql_timestamp" />,
					<cfqueryparam value="#q.description#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#q.memo#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#q.entryTypeId#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#q.amount#" cfsqltype="cf_sql_float" />,
					<cfqueryparam value="#q.created#" cfsqltype="cf_sql_timestamp" />,
					<cfqueryparam value="#q.createdBy#" cfsqltype="cf_sql_integer" />
				)
			</cfquery>
		</cfloop>
	</cffunction>

</cfcomponent>