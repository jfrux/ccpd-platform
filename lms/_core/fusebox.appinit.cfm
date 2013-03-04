<!---
	fusebox.appinit.cfm is included by the framework when the application is
	started, i.e., on the very first request (in production mode) or whenever
	the framework is reloaded, either with development-full-load mode or when
	fusebox.load=true or fusebox.loadclean=true is specified.
	It is included within a cfsilent tag so it cannot generate output. It is
	intended to be for per-application initialization that can not easily be
	done in the appinit global fuseaction.
	It is included inside a conditional lock, ensuring that only one request
	can execute this file.
	
	For example, if you are sharing application variables between a Fusebox
	application and a non-Fusebox application, you can initialize them here
	and then cfinclude this file into your non-Fusebox application.
--->

<!--- APP SETTINGS --->
<cfset Application.Settings = StructNew() />
<cfset Application.Settings.LoginPages = "Member.Home,Member.Curriculum,Member.Transcripts,Member.Account">
<cfset Application.settings.bugLogServer = "http://bugs.swodev.com" />
<cfswitch expression="#CGI.SERVER_NAME#">
	<!--- PRODUCTION --->
	<cfcase value="ccpd.uc.edu">
		<cfset Application.Settings.DSN = "CCPD_PROD">
		<cfset Application.Settings.AppName = "CCPD" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://ccpd.uc.edu/lms/" />
		<cfset Application.Settings.HostName = "ccpd.uc.edu" />
		<cfset Application.Settings.DownloadURL = "http://ccpd.uc.edu/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
	
	<cfcase value="www.ccpd.uc.edu">
		<cfset Application.Settings.DSN = "CCPD_PROD">
		<cfset Application.Settings.AppName = "CCPD" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://ccpd.uc.edu/lms/" />
		<cfset Application.Settings.HostName = "ccpd.uc.edu" />
		<cfset Application.Settings.DownloadURL = "http://ccpd.uc.edu/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
	
	<cfcase value="test.ccpd.uc.edu">
		<cfset Application.Settings.DSN = "CCPD_PROD">
		<cfset Application.Settings.AppName = "CCPD Open Test" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://test.ccpd.uc.edu/lms/" />
		<cfset Application.Settings.HostName = "test.ccpd.uc.edu" />
		<cfset Application.Settings.DownloadURL = "http://test.ccpd.uc.edu/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>

	<cfcase value="localhost">
		<cfset Application.Settings.DSN = "CCPD_CLONE">
		<cfset Application.Settings.AppName = "CCPD" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://test.ccpd.uc.edu/lms/" />
		<cfset Application.Settings.HostName = "test.ccpd.uc.edu" />
		<cfset Application.Settings.DownloadURL = "http://test.ccpd.uc.edu/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
	
	<cfcase value="10.97.106.160">
		<cfset Application.Settings.DSN = "CCPD_TEST">
		<cfset Application.Settings.AppName = "CCPD LMS DEV1" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://10.97.106.160/" />
		<cfset Application.Settings.HostName = "10.97.106.160" />
		<cfset Application.Settings.DownloadURL = "http://10.97.106.160/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
	
	<cfcase value="dev1.ccpd.uc.edu">
		<cfset Application.Settings.DSN = "CCPD_TEST">
		<cfset Application.Settings.AppName = "CCPD LMS DEV1" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://dev1.ccpd.uc.edu/" />
		<cfset Application.Settings.HostName = "dev1.ccpd.uc.edu" />
		<cfset Application.Settings.DownloadURL = "http://dev1.ccpd.uc.edu/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
	
	<cfcase value="dev2.ccpd.uc.edu">
		<cfset Application.Settings.DSN = "CCPD_TEST">
		<cfset Application.Settings.AppName = "CCPD LMS DEV2" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://dev2.ccpd.uc.edu/" />
		<cfset Application.Settings.HostName = "dev2.ccpd.uc.edu" />
		<cfset Application.Settings.DownloadURL = "http://dev2.ccpd.uc.edu/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
	
	<cfcase value="dev3.ccpd.uc.edu">
		<cfset Application.Settings.DSN = "CCPD_TEST">
		<cfset Application.Settings.AppName = "CCPD LMS DEV3" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://dev3.ccpd.uc.edu/" />
		<cfset Application.Settings.HostName = "dev3.ccpd.uc.edu" />
		<cfset Application.Settings.DownloadURL = "http://dev3.ccpd.uc.edu/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
	
	<cfcase value="dev4.ccpd.uc.edu">
		<cfset Application.Settings.DSN = "CCPD_TEST">
		<cfset Application.Settings.AppName = "CCPD LMS DEV4" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://dev4.ccpd.uc.edu/" />
		<cfset Application.Settings.HostName = "dev4.ccpd.uc.edu" />
		<cfset Application.Settings.DownloadURL = "http://dev4.ccpd.uc.edu/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
	
	<cfcase value="ccpd-web1.msbb.uc.edu">
		<cfset Application.Settings.DSN = "CCPD_TEST">
		<cfset Application.Settings.AppName = "CCPD LMS DEV4" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "/lms" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "/lms" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/_com" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://dev4.ccpd.uc.edu/" />
		<cfset Application.Settings.HostName = "dev4.ccpd.uc.edu" />
		<cfset Application.Settings.DownloadURL = "http://dev4.ccpd.uc.edu/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
	
	<!--- DEVELOPMENT --->
	<cfcase value="ccpdlms">
		<cfset Application.Settings.DSN = "CCPD_PROD">
		<cfset Application.Settings.LoginService = "http://systest.ahctest.uc.edu/admin/service/dev/LoginServices/wsAuthentication2.cfc?wsdl">
		<cfset Application.Settings.LookupService = "http://systest.ahctest.uc.edu/login/dev/UserLookup/wsUserLookup.cfc?wsdl">
		<cfset Application.Settings.RegisterService = "http://systest.ahctest.uc.edu/admin/service/dev/UserRegistration/UserReg.cfc?wsdl">
		<cfset Application.Settings.AppName = "CCPD[dev]" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/cfc_home" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://ccpdadmin-trunk/" />
		<cfset Application.Settings.HostName = "ccpdadmin-trunk" />
		<cfset Application.Settings.DownloadURL = "http://ccpdadmin-trunk/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>

	<!--- TEST --->
	<cfcase value="ccpd-web1">
		<cfset Application.Settings.DSN = "AITL-TESTSQL1">
		<cfset Application.Settings.LoginService = "http://systest.ahctest.uc.edu/admin/service/dev/LoginServices/wsAuthentication2.cfc?wsdl">
		<cfset Application.Settings.LookupService = "http://systest.ahctest.uc.edu/login/dev/UserLookup/wsUserLookup.cfc?wsdl">
		<cfset Application.Settings.RegisterService = "http://systest.ahctest.uc.edu/admin/service/dev/UserRegistration/UserReg.cfc?wsdl">
		<cfset Application.Settings.AppName = "CCPD[dev]" /> <!--- appears on Window Titles, etc. --->
		<cfset Application.Settings.RootPath = "" /> <!--- HTTP path for images, and links --->
		<cfset Application.Settings.AppPath = "" /> <!--- ColdFusion Mapping --->
		<cfset Application.Settings.ComPath = "/cfc_home" /> <!--- Master CFC ColdFusion Mapping --->
		
		<cfset Application.Settings.AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu" />
		
		<cfset Application.Settings.WebURL = "http://ccpdadmin-branch/" />
		<cfset Application.Settings.HostName = "ccpdadmin-branch" />
		<cfset Application.Settings.DownloadURL = "http://ccpdadmin-branch/index.cfm/event/Public.Download?" />
		
		<cfset Application.Settings.Com = "_com." />
		<cfset Application.Settings.Com2 = "_com." />
		<cfset Application.Settings.MDlist = "383,376,307,250,249,248,169,168,163,161,160,21,14,6,5,4">
	</cfcase>
