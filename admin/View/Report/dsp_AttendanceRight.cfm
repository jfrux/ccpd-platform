<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.CategoryID" default="">

<cfoutput>
<script>
$(document).ready(function() {
	<cfif Attributes.CategoryID NEQ "">
		nCurrCategoryID = #Attributes.CategoryID#;
	<cfelse>
		nCurrCategoryID = 0;
	</cfif>
	
	$("##CategoryID").bind("change", this, function() {
		if($("##CategoryID").val() != "") {
			window.location = "#Myself##Attributes.Fuseaction#?CategoryID=" + $("##CategoryID").val();
		} else if($("##CategoryID").val() != nCurrCategoryID) {
			window.location = "#Myself##Attributes.Fuseaction#";
		}
	});
});
</script>

<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectSubTitle">Report Generator</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
	<table>
		<input type="hidden" name="Submitted" value="1">
		<input type="hidden" name="ReportID" value="13">
        <tr>
        	<td colspan="2">To minimize your search, select a category.</td>
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
            		<option value="0">Select one...</option>
                    <cfloop query="qActivities">
                    <option value="#qActivities.ActivityID#"<cfif Attributes.ActivityID EQ qActivities.ActivityID> SELECTED</cfif>>#DateFormat(qActivities.StartDate, "MM/DD/YYYY")# - #qActivities.Title#</option>
                    </cfloop>
                </select>
            </td>
		</tr>
	</table>
	<div class="clear">
		#jButton("Generate Report","javascript:void(0)","accept","generateReport($('##ActivityID').val());")#
	</div>
</div>
</cfoutput>