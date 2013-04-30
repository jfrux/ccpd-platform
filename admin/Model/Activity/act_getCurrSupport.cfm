<cfset SupportBean = CreateObject("component","#Application.Settings.Com#ActivityFinance.Support").Init(SupportID=Attributes.SupportID)>
<cfif attributes.supportid GT 0>
  <cfset SupportBean = Application.Com.ActivitySupportDAO.Read(SupportBean)>
</cfif>
<cfset Attributes.Amount = SupportBean.getAmount()>
<cfset Attributes.Supporter = SupportBean.getSupporterID()>
<cfset Attributes.SupporterID = attributes.supporter>
<cfset Attributes.SupportType = SupportBean.getSupportTypeID()>
<cfset Attributes.ContractNum = SupportBean.getContractNum()>
<cfset Attributes.BudgetRequested = SupportBean.getBudgetRequested()>
<cfset Attributes.BudgetDueDate = SupportBean.getBudgetDueDate()>
<cfset Attributes.BudgetSent = SupportBean.getBudgetSentDate()>
<cfset Attributes.DateSent = SupportBean.getSentDate()>
<cfset Attributes.RundsReturned = SupportBean.getFundsReturned()>