<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.CategoryID" default="">

<script>
$(document).ready(function() {
	<cfoutput>
	<cfif Attributes.CategoryID NEQ "">
		nCurrCategoryID = #Attributes.CategoryID#;
	<cfelse>
		nCurrCategoryID = 0;
	</cfif>
	
	<cfif Attributes.ActivityID NEQ "">
		setActivity(#Attributes.ActivityID#);
	</cfif>
	sFuseaction = "#Attributes.Fuseaction#";
	</cfoutput>
	$("#CategoryID").bind("change", this, function() {
		if($("#CategoryID").val() != "") {
			window.location = sMyself + sFuseaction + "?CategoryID=" + $("#CategoryID").val();
		} else if($("#CategoryID").val() != nCurrCategoryID) {
			window.location = sMyself + sFuseaction;
		}
	});
	
	$("#ActivityID").bind("change", this, function() {
		if($("#ActivityID").val() != "") {
			setActivity($("#ActivityID").val());
		} else {
			$("#AssessmentSelector").html("&nbsp;");
		}
	});
});

function setActivity(nActivityID) {
	$.post(sMyself + "Report.AssessmentListAHAH?ActivityID=" + nActivityID, function(data) {
		$("#AssessmentSelector").html(data);
	});
}
</script>

<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectSubTitle">Report Generator</div>
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
        <tr>
        	<td id="AssessmentSelector" colspan="2"></td>
        </tr>
	</table>
</div>
</cfoutput>