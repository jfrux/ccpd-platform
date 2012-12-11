<link href="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_styles/Forms.css" type="text/css" rel="stylesheet"  />
<script>
	$(document).ready(function() {
		$('#email').focus();
		
		<cfif isDefined("status") AND  arrayLen(status.getErrors()) GT 0>
			<cfset errors = status.getErrors()>
			<cfoutput>
			<cfloop from="1" to="#arrayLen(errors)#" index="currError">
				$('###errors[currError].fieldname#').parent().append('<br /><span class=\'error_list\' style=\'font-size:10px;\'>#errors[currError].message#</span>');
				$('###errors[currError].fieldname#').css('background-color','##FFEEEE');
			</cfloop>
			</cfoutput>
		</cfif>
	});
</script>
<cfoutput>
<form action="#myself#Member.Confirm" method="post" name="frmConfirm" id="frmConfirm">
<div class="ContentBlock">
	<div id="ContentLeft">
		<h1>#request.page.title#</h1>
		<p>#instructions#</p>
        <p class="error_list">
        <cfif isDefined("Attributes.Message") AND Attributes.Message NEQ "">
        	#Attributes.Message#
        </cfif>
        </p>
		<p>
        <div class="Credentials">
        	<table>
            	<tbody>
                    <tr>
                    	<td class="InputLabel">Email:</td>
                    	<td class="InputField"><input type="text" name="cemail" value="#attributes.cemail#" tabindex="1" id="email" /></td>
                    </tr>
                    <tr>
                    	<td class="InputLabel">Password:</td>
                    	<td class="InputField"><input type="password" name="cpassword" id="password" tabindex="2" /></td>
                    </tr>
                    <tr>
                    	<td colspan="2"><input type="submit" value="Save Preferences" name="Submit" id="Submit" />&nbsp;&nbsp;&nbsp;&nbsp;<a href="#attributes.r#">Cancel</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
        </p>
    </div>
</div>
<input type="hidden" name="ac" value="#attributes.ac#" />
<input type="hidden" name="e" value="#attributes.e#" />
<input type="hidden" name="r" value="#attributes.r#" />
<input type="hidden" name="submitted" value="1" />
</form>
</cfoutput>