<cfsilent>
<cfset REQUEST.RequestCommitted = false />
 
  <cftry>
    <!--- Set the status code to internal server error. --->
    <cfheader
      statuscode="500"
      statustext="Internal Server Error"
      />
 
    <!--- Set the content type. --->
    <cfcontent
      type="text/html"
      reset="true"
      />
 
    <!--- Catch any errors. --->
    <cfcatch>
 
      <!---
        There was an error so flag the request as
        already being committed.
      --->
      <cfset REQUEST.RequestCommitted = true />
 
    </cfcatch>
  </cftry>

</cfsilent>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<cfoutput>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ERROR!</title>
<link href="/admin/_styles/Default.css" rel="stylesheet" type="text/css" />
<link href="/admin/_styles/Interface.css" rel="stylesheet" type="text/css" />
<link href="/admin/_styles/Navigation.css" rel="stylesheet" type="text/css" />
<link href="/admin/_styles/Button.css" rel="stylesheet" type="text/css" />
<link href="/admin/_styles/Forms.css" rel="stylesheet" type="text/css" />
<cfset ErrorInfo = StructNew()>
<cfif isDefined("Session.Person")>
  <cfset ErrorInfo.aUser.ID = Session.Person.getPersonID()>
  <cfset ErrorInfo.aUser.Name = Session.Person.getFirstName() & " " & Session.Person.getLastName()>
</cfif>

<cfset ErrorInfo.Details = error>
<style>
  a { color:##999999; }
</style>
</head>

<body style="margin:0px;color:##000;font-family:Arial, Helvetica, sans-serif;">
<table width="600" border="0" align="center">
  <tr>
    <td style="font-size:13px;">
    <p style="font-size:15px;">
    <strong>The technical team has been notified of this problem.  </strong><br />
    If this does not get resolved shortly - please feel free to contact support <a href="http://ccpd.uc.edu/support/">ccpd.uc.edu/support</a></p>
    <p style="font-size:15px;">Click <a href="javascript:history.back(-1);">here</a> to go back.</p>
    <ul style="color:##444;">
    <li><b>Your Location:</b> #error.remoteAddress#</li>
    <li><b>Your Browser:</b> #error.browser#</li>
    <li><b>Date and Time the Error Occurred:</b> #DateFormat(error.dateTime,"mm/dd/yyyy")# #TimeFormat(error.dateTime,"hh:mm:ss TT")#</li>
    <li><b>Page You Came From:</b> #error.HTTPReferer#</li>
    <li><b>Message Content</b>:</li>
    <p>#error.diagnostics#</p>
    </ul>
  </td>
</tr>
</table>
<cfdump var="#error#" />
<!---<cfmail to="rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" from="do-not-reply@uc.edu" replyto="do-not-reply@uc.edu" subject="CCPD Admin Error - #error.diagnostics#" type="html">
  <cfdump var="#ErrorInfo#">
</cfmail>--->
<cfset ErrorTitle = "#error.diagnostics#">
<cfset application.BugLog.notifyService(ErrorTitle, ErrorInfo, "", "ERROR")>
<!---<cfsavecontent variable="htmlDump">
  <cfdump var="#ErrorInfo#" format="text">
</cfsavecontent>
<cfset params = structNew() />
<cfset params = {
  project = "1",
  description = htmlDump,
  summary = "ADMIN ERROR: " & ErrorTitle,
  priority = 5,
  status = "new"
} />
<cfset application.unfuddle.createTicket(argumentCollection=params) />--->
</div>
</body>
</html>
</cfoutput>