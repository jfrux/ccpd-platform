<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- mAssessment -->
<circuit access="internal">
	<fuseaction name="getAssessTmpl">
    	<include template="act_getAssessTmpl" />
    </fuseaction>

	<fuseaction name="getDetail">
		<include template="act_getDetail" />
	</fuseaction>
	
	<fuseaction name="getQuestions">
		<include template="act_getQuestions" />
	</fuseaction>
	
	<fuseaction name="getQuestion">
		<include template="act_getQuestion" />
	</fuseaction>
	
	<fuseaction name="saveDetail">
		<include template="act_saveDetail" />
	</fuseaction>
	
	<fuseaction name="saveQuestion">
		<include template="act_saveQuestion" />
	</fuseaction>
</circuit>