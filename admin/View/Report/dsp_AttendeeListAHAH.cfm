<cfif isDefined("qReportData")>
	<script>
    $(document).ready(function() {
        $("#PersonID").bind("change", this, function() {
            if($("#PersonID").val() != "") {
                $.post(sMyself + "Report.ResultsListAHAH?ActivityID=" + $("#ActivityID").val() + "&PersonID=" + $("#PersonID").val(), function(data) {
                    $("#AssessmentSelector").html(data);
                });
            } else {
                $("#AssessmentSelector").html("&nbsp;");
            }
        });
    });
    </script>
    <cfoutput>
            <table>
                <tr>
                    <td>Attendee&nbsp;&nbsp;</td>
                    <td>
                        <select name="PersonID" id="PersonID" style="width:115px;">
                            <option value="0">Select one...</option>
                            <cfloop query="qReportData">
                                <option value="#qReportData.PersonID#">#qReportData.LastName#, #qReportData.FirstName#</option>
                            </cfloop>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
	</cfoutput>
</cfif>