<cfparam name="Attributes.SupportID" default="0">
<cfparam name="Attributes.Supporter" default="">
<cfparam name="Attributes.SupportType" default="">
<cfparam name="Attributes.Amount" default="0">

<cfif IsDefined("Attributes.Submitted") AND Attributes.Submitted EQ 1>
	<!--- Create ActivitySupportBean --->
	<cfset ActivitySupportBean = CreateObject("component","#Application.Settings.Com#ActivityFinance.Support").Init(SupportID=Attributes.SupportID,ActivityID=Attributes.ActivityID)>
	
	<!--- Insert User defined Variables --->
	<cfset ActivitySupportBean.setAmount(Attributes.Amount)>
	<cfset ActivitySupportBean.setSupporterID(Attributes.Supporter)>
	<cfset ActivitySupportBean.setSupportTypeID(Attributes.SupportType)>
	
	<!--- Checks if this is a new activity support --->
	<cfif Attributes.SupportID EQ 0>
		<cfset ActivitySupportBean.setCreatedBy(Session.Person.getPersonID())>
	<cfelse>
		<cfset ActivitySupportBean.setUpdatedBy(Session.Person.getPersonID())>
	</cfif>
	
	<!--- Validate Bean --->
	<cfset aErrors = ActivitySupportBean.Validate()>
	
	<!--- Fill Request.Status.Errors --->
	<cfloop from="1" to="#ArrayLen(aErrors)#" index="i">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,aErrors[i].Message,"|")>
	</cfloop>
	
	<cfif Attributes.Amount EQ 0>
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Amount is required","|")>
	</cfif>
	
	<cfif Request.Status.Errors EQ "">
		<cftry>
			<cfset ActivitySupportBean = Application.Com.ActivitySupportDAO.Save(ActivitySupportBean)>
				
			<!--- Read in the ActivitySupport information --->
			<cfset qActivitySupport = Application.Com.ActivitySupportGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,SupportID=ActivitySupportBean)>
			
			<!--- Acquire Activity Info --->
			<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Attributes.ActivityID)>
			<cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
			
			<!--- Update Activity Stats --->
			<cfset ActivityBean.setStatSupporters(ActivityBean.getStatSupporters()+1)>
			<cfset ActivityBean.setStatSuppAmount(ActivityBean.getStatSuppAmount()+Attributes.Amount)>
			
			<cfif ActivityBean.getParentActivityID() NEQ "">
				<cfset ParentActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=ActivityBean.getParentActivityID())>
				<cfset ParentActivityBean = Application.Com.ActivityDAO.Read(ParentActivityBean)>
				<cfset ParentActivityBean.setStatSupporters(ParentActivityBean.getStatSupporters()+1)>
				<cfset ParentActivityBean.setStatSuppAmount(ParentActivityBean.getStatSuppAmount()+Attributes.Amount)>
				<cfset ParentActivityBean = Application.Com.ActivityDAO.Update(ParentActivityBean)>
			</cfif>

			<!--- Adjust qActivitySupport.Amount for display --->
			<cfset qActivitySupport.Amount = "$" & qActivitySupport.Amount>
			
			<!--- Save the action for the Support Entry Save --->
			<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
            <cfset ActionBean.setActivityID(Attributes.ActivityID)>
            <cfset ActionBean.setShortName("Added a support entry.")>
			<cfset ActionBean.setCode("SUPA")>
            <cfset ActionBean.setLongName("Added a support entry for #qActivitySupport.SupporterName# (#qActivitySupport.SupportTypeName#) to activity '<a href=""/index.cfm/event/Activity.Detail?ActivityID=#ActivityBean.getActivityID()#"">#ActivityBean.getTitle()#</a>' for the amount of #qActivitySupport.Amount#.")>
            <cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
            <cfset Application.Com.ActionDAO.Create(ActionBean)>
			
			<!--- Save the updated ActivityBean information --->
			<cfset ActivityBean = Application.Com.ActivityDAO.Save(ActivityBean)>
			
			<cflocation url="#Myself#Activity.FinSupport?ActivityID=#Attributes.ActivityID#" addtoken="no">
			
			<cfcatch type="any">
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Error: " & cfcatch.Message,"|")>
			</cfcatch>
		</cftry>
	</cfif>
</cfif>