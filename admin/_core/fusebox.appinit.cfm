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
<cfset application['settings'] = StructNew() />
<cfset application['apiCache'] = {} />
<cfset application.settings['bugLogServer'] = "http://bugs.swodev.com" />
<cfset $_settings = application.settings />
<cfset request.CGI = CGI />

<cfinclude template="/lib/fusebox-addons/public.cfm" />
<cfset set(environment = "development") />
<cfinclude template="/lib/fusebox-addons/settings.cfm" />
<cfset set(showErrorInformation=true) />
<cfset set(showDebugInformation = false) />
<cfset set(webPath='/admin') />
<cfset set(assetPaths = {
	'http':'localhost:8888/assets',
	'https':'localhost:8888/assets'
}) />
<cfset set(imagePath = "") />
<cfswitch expression="#CGI.SERVER_NAME#">
	<!--- PRODUCTION --->
	<cfcase value="ccpd.uc.edu">
		<cfset set(assetsUrl = "http://www.getmycme.com/assets")>
		<cfset set(apiUrl = "http://www.getmycme.com")>
		<cfset set(dsn = "CCPD_PROD")>
		<cfset set(appName = "CCPD Admin 2.0")>
		<cfset set(rootPath = "/admin")>
		<cfset set(comPath = "/_com")>
		<cfset set(appPath = "/admin")>
		<cfset set(com = "_com.")>
		<cfset set(com2 = "admin._com.")>
		<cfset set(AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu")>
		<cfset set(WebURL = "https://ccpd.uc.edu/admin/")>
		<cfset set(LMSURL = "https://ccpd.uc.edu/")>
		<cfset set(CDCURL = "http://cme.uc.edu/stdptc")>
		<cfset set(javaloaderKey = "JAVALOADER-CCPD-PROD-15313")>
	</cfcase>
	
	<cfcase value="test.ccpd.uc.edu">
		<cfset set(assetsUrl = "http://localhost:3000/assets")>
		<cfset set(apiUrl = "http://localhost:3000")>
		<cfset set(dsn = "CCPD_RAILS")>
		<cfset set(appName = "CCPD Admin 2.0")>
		<cfset set(rootPath = "/admin")>
		<cfset set(comPath = "/_com")>
		<cfset set(appPath = "/admin")>
		<cfset set(Com = "_com.")>
		<cfset set(Com2 = "admin._com.")>
		<cfset set(AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu")>
		<cfset set(WebURL = "https://test.uc.edu/admin/")>
		<cfset set(LMSURL = "https://test.uc.edu/")>
		<cfset set(CDCURL = "http://cme.uc.edu/stdptc")>
		<cfset set(javaloaderKey = "JAVALOADER-CCPD-PROD-15313")>
	</cfcase>

	<cfcase value="localhost">
		<cfset set(assetsUrl = "http://localhost:9292/")>
		<cfset set(apiUrl = "http://localhost:3001")>
		<cfset set(dsn = "CCPD_CLONE")>
		<cfset set(appName = "CCPD Admin 2.0")>
		<cfset set(rootPath = "/admin")>
		<cfset set(comPath = "/_com")>
		<cfset set(appPath = "/admin")>
		<cfset set(Com = "_com.")>
		<cfset set(Com2 = "admin._com.")>
		<cfset set(AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu")>
		<cfset set(WebURL = "https://test.uc.edu/admin/")>
		<cfset set(LMSURL = "https://test.uc.edu/")>
		<cfset set(CDCURL = "http://cme.uc.edu/stdptc")>
		<cfset set(javaloaderKey = "JAVALOADER-CCPD-PROD-15313")>
	</cfcase>

	<cfcase value="v2.ccpd.uc.edu">
		<cfset set(assetsUrl = "http://localhost:3000/assets")>
		<cfset set(apiUrl = "http://localhost:3000")>
		
		<cfset set(dsn = "CCPD_CLONE")>
		<cfset set(appName = "CCPD Admin 2.0")>
		<cfset set(rootPath = "/admin")>
		<cfset set(comPath = "/_com")>
		<cfset set(appPath = "/admin")>
		<cfset set(Com = "_com.")>
		<cfset set(Com2 = "admin._com.")>
		<cfset set(AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu")>
		<cfset set(WebURL = "https://test.uc.edu/admin/")>
		<cfset set(LMSURL = "https://test.uc.edu/")>
		<cfset set(CDCURL = "http://cme.uc.edu/stdptc")>
		<cfset set(javaloaderKey = "JAVALOADER-CCPD-PROD-15313")>
	</cfcase>
</cfswitch>

<cfset request.cgi = CGI>

<cfset Application.BugLog = CreateObject("component","#Application.Settings.Com#bugLogService").init(
bugLogListener="http://bugs.swodev.com/listeners/bugLogListenerREST.cfm",
bugEmailRecipients="rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu",
bugSenderEmail="rountrjf@ucmail.uc.edu")>
<!---
<cfset Application.unfuddle = CreateObject("component","#application.settings.com#unfuddle").init(
							unfuddleUrl="http://ucccpd.unfuddle.com",
							username="rountrjf",
							password="05125586") />--->

<!--- JAVA PATHS / LOADER --->
<!--- <cfset javaPaths = ["#expandPath("/_java/lingpipe-4.0.1.jar")#",
"#expandPath("/_java/Supa.jar")#",
"#expandPath("/_java/EncodingUtil.class")#"]> --->
 
<!--- <cfset application.javaloader = createObject("component", "_com.javaloader.JavaLoader").init(javaPaths)> --->

<cfset Application.Email = CreateObject("component","#Application.Settings.Com#email").Init()>
<cfset application.search = createObject("component","_com.typeahead.search").init(application.settings.dsn) />

<!--- COMPONENTS --->
<cfset Application.Com.AccountDAO = CreateObject("component","#Application.Settings.Com#Account.AccountDAO").Init(Application.Settings.dsn)>
<cfset Application.Com.AccountGateway = CreateObject("component","#Application.Settings.Com#Account.AccountGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ActionDAO = CreateObject("component","#Application.Settings.Com#Action.ActionDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ActionGateway = CreateObject("component","#Application.Settings.Com#Action.ActionGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AgendaDAO = CreateObject("component","#Application.Settings.Com#Agenda.AgendaDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AgendaGateway = CreateObject("component","#Application.Settings.Com#Agenda.AgendaGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessmentDAO = CreateObject("component","#Application.Settings.Com#Assessment.AssessmentDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessmentGateway = CreateObject("component","#Application.Settings.Com#Assessment.AssessmentGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessTmplDAO = CreateObject("component","#Application.Settings.Com#AssessTmpl.AssessTmplDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessTmplGateway = CreateObject("component","#Application.Settings.Com#AssessTmpl.AssessTmplGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessAnswerDAO = CreateObject("component","#Application.Settings.Com#AssessAnswer.AssessAnswerDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessAnswerGateway = CreateObject("component","#Application.Settings.Com#AssessAnswer.AssessAnswerGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessQuestionDAO = CreateObject("component","#Application.Settings.Com#AssessQuestion.AssessQuestionDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessQuestionGateway = CreateObject("component","#Application.Settings.Com#AssessQuestion.AssessQuestionGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessResultDAO = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResultDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessResultGateway = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResultGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessSectionDAO = CreateObject("component","#Application.Settings.Com#AssessSection.AssessSectionDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessSectionGateway = CreateObject("component","#Application.Settings.Com#AssessSection.AssessSectionGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessmentDAO = CreateObject("component","#Application.Settings.Com#Assessment.AssessmentDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessmentGateway = CreateObject("component","#Application.Settings.Com#Assessment.AssessmentGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AttendeeDAO = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AttendeeGateway = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AttendeeCreditDAO = CreateObject("component","#Application.Settings.Com#AttendeeCredit.AttendeeCreditDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AttendeeCreditGateway = CreateObject("component","#Application.Settings.Com#AttendeeCredit.AttendeeCreditGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AttendeeCDCDAO = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeCDCDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AttendeeCDCGateway = CreateObject("component","#Application.Settings.Com#Attendee.AttendeeCDCGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AttendeeStatusDAO = CreateObject("component","#Application.Settings.Com#AttendeeStatus.AttendeeStatusDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AttendeeStatusGateway = CreateObject("component","#Application.Settings.Com#AttendeeStatus.AttendeeStatusGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AddressTypeDAO = CreateObject("component","#Application.Settings.Com#AddressType.AddressTypeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AddressTypeGateway = CreateObject("component","#Application.Settings.Com#AddressType.AddressTypeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.CategoryDAO = CreateObject("component","#Application.Settings.Com#Category.CategoryDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.CategoryGateway = CreateObject("component","#Application.Settings.Com#Category.CategoryGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ComponentDAO = CreateObject("component","#Application.Settings.Com#System.ComponentDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ComponentGateway = CreateObject("component","#Application.Settings.Com#System.ComponentGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.CommentDAO = CreateObject("component","#Application.Settings.Com#Comment.CommentDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.CommentGateway = CreateObject("component","#Application.Settings.Com#Comment.CommentGateway").Init(Application.Settings.DSN)>

<!---<cfset Application.Com.ContributorDAO = CreateObject("component","#Application.Settings.Com#ContributorDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ContributorGateway = CreateObject("component","#Application.Settings.Com#ContributorGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ContribTypeDAO = CreateObject("component","#Application.Settings.Com#ContribTypeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ContribTypeGateway = CreateObject("component","#Application.Settings.Com#ContribTypeGateway").Init(Application.Settings.DSN)>--->

<cfset Application.Com.CreditDAO = CreateObject("component","#Application.Settings.Com#System.CreditDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.CreditGateway = CreateObject("component","#Application.Settings.Com#System.CreditGateway").Init(Application.Settings.DSN)>

	<!--- ACTIVITY --->
	<cfset Application.Com.ActivityDAO = CreateObject("component","#Application.Settings.Com#Activity.ActivityDAO").Init(Application.Settings.DSN)>
	<cfset Application.Com.ActivityGateway = CreateObject("component","#Application.Settings.Com#Activity.ActivityGateway").Init(Application.Settings.DSN)>
	
	<cfset Application.Com.ActivityCategoryDAO = CreateObject("component","#Application.Settings.Com#ActivityCategory.ActivityCategoryDAO").Init(Application.Settings.DSN)>
	<cfset Application.Com.ActivityCategoryGateway = CreateObject("component","#Application.Settings.Com#ActivityCategory.ActivityCategoryGateway").Init(Application.Settings.DSN)>
	
    <cfset Application.Com.ActivityApplicationDAO = CreateObject("component","#Application.Settings.Com#ActivityApplication.ActivityApplicationDAO").Init(Application.Settings.DSN)>
	<cfset Application.Com.ActivityApplicationGateway = CreateObject("component","#Application.Settings.Com#ActivityApplication.ActivityApplicationGateway").Init(Application.Settings.DSN)>
    
	<cfset Application.Com.ActivityCommitteeDAO = CreateObject("component","#Application.Settings.Com#ActivityCommittee.ActivityCommitteeDAO").Init(Application.Settings.DSN)>
	<cfset Application.Com.ActivityCommitteeGateway = CreateObject("component","#Application.Settings.Com#ActivityCommittee.ActivityCommitteeGateway").Init(Application.Settings.DSN)>
	
	<cfset Application.Com.ActivityPubGeneralDAO = CreateObject("component","#Application.Settings.Com#ActivityPubGeneral.ActivityPubGeneralDAO").Init(Application.Settings.DSN)>
	<cfset Application.Com.ActivityPubGeneralGateway = CreateObject("component","#Application.Settings.Com#ActivityPubGeneral.ActivityPubGeneralGateway").Init(Application.Settings.DSN)>
	
	<cfset Application.Com.ActivityPubComponentDAO = CreateObject("component","#Application.Settings.Com#ActivityPubComponent.ActivityPubComponentDAO").Init(Application.Settings.DSN)>
	<cfset Application.Com.ActivityPubComponentGateway = CreateObject("component","#Application.Settings.Com#ActivityPubComponent.ActivityPubComponentGateway").Init(Application.Settings.DSN)>
	
	<cfset Application.Com.ActivityFacultyDAO = CreateObject("component","#Application.Settings.Com#ActivityFaculty.ActivityFacultyDAO").Init(Application.Settings.DSN)>
	<cfset Application.Com.ActivityFacultyGateway = CreateObject("component","#Application.Settings.Com#ActivityFaculty.ActivityFacultyGateway").Init(Application.Settings.DSN)>
	
	<cfset Application.Com.ActivityOtherDAO = CreateObject("component","#Application.Settings.Com#ActivityOther.ActivityOtherDAO").Init(Application.Settings.DSN)>
	<cfset Application.Com.ActivityOtherGateway = CreateObject("component","#Application.Settings.Com#ActivityOther.ActivityOtherGateway").Init(Application.Settings.DSN)>

		<!--- ACTIVITY FINANCES --->
		<cfset Application.Com.ActivitySupportDAO = CreateObject("component","#Application.Settings.Com#ActivityFinance.SupportDAO").Init(Application.Settings.DSN)>
		<cfset Application.Com.ActivitySupportGateway = CreateObject("component","#Application.Settings.Com#ActivityFinance.SupportGateway").Init(Application.Settings.DSN)>
		
		<cfset Application.Com.ActivityBudgetDAO = CreateObject("component","#Application.Settings.Com#ActivityFinance.BudgetDAO").Init(Application.Settings.DSN)>
		<cfset Application.Com.ActivityBudgetGateway = CreateObject("component","#Application.Settings.Com#ActivityFinance.BudgetGateway").Init(Application.Settings.DSN)>
		
		<cfset Application.Com.ActivityLedgerDAO = CreateObject("component","#Application.Settings.Com#ActivityFinance.LedgerDAO").Init(Application.Settings.DSN)>
		<cfset Application.Com.ActivityLedgerGateway = CreateObject("component","#Application.Settings.Com#ActivityFinance.LedgerGateway").Init(Application.Settings.DSN)>
		
		<cfset Application.Com.ActivityFeeDAO = CreateObject("component","#Application.Settings.Com#ActivityFinance.FeeDAO").Init(Application.Settings.DSN)>
		<cfset Application.Com.ActivityFeeGateway = CreateObject("component","#Application.Settings.Com#ActivityFinance.FeeGateway").Init(Application.Settings.DSN)>
		<!--- //ACTIVITY FINANCES --->

	<cfset Application.Com.ActivityCreditDAO = CreateObject("component","#Application.Settings.Com#ActivityCredit.ActivityCreditDAO").Init(Application.Settings.DSN)>
    <cfset Application.Com.ActivityCreditGateway = CreateObject("component","#Application.Settings.Com#ActivityCredit.ActivityCreditGateway").Init(Application.Settings.DSN)>
    
    <cfset Application.Com.ActivityNoteDAO = CreateObject("component","#Application.Settings.Com#ActivityNote.ActivityNoteDAO").Init(Application.Settings.DSN)>
    <cfset Application.Com.ActivityNoteGateway = CreateObject("component","#Application.Settings.Com#ActivityNote.ActivityNoteGateway").Init(Application.Settings.DSN)>
    
    <cfset Application.Com.ActivityOtherDAO = CreateObject("component","#Application.Settings.Com#ActivityOther.ActivityOtherDAO").Init(Application.Settings.DSN)>
    <cfset Application.Com.ActivityOtherGateway = CreateObject("component","#Application.Settings.Com#ActivityOther.ActivityOtherGateway").Init(Application.Settings.DSN)>
    
    <cfset Application.Com.ActivityCategoryLMSDAO = CreateObject("component","#Application.Settings.Com#ActivityCategoryLMS.ActivityCategoryLMSDAO").Init(Application.Settings.DSN)>
    <cfset Application.Com.ActivityCategoryLMSGateway = CreateObject("component","#Application.Settings.Com#ActivityCategoryLMS.ActivityCategoryLMSGateway").Init(Application.Settings.DSN)>
	
	<cfset Application.Com.ActivityPrereqDAO = CreateObject("component","#Application.Settings.Com#ActivityPrereq.ActivityPrereqDAO").Init(Application.Settings.DSN)>
	<cfset Application.Com.ActivityPrereqGateway = CreateObject("component","#Application.Settings.Com#ActivityPrereq.ActivityPrereqGateway").Init(Application.Settings.DSN)>

	<cfset Application.Com.ActivitySpecialtyDAO = CreateObject("component","#Application.Settings.Com#ActivitySpecialtyLMS.ActivitySpecialtyLMSDAO").Init(Application.Settings.DSN)>
    <cfset Application.Com.ActivitySpecialtyGateway = CreateObject("component","#Application.Settings.Com#ActivitySpecialtyLMS.ActivitySpecialtyLMSGateway").Init(Application.Settings.DSN)>
    
    <cfset Application.Com.ActivityTypeDAO = CreateObject("component","#Application.Settings.Com#System.ActivityTypeDAO").Init(Application.Settings.DSN)>
    <cfset Application.Com.ActivityTypeGateway = CreateObject("component","#Application.Settings.Com#System.ActivityTypeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessResultStatusDAO = CreateObject("component","#Application.Settings.Com#System.AssessResultStatusDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessResultStatusGateway = CreateObject("component","#Application.Settings.Com#System.AssessResultStatusGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.DegreeDAO = CreateObject("component","#Application.Settings.Com#System.DegreeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.DegreeGateway = CreateObject("component","#Application.Settings.Com#System.DegreeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.GroupingDAO = CreateObject("component","#Application.Settings.Com#System.GroupingDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.GroupingGateway = CreateObject("component","#Application.Settings.Com#System.GroupingGateway").Init(Application.Settings.DSN)>

<cfset application.com.imageDAO = CreateObject("component","#Application.Settings.Com#image.imageDAO").Init(Application.Settings.DSN)>
<cfset application.com.imageGateway = CreateObject("component","#Application.Settings.Com#image.imageGateway").Init(Application.Settings.DSN)>
<cfset application.com.image = CreateObject("component","#Application.Settings.Com#image.imageService").Init(Application.com.imageDao,application.com.imageGateway)>

<cfset application.com.imageTypeDAO = CreateObject("component","#Application.Settings.Com#imageType.imageTypeDAO").Init(Application.Settings.DSN)>
<cfset application.com.imageTypeGateway = CreateObject("component","#Application.Settings.Com#imageType.imageTypeGateway").Init(Application.Settings.DSN)>
<cfset application.com.imageType = CreateObject("component","#Application.Settings.Com#imageType.imageTypeService").Init(Application.com.imageTypeDao,application.com.imageTypeGateway)>

<cfset Application.Com.EntryTypeDAO = CreateObject("component","#Application.Settings.Com#System.EntryTypeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.EntryTypeGateway = CreateObject("component","#Application.Settings.Com#System.EntryTypeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.FileDAO = CreateObject("component","#Application.Settings.Com#File.FileDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.FileGateway = CreateObject("component","#Application.Settings.Com#File.FileGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.FileTypeDAO = CreateObject("component","#Application.Settings.Com#System.FileTypeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.FileTypeGateway = CreateObject("component","#Application.Settings.Com#System.FileTypeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.HistoryStyleDAO = CreateObject("component","#Application.Settings.Com#HistoryStyle.HistoryStyleDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.HistoryStyleGateway = CreateObject("component","#Application.Settings.Com#HistoryStyle.HistoryStyleGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.EmailStyleDAO = CreateObject("component","#Application.Settings.Com#EmailStyle.EmailStyleDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.EmailStyleGateway = CreateObject("component","#Application.Settings.Com#EmailStyle.EmailStyleGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonDAO = CreateObject("component","#Application.Settings.Com#Person.PersonDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonGateway = CreateObject("component","#Application.Settings.Com#Person.PersonGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonAddressDAO = CreateObject("component","#Application.Settings.Com#PersonAddress.PersonAddressDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonAddressGateway = CreateObject("component","#Application.Settings.Com#PersonAddress.PersonAddressGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonDegreeDAO = CreateObject("component","#Application.Settings.Com#PersonDegree.PersonDegreeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonDegreeGateway = CreateObject("component","#Application.Settings.Com#PersonDegree.PersonDegreeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonNewDAO = CreateObject("component","#Application.Settings.Com#Person.PersonDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonNewGateway = CreateObject("component","#Application.Settings.Com#Person.PersonGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonEmailDAO = CreateObject("component","#Application.Settings.Com#PersonEmail.PersonEmailDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonEmailGateway = CreateObject("component","#Application.Settings.Com#PersonEmail.PersonEmailGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonFileDAO = CreateObject("component","#Application.Settings.Com#PersonFile.PersonFileDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonFileGateway = CreateObject("component","#Application.Settings.Com#PersonFile.PersonFileGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonNoteDAO = CreateObject("component","#Application.Settings.Com#PersonNote.PersonNoteDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonNoteGateway = CreateObject("component","#Application.Settings.Com#PersonNote.PersonNoteGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonPrefDAO = CreateObject("component","#Application.Settings.Com#PersonPref.PersonPrefDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonPrefGateway = CreateObject("component","#Application.Settings.Com#PersonPref.PersonPrefGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonStatusDAO = CreateObject("component","#Application.Settings.Com#System.PersonStatusDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonStatusGateway = CreateObject("component","#Application.Settings.Com#System.PersonStatusGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ProcessDAO = CreateObject("component","#Application.Settings.Com#Process.ProcessDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ProcessGateway = CreateObject("component","#Application.Settings.Com#Process.ProcessGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ProcessManagerDAO = CreateObject("component","#Application.Settings.Com#ProcessManager.ProcessManagerDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ProcessManagerGateway = CreateObject("component","#Application.Settings.Com#ProcessManager.ProcessManagerGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ProcessStepDAO = CreateObject("component","#Application.Settings.Com#ProcessStep.ProcessStepDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ProcessStepGateway = CreateObject("component","#Application.Settings.Com#ProcessStep.ProcessStepGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ProcessStepActivityDAO = CreateObject("component","#Application.Settings.Com#ProcessStepActivity.ProcessStepActivityDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ProcessStepActivityGateway = CreateObject("component","#Application.Settings.Com#ProcessStepActivity.ProcessStepActivityGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.RoleDAO = CreateObject("component","#Application.Settings.Com#Role.RoleDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.RoleGateway = CreateObject("component","#Application.Settings.Com#Role.RoleGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.StatusDAO = CreateObject("component","#Application.Settings.Com#System.StatusDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.StatusGateway = CreateObject("component","#Application.Settings.Com#System.StatusGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PersonStatusDAO = CreateObject("component","#Application.Settings.Com#System.PersonStatusDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PersonStatusGateway = CreateObject("component","#Application.Settings.Com#System.PersonStatusGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.StepStatusDAO = CreateObject("component","#Application.Settings.Com#System.StepStatusDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.StepStatusGateway = CreateObject("component","#Application.Settings.Com#System.StepStatusGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.SupporterDAO = CreateObject("component","#Application.Settings.Com#System.SupporterDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.SupporterGateway = CreateObject("component","#Application.Settings.Com#System.SupporterGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.SupportTypeDAO = CreateObject("component","#Application.Settings.Com#System.SupportTypeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.SupportTypeGateway = CreateObject("component","#Application.Settings.Com#System.SupportTypeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.CBAFundDAO = CreateObject("component","#Application.Settings.Com#System.CBAFundDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.CBAFundGateway = CreateObject("component","#Application.Settings.Com#System.CBAFundGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.CBOFundDAO = CreateObject("component","#Application.Settings.Com#System.CBOFundDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.CBOFundGateway = CreateObject("component","#Application.Settings.Com#System.CBOFundGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.FunRCDAO = CreateObject("component","#Application.Settings.Com#System.FunRCDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.FunRCGateway = CreateObject("component","#Application.Settings.Com#System.FunRCGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.FunRNDAO = CreateObject("component","#Application.Settings.Com#System.FunRNDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.FunRNGateway = CreateObject("component","#Application.Settings.Com#System.FunRNGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.OccClassDAO = CreateObject("component","#Application.Settings.Com#System.OccClassDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.OccClassGateway = CreateObject("component","#Application.Settings.Com#System.OccClassGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.OrgTypeDAO = CreateObject("component","#Application.Settings.Com#System.OrgTypeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.OrgTypeGateway = CreateObject("component","#Application.Settings.Com#System.OrgTypeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.QuestionTypeDAO = CreateObject("component","#Application.Settings.Com#System.AssessQuestionTypeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.QuestionTypeGateway = CreateObject("component","#Application.Settings.Com#System.AssessQuestionTypeGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ProfCDAO = CreateObject("component","#Application.Settings.Com#System.ProfCDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ProfCGateway = CreateObject("component","#Application.Settings.Com#System.ProfCGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ProfNDAO = CreateObject("component","#Application.Settings.Com#System.ProfNDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ProfNGateway = CreateObject("component","#Application.Settings.Com#System.ProfNGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.MarketDAO = CreateObject("component","#Application.Settings.Com#System.MarketDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.MarketGateway = CreateObject("component","#Application.Settings.Com#System.MarketGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.PrinEmpDAO = CreateObject("component","#Application.Settings.Com#System.PrinEmpDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.PrinEmpGateway = CreateObject("component","#Application.Settings.Com#System.PrinEmpGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.ReportDAO = CreateObject("component","#Application.Settings.Com#System.ReportDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.ReportGateway = CreateObject("component","#Application.Settings.Com#System.ReportGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.AssessmentTypeDAO = CreateObject("component","#Application.Settings.Com#System.AssessTypeDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.AssessmentTypeGateway = CreateObject("component","#Application.Settings.Com#System.AssessTypeGateway").Init(Application.Settings.DSN)>

<!--- LMS Com Objects --->
<cfset Application.Com.CategoryLMSDAO = CreateObject("component","#Application.Settings.Com#CategoryLMS.CategoryLMSDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.CategoryLMSGateway = CreateObject("component","#Application.Settings.Com#CategoryLMS.CategoryLMSGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.SiteDAO = CreateObject("component","#Application.Settings.Com#Site.SiteDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.SiteGateway = CreateObject("component","#Application.Settings.Com#Site.SiteGateway").Init(Application.Settings.DSN)>

<cfset Application.Com.SpecialtyDAO = CreateObject("component","#Application.Settings.Com#Specialty.SpecialtyDAO").Init(Application.Settings.DSN)>
<cfset Application.Com.SpecialtyGateway = CreateObject("component","#Application.Settings.Com#Specialty.SpecialtyGateway").Init(Application.Settings.DSN)>

<!--- PUBLIC CFCs --->
<cfset Application.Activity = CreateObject("component","#Application.Settings.Com#Public_Activity").Init()>
<cfset Application.ActivityAttendee = CreateObject("component","#Application.Settings.Com#Public_ActivityAttendee").Init()>
<cfset Application.ActivityFinance = CreateObject("component","#Application.Settings.Com#Public_ActivityFinance").Init()>
<cfset Application.ActivityPeople = CreateObject("component","#Application.Settings.Com#Public_ActivityPeople").Init()>
<cfset Application.ActivityPublish = CreateObject("component","#Application.Settings.Com#Public_ActivityPublish").Init()>
<cfset Application.Assessment = CreateObject("component","#Application.Settings.Com#Public_Assessment").Init()>
<cfset Application.Auth = CreateObject("component","#Application.Settings.Com#Public_Auth").Init()>
<cfset Application.Builder = CreateObject("component","#Application.Settings.Com#Public_Builder").Init()>
<cfset Application.History = CreateObject("component","#Application.Settings.Com#History").Init()>
<cfset Application.Person = CreateObject("component","#Application.Settings.Com#Public_Person").init()>
<cfset Application.Renderer = CreateObject("component","#Application.Settings.Com#Renderer").Init()>
<!---<cfset Application.Search = CreateObject("component","#Application.Settings.Com#Search").init()>
<cfset Application.SearchResult = CreateObject("component","#Application.Settings.Com#SearchResult").init()>--->
<cfset Application.System = CreateObject("component","#Application.Settings.Com#Public_Sys").init()>
<cfset Application.UDF = CreateObject("component","#Application.Settings.Com#UDF").init()>

<!--- SYSTEM LISTS --->
<cfset Application.List.FunRC = Application.Com.FunRCGateway.getByAttributes(OrderBy='Name')>
<cfset Application.List.FunRN = Application.Com.FunRNGateway.getByAttributes(OrderBy='Name')>
<cfset Application.List.OccClass = Application.Com.OccClassGateway.getByAttributes(OrderBy='Name')>
<cfset Application.List.OrgType = Application.Com.OrgTypeGateway.getByAttributes(OrderBy='Name')>
<cfset Application.List.ProfC = Application.Com.ProfCGateway.getByAttributes(OrderBy='Name')>
<cfset Application.List.ProfN = Application.Com.ProfNGateway.getByAttributes(OrderBy='Name')>
<cfset Application.List.Market = Application.Com.MarketGateway.getByAttributes(OrderBy='Name')>
<cfset Application.List.PrinEmp = Application.Com.PrinEmpGateway.getByAttributes(OrderBy='Name')>

<cfset Application.List.StepStatus = Application.Com.StepStatusGateway.getByAttributes(OrderBy='Name')>

<!--- CACHED APPLICATION QUERIES --->
<cfset Application.List.AddressTypes = Application.Com.AddressTypeGateway.getByAttributes(OrderBy='Description')>

<cfset Application.List.AuthLevels = CreateObject("component","#Application.Settings.Com#Config_Lists").getAuthLevels()>
<cfset Application.List.States = CreateObject("component","#Application.Settings.Com#Config_Lists").getStates()>
<cfset Application.List.Countries = CreateObject("component","#Application.Settings.Com#Config_Lists").getCountries()>
<cfset Application.List.HistoryStyles = CreateObject("component","#Application.Settings.Com#Config_Lists").getHistoryStyles()>
<cfset Application.List.ActivityTypes = CreateObject("component","#Application.Settings.Com#Config_Lists").getActivityTypes()>
<cfset Application.List.Groupings = CreateObject("component","#Application.Settings.Com#Config_Lists").getGroupings()>

<cfset Application.List.Credits = Application.Com.CreditGateway.getByAttributes(DeletedFlag='N')>
<cfset Application.List.Degrees = Application.Com.DegreeGateway.getByAttributes(DeletedFlag='N')>
<cfset Application.List.OMBEthnicities = CreateObject("component","#Application.Settings.Com#Config_Lists").getOMBEthnicities()>
<cfset Application.List.PersonStatuses = Application.Com.PersonStatusGateway.getByAttributes()>

<cfset Application.List.NoiseWords = CreateObject("component","#Application.Settings.Com#Config_Lists").getNoiseWords()>

<!--- JAVA LOADER 
<!--- use a unique hard coded key to store the javaLoader in the server structure ---->
<!--- the xxxx is actually a hardcoded UUID value ---->
<cfset jarPaths = arrayNew(1)>

<!--- if the javaLoader was not created yet --->
<cfif NOT structKeyExists(server, application.settings.javaloaderKey)>

	<!--- these are absolute paths to the POI jar files --->
	<cfset arrayAppend( jarPaths, expandPath("./poi-3.7-20101029.jar")) >
	<cfset arrayAppend( jarPaths, expandPath("./poi-examples-3.7-20101029.jar")) >
	<cfset arrayAppend( jarPaths, expandPath("./poi-ooxml-3.7-20101029.jar")) >
	<cfset arrayAppend( jarPaths, expandPath("./poi-ooxml-schemas-3.7-20101029.jar")) >
	<cfset arrayAppend( jarPaths, expandPath("./poi-scratchpad-3.7-20101029.jar")) >
	
	<!---  re-verify it was not created yet --->
	<cfif NOT structKeyExists(server, application.settings.javaloaderKey)>
	   <cflock name="#Hash(application.settings.javaloaderKey)#" type="exclusive" timeout="10">
		   <!---  create an instance of the JavaLoader and store it in the server scope --->
		   <cfset server[application.settings.javaloaderKey] = createObject("component", "javaloader.JavaLoader").init( jarPaths )>
	   </cflock>
	</cfif>
</cfif>--->



<!---<cfset Application.List.Contributors = Application.Com.ContributorGateway.getByAttributes()>
<cfset Application.List.ContribTypes = Application.Com.ContribTypeGateway.getByAttributes()>--->

<!---<cfset Application.List.EducationTypes = Application.Com.EducationGateway.getByAttributes(OrderBy='Name')>
<cfset Application.List.Ethnicities = Application.Com.EthnicityGateway.getByAttributes()>
<cfset Application.List.Institutions = Application.Com.InstitutionGateway.getByAttributes()>
<cfset Application.List.OMBEthnicities = Application.Com.OMBEthnicityGateway.getByAttributes()>
<cfset Application.List.Salutations = Application.Com.SalutationGateway.getByAttributes()>

<cfset Application.List.UCBuildings = Application.Com.UCBuildingGateway.getByAttributes(OrderBy='SpaceName')>--->
