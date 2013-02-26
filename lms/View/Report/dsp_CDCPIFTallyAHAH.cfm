<cfparam name="Attributes.ReportID" default="28">

<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />
<cfoutput>
        <cfdirectory directory="#ExpandPath('#Application.Settings.RootPath#/_reports/#Attributes.ReportID#')#" action="list" name="qFileList" filter="*.xls" recurse="no">
<cfquery name="qMostRecent" dbtype="query">
    SELECT  *
    FROM qFileList
    ORDER BY DateLastModified DESC
</cfquery>
<h3>Last Generated</h3>
<div class="notify"><a href="#Application.Settings.RootPath#/_reports/28/#qMostRecent.Name#" target="_blank">#qMostRecent.Name# Download Now!</a></div>
<h3>Archived Reports</h3>
<table id="GeneratedReports" class="ViewSectionGrid" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>File</th>
            <th>Size</th>
            <th>Date</th>
        </tr>
    </thead>
    <cfquery name="qOrderedFileList" dbtype="query">
        SELECT *
        FROM qFileList
        ORDER BY DateLastModified DESC
    </cfquery>
    
    <cfloop query="qOrderedFileList">
        <tr>
            <td><a href="#Application.Settings.RootPath#/_reports/#Attributes.ReportID#/#qOrderedFileList.Name#" target="_blank">#qOrderedFileList.Name#</a></td>
            <td>#ByteConvert(qOrderedFileList.Size,0,true)#</td>
            <td>#DateFormat(qOrderedFileList.DateLastModified,"MM/DD/YYYY")# #TimeFormat(qOrderedFileList.DateLastModified,"hh:mm:ssTT")#</td>
        </tr>
    </cfloop>
</table>
</cfoutput>