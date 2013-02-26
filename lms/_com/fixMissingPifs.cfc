<cfcomponent displayname="fix da missing pifz">
	<cffunction name="run" access="remote" output="yes">
		<cfquery name="qGetAudit" datasource="#application.settings.dsn#">
			WITH CTE_ByPerson AS (
			SELECT PersonID,MAX(AttendeeID) As MaxAttendeeID FROM ceschema.View_FullPIFaudit GROUP BY PersonID
			) SELECT CTEDist.PersonID,FirstName,LastName,NewerPifs,OlderPifs,TotalPifs,TotalAttended,TotalMissing FROM CTE_ByPerson CTEDist LEFT OUTER JOIN ceschema.View_FullPIFaudit AS PIF ON CTEDist.MaxAttendeeID=PIF.AttendeeID
			WHERE TotalMissing > 0 AND CompleteDate BETWEEN '4/01/2006 00:00:00' AND '09/30/2010 23:59:59' AND TotalPifs > 0
			ORDER BY PIF.PersonID
		</cfquery>
		
		<cfloop query="qGetAudit">
			<cfquery name="qFixPifs" datasource="#application.settings.dsn#">
			
			</cfquery>
		</cfloop>
	</cffunction>
</cfcomponent>