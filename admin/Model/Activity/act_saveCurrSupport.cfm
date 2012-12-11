<cfparam name="Attributes.SupportID" default="">
<cfparam name="Attributes.Supporter" default="">
<cfparam name="Attributes.SupportType" default="">
<cfparam name="Attributes.Amount" default="0">
<cfparam name="Attributes.ContractNum" default="">
<cfparam name="Attributes.BudgetRequested" default="">
<cfparam name="Attributes.BudgetDueDate" default="">
<cfparam name="Attributes.BudgetSent" default="">
<cfparam name="Attributes.DateSent" default="">
<cfparam name="Attributes.FundsReturned" default="">
<cfparam name="Attributes.Submitted" default="0" />

<cfif Attributes.Submitted EQ 1>
	<cfset Results = Application.ActivityFinance.saveSupport(SupportID=Attributes.SupportID,ActivityID=Attributes.ActivityID,Supporter=Attributes.Supporter,SupportType=Attributes.SupportType,Amount=Attributes.Amount,ContractNum=Attributes.ContractNum,BudgetRequested=Attributes.BudgetRequested,BudgetDueDate=Attributes.BudgetDueDate,BudgetSentDate=Attributes.BudgetSent,SentDate=Attributes.DateSent,FundsReturned=Attributes.FundsReturned)>
    
    <cfif results.getStatus()>
    	<script>
			window.parent.$("#EditSupportRecord").dialog("close");
		</script>
    </cfif>
</cfif>