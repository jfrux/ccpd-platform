<cfparam name="Attributes.Email" type="string" default="">
<cfparam name="Attributes.Password" type="string" default="">
<cfparam name="Attributes.RememberMe" type="string" default="">
<cfparam name="LoggedIn" type="boolean" default="false" />
<!--- CHECK IF CLIENT.LOGIN EXISTS // REMEMBER ME FUNCTIONALITY
04/14/2010
TO DO: NEEDS UPDATED FOR NEW CE_PERSON TABLE LOGIN --->
<cfif isDefined("Client.Login") AND Client.Login NEQ "">
	<cfset LoggedIn = Application.Auth.doLogin(PersonID=Client.Login)>
<cfelseif Attributes.Email NEQ "" OR Attributes.Password NEQ "">
	<cfset LoggedIn = Application.Auth.doLogin(Email=Attributes.Email, Password=Attributes.Password, RememberMe=Attributes.RememberMe)>
</cfif>

<cfif LoggedIn>
	<cfif isDefined("client.lastActivity") AND client.lastActivity NEQ 0>

		<cflocation url="/activity/#client.lastActivity#" addtoken="no">
  <cfelse>
    <cfdump var="#Cookie#" />
		<cflocation url="/" addtoken="no">
  </cfif>
<cfelseif NOT LoggedIn>
	<cflocation url="#myself#Main.Login?FailMessage=Authentication failed.  If this is your first time logging in, please make sure you have verified your email address via the verification email you received." addtoken="no" />
<cfelse>
	<cflocation url="#myself#Main.Login" addtoken="no" />
</cfif>