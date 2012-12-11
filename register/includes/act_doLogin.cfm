<cfparam name="Form.Submitted" type="string" default="">
<cfparam name="Form.AccountID" default="">
<cfparam name="Form.Password" type="string" default="">
<cfparam name="Form.RememberMe" type="string" default="N">

<cfif isDefined("Client.Login") AND Client.Login NEQ "">
	<cfset LoggedIn = Application.Auth.doLogin(PersonID=Client.Login)>
<cfelseif Form.Submitted NEQ "">
	<cfset LoggedIn = Application.Auth.doLogin(Email=Form.Email, Password=Form.Password, RememberMe=Form.RememberMe)>
</cfif>
    
<cfif isDefined("LoggedIn") AND LoggedIn>
	<cflocation url="#Cookie.Settings.LastPage#" addtoken="no">
<cfelseif isDefined("LoggedIn") AND NOT LoggedIn>
	<cflocation url="#Request.RootPath#/Login.cfm?LoginError=Authentication failed.  Try again!" addtoken="no" />
<cfelse>
	<cflocation url="#Request.RootPath#/Login.cfm" addtoken="no" />
</cfif>