
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">

<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectSubTitle">Report Generator</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
	<table>
		<input type="hidden" name="Submitted" value="1">
		<input type="hidden" name="ReportID" value="14">
		<tr>
			<td>Activity</td>
			<td>
            	<select name="ActivityID" id="ActivityID" style="width:115px;">
            		<option value="0">Select one...</option>
                    <cfloop query="qCDCActivities">
                    <option value="#qCDCActivities.ActivityID#">#qCDCActivities.Title#</option>
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