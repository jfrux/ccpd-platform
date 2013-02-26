<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />
<cfdirectory directory="#ExpandPath('#Application.Settings.RootPath#/_reports/21')#" action="list" name="qFileList" filter="*-#Session.AccountID#.xlsx" recurse="no">
<cfoutput>
<h3>Last Generated</h3>
<cfquery name="qMostRecent" dbtype="query">
		SELECT  *
		FROM qFileList
		ORDER BY DateLastModified DESC
		
	</cfquery>
<div class="notify"><a href="#Application.Settings.RootPath#/_reports/21/#qMostRecent.Name#" target="_blank">#qMostRecent.Name# Download Now!</a></div>
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
			<td><a href="#Application.Settings.RootPath#/_reports/21/#qOrderedFileList.Name#" target="_blank">#qOrderedFileList.Name#</a></td>
			<td>#ByteConvert(qOrderedFileList.Size,0,true)#</td>
			<td>#DateFormat(qOrderedFileList.DateLastModified,"MM/DD/YYYY")# #TimeFormat(qOrderedFileList.DateLastModified,"hh:mm:ssTT")#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>