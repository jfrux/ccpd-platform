<cfinclude template="#Application.Settings.RootPath#/_com/_UDF/ByteConvert.cfm" />
<cfoutput>
<table id="GeneratedReports" class="ViewSectionGrid" cellspacing="0" width="100%">
    <thead>
        <tr>
            <th>File</th>
            <th>Size</th>
            <th>Date</th>
        </tr>
    </thead>
	<cfdirectory directory="#ExpandPath('#Application.Settings.RootPath#/_reports/13')#" action="list" name="qFileList" filter="*.XLS" recurse="no">
	
	<cfquery name="qOrderedFileList" dbtype="query">
		SELECT *
		FROM qFileList
		ORDER BY DateLastModified DESC
	</cfquery>
	
	<cfloop query="qOrderedFileList">
		<tr>
			<td><a href="#Application.Settings.RootPath#/_reports/13/#qOrderedFileList.Name#" target="_blank">#qOrderedFileList.Name#</a></td>
			<td>#ByteConvert(qOrderedFileList.Size,0,true)#</td>
			<td>#DateFormat(qOrderedFileList.DateLastModified,"MM/DD/YYYY")# #TimeFormat(qOrderedFileList.DateLastModified,"hh:mm:ssTT")#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>