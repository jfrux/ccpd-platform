<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">

<script>
	function generateReport() {
		sPrepend = "";
		result = "";
		
		// COLLECT LIST OF REPORT SECTIONS TO INCLUDE
		$(".ReportSection:checked").each(function () {
			result = $.ListAppend(result,$(this).val(),",");
		});
		
		$.blockUI({ message: '<h1>Generating Report...</h1>'});
		
		 // RUN CDC ACTIVITY REPORT
		$.ajax({
			url: sRootPath + '/_com/Report/overview.cfc', 
			type: 'post',
			data: { method: "Run", ReportID: '27', StartDate: $('#date1').val(), EndDate: $('#date2').val(), SectionList: result, returnFormat: 'plain' },
			dataType: 'json',
			success: function(returnData) {
				if(returnData.STATUS) {
					window.location= sMyself + 'Report.Overview?Message=' + returnData.STATUSMSG;
				} else {
					addError(returnData.STATUSMSG,250,6000,4000);
					$.unblockUI();
				}
			}
		});
	};
</script>

<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<form name="frmCDCOverview" method="post" action="#Myself#Report.overview">
<div class="MultiFormRight_SectSubTitle">Date range for report</div>
<div class="MultiFormRight_SectBody">
	<table>
		<input type="hidden" name="Submitted" value="1">
		<input type="hidden" name="ReportID" value="15">
		<tr>
			<td>Start Date</td>
			<td><input type="text" name="StartDate" id="date1" value="#Attributes.StartDate#" style="font-size:10pt;width:80px;" /></td>
		</tr>
		<tr>
			<td>End Date</td>
			<td><input type="text" name="EndDate" id="date2" value="#Attributes.EndDate#" style="font-size:10pt;width:80px;" /></td>
		</tr>
	</table>
</div>
<div class="MultiFormRight_SectSubTitle">Select Report Sections</div>
<div class="MultiFormRight_SectBody">
	<div class="clear">
		#jButton("Generate Report","javascript:void(0)","accept","generateReport();")#
	</div>
</div>
</form>
</cfoutput>