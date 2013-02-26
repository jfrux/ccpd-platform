<cfparam name="Attributes.ResultID" default="" />
<cfparam name="Attributes.ActivityID" default="" />
<script>
function updateReport(nActivityID) {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "Report.TestingSummaryAHAH?ActivityID=" + nActivityID, function(data) {
		$("#ReportContainer").html(data);
		$("#ReportLoading").hide();
	});
	
}

$(document).ready(function() {
	updateReport();
});

</script>
<div class="ViewSection">
	<h3>CDC Evaluation Report</h3>
	<div id="ReportContainer"></div>
	<div id="ReportLoading" class="Loading" style="display:none;"><img src="/admin/_images/ajax-loader.gif" />
		<div>Please Wait</div>
    </div>
</div>
