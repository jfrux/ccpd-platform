<cfparam name="Attributes.BudgetID" default="0">
<cfparam name="Attributes.Description" default="">
<cfparam name="Attributes.EntryType" default="">
<cfparam name="Attributes.Amount" default="0">
<cfparam name="Attributes.ExpenseOrRevenue" default="a Revenue">
<cfparam name="Attributes.ActionAmount" default="0">

<cfif IsDefined("Attributes.Submitted") AND Attributes.Submitted EQ 1>
	<cfset ActivityBudgetBean = CreateObject("component","#Application.Settings.Com#ActivityFinance.Budget").Init(BudgetID=Attributes.BudgetID,ActivityID=Attributes.ActivityID)>
	
	<!--- Enter User defined vars into the bean --->
	<cfset ActivityBudgetBean.setDescription(Attributes.Description)>
	<cfset ActivityBudgetBean.setEntryTypeID(Attributes.EntryType)>
	
	
	
	<!--- Only modifies the amount if the amount is greater than zero --->
	<cfif Attributes.Amount NEQ 0 AND isNumeric(Attributes.Amount) AND Attributes.EntryType NEQ "">
		<!--- Query of Queries to get the ExpenseFlag and Name for the Selected EntryType --->
		<cfquery name="qExpenseTypeInfo" dbtype="query">
			SELECT Name,ExpenseFlag
			FROM qEntryTypeList
			WHERE EntryTypeID = <cfqueryparam value="#ActivityBudgetBean.getEntryTypeID()#" cfsqltype="cf_sql_integer">
		</cfquery>
	
		<!--- Make sure the user didn't try to enter a negative number for the amount --->
		<cfif Attributes.Amount LT 0>
			<cfset Attributes.Amount = Attributes.Amount * -1>
		</cfif>
		
		<cfset Attributes.ActionAmount = "$" & Attributes.Amount>
	<cfelse>
		<cfif Attributes.Amount EQ 0>
			<!--- Creates error message based on the fact Attributes.Amount is zero --->
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Amount is required","|")>
		</cfif>
	</cfif>
	
	<!--- Sets the Amount in the bean --->
	<cfset ActivityBudgetBean.setAmount(Attributes.Amount)>
	
	<!--- Determines if it is a new Ledger or an edited ledger --->
	<cfif Attributes.BudgetID EQ 0>
		<cfset ActivityBudgetBean.setCreatedBy(Session.Person.getPersonID())>
	<cfelse>
		<cfset ActivityBudgetBean.setUpdatedBy(Session.Person.getPersonID())>
	</cfif>
	
	<!--- Validate Bean --->
	<cfset aErrors = ActivityBudgetBean.Validate()>
	
	<!--- Fill Request.Status.Errors --->
	<cfloop from="1" to="#ArrayLen(aErrors)#" index="i">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,aErrors[i].Message,"|")>
	</cfloop>
	
	<cfif Request.Status.Errors EQ "">
		<cftry>
			<!--- Save Ledger Entry to the DB --->
			<cfset ActivityBudgetBean = Application.Com.ActivityBudgetDAO.Save(ActivityBudgetBean)>
				
			<!--- Acquire Activity Info --->
			<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Attributes.ActivityID)>
			<cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
			
			<!--- Save the action for the Ledger Entry Save --->
			<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
            <cfset ActionBean.setActivityID(Attributes.ActivityID)>
            <cfset ActionBean.setShortName("Added a budget entry.")>
			<cfset ActionBean.setCode("BA")>
            <cfset ActionBean.setLongName("Added #Attributes.ExpenseOrRevenue# budget entry (#qExpenseTypeInfo.Name#) to activity '<a href=""#myself#Activity.Detail?ActivityID=#ActivityBean.getActivityID()#"">#ActivityBean.getTitle()#</a>' for the amount of #Attributes.ActionAmount#.")>\
            <cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
            <cfset Application.Com.ActionDAO.Create(ActionBean)>
			
			<cflocation url="#Myself#Activity.FinBudget?ActivityID=#Attributes.ActivityID#" addtoken="no">
			
			<cfcatch type="any">
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Error: " & cfcatch.Message,"|")>
			</cfcatch>
		</cftry>
	</cfif>
</cfif>