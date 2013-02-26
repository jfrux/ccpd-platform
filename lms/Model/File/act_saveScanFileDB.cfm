<cfparam name="Attributes.ID" default="0" />
<cfparam name="Attributes.ActivityFileID" default="0" />

<!--- NEW --->
<cfset FileBean = CreateObject("component","#Application.Settings.Com#File.File").init()>

<cfswitch expression="#Attributes.Mode#">
	<cfcase value="Person">
		<!--- FILE DETAILS --->
		<cfset FileBean.setFileName(File.ServerFile)>
		<cfset FileBean.setFileCaption(Attributes.FIleCaption)>
		<cfset FileBean.setFileTypeID(Attributes.FileType)>
		<cfset FileBean.setPersonID(Attributes.ModeID)>
		<cfset FileBean.setCreatedBy(0)>
		<cfset Application.Com.FileDAO.Create(FileBean)>
		
		<!--- PERSON INFO --->
		<cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person").init(PersonID=Attributes.ModeID)>
		<cfset PersonBean = Application.Com.PersonDAO.read(PersonBean)>
		
		<!--- ACTION --->
		<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
		<cfset ActionBean.setPersonID(Attributes.ModeID)>
		<cfset ActionBean.setShortName("Uploaded a file.")>
		<cfset ActionBean.setLongName("Uploaded file '#File.ServerFile#' to person '<a href=""#myself#Person.Detail?PersonID=#PersonBean.getPersonID()#"">#PersonBean.getFirstName()# #PersonBean.getLastName()#</a>'.")>\
		<cfset ActionBean.setCreatedBy(0)>
		<cfset Application.Com.ActionDAO.Create(ActionBean)>
	</cfcase>
	<cfcase value="Activity">
		<!--- FILE DETAILS --->
		<cfset FileBean.setFileName(File.ServerFile)>
		<cfset FileBean.setFileCaption(Attributes.FIleCaption)>
		<cfset FileBean.setFileTypeID(Attributes.FileType)>
		<cfset FileBean.setActivityID(Attributes.ModeID)>
		<cfset FileBean.setCreatedBy(Session.Person.getPersonID())>
		<cfset Application.Com.FileDAO.Create(FileBean)>
		
		<!--- ACTIVITY INFO --->
		<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Attributes.ModeID)>
		<cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
		
		<!--- ACTION --->
		<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
		<cfset ActionBean.setActivityID(Attributes.ModeID)>
		<cfset ActionBean.setShortName("Uploaded a file.")>
		<cfset ActionBean.setLongName("Uploaded file '#File.ServerFile#' to activity '<a href=""#myself#Activity.Detail?ActivityID=#ActivityBean.getActivityID()#"">#ActivityBean.getTitle()#</a>'.")>
		<cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
		<cfset Application.Com.ActionDAO.Create(ActionBean)>
	</cfcase>
</cfswitch>