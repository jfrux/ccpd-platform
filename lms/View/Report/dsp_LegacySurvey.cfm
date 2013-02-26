<cfparam name="Attributes.Submitted" default="0">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />


<script>
function updateReports() {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "report.legacysurveyahah", function(data) {
		$("#ReportsContainer").html(data);
		$("#ReportsLoading").hide();
	});
	
}

function generateReport() {
	sPrepend = "";
	
	if($("#formname").val() == '') {
		alert('You must select a survey...');
		return false;
	}
	$.blockUI({ message: '<h1>Generating Report...</h1><p>This may take a minute...</p>'});
	$.post(sRootPath + "/_com/Report/legacyAssessResult.cfc", 
		{ method: "Run", formname: $("#formname").val(), returnFormat: "plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			status = $.ListGetAt(cleanData,1,"|");
			statusMsg = $.ListGetAt(cleanData,2,"|");
			
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
<cfquery name="qSurveys" datasource="CCPD-SQL">
	SELECT DISTINCT resultform,
		  (SELECT     COUNT(resultid) AS Expr1
			FROM          afhformresults
			WHERE      (resultform = afr.resultform)) AS resultcount
	FROM         afhformresults AS afr
	ORDER BY resultform
</cfquery>
<cfoutput>
<h1>ACCME Preparation Report</h1>
<div class="report-area">
	<div class="report-criteria">
		<table>
			<form name="frmACCMEData" method="post" action="">
			<input type="hidden" name="Submitted" value="1">
			<tr>
				<td>Survey</td>
				<td>
					<select name="formname" id="formname">
						<option value="">select a survey</option>
						<cfloop query="qSurveys">
						<option value="#qSurveys.resultform#">#qSurveys.resultform# [results: #qSurveys.resultcount#]</option>
						</cfloop>
					</select>
				</td>
				<td>
				
		#jButton("Generate Report","javascript:void(0)","accept","generateReport();")#
				</td>
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
