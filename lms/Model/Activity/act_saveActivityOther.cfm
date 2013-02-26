<cfparam name="Attributes.OtherID" default="0">
<cfparam name="Attributes.DidacticHrs" default="0">
<cfparam name="Attributes.ExperimentalHrs" default="0">
<cfparam name="Attributes.SecClinSiteFlag" default="N">
<cfparam name="Attributes.CollabPTCFlag" default="N">
<cfparam name="Attributes.CollabPTCSpecify" default="">
<cfparam name="Attributes.CollabAgencyFlag" default="N">
<cfparam name="Attributes.CollabAgencySpecify" default="">

<cfif IsDefined("Attributes.Submitted") AND Attributes.Submitted EQ 1>
	<!--- Create ActivityOtherBean with User Defined vars --->
	<cfset ActivityOtherBean = CreateObject("component","#Application.Settings.Com#ActivityOther.ActivityOther").Init(OtherID=Attributes.OtherID)>
	
	<!--- Fill ActivityOtherBean with User Defined vars --->
	<cfset ActivityOtherBean.setActivityID(Attributes.ActivityID)>
	<cfset ActivityOtherBean.setDidacticHrs(Attributes.DidacticHrs)>
	<cfset ActivityOtherBean.setExperimentalHrs(Attributes.ExperimentalHrs)>
	<cfset ActivityOtherBean.setSecClinSiteFlag(Attributes.SecClinSiteFlag)>
	<cfset ActivityOtherBean.setCollabPTCFlag(Attributes.CollabPTCFlag)>
	<cfset ActivityOtherBean.setCollabPTCSpecify(Attributes.CollabPTCSpecify)>
	<cfset ActivityOtherBean.setCollabAgencyFlag(Attributes.CollabAgencyFlag)>
	<cfset ActivityOtherBean.setCollabAgencySpecify(Attributes.CollabAgencySpecify)>
	
	<!--- Validate Bean --->
	<cfset aErrors = ActivityOtherBean.Validate()>
	
	<!--- Fill Request.Status.Errors --->
	<cfloop from="1" to="#ArrayLen(aErrors)#" index="i">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,aErrors[i].Message,"|")>
	</cfloop>
	
	<!--- Check if Request.Status.Errors is Empty, if so try to save data --->
	<cfif Request.Status.Errors EQ "">
			<cfset ActivityOtherbean = Application.Com.ActivityOtherDAO.Save(ActivityOtherBean)>
			<cflocation url="#Myself#Activity.Other?ActivityID=#Attributes.ActivityID#" addtoken="no">
	</cfif>
</cfif>