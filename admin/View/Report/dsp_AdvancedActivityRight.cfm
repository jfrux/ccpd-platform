<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">

<script>
	function generateReport() {
		sPrepend = "";
		
		if($("#ReportType").val() == "") {
			addError("You must select a Report Type.",250,6000,4000);
			return false;
		}
		
		$.blockUI({ message: '<h1>Generating Report...</h1>'});
		$.post(sRootPath + "/_com/Report/AdvancedActivity.cfc", 
			{ method: "Run", ReportID: '7', ReportType: $("#ReportType").val(), ReportTypeDetail: $("#ReportTypeDetailSelect").val(), StartDate: $("#date1").val(), EndDate: $("#date2").val(), returnFormat: "plain" },
			function(returnData) {
				cleanData = $.trim(returnData);
				status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(status == 'Success') {
					window.location= sMyself + "report.advancedactivity?Message=" + statusMsg;
				} else if(status == 'Fail') {
					addError(statusMsg,250,6000,4000);
					$.unblockUI();
				}
			});
	}
	
	$(document).ready(function() {
		$("#ReportType").bind("change", this, function() {
			var $ReportType = $(this).val();
			
			$("#ReportTypeDetail").hide();
			$("#ReportTypeLabel").html("");
			$("#ReportTypeDetailSelect").html("");
				
			if($ReportType != "") {
				$("#ReportTypeLabel").html($ReportType);
				
				switch($ReportType) {
					case "Activity Type":
						$("#ReportTypeDetailSelect").html("");
						$("#ReportTypeDetailSelect").ajaxAddOption(sRootPath + "/_com/report/AdvancedActivity.cfc", { method: "getActivityTypes", returnFormat: "plain" });
						$("#ReportTypeDetail").show();
					break;
					case "Grouping":
						$("#ReportTypeDetailSelect").ajaxAddOption(sRootPath + "/_com/report/AdvancedActivity.cfc", { method: "getGroupings", returnFormat: "plain" });
						$("#ReportTypeDetailSelect").sortOptions();
						$("#ReportTypeDetail").show();
					break;
					case "Session Type":
						$("#ReportTypeDetailSelect").addOption("M", "Multi-session");
						$("#ReportTypeDetailSelect").addOption("S", "Stand-alone");
						$("#ReportTypeDetail").show();
					break;
					case "Sponsorship":
						$("#ReportTypeDetailSelect").addOption("D", "Directly");
						$("#ReportTypeDetailSelect").addOption("J", "Jointly");
						$("#ReportTypeDetail").show();
					break;
				}
			}
		});
	});
</script>

<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
    <form name="frmACCMEData" method="post" action="#Myself#Report.ACCME">
    <input type="hidden" name="Submitted" value="1">
    <input type="hidden" name="ReportID" value="4">
	<table width="160">
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
        <tr>
        	<td colspan="2">
            	Type 
                <select name="ReportType" id="ReportType">
                	<option value="">Select one...</option>
                	<option value="Activity Type">Activity Type</option>
                	<option value="Grouping">Grouping</option>
                	<option value="Session Type">Session Type</option>
                	<option value="Sponsorship">Sponsorship</option>
                </select>
            </td>
        </tr>
	</table>
    <div id="ReportTypeDetail" style="display: none;">
        <span id="ReportTypeLabel"></span>
        <select name="ReportTypeDetail" id="ReportTypeDetailSelect">
        </select>
    </div>
	</form>
	<div class="clear">
		#jButton("Generate Report","javascript:void(0)","accept","generateReport();")#
	</div>
</div>
</cfoutput>