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
  <form class="form-horizontal">
    <div class="control-group">
      <label class="control-label">Account ID</label>
      <div class="controls">
        <cfif len(trim(attributes.email)) EQ 0>
          <span>
            <a href="#application.settings.rootPath#/event/person.email?personId=#attributes.personId#">
            Add an Email Address
            </a>
          </span>
        <cfelse>
        <span id="AccountID">#Attributes.Email#</span>
        </cfif>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label">Password</label>
      <div class="controls">
        <cfif len(trim(attributes.password)) EQ 0>
          <span>No Password</span>
        <cfelse>
          <span><a href="javascript://" id="resend-credentials"><i class="icon-envelope-alt"></i> Email Credentials to User</a></span>
        </cfif>
      </div>
    </div>
    <div class="divider"><hr /></div>
    <div class="control-group-heading">
      <span>Change Password</span>
    </div>
    <div class="control-group">
      <label class="control-label">New Password</label>
      <div class="controls">
        <input type="password" class="input-medium" name="NewPassword" id="NewPassword" />
      </div>
    </div>
    <div class="control-group">
      <label class="control-label">Re-type Password</label>
      <div class="controls">
        <input type="password" class="input-medium" name="ConfirmPassword" id="ConfirmPassword" />
      </div>
    </div>
  </form>
</cfoutput>