<cfparam name="Attributes.Submitted" default="0">
<cfinclude template="#Application.Settings.RootPath#/_com/_UDF/ByteConvert.cfm" />
<script>
function updateReports() {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "Report.AssessmentAHAH", function(data) {
		$("#ReportContainer").html(data);
		$("#ReportLoading").hide();
	});
	
}

function generateReport(nAssessmentID) {
	if(nAssessmentID != "") {
		$("#ReportLoading").css("display","");
		$.post(sRootPath + "/_com/Report/Assess_AnswerDump.cfc?AssessmentID=" + nAssessmentID, 
			{ method: "Run", 'submit': "Download", returnFormat: "plain" },
			function(returnData) {
				cleanData = $.trim(returnData);
				status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(status == 'Success') {
					$("#ActivityID").val("");
					updateReports();
				} else if(status == 'Fail') {
					addError(statusMsg,250,6000,4000);
					updateReports();
				}
			});
	} else {
		addError("Please select an Assessment.",250,6000,4000);
	}
}

$(document).ready(function() {
	updateReports();
});
</script>
<cfoutput>
<div class="ViewSection">
	<h3>#Request.MultiFormTitle#</h3>
	<div id="ReportContainer"></div>
	<div id="ReportLoading" class="Loading" style="display:none;"><img src="/admin/_images/ajax-loader.gif" />
		<div>Please Wait</div>
    </div>
</div>
</cfoutput>
