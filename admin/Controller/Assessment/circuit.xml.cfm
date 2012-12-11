<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Assessment -->
<circuit access="public">
	<prefuseaction>
		<set name="Request.NavItem" value="2" />
		<if condition="isDefined('Attributes.AssessmentID') AND Attributes.AssessmentID NEQ ''">
			<true>
				<do action="mAssessment.getDetail" />
			</true>
		</if>
	</prefuseaction>
	
	<fuseaction name="Create">
    	<do action="mAssessment.saveDetail" />
		<xfa name="AssessSubmit" value="Assessment.Create" />
		<set name="Request.Page.Title" value="Create Assessment" />
		
		<do action="vAssessment.DetailForm" />
	</fuseaction>
	
	<fuseaction name="Edit">
    	<do action="mAssessment.saveDetail" />
		<xfa name="AssessSubmit" value="Assessment.Edit" />
		<set name="Request.Page.Title" value="Edit Assessment" />
        
		<do action="vAssessment.DetailForm" />
	</fuseaction>
	
	<fuseaction name="Questions">
		<do action="mAssessment.getQuestions" />
		<set name="Request.Page.Title" value="Assessment: #qDetails.Name#" />
        
		<do action="vAssessment.Questions" />
	</fuseaction>
	
	<fuseaction name="QuestionCreate">
		<do action="mAssessment.saveQuestion" />
		<xfa name="QuestionSubmit" value="Assessment.QuestionCreate" />
		<set name="Request.Page.Title" value="Create Question" />
        
		<do action="vAssessment.QuestionForm" />
	</fuseaction>
	
	<fuseaction name="QuestionEdit">
		<do action="mAssessment.getQuestion" />
		<do action="mAssessment.saveQuestion" />
		<xfa name="QuestionSubmit" value="Assessment.QuestionEdit" />
		<set name="Request.Page.Title" value="Edit Question" />
        
		<do action="vAssessment.QuestionForm" />
	</fuseaction>
</circuit>