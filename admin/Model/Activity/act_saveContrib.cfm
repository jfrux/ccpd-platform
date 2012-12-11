<cfparam name="Attributes.ContributorID" default="-1">

<cfif IsDefined("Attributes.Submitted")>
	<cfset Request.Status.Errors = "">
	
	<!--- Checks if a new contributor is being created or one is being selected from the list --->
	<cfif Attributes.ContributorID EQ "">
		<cfif Attributes.ContributorName EQ "">
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a Contributor Name.","|")>
		</cfif>
	<cfelseif Attributes.ContributorID EQ "0">
		<!--- Determines if Contributor Drop down was changed at all --->
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select a Contributor.","|")>
	</cfif>
	
	<cfif Attributes.TypeID EQ "0">
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please select a Contributor Type.","|")>
	</cfif>
	
	<cfif Attributes.Amount EQ "">
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter an Amount.","|")>
	</cfif>
	
	<cfif Request.Status.Errors EQ "">
		<!--- Create Contributor Bean --->
		<cfset ContribBean = CreateObject("component","#Application.Settings.Com#Contributor").Init(ContributorID=Attributes.ContributorID)>
		
		<!--- Fills the Contributor Bean --->
		<cfset ContribBean.setContributorID(Attributes.ContributorID)> 
		<cfset ContribBean.setName(Attributes.ContributorName)> 
		<cfset ContribBean.setDescription(Attributes.ContributorDescription)> 
		
		
		<!--- Saves ContributorBean Data --->
		<cfset NewContributorID = Application.Com.ContributorDAO.Save(ContribBean)>
		
		<cfif Attributes.ContributorID EQ -1>
			<cfset Attributes.ContributorID = NewContributorID>
		</cfif>
		
		<!--- Create ActivityContributor Bean --->
		<cfset ActivityContribBean = CreateObject("component","#Application.Settings.Com#ActivityContrib").Init(ContributorID=Attributes.ContributorID)>
		
		<!--- Fills the ActivityContributor Bean --->
		<cfset ActivityContribBean.setActivityContribID(Attributes.ContributorID)> 
		<cfset ActivityContribBean.setActivityID(Attributes.ActivityID)> 
		<cfset ActivityContribBean.setContributorID(Attributes.ContributorID)>
		<cfset ActivityContribBean.setContribTypeID(Attributes.TypeID)> 
		<cfset ActivityContribBean.setAmount(Attributes.Amount)>
		
		<!--- Submits the Bean for data saving --->
		<cfset ActivityContribBean = Application.Com.ActivityContribDAO.Save(ActivityContribBean)>
		<cflocation url="#Myself#Activity.Contrib&ActivityID=#Attributes.ActivityID#" addtoken="no">
	</cfif>
</cfif>