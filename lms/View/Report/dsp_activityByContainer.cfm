<cfparam name="Attributes.Submitted" default="0">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />


<script>
function updateReports() {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "report.activityByContainerAHAH", function(data) {
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
	$.post(sRootPath + "/_com/Report/activityByContainer.cfc", 
		{ method: "Run", StartDate: $("#date1").val(), EndDate: $("#date2").val(), Categories:$("#CategoryID").val(), returnFormat: "plain" },
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
<h1>Activities By Container</h1>
<div class="report-area">
	<div class="report-criteria">
		<table border="0" cellspacing="1" cellpadding="0">
			<form name="frmCategoryLMS" method="get" action="#Application.Settings.RootPath#/_com/Report/ActivityByContainer.cfc">
			<input type="hidden" name="Submitted" value="1">
			<input type="hidden" name="method" value="Run" />
			<tr>
				<td>Start Date</td>
				<td><input type="text" name="StartDate" id="date1" value="#Attributes.StartDate#" style="font-size:10pt;width:80px;" /></td>
			</tr>
			<tr>
				<td>End Date</td>
				<td><input type="text" name="EndDate" id="date2" value="#Attributes.EndDate#" style="font-size:10pt;width:80px;" /></td>
			</tr>
			
			<tr>
				<td colspan="2">Categories (ctrl+click)</td>
			</tr>
			<tr>
				<td colspan="2">
					<cfquery name="Categories" datasource="#Application.Settings.DSN#">
						SELECT     CategoryID, Name, Description
						FROM         ce_Category
						ORDER BY Name
					</cfquery>
					<select name="Categories" size="5" multiple="multiple" id="CategoryID" style="width:355px; font-size:11px; height:80px;">
						<cfloop query="Categories">
						<option value="#Categories.CategoryID#">#Categories.Name#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			
			<tr>
				<td colspan="2"><input type="submit" value="Generate Report" /></td>
			</tr>
			</form>
		</table>
	</div>
	<div class="report-listing">
		<div id="ReportsContainer"></div>
		<div id="ReportsLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
			<div>Please Wait</div>
		</div>
	</div>
	
</div>
</cfoutput>
