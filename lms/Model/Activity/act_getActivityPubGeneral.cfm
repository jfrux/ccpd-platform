<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="attributes.Goals" default="" />
<cfparam name="attributes.Keywords" default="" />
<cfparam name="attributes.LinkName" default="" />
<cfparam name="attributes.Objectives" default="" />
<cfparam name="attributes.overview" default="" />
<cfparam name="attributes.PaymentFlag" default="" />
<cfparam name="attributes.PaymentFee" default="" />
<cfparam name="attributes.PubGeneralID" default="0" />
<cfparam name="attributes.PublishDate" default="" />
<cfparam name="attributes.RemoveDate" default="" />
<cfparam name="attributes.RestrictedFlag" default="N" />
<cfparam name="attributes.TermsFlag" default="" />
<cfparam name="attributes.TermsText" default="" />
<cfparam name="attributes.StatVoteCount" default="" />
<cfparam name="attributes.StatVoteValue" default="" />

<cfset ActivityPubGeneral = CreateObject("component","#Application.Settings.Com#ActivityPubGeneral.ActivityPubGeneral").Init(ActivityID=Attributes.ActivityID)>
<cfset PubGeneralExists = Application.Com.ActivityPubGeneralDAO.Exists(ActivityPubGeneral)>

<cfif PubGeneralExists>
    <cfset ActivityPubGeneral = Application.Com.ActivityPubGeneralDAO.Read(ActivityPubGeneral)>
    
    <cfset Attributes.Goals = ActivityPubGeneral.getGoals()>
    <cfset Attributes.Keywords = ActivityPubGeneral.getKeywords()>
    <cfset Attributes.LinkName = ActivityPubGeneral.getLinkName()>
    <cfset Attributes.Objectives = ActivityPubGeneral.getObjectives()>
    <cfset Attributes.Overview = ActivityPubGeneral.getOverview()>
    <cfset Attributes.PaymentFlag = ActivityPubGeneral.getPaymentFlag()>
	<cfset Attributes.PaymentFee = ActivityPubGeneral.getPaymentFee()>
    <cfset Attributes.PubGeneralID = ActivityPubGeneral.getPubGeneralID()>
    <cfset Attributes.ExtHostFlag = ActivityPubGeneral.getExtHostFlag()>
    <cfset Attributes.ExtHostLink = ActivityPubGeneral.getExtHostLink()>
    <cfset Attributes.PublishDate = ActivityPubGeneral.getPublishDate()>
    <cfset Attributes.RemoveDate = ActivityPubGeneral.getRemoveDate()>
    <cfset Attributes.RestrictedFlag = ActivityPubGeneral.getRestrictedFlag()>
    <cfset Attributes.TermsFlag = ActivityPubGeneral.getTermsFlag()>
    <cfset Attributes.TermsText = ActivityPubGeneral.getTermsText()>
	<cfset Attributes.StatVoteCount = ActivityPubGeneral.getStatVoteCount()>
	<cfset Attributes.StatVoteValue = ActivityPubGeneral.getStatVoteValue()>
</cfif>