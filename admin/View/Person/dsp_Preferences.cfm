<script>
App.Person.Preferences.start();
	function updatePreferences() {
		$("#PreferencesLoading").show();
		$.post(sMyself + "Person.PreferencesAHAH", { PersonID: nPerson },
			function(data) {
				$("#PreferencesContainer").html(data);
				$("#PreferencesLoading").hide();
		});
	}
	
	$(document).ready(function() {
		updatePreferences();
	});
</script>

<div class="ViewSection">
	<div id="PreferencesContainer"></div>
	<div id="PreferencesLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
	<div>Please Wait</div></div>
</div>