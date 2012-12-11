<cfparam name="Attributes.AssessmentID" default="0" />
<cfparam name="Attributes.AssessTypeID" default="" />
<cfparam name="Attributes.Name" default="" />
<cfparam name="Attributes.Description" default="" />
<cfparam name="Attributes.PassingScore" default="" />
<cfparam name="Attributes.MaxAttempts" default="" />
<cfparam name="Attributes.AssessRequiredFlag" default="N" />
<cfparam name="Attributes.RandomFlag" default="N" />
<cfparam name="Attributes.CommentFlag" default="N" />
<cfparam name="Attributes.Submitted" default="" />

<cfif Attributes.Submitted NEQ "">
	<cfset DetailBean = CreateObject("component","#Application.Settings.Com#Assessment.Assessment").init(AssessmentID=Attributes.AssessmentID,ActivityID=Attributes.ActivityID)>
    
    <cfset DetailBean.setAssessTypeID(Attributes.AssessTypeID)>
    <cfset DetailBean.setName(Attributes.Name)>
    <cfset DetailBean.setDescription(Attributes.Description)>
    <cfset DetailBean.setPassingScore(Attributes.PassingScore)>
    <cfset DetailBean.setMaxAttempts(Attributes.MaxAttempts)>
    <cfset DetailBean.setRequiredFlag(Attributes.AssessRequiredFlag)>
    <cfset DetailBean.setRandomFlag(Attributes.RandomFlag)>
    <cfset DetailBean.setCommentFlag(Attributes.CommentFlag)>
	<!--- Validate Bean --->
	<cfset aErrors = DetailBean.Validate()>
	
	<!--- Fill Request.Status.Errors --->
	<cfloop from="1" to="#ArrayLen(aErrors)#" index="i">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,aErrors[i].Message,"|")>
	</cfloop>
    
    <cfif Request.Status.Errors EQ "">
		<cfset DetailBean = Application.Com.AssessmentDAO.Save(DetailBean)>
    </cfif>
</cfif>