<cfparam name="Attributes.Email" default="">
<cfparam name="Attributes.Password" default="">
<cfparam name="Attributes.RememberMe" default="">

<!--- CHECK IF CLIENT.LOGIN EXISTS // REMEMBER ME FUNCTIONALITY --->
<cfif isDefined("Client.Login") AND Client.Login NEQ "">
	<cflocation url="#Myself##xfa.Authenticate#" addtoken="no" />
</cfif>
<cfif isDefined("cookie.Account.Email")>
	<cfset Attributes.Email = cookie.Account.Email>
</cfif>
<script language="javascript">
	$(document).ready(function(){
	  <cfif Attributes.Email NEQ "">
	  $("#Password").focus();
	  <cfelse>
	  $("#Email").focus();
	  </cfif>
	});
</script>
<style>
.loginbox {
color:#000;
background-color:#EEE;
border:1px solid #CCC;
bottom:0;
height:100px;
left:0;
margin:auto;
padding:10px;
position:absolute;
right:0;
top:0;
width:350px;
-moz-border-radius:10px 10px 10px 10px; 
}
</style>
<cfoutput>

<div class="loginbox">
<form name="formLogin" method="post" action="#myself##xfa.Authenticate#">
<fieldset class="common-form">
<table border="0" cellspacing="2" cellpadding="3">
	<tbody>
		<tr>
			<td class="label">Email</td>
			<td class="input">
				<input type="text" name="Email" id="Email" value="#Attributes.Email#" tabindex="1" />
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="label">Password</td>
			<td class="input">
				<input type="password" name="Password" id="Password" value="#Attributes.Password#" tabindex="2" />
			</td>
			<td class="button">
				<input type="submit" name="button" id="button" value="Login" tabindex="4" class="btn" />
			</td>
		</tr>
		<tr>
			<td colspan="3">
				
				<input type="checkbox" name="RememberMe" id="RememberMe" value="Y" tabindex="3" />
				<label for="RememberMe">Keep me logged in on this computer</label>
			</td>
		</tr>
	</tbody>
</table>
</fieldset>
</form>
</div>
</cfoutput>
