<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">

<script>
	$(document).ready(function() {
		$("input").unbind("keyup");
	});
	
	function generateReport() {
	sPrepend = "";
	
	$.blockUI({ message: '<h1>Generating Report...</h1>'});
	$.post("<cfoutput>#Application.Settings.RootPath#</cfoutput>/_com/Report/accmeSummary.cfc", 
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
</script>

<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
	<table>
		<form name="frmACCMEData" method="post" action="#Myself#Report.ACCME">
		<input type="hidden" name="Submitted" value="1">
		<input type="hidden" name="ReportID" value="4">
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
	<div class="clear">
		#jButton("Generate Report","javascript:void(0)","accept","generateReport();")#
	</div>
</div>
</cfoutput>