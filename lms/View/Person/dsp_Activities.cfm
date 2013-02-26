<cfoutput>
<script>
$(document).ready(function() {
	$("##GetTranscript").bind("click", function() {
		if($("##date1").val() != "" && $("##date2").val() != "") {
			window.open("#myself#Report.Transcript?PersonID=#Attributes.PersonID#&StartDate=" + $("##date1").val() + "&EndDate=" + $("##date2").val() + "&ReportID=8");
		} else if($("##date1").val() == "" && $("##date2").val() != "") {
			addError("Please select a start date.",250,6000,4000);
		} else if($("##date1").val() != "" && $("##date2").val() == "") {
			addError("Please select an end date.",250,6000,4000);
		} else if($("##date1").val() == "" && $("##date2").val() == "") {
			addError("Please select a start and end date.",250,6000,4000);
		};
	});
});
</script>
<div class="ViewSection">
	<h3>Activities</h3>
<input type="hidden" name="PersonID" value="<cfoutput>#Attributes.personID#</cfoutput>" />
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="ViewSectionGrid">
	<thead>
		<tr>
			<th>Title</th>
			<th width="100">Activity Date</th>
			<th width="100">Registered</th>
		</tr>
	</thead>
	<tbody>
		<cfif qActivities.RecordCount NEQ 0>
			<cfloop query="qActivities">
				<tr>
					<td><a href="#myself#Activity.Detail?ActivityID=#ActivityID#">#Title#</a></td>
					<td>#DateFormat(qActivities.StartDate,"mm/dd/yyyy")#</td>
					<td><cfif qActivities.RegisterDate NEQ "">#DateFormat(qActivities.RegisterDate,"mm/dd/yyyy")#<cfelse>#DateFormat(qActivities.Checkin,"mm/dd/yyyy")#</cfif></td>
				</tr>
			</cfloop>
		<cfelse>
			<tr>
				<td colspan="9">There are no registered Activities for #Attributes.FirstName# #Attributes.LastName#</td>
			</tr>
		</cfif>
	</tbody>
</table>
</div>
</cfoutput>