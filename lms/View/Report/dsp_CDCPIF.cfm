<cfparam name="Attributes.Submitted" default="0">
<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />
<script>
function updateReports() {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "Report.CDCPIFAHAH", function(data) {
		$("#ReportContainer").html(data);
		$("#ReportLoading").hide();
	});
	
}

function generateReport(nActivityID) {
	if(nActivityID != 0) {
		$("#ReportLoading").css("display","");
		$.post(sRootPath + "/_com/Report/CDCReportAJAX.cfc", 
			{ method: "CDCPIFReport", ReportID: '14', ActivityID: nActivityID, returnFormat: "plain" },
			function(returnData) {
				cleanData = $.trim(returnData);
				status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(status == 'Success') {
					$("#ActivityID").val("0");
					updateReports();
				} else if(status == 'Fail') {
					addError(statusMsg,250,6000,4000);
					updateReports();
				}
			});
	} else {
		addError("Please select an Activity.",250,6000,4000);
	}
}

$(document).ready(function() {
	updateReports();
});
</script>

<div class="ViewSection">
	<h3>CDC PIF Report</h3>
	<div id="ReportContainer"></div>
	<div id="ReportLoading" class="Loading" style="display:none;"><img src="/admin/_images/ajax-loader.gif" />
		<div>Please Wait</div>
    </div>
</div>
