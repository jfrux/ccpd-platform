<cfoutput>
<table width="100%" cellspacing="0" border="0" cellpadding="0" class="DataGrid">
	<thead>
		<tr>
			<th nowrap="nowrap"><a href="javascript:void(0);">Section/Event Dates</a></th>
			<th nowrap="nowrap"><a href="javascript:void(0);">Created</a></th>
			<th nowrap="nowrap"><a href="javascript:void(0);">Last Updated</a></th>
			<th nowrap="nowrap"><a href="javascript:void(0);">Actions</a></th>
		</tr>
	</thead>
	<tbody>
		<cfif qActivitiesectList.RecordCount NEQ 0>
			<cfloop query="qActivitiesectList">
			<tr>
				<td nowrap="nowrap">#DateFormat(qActivitiesectList.StartDate,"mm/dd/yyyy")# - #DateFormat(qActivitiesectList.EndDate,"mm/dd/yyyy")#</td>
				<td nowrap="nowrap">#DateFormat(qActivitiesectList.Created,"mm/dd/yyyy")# #TimeFormat(qActivitiesectList.Created,"hh:mmTT")# (by #qActivitiesectList.CreatedUser#)</td>
				<td nowrap="nowrap"><cfif UpdatedBy NEQ "">#DateFormat(qActivitiesectList.Updated,"mm/dd/yyyy")# #TimeFormat(qActivitiesectList.Updated,"hh:mmTT")# (by #qActivitiesectList.UpdatedUser#)</cfif></td>
				<td nowrap="nowrap"><div class="DataGridButton"><a href="#myself#Activity.EditSection&ActivityID=#Attributes.ActivityID#&ActivitiesectionID=#qActivitiesectList.ActivitiesectionID#"><img src="#Application.Settings.RootPath#/_images/application_form_magnify.gif" border="0" align="absmiddle" /> Open</a></div></td>
			</tr>
			</cfloop>
		<cfelse>
			<tr>
				<td colspan="4">There are no sections created for this Activity.</td>
			</tr>
		</cfif>
	</tbody>
</table>
</cfoutput>