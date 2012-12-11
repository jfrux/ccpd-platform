<!---<cfquery name="qAlsoTaken" datasource="#Application.Settings.DSN#">
	DECLARE @ActivityID int;
	SET @ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />;
	
	SELECT TOP 5
		A.ActivityID,A.Title,Permalink = 
CASE isNull(APG.LinkName,'0')
	WHEN '0' THEN
		'http://ccpd.uc.edu/activity/' + CAST(A.ActivityID As varchar)
	WHEN '' THEN
		'http://ccpd.uc.edu/activity/' + CAST(A.ActivityID As varchar)
	ELSE
		'http://ccpd.uc.edu/activity/' + APG.LinkName
END
	FROM 
		ce_Attendee AS Att 
	INNER JOIN
		ce_Activity AS A ON Att.ActivityID = A.ActivityID 
	INNER JOIN
		ce_Activity_PubGeneral AS APG ON A.ActivityID = APG.ActivityID
	WHERE 
	(
		Att.PersonID IN
		  (SELECT Att2.PersonID
			FROM          ce_Attendee AS Att2
			WHERE      (Att2.ActivityID = @ActivityID) AND Att2.DeletedFlag='N') AND 
		(Att.ActivityID <> @ActivityID) AND 
		(A.StatusID = 1) AND 
		(Att.StatusID = 1) AND 
	
		(APG.PublishDate <= GETDATE()) AND 
		(APG.RemoveDate > GETDATE()) AND 
	
		(A.DeletedFlag = 'N') AND 
		(Att.DeletedFlag = 'N')
	)
	OR
	(
		Att.PersonID IN
		  (SELECT Att2.PersonID
			FROM          ce_Attendee AS Att2
			WHERE      (Att2.ActivityID = @ActivityID) AND Att2.DeletedFlag='N') AND 
	
		(Att.ActivityID <> @ActivityID) AND 
		(A.StatusID = 1) AND 
		(Att.StatusID = 1) AND 
	
		(APG.PublishDate <= GETDATE()) AND 
		(APG.RemoveDate IS NULL) AND 
	
		(A.DeletedFlag = 'N') AND 
		(Att.DeletedFlag = 'N')
	)
	ORDER BY Att.CheckIn DESC
</cfquery>--->