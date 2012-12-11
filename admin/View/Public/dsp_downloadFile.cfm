<cfparam name="Attributes.FID" type="integer" />
<cfparam name="Attributes.ModeID" type="integer" />
<cfparam name="Attributes.Mode" type="string" />

<!--- CREATE FILEBEAN --->
<cfset FileBean = CreateObject("component","#Application.Settings.Com#File.File").Init(FileID=URL.FID)>
<cfset FileExists = Application.Com.FileDAO.Exists(FileBean)>

<cfif FileExists>
	<!--- READ FILEBEAN --->
	<cfset FileBean = Application.Com.FileDAO.Read(FileBean)>
    
	<cfset basePath = ExpandPath('#Application.Settings.RootPath#/_uploads/#Attributes.Mode#Files/#Attributes.ModeID#/')>
    <cfset physFilePath = basePath & fileBean.getFileName() />
    <cfset fileName = application.udf.friendlyUrl(application.udf.parseUrl(fileBean.getFileName()).file) & "_" & application.udf.getRandomString(10) & "." & application.udf.getExtension(application.udf.parseUrl(fileBean.getFileName()).file)>
    <!---<cfdump var="#basePath#"><br>
    <cfdump var="#physFilePath#"><br>
    <cfdump var="#fileName#">
    <cfabort>--->
    <cfif fileExists(physFilePath)>
        <cfheader name="Content-Type" value="#getPageContext().getServletContext().getMimeType(physFilePath)#">
        <cfheader name="Content-Disposition" value="attachment; filename=#fileName#">
        <cfcontent file="#physFilePath#">
    </cfif>
</cfif>