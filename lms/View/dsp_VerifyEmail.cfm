<cfparam name="attributes.v" default="" />
<cfparam name="attributes.k" default="" />

<script>
<cfoutput>
var sV = '#attributes.v#';
var sK = '#attributes.k#';
</cfoutput>
$(document).ready(function() {
	$.ajax({
		url: sRootPath + '/_com/ajax_auth.cfc',
		type: 'post',
		data: { method: 'verifyEmail', v: sV, k: sK, returnFormat: 'plain' },
		dataType: 'json',
		success: function(data) {
			$('#EmailLoading').detach();
			$('#EmailContainer').html(data.STATUSMSG);
		}
	});
});
</script>
<div class="ContentBlock">
	<h1>Email Address Verification</h1>
	<div id="EmailContainer"></div>
	<div id="EmailLoading" class="Loading">
		<div>Please wait while your email address is verified...</div>
    	<img src="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_images/ajax-loader.gif" />
	</div>
</div>