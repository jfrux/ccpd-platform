<cfparam name="Attributes.AssessmentID" default="" />

<cfset AssessmentBean = CreateObject("component","#Application.Settings.Com#Assessment.Assessment").Init(AssessmentID=Attributes.AssessmentID)>

<cfif Application.Com.AssessmentDAO.Exists(AssessmentBean)>
	<cfset AssessmentBean = Application.Com.AssessmentDAO.Read(AssessmentBean)>
    
    <!--- SET ATTRIBUTES SCOPE --->
    <cfset Attributes.ActivityID = AssessmentBean.getActivityID()>
    <cfset Attributes.AssessTypeID = AssessmentBean.getAssessTypeID()>
    <cfset Attributes.CommentFlag = AssessmentBean.getCommentFlag()>
    <cfset Attributes.Created = AssessmentBean.getCreated()>
    <cfset Attributes.CreatedBy = AssessmentBean.getCreatedBy()>
    <cfset Attributes.Deleted = AssessmentBean.getDeleted()>
    <cfset Attributes.DeletedFlag = AssessmentBean.getDeletedFlag()>
    <cfset Attributes.Description = AssessmentBean.getDescription()>
    <cfset Attributes.MaxAttempts = AssessmentBean.getMaxAttempts()>
    <cfset Attributes.Name = AssessmentBean.getName()>
    <cfset Attributes.PassingScore = AssessmentBean.getPassingScore()>
    <cfset Attributes.RandomFlag = AssessmentBean.getRandomFlag()>
    <cfset Attributes.RequiredFlag = AssessmentBean.getRequiredFlag()>
    <cfset Attributes.Sort = AssessmentBean.getSort()>
    <cfset Attributes.Updated = AssessmentBean.getUpdated()>
    <cfset Attributes.UpdatedBy = AssessmentBean.getUpdatedBy()>
</cfif>