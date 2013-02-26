<cfparam name="Attributes.ID" default="0" />
<cfparam name="Attributes.FileID" default="#Attributes.ID#" />
<cfset FileBean = CreateObject("component","#Application.Settings.Com#File.File").Init()>
<cfif isNumeric(Attributes.FileID)>
	<cfset FileBean.setFileID(Attributes.FileID)>
	<cfif Application.Com.FileDAO.Exists(FileBean)>
		<cfset FileBean = Application.Com.FileDAO.Read(FileBean)>
		
        <!--- GET FILE INFO --->
		<cfset ActivityFileBean = CreateObject("component","#Application.Settings.Com#File.File").Init(ActivityFileID=Attributes.ID,FileID=Attributes.FileID,DeletedFlag='N')>
		<cfset ActivityFileBean = Application.Com.FileDAO.Read(ActivityFileBean)>
		
        <!--- GET COMPONENT INFO --->
        <cfquery name="qGetAddlInfo" datasource="#Application.Settings.DSN#">
        	SELECT DisplayName,Description
            FROM ce_Activity_PubComponent
            WHERE ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND FileID = <cfqueryparam value="#Attributes.FileID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
        </cfquery>
        
		<cfset Attributes.FileCaption = FileBean.getFileCaption()>
		<cfset Attributes.FileType = ActivityFileBean.getFileTypeID()>
		<cfset Attributes.FileName = ActivityFileBean.getFileName()>
        <cfset Attributes.FileSize = ActivityFileBean.getFileSize()>
   		<cfset Attributes.FileExt = getToken(Attributes.FileName,2,".")>
        <cfset Attributes.DisplayName = qGetAddlInfo.DisplayName>
        <cfset Attributes.Description = qGetAddlInfo.Description>
	</cfif>
</cfif>