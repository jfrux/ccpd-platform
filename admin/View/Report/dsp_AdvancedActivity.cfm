<cfparam name="Attributes.Submitted" default="0">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.ReportID" default="22">
<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />

<cfoutput>
<div class="ViewContainer">
	<div class="ViewSection">
		<h3>Generated Reports</h3>
		<table id="GeneratedReports" class="ViewSectionGrid" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th>File</th>
					<th>Size</th>
					<th>Date</th>
				</tr>
			</thead>
			<cfif Attributes.ReportID NEQ "">
				<cfdirectory directory="#ExpandPath('#Application.Settings.RootPath#/_reports/#Attributes.ReportID#')#" action="list" name="qFileList" filter="*_#session.personId#.XLSX" recurse="no">
				
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
			<cfelse>
				<tr>
					<td colspan="3">Please <a href="#Myself#Report.Home">click here</a> to select a report type.</td>
				</tr>
			</cfif>
		</table>
	</div>
</div>
</cfoutput>
