<cfparam name="Attributes.FeeID" default="0">
<cfparam name="Attributes.DisplayName" default="">
<cfparam name="Attributes.Name" default="">
<cfparam name="Attributes.FeeStartDate" default="">
<cfparam name="Attributes.FeeStartTime" default="">
<cfparam name="Attributes.FeeEndDate" default="">
<cfparam name="Attributes.FeeEndTime" default="">
<cfparam name="Attributes.Amount" default="">
<cfparam name="Attributes.ActionAmount" default="0">
<cfparam name="Attributes.StartDateTime" default="">
<cfparam name="Attributes.EndDateTime" default="">

<cfif IsDefined("Attributes.Submitted") AND Attributes.Submitted EQ 1>
	<cfset ActivityFeeBean = CreateObject("component","#Application.Settings.Com#ActivityFinance.Fee").Init(FeeID=Attributes.FeeID,ActivityID=Attributes.ActivityID)>
	
	<cfif Attributes.FeeStartDate NEQ "" AND IsDate(Attributes.FeeStartDate) AND Attributes.FeeStartTime NEQ "" AND IsDate(Attributes.FeeStartTime) AND Attributes.FeeEndDate NEQ "" AND IsDate(Attributes.FeeEndDate) AND Attributes.FeeEndTime NEQ "" AND IsDate(Attributes.FeeEndTime)>
		<!--- CREATE START AND END DATETIME VARIABLES --->
		<cfset Attributes.StartDateTime = CreateODBCDateTime(Attributes.FeeStartDate & " " & Attributes.FeeStartTime)>
		<cfset Attributes.EndDateTime = CreateODBCDateTime(Attributes.FeeEndDate & " " & Attributes.FeeEndTime)>
	<cfelse>
    	<!--- SET VARIABLES IF THEY WERE BLANK --->
		<cfif Attributes.FeeStartDate EQ "" OR NOT IsDate(Attributes.FeeStartDate)>
        	<cfset Attributes.FeeStartDate = Attributes.ReleaseDate>
		</cfif>
		<cfif Attributes.FeeStartTime EQ "" OR NOT IsDate(Attributes.FeeStartTime)>
        	<cfset Attributes.FeeStartTime = "00:00:00">
		</cfif>
		<cfif Attributes.FeeEndDate EQ "" OR NOT IsDate(Attributes.FeeEndDate)>
        	<cfset Attributes.FeeEndDate = Attributes.ReleaseDate>
		</cfif>
		<cfif Attributes.FeeEndTime EQ "" OR NOT IsDate(Attributes.FeeEndTime)>
        	<cfset Attributes.FeeEndTime = "23:59:59">
		</cfif>
		<!--- CREATE START AND END DATETIME VARIABLES --->
		<cfset Attributes.StartDateTime = CreateODBCDateTime(Attributes.FeeStartDate & " " & Attributes.FeeStartTime)>
		<cfset Attributes.EndDateTime = CreateODBCDateTime(Attributes.FeeEndDate & " " & Attributes.FeeEndTime)>
	</cfif>
	
	<!--- Enter User defined vars into the bean --->
	<cfset ActivityFeeBean.setName(Attributes.Name)>
	<cfset ActivityFeeBean.setDisplayName(Attributes.Name)>
	<cfset ActivityFeeBean.setStartDate(Attributes.StartDateTime)>
	<cfset ActivityFeeBean.setEndDate(Attributes.EndDateTime)>
	
	<!--- Only modifies the amount if the amount is greater than zero --->
	<cfif Len(Attributes.Amount) GT 0 AND isNumeric(Attributes.Amount)>
		<!--- Make sure the user didn't try to enter a negative number for the amount --->
		<cfif Attributes.Amount LT 0>
			<cfset Attributes.Amount = Attributes.Amount * -1>
		</cfif>
	
		<cfset Attributes.ActionAmount = "$" & Attributes.Amount>
	</cfif>
	
	<!--- Sets the Amount in the bean --->
	<cfset ActivityFeeBean.setAmount(Attributes.Amount)>
	
	<!--- Determines if it is a new Ledger or an edited ledger --->
	<cfif Attributes.FeeID EQ 0>
		<cfset ActivityFeeBean.setCreatedBy(Session.Person.getPersonID())>
	<cfelse>
		<cfset ActivityFeeBean.setUpdatedBy(Session.Person.getPersonID())>
	</cfif>
	
	<!--- Validate Bean --->
	<cfset aErrors = ActivityFeeBean.Validate()>
	
	<!--- Fill Request.Status.Errors --->
	<cfloop from="1" to="#ArrayLen(aErrors)#" index="i">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,aErrors[i].Message,"|")>
	</cfloop>
	
	<cfif Request.Status.Errors EQ "">
		<cftry>
			<!--- Save Ledger Entry to the DB --->
			<cfset ActivityFeeBean = Application.Com.ActivityFeeDAO.Save(ActivityFeeBean)>
				
			<!--- Acquire Activity Info --->
			<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Attributes.ActivityID)>
			<cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
			
			<!--- Save the action for the Ledger Entry Save --->
			<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
            <cfset ActionBean.setActivityID(Attributes.ActivityID)>
            <cfset ActionBean.setShortName("Added a fee entry.")>
			<cfset ActionBean.setCode("FEEA")>
            <cfset ActionBean.setLongName("Added a fee to activity '<a href=""#myself#Activity.Detail?ActivityID=#ActivityBean.getActivityID()#"">#ActivityBean.getTitle()#</a>' for the amount of #Attributes.ActionAmount#.")>\
            <cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
            <cfset Application.Com.ActionDAO.Create(ActionBean)>
			
			<cflocation url="#Myself#Activity.FinFees?ActivityID=#Attributes.ActivityID#" addtoken="no">
			
			<cfcatch type="any">
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Error: " & cfcatch.Message,"|")>
			</cfcatch>
		</cftry>
	</cfif>
</cfif>