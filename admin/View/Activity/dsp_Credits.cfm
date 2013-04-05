<cfparam name="Attributes.Credits" default="">
<div class="ViewSection">
<script>
$(document).ready(function() {
	App.Activity.Credits.start();
});
</script>
<cfoutput>
<form 
	name="frmAddCredits" 
	method="post"
	class="js-form-credits" 
	action="#myself#Activity.Credits?ActivityID=#Attributes.ActivityID#">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="ViewSectionGrid table table-bordered table-condensed">
		<thead>
			<tr>
				<th style="text-align:center;">&nbsp;</th>
				<th>Type</th>
				<th>Amount</th>
				<th>Reference No</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="qCredits">
          <tr>
              <td style="width:10px;"><input type="checkbox" class="CreditBox" name="Credits" id="Credits#qCredits.CreditID#" value="#qCredits.CreditID#"<cfif ListFind(Attributes.Credits,qCredits.CreditID,",")> checked</cfif> /></td>
              <td width="100"><label for="Credits#qCredits.CreditID#">#qCredits.Name#</label></td>
              <td width="40"><input type="text" name="CreditAmount#qCredits.CreditID#" id="CreditAmount#qCredits.CreditID#" value="#Evaluate('Attributes.CreditAmount#qCredits.CreditID#')#" style="width:34px;" /></td>
              <td><cfif qCredits.ReferenceFlag EQ "Y"><input type="text" name="ReferenceNo#qCredits.CreditID#" id="ReferenceNo#qCredits.CreditID#" value="#Evaluate('Attributes.ReferenceNo#qCredits.CreditID#')#" /><cfelse>&nbsp;</cfif></td>
          </tr>
			</cfloop>
		</tbody>
	</table>
	<input type="hidden" name="activityid" value="#attributes.activityid#" />
	<input type="hidden" name="submitted" value="1" />
</form>
</cfoutput>
</div>