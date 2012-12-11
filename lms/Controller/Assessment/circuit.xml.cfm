<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Assessment -->
<circuit access="public" xmlns:cs="coldspring/">
    <fuseaction name="Build">
    	<do action="mAssessment.saveAssessment" />
    	<do action="mAssessment.getAssessment" />
    	<do action="mAssessment.getAssessResult" />
    	<do action="mAssessment.getQuestions" />
        <do action="vAssessment.BuildAssessment" />
    </fuseaction>
</circuit>