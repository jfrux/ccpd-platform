<cfparam name="Attributes.FileID" default="0">
<cfparam name="Attributes.FileField" default="">
<cfparam name="Attributes.FileCaption" default="">
<cfparam name="Attributes.FileType" default="">
<cfparam name="Attributes.Submitted" default="0">

<cfif Attributes.Submitted EQ 1>
	<!--- ERROR CHECKING --->
	<cfif Len(Form["FileField"]) LTE 0>
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must select a File.","|")>
    </cfif>
    
	<cfif Attributes.FileType EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must select a File Type.","|")>
    </cfif>
            
    <!--- CHECK IF ANY ERRORS WERE FOUND --->
    <cfif Request.Status.Errors EQ "">
        <cftry>
        	<!--- GET FILETYPES --->
            <cfquery name="qGetFileType" datasource="#Application.Settings.DSN#">
            	SELECT FileTypeID, Name
                FROM ce_Sys_FileType
                WHERE FileTypeID = <cfqueryparam value="#Attributes.FileType#" cfsqltype="cf_sql_integer" />
            </cfquery>
            
            <!--- SET FILE PATH --->
            <cfset FilePath = ExpandPath(".\_uploads\PersonFiles\#Attributes.PersonID#") />
            
            <!--- CHECK IF DIRECTORY EXISTS --->
            <cfif NOT DirectoryExists(FilePath)>
                <cfdirectory action="Create" directory="#FilePath#" />
            </cfif>
            
            <!--- UPLOAD FILE --->
            <cffile
                action="upload"
                destination="#FilePath#\"
                filefield="FileField"
                nameconflict="makeunique" 
                accept = "application/PDF,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,image/tif,image/tiff,image/tiff-fx,text/*" />
            
            <!--- CREATE FILEBEAN OBJECT --->
            <cfset FileBean = CreateObject("component","#Application.Settings.Com#File.File").Init(FileID=Attributes.FileID)>
            
            <!--- FILEBEAN DETAILS --->
            <cfset FileBean.setFileName(File.ServerFile)>
            <cfset FileBean.setFileCaption(Attributes.FileCaption)>
            <cfset FileBean.setFileTypeID(Attributes.FileType)>
            <cfset FileBean.setPersonID(Attributes.PersonID)>
            <cfset FileBean.setCreatedBy(Session.Person.getPersonID())>
            <cfset NewFileID = Application.Com.FileDAO.Create(FileBean)>
            
            <!--- UPDATE ACTIVITYFACULTY TABLE --->
            <!--- CV FILETYPE --->
            <cfif qGetFileType.Name EQ "CV">
            	<cfquery name="qUpdateActivityFaculty" datasource="#Application.Settings.DSN#">
                	UPDATE ce_Activity_Faculty
                    SET CVFileID = <cfqueryparam value="#NewFileID#" cfsqltype="cf_sql_integer" />,
                    	CVApproveFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char" />
                    WHERE ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND PersonID = <cfqueryparam value="#Attributes.PersonID#" cfsqltype="cf_sql_integer" />
                </cfquery>
            <!--- DISCLOSURE FILETYPE --->
            <cfelseif qGetFileType.Name EQ "Disclosure">
            	<cfquery name="qUpdateActivityFaculty" datasource="#Application.Settings.DSN#">
                	UPDATE ce_Activity_Faculty
                    SET DisclosureFileID = <cfqueryparam value="#NewFileID#" cfsqltype="cf_sql_integer" />,
                    	DisclosureApproveFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char" />
                    WHERE ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND PersonID = <cfqueryparam value="#Attributes.PersonID#" cfsqltype="cf_sql_integer" />
                </cfquery>
            </cfif>
				
			<!--- PERSON INFO --->
            <cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person").init(PersonID=Attributes.PersonID)>
            <cfset PersonBean = Application.Com.PersonDAO.read(PersonBean)>
            
			<!--- PERSON ACTION --->
            <cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
            <cfset ActionBean.setPersonID(Attributes.PersonID)>
            <cfset ActionBean.setCode("FIU")>
            <cfset ActionBean.setShortName("Uploaded a file.")>
            <cfset ActionBean.setLongName("Uploaded file '#File.ServerFile#' to person '<a href=""#myself#Person.Detail?PersonID=#PersonBean.getPersonID()#"">#PersonBean.getFirstName()# #PersonBean.getLastName()#</a>'.")>\
            <cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
            <cfset Application.Com.ActionDAO.Create(ActionBean)>
            
			<!--- ACTIVITY ACTION --->
            <cfset ActionBean = CreateObject("component","#Application.Settings.Com#Action.Action").init()>
            <cfset ActionBean.setActivityID(Attributes.ActivityID)>
            <cfset ActionBean.setCode("FIU")>
            <cfif qGetFileType.Name EQ "CV">
            	<cfset ActionBean.setShortName("Updated Faculty CV file.")>
            	<cfset ActionBean.setLongName("Updated CV file for person '<a href=""#myself#Person.Detail?PersonID=#PersonBean.getPersonID()#"">#PersonBean.getFirstName()# #PersonBean.getLastName()#</a>'.")>\
            <cfelseif qGetFileType.Name EQ "Disclosure">
            	<cfset ActionBean.setShortName("Updated Faculty Disclosure file.")>
            	<cfset ActionBean.setLongName("Updated disclosure file for person '<a href=""#myself#Person.Detail?PersonID=#PersonBean.getPersonID()#"">#PersonBean.getFirstName()# #PersonBean.getLastName()#</a>'.")>\
            </cfif>
            <cfset ActionBean.setCreatedBy(Session.Person.getPersonID())>
            <cfset Application.Com.ActionDAO.Create(ActionBean)>
            
            <!--- RELOCATE --->
            <cflocation url="#Myself#Activity.FileUpload?PersonID=#Attributes.PersonID#&ActivityID=#Attributes.ActivityID#&action=uploaded" addtoken="no" />
            
            <cfcatch type="any">
                <cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Error: " & cfcatch.Message,"|")>
            </cfcatch>
        </cftry>
    </cfif>
</cfif>