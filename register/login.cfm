<cfparam name="Attributes.Email" default="">
<cfparam name="Attributes.Password" default="">
<cfparam name="Attributes.RememberMe" default="">
<cfparam name="Attributes.LoginError" default="">

<!--- CHECK IF CLIENT.LOGIN EXISTS // REMEMBER ME FUNCTIONALITY --->
<cfif isDefined("Client.Login") AND Client.Login NEQ "">
    <cflocation url="#Request.RootPath#/Includes/act_doLogin.cfm" addtoken="no" />
</cfif>
<cfif isDefined("cookie.Account.Username")>
    <cfset Attributes.Username = cookie.Account.Username>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Welcome Center</title>
<cfinclude template="#Request.RootPath#/Includes/inc_Scripts.cfm" />
<link href="styles/inc_styles.css" rel="stylesheet" type="text/css" />
</head>

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
	#LoginLeft { width:40%; float:left; }
	#LoginRight { width:60%; float:left; background-color:#EEE; }
</style>

<body>
<cfinclude template="includes/inc_header.cfm">
<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<td class="content_cell" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="content_title">Account Login</td>
				</tr>
				<tr>
					<td class="content_body">
                    <cfoutput>
                    <div class="ContentBlock">
                        <h1>Sign-in</h1>
                        <div id="ContentLeft" class="Wide">
                            <h2>Member Login</h2>
                            <form name="formLogin" method="post" action="#Request.RootPath#/Includes/act_doLogin.cfm?submitted=1">
                            <table width="200" border="0" cellspacing="1" cellpadding="2" style="font-family:Arial, Helvetica, sans-serif; font-size:14px;">
                                <tr>
                                    <td width="75">
                                        <cfif Attributes.LoginError NEQ ""><font color="##FF0000">#Attributes.LoginError#</font></cfif>
                                        <table width="300" border="0" cellspacing="1" cellpadding="2" style="font-family:Arial, Helvetica, sans-serif; font-size:14px;font-weight:bold;">
                                            <tr>
                                                <td width="102" class="FieldLabel">Email Address</td>
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
                                <a href="#Request.RootPath#/ForgotPW.cfm" class="LearnMore">Forgot Password Request</a>
                            </p>
                        </div>
                        <div id="ContentRight" class="Wide">
                            <h2>What is my Account ID?</h2>
                            <p>
                            <strong>UC Affiliated (Faculty, Staff, and Students)</strong><br />
                            Your Account ID is the email address you used to register.
                            </p>
                            <h2>Don't have an account?</h2>
                            <p>
                            <a href="#Request.RootPath#/Register.cfm" class="LearnMore">Click here to sign-up!</a>
                            </p>
                        </div>
                    </div>
                    </cfoutput>

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
