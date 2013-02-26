<cfparam name="Attributes.Username" default="">
<cfparam name="Attributes.Password" default="">
<cfparam name="Attributes.RememberMe" default="">
<cfif isDefined("cookie.Account.Username")>
	<cfset Attributes.Username = cookie.Account.Username>
</cfif>
<script language="javascript">
	$(document).ready(function(){
	  <cfif Attributes.Username NEQ "">
	  document.formLogin.Password.focus();
	  <cfelse>
	  document.formLogin.Username.focus();
	  </cfif>
	});
</script>
<cfoutput>
<form name="formLogin" method="post" action="">
	<input type="hidden" name="Submitted" value="1" />
    <table width="200" border="0" cellspacing="1" cellpadding="2" style="font-family:Arial, Helvetica, sans-serif; font-size:14px;">
        <tr>
            <td width="75">
                <table width="200" border="0" cellspacing="1" cellpadding="2" style="font-family:Arial, Helvetica, sans-serif;font-size:14px;font-weight:bold;">
                    <tr>
                        <td width="75">Username:</td>
                        <td width="125"><input type="text" name="Username" id="Username" value="#Attributes.Username#" style="font-size:15px;width:110px;color:##000066;font-weight:bold;" /></td>
                        <td width="125">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="Password" id="Password" value="#Attributes.Password#" style="font-size:15px;width:110px;color:##000066;font-weight:bold;" /></td>
                        <td><input type="submit" name="button" id="button" value="Login" /></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
</cfoutput>