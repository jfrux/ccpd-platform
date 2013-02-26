<script>
function updatePrereqs() {
	$("#PrereqLoading").show();
	$.post(sMyself + "Activity.PubPrereqsAHAH", { ActivityID: nActivity }, 
		function(data) {
			$("#PrereqContainer").html(data);
			$("#PrereqLoading").hide();
	});
}
$(document).ready(function() {
	updatePrereqs();
});
</script>

<cfoutput>
<div class="ViewSection">
	<h3>Prerequisites</h3>
	<div id="PrereqContainer"></div>
	<div id="PrereqLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
	<div>Please Wait</div></div>
</div>
</cfoutput>