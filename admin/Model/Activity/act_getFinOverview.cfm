<!--- GET LEDGER INFO --->
<cfquery name="qLedger" datasource="#Application.Settings.DSN#">
    SELECT
        EntryTypeID, 
        Name, 
        ISNULL ((SELECT SUM(Amount) AS Expr1
                 FROM ce_Activity_FinLedger
                 WHERE (ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />) AND (EntryTypeID = ET.EntryTypeID) AND DeletedFlag='N'), 0)*-1 AS TotalAmount
	FROM ce_Sys_EntryType AS ET
</cfquery>

<!--- GET BUDGET INFO --->
<cfquery name="qBudget" datasource="#Application.Settings.DSN#">
    SELECT     
        EntryTypeID, 
        Name, 
        Description, 
        ISNULL ((SELECT SUM(Amount) AS Expr1
                 FROM ce_Activity_FinBudget
                 WHERE (ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />) AND (EntryTypeID = ET.EntryTypeID) AND DeletedFlag='N'), 0) AS TotalAmount
	FROM ce_Sys_EntryType AS ET
</cfquery>

<cfset aTempFinances = arrayNew(2)>
<cfset aFinances = arrayNew(2)>
<!--- CREATE FINANCIAL ARRAY --->
<cfloop query="qBudget">
    <cfset aFinances[qBudget.CurrentRow][1] = qBudget.Description>
    <cfset aFinances[qBudget.CurrentRow][2] = qBudget.TotalAmount>
    <cfset aFinances[qBudget.CurrentRow][4] = qBudget.Name>
</cfloop>
<cfloop query="qLedger">
    <cfset aFinances[qLedger.CurrentRow][3] = qLedger.TotalAmount>
</cfloop>