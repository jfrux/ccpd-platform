<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.SSN" default="0" />

<cfquery name="qReportDataPre" datasource="#Application.Settings.DSN#">
	SELECT	p.PersonID,
    		p.DisplayName,
            p.FirstName,
            p.LastName,
            p.Birthdate,
            p.SSN
	FROM	ce_Attendee a
    INNER JOIN ce_Person p ON p.PersonID = a.PersonID
    WHERE 	a.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND 
    		a.DeletedFlag = 'N' AND
            p.DeletedFlag = 'N'
			<cfif IsDefined("Attributes.SelectedAttendees")>
                AND a.AttendeeId IN (#Attributes.SelectedAttendees#)
            </cfif>
    ORDER BY p.LastName, p.FirstName DESC
</cfquery>

<!--- DEFINE NEW QUERY --->
<cfset qReportData = QueryNew("DisplayName,Birthdate,SSN")>
<cfset RowCount = 1>

<cfloop query="qReportDataPre">
	<!--- ADD NEW ROW --->
	<cfset QueryAddRow(qReportData,1)>
    
    <!--- BUILD NEW QUERY --->
	<cfset QuerySetCell(qReportData, "DisplayName", qReportDataPre.DisplayName, RowCount)>
	<cfif Len(qReportDataPre.Birthdate) LTE 0 OR qReportDataPre.Birthdate EQ "">
		<cfset QuerySetCell(qReportData, "Birthdate", "", RowCount)>
    <cfelse>
		<cfset QuerySetCell(qReportData, "Birthdate", qReportDataPre.Birthdate, RowCount)>
    </cfif>
    <cfif Len(qReportDataPre.SSN) LTE 0 OR Attributes.SSN EQ 0>
		<cfset QuerySetCell(qReportData, "SSN", "", RowCount)>
   	<cfelse>
		<cfset QuerySetCell(qReportData, "SSN", qReportDataPre.SSN, RowCount)>
    </cfif>
    
    <cfset RowCount++>
</cfloop>