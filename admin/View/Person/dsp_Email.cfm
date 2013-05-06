<script>

App.Person.Emails.start();
</script>

<div class="ViewSection">
	<div id="EmailContainer"></div>
	<div id="EmailLoading" class="Loading"><img src="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_images/ajax-loader.gif" />
	<div>Please Wait</div>
	</div>
	<cfoutput>
  <div class="js-email-add email-form">
  	<form action="/admin/_com/ajax_person.cfc" method="post" class="form-horizontal" name="formAddEmail">
      <input type="hidden" name="method" value="saveEmail" />
      <input type="hidden" name="returnformat" value="plain" />
      <input type="hidden" name="person_id" value="#attributes.personid#" />
      <input type="hidden" name="email_id" value="0" />
      <input type="hidden" name="is_primary" value="0" />
      <input type="hidden" name="is_verified" value="0" />
      <input type="hidden" name="allow_login" value="0" />
  		<div class="control-group">
  			<label class="control-label">
          Email Address
  			</label>
        <div class="controls">
      		<input id="email_address-0" name="email_address" type="text" class="inputText email_address" value=""  /><br />
        </div>
      </div>
      <div class="control-group">
        <div class="controls">
          <input type="submit" class="btn btn-primary save-link" value="Add Email" /> 
          <a href="javascript://" class="cancel-link btn" id="cancel-0">Cancel</a>
        </div>
      </div>
    </form>
  </div>
  </cfoutput>
</div>