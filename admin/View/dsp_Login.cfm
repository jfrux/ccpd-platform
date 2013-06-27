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
<cfoutput>

<div class="auth-box">
<form name="formLogin" class="form-horizontal" method="post" action="#myself##xfa.Authenticate#">

	<div class="control-group">
		<label class="control-label">Email</label>
		<div class="controls">
			<input type="text" name="Email" id="Email" value="#Attributes.Email#" tabindex="1" />
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">Password</label>
		<div class="controls">
			<input type="password" name="Password" id="Password" value="#Attributes.Password#" tabindex="2" />
		</div>
	</div>
		
	<div class="control-group">
		<div class="controls">
			<input type="submit" name="button" id="button" value="Login" tabindex="4" class="btn" />
		</div>
	</div>
	<input type="checkbox" name="RememberMe" id="RememberMe" value="Y" tabindex="3" />
	<label for="RememberMe">Keep me logged in on this computer</label>
</form>
</div>
</cfoutput>
