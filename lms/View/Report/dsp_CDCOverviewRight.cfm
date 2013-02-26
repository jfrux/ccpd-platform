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
		$.post(sRootPath + "/_com/Report/CDCReportAJAX.cfc", 
			{ method: "CDCOverviewReport", ReportID: '16', StartDate: $("#date1").val(), EndDate: $("#date2").val(), SectionList: result, returnFormat: "plain" },
			function(returnData) {
				cleanData = $.trim(returnData);
				Status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(Status == 'Success') {
					window.location="<cfoutput>#myself#</cfoutput>Report.CDCOverview?Message=" + statusMsg;
				} else if(Status == 'Fail') {
					addError(statusMsg,250,6000,4000);
					$.unblockUI();
				}
			});
	};
</script>

<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<form name="frmCDCOverview" method="post" action="#Myself#Report.ACCME">
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
	<input type="checkbox" class="ReportSection" name="ReportSection" id="ReportSectionCourses" value="Course" /><label for="ReportSectionCourses">Summary of courses</label><br />
	<input type="checkbox" class="ReportSection" name="ReportSection" id="ReportSectionParticipants" value="Participants" /><label for="ReportSectionParticipants">Summary of Participants</label><br />
	<input type="checkbox" class="ReportSection" name="ReportSection" id="ReportSectionParticipantsCourse" value="ParticipantsCourse" /><label for="ReportSectionParticipantsCourse">Sum. of Part. BY COURSE</label><br />
	<input type="checkbox" class="ReportSection" name="ReportSection" id="ReportSectionParticipantsState" value="ParticipantsState" /><label for="ReportSectionParticipantsState">Sum. of Part. BY STATE</label><br />
	<input type="checkbox" class="ReportSection" name="ReportSection" id="ReportSectionCities" value="Cities" /><label for="ReportSectionCities">Summary of cities</label><br />
	<div class="clear">
		#jButton("Generate Report","javascript:void(0)","accept","generateReport();")#
	</div>
</div>
</form>
</cfoutput>