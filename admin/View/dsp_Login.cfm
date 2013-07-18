<cfparam name="Attributes.Email" default="">
<cfparam name="Attributes.Password" default="">
<cfparam name="Attributes.RememberMe" default="">
<cfparam name="Attributes.failmessage" default="">

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
	<cfif len(trim(attributes.failmessage)) GT 0>
		<div class="alert alert-danger">
		<cfswitch expression="#attributes.failmessage#">
			<cfcase value="Permission denied.">
				The page you requested requires you to sign in.
			</cfcase>
			<cfcase value="failed">
				Authentication failed.  Invalid credentials.
			</cfcase>
		</cfswitch>
		</div>
	</cfif>
<form name="formLogin" class="form-horizontal" method="post" action="#myself##xfa.Authenticate#">
	<div class="grouped-title">
		Already have an account?
	</div>

	<div class="control-group-set">
		<div class="control-group">
			<label class="control-label">Email</label>
			<div class="controls">
				<input type="email" name="Email" id="Email" value="#Attributes.Email#" placeholder="you@example.org" tabindex="1" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">Password</label>
			<div class="controls">
				<input type="password" name="Password" id="Password" value="#Attributes.Password#" placeholder="&##9679;&##9679;&##9679;&##9679;&##9679;&##9679;&##9679;&##9679;" tabindex="2" />
			</div>
		</div>
	</div>
	<input type="submit" name="button" value="Sign In" tabindex="4" class="btn btn-primary" />
	<div class="grouped-title">
		New to CCPD?
	</div>
	<a href="#myself#main.register" tabindex="4" class="btn btn-default">Create New Account</a>

</form>
</div>
<div class="auth-links">
	<a href="#myself#main.forgot_pw">Forgot your password?</a>
	 &middot; 
	<a href="#myself#main.forgot_pw">Help Center</a>
</div>
</cfoutput>
