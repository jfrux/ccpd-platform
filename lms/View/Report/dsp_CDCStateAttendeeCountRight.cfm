<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">

<script>
	function generateReport() {
		if($("#date1").val() != "" && $("#date2").val() != "") {		
			$.blockUI({ message: '<h1>Generating Report...</h1>'});
			
			 // RUN CDC ACTIVITY REPORT
			$.post(sRootPath + "/_com/Report/CDCState_ActivityType.cfc", 
				{ method: "Run", StartDate: $("#date1").val(), EndDate: $("#date2").val(), returnFormat: "plain" },
				function(returnData) {
				
						window.location="<cfoutput>#myself#</cfoutput>Report.CDCStateAttendeeCount";

				});
		} else {
			addError("Please enter a Start and End Date.",250,6000,4000);
			return false;
		}
	};
</script>

<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectSubTitle">Date range for report</div>
<div class="MultiFormRight_SectBody">
<form>
	<table>
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
<div class="MultiFormRight_SectBody">
	<div class="clear">
		#jButton("Generate Report","javascript:void(0)","accept","generateReport();")#
	</div>
</div>
</form>
</cfoutput>