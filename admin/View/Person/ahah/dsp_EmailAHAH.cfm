<script id="new-email-address" type="text/x-jquery-tmpl">
	<tr id="edit-email-0" class="email-0 edit-row">
		<td width="305"><input id="email_address-0" name="email_address" type="text" class="inputText email_address" value="" style="width:250px;"  /><br />
			Primary Address: 
			<select name="is_primary" class="is_primary" id="is_primary-0">
				<option value="1">Yes</option>
				<option value="0" SELECTED>No</option>
			</select></td>
		<td>
			Allow Login: 
			<select name="allow_login" class="allow_login" id="allow_login-0">
				<option value="1">Yes</option>
				<option value="0" SELECTED>No</option>
			</select><br />
			Is Verified: 
			<select name="is_verified" class="is_verified" id="is_verified-0">
				<option value="1">Yes</option>
				<option value="0" SELECTED>No</option>
			</select>
		</td>
		<td>
			<a href="javascript://" class="save-link" id="save-0">Save</a><br />
			<a href="javascript://" class="cancel-link" id="cancel-0">Cancel</a>
		</td>
	</tr>
</script>
<script>
$(document).ready(function() {
	<cfif emailList.recordCount EQ 0>
	addEmail();
	</cfif>
	$('.cancel-link').live('click', function() {
		cancelFunc($(this));
	});
	
	$('.delete-link').live('click', function() {
		deleteFunc($(this));
	});
	
	$('.edit-link').live('click', function() {
		editFunc($(this));
	});
	
	$('.primary-link').live('click', function() {
		setPrimaryEmail($(this));
	});
	
	$('.save-link').live('click', function() {
		saveFunc($(this));
	});
	
	$('.verify-link').live('click', function() {
		verifyFunc($(this));
	});
	
	$('.view-row').mouseover(function() {
		showPrimaryLink($(this));
	}).mouseout(function() {
		hidePrimaryLink($(this));
	});
});
</script>
<cfoutput>
<form method="post" name="frmEditActivity" id="EditForm">
<fieldset class="common-form">
	<table width="100%" border="0" cellpadding="2" cellspacing="0" class="ViewSectionGrid">
        <tbody id="email-addresses">
            <cfloop query="emailList">
            <tr id="view-email-#emailList.email_id#" class="email-#emailList.email_id# view-row">
            	<td width="305"><span class="email-address">#emailList.email_address#</span>
					<cfif emailList.isPrimaryEmail EQ 1>
                    	<br /><em style="color:##000; font-size:10px;">Primary</em>
					<cfelseif emailList.is_verified EQ 1>
                        <br /><em style="color:##555; font-size:10px; cursor: pointer;" id="primary-#emailList.email_id#" class="primary-link dn">Make Primary</em>
					</cfif>
                </td>
            	<td width="217">
                	Allow Login: <cfif emailList.allow_login EQ 1>Yes<cfelse>No</cfif><br />
                    Is Verified: <cfif emailList.is_verified EQ 1>Yes<cfelse>No (<a href="javascript://" id="verify-#emailList.email_id#" class="verify-link">Send Verification</a>)</cfif>
                </td>
            	<td>
                	<a href="javascript://" class="edit-link" id="edit-#emailList.email_id#">Edit</a><br />
                	<a href="javascript://" class="delete-link" id="delete-#emailList.email_id#">Delete</a>
                </td>
            </tr>
            <tr id="edit-email-#emailList.email_id#" class="dn email-#emailList.email_id# edit-row">
            	<td width="305"><input id="email_address-#emailList.email_id#" name="email_address" type="text" class="inputText email_address" value="#emailList.email_address#" style="width:250px;"  /><br />
                    Primary Address: 
                    <select name="is_primary" class="is_primary" id="is_verified-#emailList.email_id#">
                        <option value="1"<cfif emailList.isPrimaryEmail EQ 1> SELECTED</cfif>>Yes</option>
                        <option value="0"<cfif emailList.isPrimaryEmail EQ 0> SELECTED</cfif>>No</option>
                    </select></td>
            	<td>
                	Allow Login: 
                    <select name="allow_login" class="allow_login" id="allow_login-#emailList.email_id#">
                        <option value="1"<cfif emailList.allow_login EQ 1> SELECTED</cfif>>Yes</option>
                        <option value="0"<cfif emailList.allow_login EQ 0> SELECTED</cfif>>No</option>
                    </select><br />
                    Is Verified: 
                	<select name="is_verified" class="is_verified" id="is_verified-#emailList.email_id#">
                    	<option value="1"<cfif emailList.is_verified EQ 1> SELECTED</cfif>>Yes</option>
                    	<option value="0"<cfif emailList.is_verified EQ 0> SELECTED</cfif>>No</option>
                    </select>
                </td>
            	<td>
                	<a href="javascript://" class="save-link" id="save-#emailList.email_id#">Save</a><br />
                	<a href="javascript://" class="cancel-link" id="cancel-#emailList.email_id#">Cancel</a>
                </td>
            </tr>
            </cfloop>
        </tbody>
    </table>
</fieldset>
</form>
</cfoutput>