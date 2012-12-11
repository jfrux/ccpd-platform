<cfparam name="Attributes.ActivityID" default="">

<cfquery name="qReportData" datasource="#Application.Settings.DSN#">
	SELECT 	act.StartDate AS CertificateDate,
    		act.endDate,
            act.Title AS ActivityTitle, 
			act.Location AS ActivityLocation,
            act.sponsor, 
            p.CertName AS DisplayName,
            ac.Amount AS TotalAmount,
			sc.Name AS CreditName,
            (SELECT TOP 1 attc.Amount
             FROM ce_AttendeeCredit attc
             WHERE (attc.AttendeeID = a.AttendeeID) AND (attc.CreditID = 2)) AS CreditAmount,
            (SELECT TOP 1 attc.ReferenceNo
             FROM ce_AttendeeCredit attc
             WHERE (attc.AttendeeID = a.AttendeeID) AND (attc.CreditID = 2)) AS ReferenceNumber,
            (SELECT TOP 1 p1.FirstName
             FROM ce_Activity_Faculty af
             INNER JOIN ce_Person p1 ON p1.PersonID = af.PersonID
             WHERE af.DeletedFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char" />) AS FacultyFName,
            (SELECT TOP 1 p1.LastName
             FROM ce_Activity_Faculty af
             INNER JOIN ce_Person p1 ON p1.PersonID = af.PersonID
             WHERE af.DeletedFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char" />) AS FacultyLName
	FROM ce_Attendee a
	INNER JOIN ce_Person p ON p.PersonID = a.PersonID AND p.deletedFlag = 'N'
	INNER JOIN ce_Activity_Credit ac ON ac.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />
	INNER JOIN ce_Sys_Credit sc ON sc.CreditID = ac.CreditID
	LEFT OUTER JOIN ce_Activity act ON act.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />
	WHERE 
		<cfif IsDefined("Attributes.SelectedAttendees") AND len(trim(attributes.SelectedAttendees)) GT 0>
		(
        	a.AttendeeId IN (#Attributes.SelectedAttendees#) AND
			a.DeletedFlag = 'N' AND 
			a.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND 
			sc.Name = <cfqueryparam value="CNE" cfsqltype="cf_sql_varchar" /> AND
			act.DeletedFlag = 'N' AND
			a.StatusId = 1
		)
		<cfelseif IsDefined("Attributes.SelectedMembers") AND len(trim(attributes.SelectedMembers)) GT 0>
		(
        	a.PersonId IN (#Attributes.SelectedMembers#) AND
			a.DeletedFlag = 'N' AND 
			a.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND 
			sc.Name = <cfqueryparam value="CNE" cfsqltype="cf_sql_varchar" /> AND
			act.DeletedFlag = 'N' AND
			a.StatusId = 1
		)
		<cfelse>
		a.DeletedFlag = 'N' AND 
    	a.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND 
        sc.Name = <cfqueryparam value="CNE" cfsqltype="cf_sql_varchar" /> AND
    	act.DeletedFlag = 'N' AND
        a.StatusId = 1
        </cfif>
</cfquery>

<cfif qReportData.recordCount GT 0>
	<cfset ActStartDate = DateFormat(qReportData.CertificateDate,"MMMM D, YYYY")>
	<cfset ActEndDate = DateFormat(qReportData.EndDate,"MMMM D, YYYY")>
    
	<cfif qReportData.CertificateDate EQ qReportData.EndDate>
        <cfset qReportData.CertificateDate = ActStartDate>
    <cfelse>
        <cfif compare(datepart("yyyy", actStartDate), datepart("yyyy", ActEndDate)) EQ 0 AND compare(datepart("m", actStartDate), datepart("m", ActEndDate)) EQ 0>
            <cfset qReportData.CertificateDate = dateFormat(ActStartDate, "MMMM DD") & " - " & dateFormat(ActEndDate, "DD, YYYY")>
        <cfelseif compare(datepart("yyyy", actStartDate), datepart("yyyy", ActEndDate)) EQ 0>
            <cfset qReportData.CertificateDate = dateFormat(ActStartDate, "MMMM DD") & " - " & dateFormat(ActEndDate, "MMMM DD, YYYY")>
        <cfelse>
            <cfset qReportData.CertificateDate = ActStartDate & " - " & ActEndDate>
        </cfif>
    </cfif>
</cfif>