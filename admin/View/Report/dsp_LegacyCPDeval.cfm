<cfparam name="Attributes.Submitted" default="0">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />


<script>
function updateReports() {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "report.cpdEvalsahah", function(data) {
		$("#ReportsContainer").html(data);
		$("#ReportsLoading").hide();
	});
	
}

function generateReport() {
	sPrepend = "";
	
	if($("#CourseID").val() == '') {
		alert('You must select a course...');
		return false;
	}
	$.blockUI({ message: '<h1>Generating Report...</h1><p>This may take a minute...</p>'});
	$.post(sRootPath + "/_com/Report/oldEvals.cfc", 
		{ method: "Run", CourseID: $("#CourseID").val(), returnFormat: "plain" },
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
<cfquery name="qCourses" datasource="#Application.Settings.DSN#">
	SELECT C.CourseID, C.Title
	FROM         ec_Course AS C
	WHERE (SELECT     Count(PT.PersonID)
			FROM         dbo.ec_Person_Training AS PT
			WHERE     (PT.CourseId = C.CourseID) AND PT.TrainingStatusID=1) > 0
	ORDER BY C.Title
</cfquery>
<cfoutput>
<h1>Legacy CPD Evaluations</h1>
<div class="report-area">
	<div class="report-criteria">
		<table>
			<form name="frmACCMEData" method="post" action="">
			<input type="hidden" name="Submitted" value="1">
			<tr>
				<td>Survey</td>
				<td>
					<select name="CourseID" id="CourseID" style="width:250px;font-size:10px;">
						<option value="">select a course</option>
						<cfloop query="qCourses">
						<option value="#qCourses.CourseID#">#Left(qCourses.Title,150)#</option>
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
