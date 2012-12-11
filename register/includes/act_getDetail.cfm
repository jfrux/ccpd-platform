<cfset qDetails = Application.Com.AssessmentGateway.getByViewAttributes(AssessmentID=url.AssessmentID)>

<cfparam name="Attributes.AssessTypeID" default="#qDetails.AssessTypeID#" />
<cfparam name="Attributes.Name" default="#qDetails.Name#" />
<cfparam name="Attributes.Description" default="#qDetails.Description#" />
<cfparam name="Attributes.PassingScore" default="#qDetails.PassingScore#" />
<cfparam name="Attributes.MaxAttempts" default="#qDetails.MaxAttempts#" />
<cfparam name="Attributes.RequiredFlag" default="#qDetails.RequiredFlag#" />
<cfparam name="Attributes.RandomFlag" default="#qDetails.RandomFlag#" />
<cfparam name="Attributes.CommentFlag" default="#qDetails.CommentFlag#" />