<cfparam name="Attributes.FileID" default="" />
<cfparam name="Attributes.FileCaption" default="" />
<cfparam name="Attributes.FileName" default="" />
<cfparam name="Attributes.FileExt" default="" />
<cfparam name="Attributes.FileSize" default="" />
<cfparam name="Attributes.FileTypeID" default="" />

<cfset FileBean = CreateObject("component","#Application.Settings.Com#File.File").Init(FileID=Attributes.FileID)>

<cfif Application.Com.FileDAO.Exists(FileBean)>
	<cfset FileBean = Application.Com.FileDAO.Read(FileBean)>
    
    <cfset Attributes.FileCaption = FileBean.getFileCaption()>
    <cfset Attributes.FileName = FileBean.getFileName()>
    <cfset Attributes.FileSize = FileBean.getFileSize()>
    <cfset Attributes.FileTypeID = FileBean.getFileTypeID()>
    <cfset Attributes.FileExt = getToken(Attributes.FileName,2,".")>
</cfif>