<cfquery name="qTestingActivities" datasource="#Application.Settings.DSN#">
	SELECT act.ActivityID, act.Title, act.StartDate
    FROM ce_Activity act
    WHERE
    	(SELECT Count(AssessmentID)
         FROM ce_Assessment
         WHERE (ActivityID = act.ActivityID AND AssessTypeID = 2) AND act.DeletedFlag = 'N' OR (ActivityID = act.ActivityID AND AssessTypeID = 3)) > 0 AND 
    	(act.DeletedFlag = 'N')
    ORDER BY act.StartDate DESC
</cfquery>