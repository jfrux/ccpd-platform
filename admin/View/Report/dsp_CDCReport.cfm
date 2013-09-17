<cfparam name="Attributes.Submitted" default="0">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.StuReportID" default="9">
<cfparam name="Attributes.ActReportID" default="10">
<cfinclude template="#Application.Settings.ComPath#/_UDF/ByteConvert.cfm" />

<cfoutput>
<div class="ViewContainer">
	<div class="ViewSection">
		<h3>Generated CDC Student Reports</h3>
		<table id="GeneratedStudentReports" class="ViewSectionGrid" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th>File</th>
					<th>Size</th>
					<th>Date</th>
				</tr>
			</thead>
			<cfif Attributes.StuReportID NEQ "">
				<cfdirectory directory="#ExpandPath('#Application.Settings.RootPath#/_reports/#Attributes.StuReportID#')#" action="list" name="qFileList" filter="*.CSV" recurse="no">
				
				<cfquery name="qOrderedFileList" dbtype="query">
					SELECT *
					FROM qFileList
					ORDER BY DateLastModified DESC
				</cfquery>
				
				<cfloop query="qOrderedFileList">
					<tr>
						<td><a href="#Application.Settings.RootPath#/_reports/#Attributes.StuReportID#/#qOrderedFileList.Name#" target="_blank">#qOrderedFileList.Name#</a></td>
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
		<h3>Generated CDC Activity Reports</h3>
		<table id="GeneratedActivityReports" class="ViewSectionGrid" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th>File</th>
					<th>Size</th>
					<th>Date</th>
				</tr>
			</thead>
			<cfif Attributes.ActReportID NEQ "">
				<cfdirectory directory="#ExpandPath('#Application.Settings.RootPath#/_reports/#Attributes.ActReportID#')#" action="list" name="qFileList" filter="*.xlsx" recurse="no">
				
				<cfquery name="qOrderedFileList" dbtype="query">
					SELECT *
					FROM qFileList
					ORDER BY DateLastModified DESC
				</cfquery>
				
				<cfloop query="qOrderedFileList">
					<tr>
						<td><a href="#Application.Settings.RootPath#/_reports/#Attributes.ActReportID#/#qOrderedFileList.Name#" target="_blank">#qOrderedFileList.Name#</a></td>
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
