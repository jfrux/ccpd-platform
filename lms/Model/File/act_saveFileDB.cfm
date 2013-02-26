<cfparam name="Attributes.ModeID" default="0" />
<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.ActivityFileID" default="0" />

<cfif IsDefined("Attributes.Submitted") AND Attributes.Submitted AND Request.Status.Errors EQ "">
	<!--- NEW --->
	<cfif Attributes.Fuseaction NEQ "File.Edit">
		<cfset FileBean = CreateObject("component","#Application.Settings.Com#File.File").init()>
		
		<cfswitch expression="#Attributes.Mode#">
			<cfcase value="Person">
				<!--- FILE DETAILS --->
				<cfset FileBean.setFileName(NewFileName)>
				<cfset FileBean.setFileCaption(Attributes.FileCaption)>
				<cfset FileBean.setFileSize(File.FileSize)>
				<cfset FileBean.setFileTypeID(Attributes.FileType)>
				<cfset FileBean.setPersonID(Attributes.ModeID)>
				<cfset FileBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset NewFileID = Application.Com.FileDAO.Create(FileBean)>
				<cfset FileBean.setFileID(NewFileID)>
				<!--- PERSON INFO --->
				<cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person.Person").init(PersonID=Attributes.ModeID)>
				<cfset PersonBean = Application.Com.PersonDAO.read(PersonBean)>
                
                <!--- CHECK IF ACITIVTYID IS PRESENT --->
                <cfif Attributes.ActivityID NEQ "">
					<!--- GET FILETYPES --->
                    <cfquery name="qGetFileType" datasource="#Application.Settings.DSN#">
                        SELECT FileTypeID, Name
                        FROM ce_Sys_FileType
                        WHERE FileTypeID = <cfqueryparam value="#Attributes.FileType#" cfsqltype="cf_sql_integer" />
                    </cfquery>
                    
                	<!--- GET ACTIVITYFACULTYBEAN INFO --->
                	<cfset ActivityFacultyBean = CreateObject("component","#Application.Settings.Com#ActivityFaculty.ActivityFaculty").Init(PersonID=Attributes.ModeID,ActivityID=Attributes.ActivityID)>
                    <cfset ActivityFacultyBean = Application.Com.ActivityFacultyDAO.Read(ActivityFacultyBean)>
                    
                    <!--- UPDATE ACTIVITYFACULTYBEAN INFO --->
                    <cfif qGetFileType.Name EQ "CV">
                    	<cfset ActivityFacultyBean.setCVFileID(NewFileID)>
                    	<cfset ActivityFacultyBean.setCVApproveFlag("N")>
                    <cfelseif qGetFileType.Name EQ "Disclosure">
                    	<cfset ActivityFacultyBean.setDisclosureFileID(NewFileID)>
                    	<cfset ActivityFacultyBean.setDisclosureApproveFlag("N")>
                    </cfif>
                    
                    <!--- SAVE ACTIVITYFACULTYBEAN --->
                    <cfset ActivityFacultySaved = Application.Com.ActivityFacultyDAO.Save(ActivityFacultyBean)>
                    
					<!--- ACTIVITY INFO --->
                    <cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Attributes.ActivityID)>
                    <cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
				
					<!--- PERSON INFO --->
                    <cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person").init(PersonID=Attributes.ModeID)>
                    <cfset PersonBean = Application.Com.PersonDAO.read(PersonBean)>
					
					<!--- ACTIVITYFACULTY ACTION --->
            		<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
					<cfset ActionBean.setActivityID(Attributes.ActivityID)>
                    <cfset ActionBean.setCode("FIU")>
                    <cfif qGetFileType.Name EQ "CV">
                        <cfset ActionBean.setShortName("Updated Faculty CV file.")>
                        <cfset ActionBean.setLongName("Updated CV file for person '<a href=""#myself#Person.Detail?PersonID=#PersonBean.getPersonID()#"">#PersonBean.getFirstName()# #PersonBean.getLastName()#</a>' on activity '<a href=""#Myself#Activity.Detail?ActivityID=#Attributes.ActivityID#"">#ActivityBean.getTitle()#</a>'.")>
                    <cfelseif qGetFileType.Name EQ "Disclosure">
                        <cfset ActionBean.setShortName("Updated Faculty Disclosure file.")>
                        <cfset ActionBean.setLongName("Updated disclosure file for person '<a href=""#myself#Person.Detail?PersonID=#PersonBean.getPersonID()#"">#PersonBean.getFirstName()# #PersonBean.getLastName()#</a>' on activity '<a href=""#Myself#Activity.Detail?ActivityID=#Attributes.ActivityID#"">#ActivityBean.getTitle()#</a>'.")>
                    </cfif>
                    <cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
                    <cfset ActionBean = Application.Com.ActionDAO.Create(ActionBean)>
                </cfif>
				
				<!--- ACTION --->
				<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
				<cfset ActionBean.setPersonID(Attributes.ModeID)>
				<cfset ActionBean.setCode("FIU")>
				<cfset ActionBean.setShortName("Uploaded a file.")>
				<cfset ActionBean.setLongName("Uploaded file '#File.ServerFile#' to person '<a href=""#myself#Person.Detail?PersonID=#PersonBean.getPersonID()#"">#PersonBean.getFirstName()# #PersonBean.getLastName()#</a>'.")>
				<cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset Application.Com.ActionDAO.Create(ActionBean)>
				
				<cfoutput>success|#FileBean.getFileID()#</cfoutput><cfabort>
			</cfcase>
			<cfcase value="Activity">
				<!--- FILE DETAILS --->
				<cfset FileBean.setFileName(NewFileName)>
				<cfset FileBean.setFileCaption(Attributes.FileCaption)>
				<cfset FileBean.setFileSize(File.FileSize)>
				<cfset FileBean.setFileTypeID(Attributes.FileType)>
				<cfset FileBean.setActivityID(Attributes.ModeID)>
				<cfset FileBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset FileBean.setFileID(Application.Com.FileDAO.Create(FileBean))>
				
				<!--- ACTIVITY INFO --->
				<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Attributes.ModeID)>
				<cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
				
				<!--- ACTION --->
				<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
				<cfset ActionBean.setActivityID(Attributes.ModeID)>
				<cfset ActionBean.setCode("FIU")>
				<cfset ActionBean.setShortName("Uploaded a file.")>
				<cfset ActionBean.setLongName("Uploaded file '#File.ServerFile#' to activity '<a href=""#myself#Activity.Detail?ActivityID=#ActivityBean.getActivityID()#"">#ActivityBean.getTitle()#</a>'.")>
				<cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset Application.Com.ActionDAO.Create(ActionBean)>
				
				<cfoutput>success|#FileBean.getFileID()#</cfoutput><cfabort>
			</cfcase>
			
			<cfcase value="PublishActivity">
				<!--- FILE DETAILS --->
				<cfset FileBean.setFileName(NewFileName)>
				<cfset FileBean.setFileCaption(Attributes.FileCaption)>
				<cfset FileBean.setFileSize(File.FileSize)>
				<cfset FileBean.setFileTypeID(Attributes.FileType)>
				<cfset FileBean.setActivityID(Attributes.ModeID)>
				<cfset FileBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset FileBean.setFileID(Application.Com.FileDAO.Create(FileBean))>
				
				<!--- ACTIVITY INFO --->
				<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Attributes.ModeID)>
				<cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
				
				<!--- ACTION --->
				<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
				<cfset ActionBean.setActivityID(Attributes.ModeID)>
				<cfset ActionBean.setCode("FIU")>
				<cfset ActionBean.setShortName("Uploaded a file.")>
				<cfset ActionBean.setLongName("Uploaded file '#File.ServerFile#' to activity '<a href=""#myself#Activity.Detail?ActivityID=#ActivityBean.getActivityID()#"">#ActivityBean.getTitle()#</a>'.")>
				<cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset Application.Com.ActionDAO.Create(ActionBean)>
				
				<cfoutput>success|#FileBean.getFileID()#</cfoutput><cfabort>
			</cfcase>
		</cfswitch>
		
	<!--- EDIT --->
	<cfelse>
		
		<cfset FileBean = CreateObject("component","#Application.Settings.Com#File.File").init(FileID=Attributes.ID)>
		<cfset FileBean = Application.Com.FileDAO.read(FileBean)> <!--- Read Previous Data --->
		
		<cfswitch expression="#Attributes.Mode#">
			<cfcase value="Person">
				<!--- FILE DETAILS --->
				<cfset FileBean.setFileCaption(Attributes.FileCaption)>
				<cfset FileBean.setFileTypeID(Attributes.FileType)>
				<cfset FileBean.setUpdatedBy(Session.Person.getPersonID())>
				<cfset Application.Com.FileDAO.Update(FileBean)>
				
				<!--- PERSON INFO --->
				<cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person").init(PersonID=Attributes.ModeID)>
				<cfset PersonBean = Application.Com.PersonDAO.read(PersonBean)>
				
				<!--- ACTION --->
				<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
				<cfset ActionBean.setPersonID(Attributes.ModeID)>
				<cfset ActionBean.setShortName("Modified some file info.")>
				<cfset ActionBean.setLongName("Modified file details of '#FileBean.getFileName()#' for person '<a href=""#myself#Person.Detail?PersonID=#PersonBean.getPersonID()#"">#PersonBean.getFirstName()# #PersonBean.getLastName()#</a>'.")>
				<cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset Application.Com.ActionDAO.Create(ActionBean)>
				
				<cfoutput>success|#FileBean.getFileID()#</cfoutput><cfabort>
			</cfcase>
			<cfcase value="Activity">
				<!--- FILE DETAILS --->
				<cfset FileBean.setFileCaption(Attributes.FileCaption)>
				<cfset FileBean.setFileTypeID(Attributes.FileType)>
				<cfset FileBean.setUpdatedBy(Session.Person.getPersonID())>
				<cfset Application.Com.FileDAO.Update(FileBean)>
				
				<!--- ACTIVITY INFO --->
				<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").init(ActivityID=Attributes.ModeID)>
				<cfset ActivityBean = Application.Com.ActivityDAO.read(ActivityBean)>
				
				<!--- ACTION --->
				<cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
				<cfset ActionBean.setActivityID(Attributes.ModeID)>
				<cfset ActionBean.setShortName("Modified some file info.")>
				<cfset ActionBean.setLongName("Modified file details '#FileBean.getFileName()#' for activity '<a href=""#myself#Activity.Detail?ActivityID=#ActivityBean.getActivityID()#"">#ActivityBean.getTitle()#</a>'.")>
				<cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
				<cfset Application.Com.ActionDAO.Create(ActionBean)>
				
				<cfoutput>success|#FileBean.getFileID()#</cfoutput><cfabort>
			</cfcase>
		</cfswitch>
		
	</cfif>
	
	<!---
	<cfset RedirectLoc = "#Attributes.Mode#.Docs&#Attributes.Mode#ID=#Attributes.ModeID#" />
	
	<cflocation url="#myself##RedirectLoc#" addtoken="no">--->
</cfif>