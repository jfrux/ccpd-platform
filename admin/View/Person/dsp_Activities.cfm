<cfoutput>
<script>
$(document).ready(function() {
	$("##GetTranscript").bind("click", function() {
		if($("##date1").val() != "" && $("##date2").val() != "") {
			window.open("#application.settings.apiUrl#/users/#Attributes.PersonID#/transcript?startdate=" + $("##date1").val() + "&enddate=" + $("##date2").val());
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
<input type="hidden" name="PersonID" value="<cfoutput>#Attributes.personID#</cfoutput>" />
<table class="table table-condensed table-bordered">
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