<script>
$(document).ready(function() {
	updateAssessments();
	
	$("#AssessDialog").dialog({ 
			title: "Assessment",
			modal: true, 
			autoOpen: false,
			height:550,
			width:900,
			position:[200,100],
			resizable: false,
			draggable: true,
			overlay: { 
				opacity: 0.5, 
				background: "black" 
			} ,
			buttons: { 
				Save:function() {
					$("#formDetail").ajaxSubmit(); 
					addMessage("Assessment successfully created.",250,6000,4000);
					$(this).dialog("close");
					updateAssessments();
					
				},
				Cancel:function() {
					$(this).dialog("close");
				}
			},
			open:function() {
				$.post(sMyself + "Assessment." + AssessType + "?ActivityID=" + nActivity + "&AssessmentID=" + nAssessmentID, function(data) {
					$("#AssessForm").html(data);
				});
			},
			close:function() {
				$("#AssessForm").html("");
			}
		});
	
	$("#AssessLink0").click(function() {
		AssessType = "Create";
		nAssessmentID = 0;
		
		$("#AssessDialog").dialog("open");
		
		return false;
	});
});
	
function updateAssessments() {
	$("#AssessLoading").show();
	$.post(sMyself + "Activity.AssessmentsAHAH?ActivityID=" + nActivity, function(data) {
		$("#AssessContainer").html(data);
		$("#AssessLoading").hide();
	});
};
</script>
<cfoutput>
<div class="ViewSection">
	<h3>Assessments</h3>
	<div id="AssessContainer"></div>
	<div id="AssessLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
	<div>Please Wait</div></div>
</div>
<div id="AssessDialog">
	<div id="AssessForm">
	
	</div>
</div>
<div id="QuestionsDialog">
	<div id="QuestionsForm">
	
	</div>
</div>
</cfoutput>