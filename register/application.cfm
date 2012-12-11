<cfapplication name="CCPD_CDC_FULL" sessionmanagement="Yes" clientmanagement="Yes" sessiontimeout="#CreateTimeSpan(0, 0, 120, 0)#">



<cfset Request.RootPath = "/stdptc" />
<cfset Request.Status.Errors = "" />
<cfinclude template="#Request.RootPath#/includes/fusebox.appinit.cfm" />
<!---<cfinclude template="#Request.RootPath#/includes/inc_query_global.cfm">
<cfinclude template="#Request.RootPath#/includes/inc_func_global.cfm">--->
<cfinclude template="#Request.RootPath#/includes/aebrowser.cfm">
<!---<cfinclude template="#Request.RootPath#/includes/inc_user_info.cfm">--->

<!---<cfif isDefined("session.personid") AND NOT ListFind("169841,113290",session.personid,",")>
	<cferror type="EXCEPTION" template="#Request.RootPath#/errors/fullhandler.cfm" MAILTO="rountrjf@ucmail.uc.edu">
	<cferror type="REQUEST" template="#Request.RootPath#/errors/fullhandler.cfm">
</cfif>--->
<cfset Request.Myself = "">

<cfif NOT isDefined("Cookie.Settings.LastPage")>
	<cfcookie name="Settings.LastPage" value="#CGI.HTTP_REFERER#">
<cfelse>
	<cfset Cookie.Settings.LastPage = CGI.HTTP_Referer>
</cfif>

<cfif NOT isDefined("Session.Person")>
	<cfset Session.Person = CreateObject("component", "#Application.Settings.Com#Person.Person").Init()>
</cfif>

<cfif NOT isDefined("Session.Account")>
	<cfset Session.Account = CreateObject("component", "#Application.Settings.Com#Account.Account").Init()>
</cfif>

<cfif ListFindNoCase("activity_documents.cfm,cdc_contact.cfm,cdc_pif.cfm,cdc_reg.cfm,evaluation.cfm,index.cfm,welcome.cfm", getToken(cgi.script_name, 2, "/"), ",") GT 0>
	<cfif NOT isDefined("Session.LoggedIn") OR isDefined("Session.PersonID") AND Session.PersonID EQ "">
		<cfset Session.LoggedIn = "">
	    <cflocation url="#Request.RootPath#/login.cfm" addtoken="no" />
    </cfif>
<cfelseif ListFindNoCase("login.cfm", getToken(cgi.script_name, 2, "/"), ",") GT 0>
	<cfif isDefined("Session.LoggedIn") AND Session.LoggedIn NEQ "">
		<cflocation url="#Request.RootPath#/cdc_reg.cfm" addtoken="no" />
    </cfif>
</cfif>

<!--- USER DEFINED VARS --->
<cfset Myself = "#Request.RootPath#/index.cfm/event/">
