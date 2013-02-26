<cfsilent>
<cfparam name="Session.LoggedIn" default="false" />
<cfparam name="Session.PersonID" default="0" />
<cfif NOT isDefined("Cookie.Settings.LastPage")>
	<cfcookie name="Settings.LastPage" value="#myself#Member.Home" domain="ccpd.uc.edu" path="/" />
</cfif>

<!---<cfset LastPageIgnore = "Main.doLogin,Main.Login,Main.doLogout,Person.Finder,Process.AddToQueue,Activity.Notes,Person.PhotoUpload,Activity.Container,Activity.Overview,Assessment.Create,Assessment.Edit,Assessment.Questions,Assessment.QuestionCreate,Assessment.QuestionEdit,Activity.FacultyAHAH,Activity.AttendeeAHAH,Activity.CommitteeAHAH,Activity.ActionsShort,Activity.Stats,Activity.AssessmentsAHAH,Activity.BuilderQ,Assessment.Build,Activity.Status,Activity.Assessments,Activity.Materials,Main.Register,Main.About,Main.Support,Activity.Browse,Main.Welcome,Activity.Links,Activity.Comments,Member.GenerateTranscript,Activity.Cert" />
<cfif NOT ListFind(LastPageIgnore,Attributes.Fuseaction,",")>
	<cfcookie name="Settings.LastPage" value="#myself##Attributes.Fuseaction#?#CGI.QUERY_STRING#" domain="ccpd.uc.edu" path="/">
</cfif>--->

<cfif NOT isDefined("Cookie.Pref.HideWelcome")>
	<cfcookie name="Pref.HideWelcome" value="false" />
</cfif>

<cfset PersonIDExceptionList = "169841,113290">

<cfparam name="Request.Status.Errors" default="" />
<cfparam name="Request.Status.Messages" default="" />
<cfparam name="Request.NavItem" default="" />

<!---<cfif Compare(cgi.SERVER_PORT,443) AND CGI.SERVER_NAME EQ "ccpd.uc.edu"> 
	<cflocation url="https://#cgi.server_name##cgi.path_info#?#cgi.query_string#" addtoken="false"/> 
</cfif>--->

<!--- UDF Includes --->
<cfinclude template="/_com/_UDF/browserDetect.cfm" />
<cfinclude template="/_com/_UDF/QualitativeDate.cfm" />
<cfinclude template="/_com/_UDF/jButton.cfm" />
<cfinclude template="/_com/_UDF/nameCase.cfm" />
<cfinclude template="/_com/_UDF/ActivateURL.cfm" />
<cfinclude template="/_com/_UDF/stripAllBut.cfm" />
<cfinclude template="/_com/_UDF/HTMLSafe.cfm" />
<cfinclude template="/_com/_UDF/StripHTML.cfm" />
<cfinclude template="/_com/_UDF/XMLSafeText.cfm" />
<cfinclude template="/lms/Model/Page/act_Access.cfm" />

</cfsilent>