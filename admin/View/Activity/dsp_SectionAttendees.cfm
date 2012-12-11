<cfoutput>
<div class="clear">#jButton("New Attendee","#Myself#Activity.CreateAttendee&ActivityID=#Attributes.ActivityID#&ActivitiesectionID=#Attributes.ActivitiesectionID#","add.gif")#</div>
<table width="100%" cellspacing="0" border="0" cellpadding="0" class="DataGrid">
	<thead>
		<tr>
			<th nowrap="nowrap"><a href="javascript:void(0);">Last Name, First Name</a></th>
			<!---
			<th nowrap="nowrap"><a href="javascript:void(0);">Registration Fee</a></th>
			<th nowrap="nowrap"><a href="javascript:void(0);">Total Payments</a></th>
			--->
			<th nowrap="nowrap"><a href="javascript:void(0);">Attended?</a></th>
		</tr>
	</thead>
	<tbody>
		<cfif qSectionAttendees.RecordCount GT 0>
			<cfloop query="qSectionAttendees">
			<tr>
				<td nowrap="nowrap">#qSectionAttendees.FirstName#, #qSectionAttendees.LastName#</td>
				<!---
				<td nowrap="nowrap">## ## ##</td>
				<td nowrap="nowrap">## ## ##</td>
				--->
				<td nowrap="nowrap"><input type="checkbox" name="AttendedFlag" id="AttendedFlag" disabled="disabled"<cfif qSectionAttendees.AttendedFlag EQ "Y"> Checked</cfif>></td>
			</tr>
			</cfloop>
		<cfelse>
			<tr>
				<td colspan="2">There are no attendees for this section!</td>
			</tr>
		</cfif>
	</tbody>
</table>
</cfoutput>