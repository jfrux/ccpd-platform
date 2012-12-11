<cfparam name="Attributes.FeeID" default="" />

<cfif isNumeric(Attributes.FeeID)>
	<!--- GATHER FEE INFORMATION --->
	<cfset FeeBean = CreateObject("component","#Application.Settings.Com#ActivityFinance.Fee").Init(FeeID=Attributes.FeeID)>
    <cfset FeeBean = Application.Com.ActivityFeeDAO.Read(FeeBean)>
    
    <!--- DEFINE VARIABLES --->
    <cfset Attributes.FeeID = FeeBean.getFeeID()>
    <cfset Attributes.Name = FeeBean.getName()>
    <cfset Attributes.FeeStartDate = DateFormat(FeeBean.getStartDate(), "MM/DD/YYYY")>
    <cfset Attributes.FeeStartTime = TimeFormat(FeeBean.getStartDate(), "hh:mm tt")>
    <cfset Attributes.FeeEndDate = DateFormat(FeeBean.getEndDate(), "MM/DD/YYYY")>
    <cfset Attributes.FeeEndTime = TimeFormat(FeeBean.getEndDate(), "hh:mm tt")>
    <cfset Attributes.Amount = FeeBean.getAmount()>
</cfif>