</cfswitch>

<cfset Application.BugLog = CreateObject("component","#Application.Settings.Com#bugLogService").init(
bugLogListener="http://bugs.swodev.com/listeners/bugLogListenerREST.cfm",
bugEmailRecipients="rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu",
bugSenderEmail="rountrjf@ucmail.uc.edu")>
<!---
<cfset Application.unfuddle = CreateObject("component","#application.settings.com#unfuddle").init(
							unfuddleUrl="http://ucccpd.unfuddle.com",
							username="rountrjf",
							password="05125586") />--->

<!--- COMPONENTS --->
<cfset Application.Com.AccountDAO = CreateObject("component","#Application.Settings.Com#Account.AccountDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AccountGateway = CreateObject("component","#Application.Settings.Com#Account.AccountGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ActivityDAO = CreateObject("component","#Application.Settings.Com#Activity.ActivityDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ActivityGateway = CreateObject("component","#Application.Settings.Com#Activity.ActivityGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ActivityCreditDAO = CreateObject("component","#Application.Settings.Com#ActivityCredit.ActivityCreditDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ActivityCreditGateway = CreateObject("component","#Application.Settings.Com#ActivityCredit.ActivityCreditGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ActivityPubComponentDAO = CreateObject("component","#Application.Settings.Com#ActivityPubComponent.ActivityPubComponentDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ActivityPubComponentGateway = CreateObject("component","#Application.Settings.Com#ActivityPubComponent.ActivityPubComponentGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ActivityPubGeneralDAO = CreateObject("component","#Application.Settings.Com#ActivityPubGeneral.ActivityPubGeneralDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ActivityPubGeneralGateway = CreateObject("component","#Application.Settings.Com#ActivityPubGeneral.ActivityPubGeneralGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ActivityVoteDAO = CreateObject("component","#Application.Settings.Com#ActivityVote.ActivityVoteDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ActivityVoteGateway = CreateObject("component","#Application.Settings.Com#ActivityVote.ActivityVoteGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessAnswerDAO = CreateObject("component","#Application.Settings.Com#AssessAnswer.AssessAnswerDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessAnswerGateway = CreateObject("component","#Application.Settings.Com#AssessAnswer.AssessAnswerGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessmentDAO = CreateObject("component","#Application.Settings.Com#Assessment.AssessmentDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessmentGateway = CreateObject("component","#Application.Settings.Com#Assessment.AssessmentGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessQuestionDAO = CreateObject("component","#Application.Settings.Com#AssessQuestion.AssessQuestionDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessQuestionGateway = CreateObject("component","#Application.Settings.Com#AssessQuestion.AssessQuestionGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessResultDAO = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResultDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessResultGateway = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResultGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AttendeeDAO = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AttendeeGateway = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AttendeeCreditDAO = CreateObject("component","#Application.Settings.Com#AttendeeCredit.AttendeeCreditDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AttendeeCreditGateway = CreateObject("component","#Application.Settings.Com#AttendeeCredit.AttendeeCreditGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AttendeeStatusDAO = CreateObject("component","#Application.Settings.Com#AttendeeStatus.AttendeeStatusDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AttendeeStatusGateway = CreateObject("component","#Application.Settings.Com#AttendeeStatus.AttendeeStatusGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.CategoryLMSDAO = CreateObject("component","#Application.Settings.Com#CategoryLMS.CategoryLMSDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.CategoryLMSGateway = CreateObject("component","#Application.Settings.Com#CategoryLMS.CategoryLMSGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.CreditDAO = CreateObject("component","#Application.Settings.Com#Credit.CreditDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.CreditGateway = CreateObject("component","#Application.Settings.Com#Credit.CreditGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.CommentDAO = CreateObject("component","#Application.Settings.Com#Comment.CommentDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.CommentGateway = CreateObject("component","#Application.Settings.Com#Comment.CommentGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.DegreeDAO = CreateObject("component","#Application.Settings.Com#System.DegreeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.DegreeGateway = CreateObject("component","#Application.Settings.Com#System.DegreeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.EmailStyleDAO = CreateObject("component","#Application.Settings.Com#EmailStyle.EmailStyleDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.EmailStyleGateway = CreateObject("component","#Application.Settings.Com#EmailStyle.EmailStyleGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.FileDAO = CreateObject("component","#Application.Settings.Com#File.FileDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.FileGateway = CreateObject("component","#Application.Settings.Com#File.FileGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonDAO = CreateObject("component","#Application.Settings.Com#Person.PersonDAO").init(DSN=Application.Settings.DSN)>
<cfset Application.Com.PersonGateway = CreateObject("component","#Application.Settings.Com#Person.PersonGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonDegreeDAO = CreateObject("component","#Application.Settings.Com#PersonDegree.PersonDegreeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonDegreeGateway = CreateObject("component","#Application.Settings.Com#PersonDegree.PersonDegreeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonEmailDAO = CreateObject("component","#Application.Settings.Com#PersonEmail.PersonEmailDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonEmailGateway = CreateObject("component","#Application.Settings.Com#PersonEmail.PersonEmailGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonAddressDAO = CreateObject("component","#Application.Settings.Com#PersonAddress.PersonAddressDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonAddressGateway = CreateObject("component","#Application.Settings.Com#PersonAddress.PersonAddressGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonInterestExceptDAO = CreateObject("component","#Application.Settings.Com#PersonInterestExcept.PersonInterestExceptDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonInterestExceptGateway = CreateObject("component","#Application.Settings.Com#PersonInterestExcept.PersonInterestExceptGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonPrefDAO = CreateObject("component","#Application.Settings.Com#PersonPref.PersonPrefDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonPrefGateway = CreateObject("component","#Application.Settings.Com#PersonPref.PersonPrefGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonSpecialtyDAO = CreateObject("component","#Application.Settings.Com#PersonSpecialty.PersonSpecialtyDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonSpecialtyGateway = CreateObject("component","#Application.Settings.Com#PersonSpecialty.PersonSpecialtyGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ReportDAO = CreateObject("component","#Application.Settings.Com#System.ReportDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ReportGateway = CreateObject("component","#Application.Settings.Com#System.ReportGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.SpecialtyLMSDAO = CreateObject("component","#Application.Settings.Com#Specialty.SpecialtyDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.SpecialtyLMSGateway = CreateObject("component","#Application.Settings.Com#Specialty.SpecialtyGateway").Init(Application.Settings.DSN)>

<!--- PUBLIC CFCs --->
<cfset Application.Activity = CreateObject("component","#Application.Settings.Com#Public_Activity").Init()>
<cfset Application.ActivityAttendee = CreateObject("component","#Application.Settings.Com#Public_ActivityAttendee").Init()>
<cfset Application.ActivityPublish = CreateObject("component","#Application.Settings.Com#Public_ActivityPublish").Init()>
<cfset Application.Assessment = CreateObject("component","#Application.Settings.Com#Public_Assessment").Init()>
<cfset Application.Auth = CreateObject("component","#Application.Settings.Com#Public_Auth").Init()>
<cfset Application.Email = CreateObject("component","#Application.Settings.Com#Email").init()>
<cfset Application.History = CreateObject("component","#Application.Settings.Com#History").Init()>
<cfset Application.Person = CreateObject("component","#Application.Settings.Com#Public_Person").Init()>
<cfset Application.Sys = CreateObject("component","#Application.Settings.Com#Public_Sys").init()>
<cfset Application.UDF = CreateObject("component","#Application.Settings.Com#UDF").init()>

<cfset Application.List.Degrees = Application.Com.DegreeGateway.getByAttributes(DeletedFlag='N')>