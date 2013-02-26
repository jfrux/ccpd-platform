<cfparam name="Attributes.PubGeneralID" default="0" />

<cfif NOT IsDefined("Attributes.Submitted")>
	<cfset ActivityPubGeneral = CreateObject("component","#Application.Settings.Com#ActivityPubGeneral.ActivityPubGeneral").Init(ActivityID=Attributes.ActivityID)>
    
    <cfset PubGeneralExists = Application.Com.ActivityPubGeneralDAO.Exists(ActivityPubGeneral)>
	
	<cfif PubGeneralExists>
		<cfset ActivityPubGeneral = Application.Com.ActivityPubGeneralDAO.Read(ActivityPubGeneral)>
        
		<cfset Attributes.Overview = ActivityPubGeneral.getOverview()>
		<cfset Attributes.Keywords = ActivityPubGeneral.getKeywords()>
		<cfset Attributes.Objectives = ActivityPubGeneral.getObjectives()>
		<cfset Attributes.Goals = ActivityPubGeneral.getGoals()>
		<cfset Attributes.PublishDate = DateFormat(ActivityPubGeneral.getPublishDate(),"mm/dd/yyyy")>
		<cfset Attributes.RemoveDate = DateFormat(ActivityPubGeneral.getRemoveDate(),"mm/dd/yyyy")>
        <cfset Attributes.PaymentFlag = ActivityPubGeneral.getPaymentFlag()>
        <cfset Attributes.AllowCommentFlag = ActivityPubGeneral.getAllowCommentFlag()>
        <cfset Attributes.CommentApproveFlag = ActivityPubGeneral.getCommentApproveFlag()>
        <cfset Attributes.NotifyEmails = ActivityPubGeneral.getNotifyEmails()>
        <cfset Attributes.FeaturedFlag = ActivityPubGeneral.getFeaturedFlag()>
        <cfset Attributes.ExtHostFlag = ActivityPubGeneral.getExtHostFlag()>
        <cfset Attributes.ExtHostLink = ActivityPubGeneral.getExtHostLink()>
        <cfset Attributes.PaymentFlag = ActivityPubGeneral.getPaymentFlag()>
		<cfset Attributes.PaymentFee = ActivityPubGeneral.getPaymentFee()>
        <cfset Attributes.PublishFlag = ActivityPubGeneral.getPublishFlag()>
        <cfset Attributes.TermsFlag = ActivityPubGeneral.getTermsFlag()>
        <cfset Attributes.TermsText = ActivityPubGeneral.getTermsText()>
		<cfset Attributes.RestrictedFlag = ActivityPubGeneral.getRestrictedFlag()>
	</cfif>
</cfif>