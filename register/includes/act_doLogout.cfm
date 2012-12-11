<!--- REMOVED 03/03/2009 TO SOLVE LOGOUT SESSION ISSUES      
<cfquery datasource="#session.datasource#" NAME="deletejsid">
delete from ca_loginsession where jid = '#jsid#'             
</cfquery>                                               --->


<cfapplication clientmanagement="Yes" sessionmanagement="Yes" name="#Application.Settings.Application_Name#" setclientcookies="Yes" sessiontimeout="#CreateTimeSpan(0, 8, 0, 0)#">
<cfset Application.Auth.doLogout()>
Variables deleted...
<cflocation  url="#Request.RootPath#/welcome.cfm">