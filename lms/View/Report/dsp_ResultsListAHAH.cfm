<cfoutput>
<script>
$(document).ready(function() {
	$("##ResultID").bind("change", this, function() {
		if($("##ResultID").val() != "") {
			updateReport($("##ActivityID").val(), $("##ResultID").val());
		} 
	});
});
</script>
    <table>
        <tr>
            <td>Assess.:&nbsp;&nbsp;</td>
            <td>
                <select name="ResultID" id="ResultID" style="width:115px;">
                    <option value="0">Select one...</option>
                    <cfloop query="qGetResults">
                        <option value="#qGetResults.ResultID#">#qGetResults.AssessmentName#</option>
                    </cfloop>
                </select>
            </td>
        </tr>
    </table>
</cfoutput>