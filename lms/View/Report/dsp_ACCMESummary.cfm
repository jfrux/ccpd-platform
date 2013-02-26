<cfparam name="Attributes.Submitted" default="0">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.ReportID" default="11">
<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />

<script>
function updateReports() {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "Report.ACCMESummaryAHAH", function(data) {
		$("#ReportsContainer").html(data);
		$("#ReportsLoading").hide();
	});
	
}

$(document).ready(function() {
	updateReports();
});
</script>

<cfoutput>
<div class="ViewSection">
	<h3>Generated Reports</h3>
	<div id="ReportsContainer"></div>
	<div id="ReportsLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
		<div>Please Wait</div>
    </div>
</div>
</cfoutput>
