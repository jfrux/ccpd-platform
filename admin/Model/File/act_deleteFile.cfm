<cfif IsDefined("Attributes.ActivityFileID")>
	<cftry>
		<cfswitch expression="#Attributes.Mode#">
			<cfcase value="Activity">
				<!--- Get File and ActivityFile information --->
				<cfset DeleteFileBean = CreateObject("component","#Application.Settings.Com#File.File").Init(FileID=Attributes.ActivityFileID)>
				<cfset DeleteFileBean = Application.Com.FileDAO.Read(DeleteFileBean)>
				
				<cfset DeleteActivityFileBean = CreateObject("component","#Application.Settings.Com#ActivityFile.ActivityFile").Init(ActivityFileID=Attributes.ActivityFileID,FileID=Attributes.ActivityFileID)>
								
				<!--- Defines File Vars --->
				<cfset FileID = DeleteActivityFileBean.getFileID()>
				<cfset FileName = DeleteFileBean.getFileName()>
				<cfset ActivityID = Attributes.ActivityID>
				<cfset FileGroupID = DeleteActivityFileBean.getFileGroupID()>
				<cfset FilePath = "#ExpandPath(".\_uploads\ActivityFiles\#ActivityID#\#FileGroupID#")#">
	
				<!--- Delete Physical File from server --->
				<cfif FileExists(#FilePath# & "\" & #FileName#)>
					<cffile action="Delete" file="#FilePath#\#FileName#">
				</cfif>
				
				<!--- Remove ActivityFile Record --->
				<cfset DeleteActivityFileBean = Application.Com.ActivityFileDAO.Delete(DeleteActivityFileBean)>
				 
				 
				<!--- Remove File Record --->
				<cfset DeleteFileBean = Application.Com.FileDAO.Delete(DeleteFileBean)>
				
				<cflocation url="#Myself#Activity.Docs&ActivityID=#ActivityID#" addtoken="no">
			</cfcase>
		</cfswitch>
		<cfcatch type="any">
			Invalid File, <a href="javascript:history.back(-1);">Click Here</a>
			<cfabort>
		</cfcatch>
	</cftry>
</cfif>