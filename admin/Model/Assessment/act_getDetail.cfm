<cfparam name="Attributes.AssessmentID" default="0">
<cfif Attributes.AssessmentID GT 0>
<cfset qDetails = Application.Com.AssessmentGateway.getByViewAttributes(AssessmentID=Attributes.AssessmentID)>

<cfparam name="Attributes.PassingScore" default="#qDetails.PassingScore#" />
<cfparam name="Attributes.MaxAttempts" default="#qDetails.MaxAttempts#" />
<cfparam name="Attributes.RequiredFlag" default="#qDetails.RequiredFlag#" />
<cfparam name="Attributes.RandomFlag" default="#qDetails.RandomFlag#" />
<cfparam name="Attributes.CommentFlag" default="#qDetails.CommentFlag#" />
</cfif>