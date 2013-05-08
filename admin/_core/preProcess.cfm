
<cfsilent><!--- DEFAULT COOKIES --->
<cfparam name="session.loggedin" default="false" />
<!--- <cfif NOT structKeyExists(cookie,"USER_ActShowInfobar")>
	<cfcookie name="USER_ActShowInfobar" value="false">
</cfif> --->
<cfif NOT structKeyExists(cookie,"USER_ActListPos")>
	<cfcookie name="USER_ActListPos" value="200,200">
</cfif>

<cfif NOT structKeyExists(cookie,"USER_ActListOpen")>
	<cfcookie name="USER_ActListOpen" value="false">
</cfif>

<cfif NOT structKeyExists(cookie,"USER_ActListSize")>
	<cfcookie name="USER_ActListSize" value="200,253">
</cfif>

<cfif NOT structKeyExists(cookie,"USER_ActNotesPos")>
	<cfcookie name="USER_ActNotesPos" value="200,200">
</cfif>

<cfif NOT structKeyExists(cookie,"USER_ActNotesOpen")>
	<cfcookie name="USER_ActNotesOpen" value="false">
</cfif>

<cfif NOT structKeyExists(cookie,"USER_ActNotesSize")>
	<cfcookie name="USER_ActNotesSize" value="200,253">
</cfif>

<cfif NOT structKeyExists(cookie,"USER_PersonFinderOpen")>
	<cfcookie name="USER_PersonFinderOpen" value="false">
</cfif>

<cfif NOT structKeyExists(cookie,"USER_AttendeePage")>
	<cfcookie name="USER_AttendeePage" value="0|1">
</cfif>

<cfif NOT structKeyExists(cookie,"USER_AttendeeStatus")>
	<cfcookie name="USER_AttendeeStatus" value="0|0">
</cfif>

<cfif NOT structKeyExists(cookie,"USER_Containers")>
	<cfcookie name="USER_Containers" value="" />
</cfif>

<cfif NOT structKeyExists(cookie,"USER_FINDSTARTDATE")>
	<cfcookie name="USER_FINDSTARTDATE" value="" />
</cfif>

<cfif isDefined("Session.Person")>
	<cfset Session.PersonID = Session.Person.getPersonID()>
</cfif>

<cfset LastPageIgnore = "Main.doLogin,Main.Login,Main.doLogout,Person.Finder,Process.AddToQueue,Activity.Notes,Person.PhotoUpload,Activity.Container,Activity.Overview,Assessment.Create,Assessment.Edit,Assessment.Questions,Assessment.QuestionCreate,Assessment.QuestionEdit,Activity.FacultyAHAH,Activity.AttendeesAHAH,Activity.CommitteeAHAH,Activity.ActionsShort,Activity.Stats,Report.ACCMEDetailAHAH,Report.ACCMESummaryAHAH,Report.CMECert,Public.CMECert,Activity.BuildTX,Activity.BuildEC,Activity.BuildHD1,Activity.BuildHD2,Activity.BuildHD3,Activity.BuildFD,Activity.BuildFV,Activity.BuildEC,Activity.BuildASEV,Activity.BuildASPO,Activity.BuildAUD,Activity.BuildVID,Activity.BuildPAY,Activity.BuildST,Activity.BuildTA,Activity.PubComponents,Activity.DocsAHAH,Activity.ActivityList,Activity.BuilderTX,Report.CDCAttendanceAHAH,Report.CDCEvalAHAH,Report.CDCPIFAHAH,Activity.BuilderFileUploader,Public.FileView,Activity.FinFeesAHAH,Activity.BuilderQ,Admin.CommentsAHAH,Public.FileView,Person.Create,Activity.PublishBar" />

<!---<cfif Compare(cgi.SERVER_PORT,443) AND CGI.SERVER_NAME EQ "ccpd.uc.edu"> 
	<cflocation url="https://#cgi.server_name##cgi.path_info#?#cgi.query_string#" addtoken="false"/> 
</cfif>--->

<!---<cfif NOT ListFind(LastPageIgnore,Attributes.Fuseaction,",")>
	<cfcookie name="Settings.LastPage" value="#myself##Attributes.Fuseaction#?#CGI.QUERY_STRING#" path="/admin">
</cfif>--->
<cfparam name="Request.Status.Errors" default="" />
<cfparam name="Request.Status.Messages" default="" />
<cfparam name="Request.NavItem" default="" />

<!--- ERROR REPORTING --->
<cfif isDefined("Session.Account") AND Session.Account.getAuthorityID() NEQ 3>
	<cferror template="/admin/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
	<!---<cferror template="/admin/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu"> --->
</cfif>

<!--- UDF Includes --->
<cfinclude template="/_com/_UDF/browserDetect.cfm" />
<cfinclude template="/_com/_UDF/QualitativeDate.cfm" />
<cfinclude template="/_com/_UDF/jButton.cfm" />
<cfinclude template="/_com/_UDF/nameCase.cfm" />
<cfinclude template="/_com/_UDF/HTMLSafe.cfm" />
<cfinclude template="/_com/_UDF/midLimit.cfm" />
<cfinclude template="#Application.Settings.AppPath#/Model/Page/act_Access.cfm" />
</cfsilent>