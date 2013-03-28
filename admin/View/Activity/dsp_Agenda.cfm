<script>
	function updateAgenda() {
		$("#AgendaLoading").show();
		
		$.post(sMyself + "Activity.AgendaAHAH", { ActivityID: nActivity }, 
			function(data) {
				$("#AgendaContainer").html(data);
				$("#AgendaLoading").hide();
		});
	}
	
	$(document).ready(function (){
		updateAgenda();
	});
</script>
<cfoutput>
<div class="ViewSection">
	<div id="AgendaContainer"></div>
	<div id="AgendaLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
	<div>Please Wait</div>
	</div>
</div>

<div id="ItemDialog" style="display:none;">
	<div id="Loading" style="display:none;">Loading...</div>
	<div id="FormArea"></div>
</div>
</cfoutput>