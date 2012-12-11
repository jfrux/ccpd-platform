<cfparam name="Attributes.AssessmentID" default="0" />

<cfif Attributes.AssessmentID GT 0>
	<cfset qAssessment = Application.Com.AssessmentGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,AssessmentID=Attributes.AssessmentID,DeletedFlag="N")>
    
    <cfif qAssessment.RecordCount GT 0>
    	<cfset qQuestions = Application.Com.AssessQuestionGateway.getByAttributes(AssessmentID=Attributes.AssessmentID,DeletedFlag="N",OrderBy="Sort")>
	</cfif>
<cfelse>
	<cfset qAssessments = Application.Com.AssessmentGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,DeletedFlag="N")>
</cfif>