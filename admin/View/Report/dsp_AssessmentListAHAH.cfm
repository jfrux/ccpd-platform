<cfoutput>
<script>
$(document).ready(function() {
	$("##AssessmentID").bind("change", this, function() {
		if($("##AssessmentID").val() != "") {
			$("##GenerateReport").show();
		} else {
			$("##GenerateReport").hide();
		}
	});
});
</script>
Assess.:&nbsp;&nbsp;
<select name="AssessmentID" id="AssessmentID" style="width:115px;">
	<option value="">Select one...</option>
    <cfloop query="qAssessments">
	<option value="#qAssessments.AssessmentID#">#qAssessments.Name#</option>
    </cfloop>
</select>
<div id="GenerateReport" class="clear" style="display:none;">
    #jButton("Generate Report","javascript:void(0)","accept","generateReport($('##AssessmentID').val());")#
</div>
</cfoutput>