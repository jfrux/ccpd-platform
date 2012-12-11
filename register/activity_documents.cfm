<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<cfif isDefined("URL.AID") AND URL.AID NEQ "">
	<cfset docpath = "E:\Webapp_Cluster\Inetpub\wwwroot\CPD_Online2\cdc\documents\" & URL.AID & "\">
	
	<cfquery name="getCourseInfo" datasource="CCPD_Prod">
		SELECT Title, ReleaseDate
		FROM ceschema.ce_Activity
		WHERE (ActivityID = <cfqueryparam value="#URL.AID#" cfsqltype="cf_sql_integer" />)
	</cfquery>
	
	<cfset sCourseTitle = getCourseInfo.Title>
	<cfset dtCourseDate = DateFormat(getCourseInfo.ReleaseDate,"mm/dd/yyyy")>
	<cfset sDocumentName = "">
	<cfset sDocumentDesc = "">
	<cfset sError = "">
    
    <cfquery name="qGetDocs" datasource="CCPD_Prod">
    	SELECT 	f.FileID,
        		f.FileName, 
        		f.FileCaption, 
                ft.Name AS FileType,
                f.FileSize,
                f.Created
		FROM ceschema.ce_File f
        INNER JOIN ceschema.ce_Sys_FileType ft ON ft.FileTypeID = f.FileTypeID
        WHERE f.ActivityID = <cfqueryparam value="#URL.AID#" cfsqltype="cf_sql_integer" /> AND ft.Description = <cfqueryparam value="No People" cfsqltype="cf_sql_varchar" />
    </cfquery>
</cfif>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Welcome Center</title>
<link href="styles/inc_styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
<cfinclude template="/_com/_UDF/DownloadTime56K.cfm" />
<cfinclude template="includes/inc_header.cfm">
<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<td class="content_cell" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="content_title">Course Documents </td>
				</tr>
                <cfif isDefined("URL.AID") AND URL.AID NEQ "">
                    <tr>
                        <td class="content_body">
                        <cfoutput>
                        <div style="height:2px;"></div>
                        <strong>#sCourseTitle# #dtCourseDate# </strong>
                        <div style="height:4px;"></div>
                        <cfloop query="qGetDocs">
                            <div id="info_box_blue">
                                <strong>#qGetDocs.FileType#</strong><br>
                            	#qGetDocs.FileCaption#<br>
                            	<a href="http://ccpd.uc.edu/admin/index.cfm/event/Public.Download?mode=activity&modeid=#URL.AID#&fid=#qGetDocs.FileID#"><strong>Download Now!</strong></a> (#NumberFormat(qGetDocs.FileSize/1024,"0.00")# KB) <a href="http://ccpd.uc.edu/admin/index.cfm/event/Public.Download?mode=activity&modeid=#URL.AID#&fid=#qGetDocs.FileID#" target="frameDownload" style="text-decoration:none;"><img border="0" src="images/file_icon_doc.gif" align="absmiddle"> #qGetDocs.FileName#</a>
                            
                            	<br><strong>Est. Download Time:</strong> #DownLoadTime56k(qGetDocs.FileSize)# [56k Modem]
                            </div>
                            <div style="height:4px;"></div>
						</cfloop>
                        </cfoutput><div id="info_box_red">
                            <strong>Need Assistance? Having trouble finding what you are looking for?</strong>
                            <div style="height:5px;"></div>
                            <input type="button" name="fldContact" value="Contact Technical Support" style="width:220px;" onClick="window.location='cdc_contact.cfm?type=1';" />
                            </div>
                        </td>
                    </tr>
                <cfelse>
                	<tr>
                    	<td><strong>ERROR:</strong> No course information available.</td>
                    </tr>
                </cfif>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
