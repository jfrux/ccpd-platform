<cfparam name="Attributes.ResultID" default="" />
<cfparam name="Attributes.ActivityID" default="" />

<script>
function updateReport(nActivityID, nResultID) {
	$("#ReportsLoading").show();
	
	$.post(sMyself + "Report.AssessSingleAHAH?ActivityID=" + nActivityID + "&ResultID=" + nResultID, function(data) {
		$("#ReportContainer").html(data);
		$("#ReportLoading").hide();
	});
	
}

</script>
<cfoutput>
<div class="ViewSection">
	<h3>#Request.MultiFormTitle#</h3>
	<div id="ReportContainer"></div>
	<div id="ReportLoading" class="Loading" style="display:none;"><img src="/admin/_images/ajax-loader.gif" />
		<div>Please Wait</div>
    </div>
</div>
</cfoutput>