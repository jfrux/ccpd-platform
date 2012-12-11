<cfparam name="Attributes.PubComponentID" default="" />

<cfset PubComponent = CreateObject("component","#Application.Settings.Com#ActivityPubComponent.ActivityPubComponent").init(PubComponentID=Attributes.PubComponentID)>
<cfif Application.Com.ActivityPubComponentDAO.Exists(PubComponent)>
	<cfset PubComponent = Application.Com.ActivityPubComponentDAO.Read(PubComponent)>
	<cfset Attributes.DisplayName = PubComponent.getDisplayName()>
	<cfset Attributes.Description = PubComponent.getDescription()>
	<cfset Attributes.ExternalURL = PubComponent.getExternalURL()>
	<cfset Attributes.AssessmentID = PubComponent.getAssessmentID()>
	<cfset Attributes.FileID = PubComponent.getFileID()>
</cfif>