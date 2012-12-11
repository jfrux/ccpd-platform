<script>
<cfoutput>
var sEmail = '#attributes.email#';
</cfoutput>
$(document).ready(function() {
	$('#resend-credentials').click(function() {
		$.ajax({
			url: sRootPath + '/_com/ajax_person.cfc',
			type: 'post',
			data: { method: 'requestPassword', email: sEmail, returnFormat: 'plain' },
			dataType: 'json',
			success: function(data) {
				if(data.STATUS) {
					addMessage(data.STATUSMSG,250,6000,4000);
				} else {
					addError(data.STATUSMSG,250,6000,4000);
				}
			}
		});
	});
});
</script>

<cfoutput>
<p><strong>AccountID:</strong> <cfif len(trim(attributes.email)) EQ 0><strong><a href="#application.settings.rootPath#/index.cfm/event/person.email?personId=#attributes.personId#">Needs Email</a></strong><cfelse><span id="AccountID">#Attributes.Email#</span></cfif><br /><strong>Password:</strong> <cfif len(trim(attributes.password)) EQ 0><strong>No Password</strong><cfelse><a href="javascript://" id="resend-credentials">Resend Credentials</a></cfif></p>
<p>
    <strong>New Password:</strong> <input type="password" name="NewPassword" id="NewPassword" /><br />
    <strong>Confirm Password:</strong> <input type="password" name="ConfirmPassword" id="ConfirmPassword" />
</p>
</cfoutput>