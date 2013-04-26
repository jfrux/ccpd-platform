<cfoutput>
<div class="ViewSection">
	<h3>Email Logs</h3>
	<style>
		table.email_logs > thead > tr > th {
			font-weight:bold;
			padding:4px;
			text-align:center;
		}
		table.email_logs > tbody > tr > td {
			font-weight:normal;
			padding:4px;
			text-align:center;
			border-bottom:1px solid ##CCC;
		}
	</style>
	<table class="email_logs">
		<thead>
			<tr>
				<th style="width:35%;">Attendee</th>
				<th>Email</th>
				<th>Status</th>
				<th>Opens</th>
				<th>Clicks</th>
				<th>Created</th>
				<th>Updated</th>
			</tr>
		</thead>
		<tbody>
	<cfloop query="email_logs">
		<tr>
			<td style="width:35%;">
				<b>#email_logs.lastname#, #email_logs.firstname#</b>
				<div>AttendeeID: #email_logs.attendee_id#</div>
				<div>PersonID: #email_logs.user_id#</div>
			</td>
			<td>
				#email_logs.email#
			</td>
			<td>
				#email_logs.status#
			</td>
			<td>
				#email_logs.opens#
			</td>
			<td>
				#email_logs.clicks#
			</td>
			<td>
				#dateFormat(email_logs.created_at,'mm/dd/yyyy')# #timeFormat(email_logs.created_at,'hh:mm TT')#
			</td>
			<td>
				#dateFormat(email_logs.updated_at,'mm/dd/yyyy')# #timeFormat(email_logs.updated_at,'hh:mm TT')#
			</td>
		</tr>
	</cfloop>
		</tbody>
	</table>
</div>
</cfoutput>