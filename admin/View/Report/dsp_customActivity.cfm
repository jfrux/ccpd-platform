<cfquery name="qActivities" datasource="#application.settings.dsn#">
	SELECT
    	act.activityId,
        sat.name,
        act.title,
        act.startDate,
        act.endDate,
        act.statAttendees,
        ass.assessmentId
    FROM
    	ce_activity AS act
    INNER JOIN
    	ce_assessment AS ass ON ass.activityId = act.activityId
    INNER JOIN 
    	ce_sys_activityType AS sat ON sat.activityTypeId = act.activityTypeId
    WHERE
    	act.title LIKE 'HCPLive%' AND
        ass.assessTypeId = 1 AND
        act.deletedFlag = 'N' AND
        ass.deletedFlag = 'N' AND
        (SELECT 
        	COUNT(ar.resultId)
         FROM
         	ce_assessResult AS ar
         WHERE
         	ar.assessmentId = ass.assessmentId) > 0
</cfquery>

<cfoutput>
<table>
<tr>
	<td colspan="2">Activity Count: #qActivities.recordCount#</td>
</tr>
<cfloop query="qActivities">
<tr>
	<td style="padding-bottom:5px;"><a href="#myself#activity.reports?activityId=#qActivities.activityId#" target="_blank">#qActivities.title#</a> (#qActivities.assessmentId#)</td>
	<td style="padding-bottom:5px;"><form method="get" action="/admin/_com/Report/Assess_AnswerDump.cfc">
            <input type="hidden" value="Run" name="method">
            <input type="hidden" value="Incept" name="reportLabel">
            <input type="hidden" value="#qActivities.assessmentId#" name="assessmentId">
        	<input type="submit" class="button" value="Download" name="submit">
		</form>
	</td>
</tr>
</cfloop>
</table>
</cfoutput>