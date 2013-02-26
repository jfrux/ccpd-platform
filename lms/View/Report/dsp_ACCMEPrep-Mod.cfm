<cfparam name="Attributes.Submitted" default="0">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />


<script>
function updateReports() {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "report.accmeprep-modahah", function(data) {
		$("#ReportsContainer").html(data);
		$("#ReportsLoading").hide();
	});
	
}

function generateReport() {
	sPrepend = "";
	
	if($("#date1").val() == '' || $("#date2").val() == '') {
		alert("You must enter start and end date to continue.");
		return false;
	}
	
	$.blockUI({ message: '<h1>Generating Report...</h1><p>This may take a minute...</p>'});
	$.post(sRootPath + "/_com/Report/accme_newInfo.cfc", 
		{ method: "Run", StartDate: $("#date1").val(), EndDate: $("#date2").val(), returnFormat: "plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			status = $.ListGetAt(cleanData,1,"|");
			statusMsg = $.ListGetAt(cleanData,2,"|");
		
			$("#date1").val("");
			$("#date2").val("");
			
			$.unblockUI();
			updateReports();
			<!---window.location="<cfoutput>#myself#</cfoutput>Report.ACCMEAnnualReport?Message=" + statusMsg;--->
		});
	}

$(document).ready(function() {
	updateReports();
	$("input").unbind("keyup");
});
</script>
<cfoutput>
<h1>ACCME Preparation Report</h1>
<div class="report-area">
	<div class="report-criteria">
		<table>
			<form name="frmACCMEData" method="post" action="">
			<input type="hidden" name="Submitted" value="1">
			<tr>
				<td colspan="2" align="center">Report Generator</td>
			</tr>
			<tr>
				<td>Start Date</td>
				<td><input type="text" name="StartDate" id="date1" value="#Attributes.StartDate#" style="font-size:10pt;width:80px;" /></td>
			</tr>
			<tr>
				<td>End Date</td>
				<td><input type="text" name="EndDate" id="date2" value="#Attributes.EndDate#" style="font-size:10pt;width:80px;" /></td>
			</tr>
			</form>
		</table>
		
		#jButton("Generate Report","javascript:void(0)","accept","generateReport();")#
	</div>
	<div class="report-listing">
		<div id="ReportsContainer"></div>
		<div id="ReportsLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
			<div>Please Wait</div>
		</div>
	</div>
	
</div>
</cfoutput>
