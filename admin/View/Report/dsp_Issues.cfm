<div class="ViewSection">
	<h3>Results</h3>
	<cfif isDefined("qIssues") AND qIssues.RecordCount GT 0 >
	<cfif IssuesPager.getTotalNumberOfPages() GT 1><div><cfoutput>#IssuesPager.getRenderedHTML()#</cfoutput></div></cfif>
		<table width="100%" cellspacing="2" cellpadding="2" border="0" class="ViewSectionGrid">
			<thead>
				<th>Activity</th>
				<th>Release Date</th>
				<th>Reason</th>
			</thead>
			<tbody>
		<cfoutput query="qIssues" startrow="#IssuesPager.getStartRow()#" maxrows="#IssuesPager.getMaxRows()#">
				<tr>
					<td>
						<cfif Len(Title) GT 50>
							<cfset TitleShort = Left(Title,47) & "...">
						<cfelse>
							<cfset TitleShort = Title>
						</cfif>
					<a href="#myself#Activity.Detail?ActivityID=#ActivityID#">#TitleShort#</a></td>
					<td>#DateFormat(ReleaseDate,'mm/dd/yyyy')#</td>
					<td>#Reason#</td>
				</tr>
		</cfoutput>
			</tbody>
		</table>
	</cfif>
</div>