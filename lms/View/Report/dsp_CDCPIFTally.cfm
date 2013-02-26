<cfparam name="Attributes.Submitted" default="0">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">

<script>
function updateReports() {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "Report.CDCPIFTallyAHAH", function(data) {
		$("#ReportContainer").html(data);
		$("#ReportLoading").hide();
	});
	
}

function generateReport() {
	sPrepend = "";
	
	if($("#date1").val() == "") {
		addError("You must enter a Start Date.",250,6000,4000);
		return false;
	} else if($("#date2").val() == "") {
		addError("You must enter an End Date.",250,6000,4000);
		return false;
	} else {
		 // RUN CDC ACTIVITY REPORT
		$.post(sRootPath + "/_com/Report/CDCPIFTally.cfc", { method: "run", StartDate: $("#date1").val(), EndDate: $("#date2").val(), returnFormat: "plain" },
			function(data) {
			
			updateReports();
		});
	}
};

$(document).ready(function() {
	updateReports();
	
	$("#btnSubmit").click(function() {
		generateReport();
	});
});
</script>

<cfoutput>
<div class="report-area">
	<div class="report-criteria">
		<h1>CDC PIF Tally</h1>
        <table border="0" cellspacing="1" cellpadding="0">
			<tr>
				<td>Start Date</td>
				<td><input type="text" name="StartDate" id="date1" value="#Attributes.StartDate#" style="font-size:10pt;width:80px;" /></td>
			</tr>
			<tr>
				<td>End Date</td>
				<td><input type="text" name="EndDate" id="date2" value="#Attributes.EndDate#" style="font-size:10pt;width:80px;" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" name="btnSubmit" id="btnSubmit" value="Generate Report" /></td>
			</tr>
		</table>
	</div>
    <div id="ReportContainer"></div>
</div>
</cfoutput>
