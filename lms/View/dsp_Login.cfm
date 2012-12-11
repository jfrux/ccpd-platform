<cfparam name="Attributes.Email" default="">
<cfparam name="Attributes.Password" default="">
<cfparam name="Attributes.RememberMe" default="">
<cfparam name="Attributes.FailMessage" default="">
<cfparam name="Attributes.SuccessMessage" default="">
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
	  document.formLogin.Password.focus();
	  <cfelse>
	  document.formLogin.Email.focus();
	  </cfif>
	});
</script>
<style>
#LoginLeft { width:40%; float:left; }
#LoginRight { width:60%; float:left; background-color:#EEE; }
</style>
<cfoutput>
<div class="ContentBlock">
	<h1>Sign-in</h1>
	<div id="ContentLeft" class="Wide">
		<h2>Member Login</h2>
		<form name="formLogin" method="post" action="#myself##xfa.Authenticate#">
		<table width="200" border="0" cellspacing="1" cellpadding="2" style="font-family:Arial, Helvetica, sans-serif; font-size:14px;">
			<tr>
				<td width="75">
					<cfif len(trim(Attributes.FailMessage)) GT 0><font color="##FF0000">#Attributes.FailMessage#</font></cfif>
					<cfif len(trim(Attributes.SuccessMessage)) GT 0><font color="##339900">#Attributes.SuccessMessage#</font></cfif>
					<table width="300" border="0" cellspacing="1" cellpadding="2" style="font-family:Arial, Helvetica, sans-serif; font-size:14px;font-weight:bold;">
						<tr>
							<td width="102" class="FieldLabel">Email</td>
							<td width="100" class="FieldInput"><input type="text" name="Email" id="Email" value="#Attributes.Email#" style="width:100px;" tabindex="1" /></td>
							<td width="82">&nbsp;</td>
						</tr>
						<tr>
							<td class="FieldLabel">Password</td>
							<td class="FieldInput"><input type="password" name="Password" id="Password" value="#Attributes.Password#" style="width:100px;" tabindex="2" /></td>
							<td><input type="submit" name="button" id="button" value="Login" /><input type="hidden" name="submitted" value="1" tabindex="4" /></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2"><input type="checkbox" name="RememberMe" id="RememberMe" tabindex="3" value="Y" /><label for="RememberMe">Remember Me</label></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</form>
		
		<h2>Forget your password?</h2>
		<p>
		Request it by clicking below...
		</p>
		<p>
			<a href="#myself#Main.ForgotPW" class="LearnMore">Forgot Password Request</a>
		</p>
	</div>
	<div id="ContentRight" class="Wide">
		<h<!---2>What is my Account ID?</h2>
		<p>
		<strong>UC Affiliated (Faculty, Staff, and Students)</strong><br />
		Your Username is generally the first 6 characters of your last name, the first character of your first name and the first character of your middle name.<br />
		Unless you have previously changed it on this system, your password is the last 4 digits of your social security number followed by the first 4 digits of your birthdate in mmdd format.
		<br /><br />
		<strong>Non-UC (University of Cincinnati)</strong><br />
		If you are a non-UC user AND have previously registered, enter your email address and password. If you are a non-UC user and have NOT previously registered, use the <a href="#Myself#Main.Register">New User? box</a> to sign up for an account.
		</p>--->
		<h2>Don't have an account?</h2>
		<p>
		<a href="#myself#Main.Register" class="LearnMore">Click here to sign-up!</a>
		</p>
	</div>
</div>
</cfoutput>
