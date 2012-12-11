<cfparam name="Attributes.CategoryID" default="0">
<script>
<cfoutput>
var sFuseaction = "#Attributes.Fuseaction#";
var nCategory = <cfif Attributes.CategoryID NEQ "">#Attributes.CategoryID#<cfelse>0</cfif>;
</cfoutput>
function getAttendeeList(nActivity) {
	if(nActivity != "") {
		$.post(sMyself + "Report.AttendeeListAHAH?ActivityID=" + nActivity, function(data) {
			$("#AttendeeSelector").html(data);
		});
	} else {
		$("#AttendeeSelector").html("&nbsp;");
	}
}

	$(document).ready(function() {
		<cfif Attributes.CategoryID NEQ 0>
			nCurrCategoryID = nCategory;
		<cfelse>
			nCurrCategoryID = 0;
		</cfif>
		getAttendeeList($("#ActivityID").val());
		
		$("#CategoryID").bind("change", this, function() {
			if($("#CategoryID").val() != "") {
				window.location = sMyself + sFuseaction + "?CategoryID=" + $("#CategoryID").val();
			} else if($("#CategoryID").val() != nCurrCategoryID) {
				window.location = sMyself + sFuseaction;
			}
		});
	
		$("#ActivityID").bind("change", this, function() {
			getAttendeeList($("#ActivityID").val());
		});
	});
</script>

<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectSubTitle">Activity Selector</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
	<table>
		<input type="hidden" name="Submitted" value="1">
		<input type="hidden" name="ReportID" value="13">
        <tr>
        	<td colspan="2">Select a category to minimize your search.</td>
        </tr>
		<tr>
			<td>Category</td>
			<td>
            	<select name="CategoryID" id="CategoryID" style="width:115px;">
            		<option value="">Select one...</option>
                    <cfloop query="qCategories">
                    <option value="#qCategories.CategoryID#"<cfif Attributes.CategoryID EQ qCategories.CategoryID> SELECTED</cfif>>#qCategories.Name#</option>
                    </cfloop>
                </select>
            </td>
		</tr>
		<tr>
			<td>Activity</td>
			<td>
            	<select name="ActivityID" id="ActivityID" style="width:115px;">
            		<option value="">Select one...</option>
                    <cfloop query="qActivities">
                    <option value="#qActivities.ActivityID#"<cfif Attributes.ActivityID EQ qActivities.ActivityID> SELECTED</cfif>>#DateFormat(qActivities.StartDate, "MM/DD/YYYY")# - #qActivities.Title#</option>
                    </cfloop>
                </select>
            </td>
		</tr>
    </table>
</div>
<div id="AttendeeSelector"></div>
<div id="AssessmentSelector"></div>
</cfoutput>