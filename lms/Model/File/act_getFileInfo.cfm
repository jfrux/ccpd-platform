<cfparam name="Attributes.ID" default="0" />
<cfparam name="Attributes.FileID" default="#Attributes.ID#" />
<cfset FileBean = CreateObject("component","#Application.Settings.Com#File.File").Init()>
<cfif isNumeric(Attributes.FileID)>
	<cfset FileBean.setFileID(Attributes.FileID)>
	<cfif Application.Com.FileDAO.Exists(FileBean)>
		<cfset FileBean = Application.Com.FileDAO.Read(FileBean)>
		
		<cfset ActivityFileBean = CreateObject("component","#Application.Settings.Com#File.File").Init(ActivityFileID=Attributes.ID,FileID=Attributes.FileID)>
		<cfset ActivityFileBean = Application.Com.FileDAO.Read(ActivityFileBean)>
		
		<cfset Attributes.FileCaption = FileBean.getFileCaption()>
		<cfset Attributes.FileType = ActivityFileBean.getFileTypeID()>
		<cfset Attributes.FileName = ActivityFileBean.getFileName()>
	</cfif>
</cfif>