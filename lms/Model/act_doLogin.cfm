<cfparam name="Attributes.Email" type="string" default="">
<cfparam name="Attributes.Password" type="string" default="">
<cfparam name="Attributes.RememberMe" type="string" default="">

<!--- CHECK IF CLIENT.LOGIN EXISTS // REMEMBER ME FUNCTIONALITY
04/14/2010
TO DO: NEEDS UPDATED FOR NEW CE_PERSON TABLE LOGIN --->


<cfif isDefined("Client.Login") AND Client.Login NEQ "">
	<cfset LoggedIn = Application.Auth.doLogin(PersonID=Client.Login)>
<cfelseif Attributes.Email NEQ "" OR Attributes.Password NEQ "">
	<cfset LoggedIn = Application.Auth.doLogin(Email=Attributes.Email, Password=Attributes.Password, RememberMe=Attributes.RememberMe)>
</cfif>
<cfif isDefined("LoggedIn") AND LoggedIn>
	<cflocation url="#myself#main.welcome" addtoken="no">
<cfelseif isDefined("LoggedIn") AND NOT LoggedIn>
	<cflocation url="#myself#Main.Login?FailMessage=Authentication failed." addtoken="no" />
<cfelse>
	<cflocation url="#myself#Main.Login" addtoken="no" />
</cfif>