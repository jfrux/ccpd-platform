<cfcomponent displayname="Attendance Report">
	<cffunction name="Run" access="remote" output="true" returntype="string">
    	<cfargument name="ActivityID" type="string" required="true" />
    	<cfargument name="ReportID" type="string" required="true" default="13" />
        
		<cfquery name="qActivity" datasource="#Application.Settings.DSN#">
			SELECT Title FROM ce_Activity
			WHERE ActivityID=#Arguments.ActivityID#
		</cfquery>
		
        <cfquery name="qAttendees" datasource="#application.settings.dsn#">
        	DECLARE @activity INT
            SET @activity = <cfqueryparam value="#arguments.activityId#" cfsqltype="cf_sql_integer" />
            
			SELECT
	a.attendeeid,
	a.personid,
	firstName = CASE
		WHEN a.personid > 0 THEN
			p.firstName
		ELSE
			a.firstName
	END,
	middleName = CASE
		WHEN a.personid > 0 THEN
			p.middleName
		ELSE
			a.middleName
	END,
	lastName = CASE
		WHEN a.personid > 0 THEN
			p.lastName
		ELSE
			a.lastName
	END,
	ss.Name AS statusName,
	a.registerDate,
	a.CompleteDate,
	sd.name AS degreeName,
	email = CASE
		WHEN a.personid > 0 THEN
			p.email
		ELSE
			a.email
	END,
	address1 = CASE
		WHEN a.personid > 0 THEN
			pa.address1
		ELSE
			a.address1
	END,
	address2 = CASE
		WHEN a.personid > 0 THEN
			pa.address2
		ELSE
			a.address2
	END,
	city = CASE
		WHEN a.personid > 0 THEN
			pa.city
		ELSE
			a.city
	END,
	state = CASE
		WHEN a.personid > 0 THEN
			pa.state
		ELSE
			a.stateProvince
		END,
	stateId = CASE
		WHEN a.personid > 0 THEN
			pa.stateId
		ELSE
			a.stateId
	END,
	country = CASE
		WHEN a.personid > 0 THEN
			pa.country
		ELSE
			country.name
	END,
	countryId = CASE
		WHEN a.personid > 0 THEN
			pa.countryId
		ELSE
			a.countryId
	END,
	zipCode = CASE
		WHEN a.personid > 0 THEN
			pa.zipCode
		ELSE
			a.postalCode
	END,
	a.entryMethod
FROM
	ce_attendee AS a
LEFT OUTER JOIN
	ce_person AS p ON p.personId = a.personId AND a.personId > 0
INNER JOIN
	ce_sys_status AS ss ON ss.statusId = a.statusId
LEFT OUTER JOIN
	ce_person_degree AS pd ON pd.personId = p.personId AND pd.deletedFlag='N'
LEFT OUTER JOIN
	ce_sys_degree AS sd ON sd.degreeId = pd.degreeId
LEFT OUTER JOIN
	ce_person_address AS pa ON pa.addressId = p.primaryAddressId
LEFT OUTER JOIN
	ce_sys_state AS state ON state.stateId = a.stateId
LEFT OUTER JOIN
	ce_sys_country AS country ON country.id = a.countryId
WHERE	
	a.activityId = @activity AND
	a.deletedFlag = 'N'
ORDER BY
	p.lastName, p.firstName DESC
        </cfquery>
        
		<!--- Import POI Library --->
		<cfimport taglib="/_poi/" prefix="poi" />
		
		<!--- Create Report Folder variable --->
		<cfset ReportPath = ExpandPath("/admin/_reports")>
		
		<!--- Check if the report folder exists yet --->
		<cfif NOT DirectoryExists("#ReportPath#/#Arguments.ReportID#")>
			<cfdirectory action="Create" directory="#ReportPath#/#Arguments.ReportID#">
		</cfif>
		
		<!--- Define variables used in the CreateExcel object --->
		<cfset CurrFileName = "Attendance_Report_#Arguments.ActivityID#_#DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#.xlsx">
		<cfset ReportExtendedPath = ReportPath & "/" & Arguments.ReportID & "/" & CurrFileName>
        
		<cfset ColumnCount = 16>
        
		<!--- Start Building Excel file --->
		<poi:document name="Request.ExcelData" file="#ReportExtendedPath#" type="XSSF">
			<poi:classes>
				<poi:class name="title" style="font-family: arial; color: ##000; font-size:12pt; font-weight:bold;  background-color: PALE_BLUE; border-top: 3px BLACK; border-bottom:3px BLACK; border-left: 2px BLACK; border-right:2px BLACK;" />
				<poi:class name="headers" style="font-family: arial ; color: ##000; background-color:GREY_25_PERCENT;  font-size: 10pt; font-weight: bold; border-top: 3px BLACK; border-bottom:3px BLACK; border-left: 2px BLACK; border-right:2px BLACK;" />
				<poi:class name="data" style="font-family: arial ; color: ##000 ;  font-size: 10pt; border-bottom:2px GREY_50_PERCENT;" />
			</poi:classes>
			
			<poi:sheets>
				<poi:sheet name="Attendance Records" orientation="landscape">
					<poi:columns>
						<cfloop from="1" to="#ColumnCount#" index="i">
						<poi:column style="width: 150px;" />
						</cfloop>
					</poi:columns>
					
					<poi:row class="title">
						<poi:cell value="#Left(qActivity.Title,100)# Attendance - #DateFormat(now(),'mm/dd/yyyy')# #TimeFormat(now(),'hh:mm TT')#" colspan="#ColumnCount#" />
					</poi:row>
					
					<poi:row class="headers">
						<poi:cell value="First Name" />
						<poi:cell value="Middle Name" />
						<poi:cell value="Last Name" />
                        <poi:cell value="Status" />
						<poi:cell value="Registration Date" />
						<poi:cell value="Completion Date" />
                        <poi:cell value="Degree" />
						<poi:cell value="Email" />
						<poi:cell value="Address 1" />
						<poi:cell value="Address 2" />
						<poi:cell value="City" />
						<poi:cell value="State" />
						<poi:cell value="Postal Code" />
						<poi:cell value="Country" />
						<poi:cell value="Has Account" />
						<poi:cell value="Entry Method" />
					</poi:row>
					
					<cfloop query="qAttendees">
						<cfset RegistrationDate = DateFormat(qAttendees.RegisterDate, "MM/DD/YYYY") & " " & TimeFormat(qAttendees.RegisterDate, "hh:mmTT")>
                        <cfif qAttendees.CompleteDate NEQ "">
							<cfset CompletionDate = DateFormat(qAttendees.CompleteDate, "MM/DD/YYYY") & " " & TimeFormat(qAttendees.CompleteDate, "hh:mmTT")>
                        <cfelse>
                        	<cfset CompletionDate = "">
                        </cfif>
						<poi:row>
							<poi:cell value="#qAttendees.FirstName#" />
							<poi:cell value="#qAttendees.MiddleName#" />
							<poi:cell value="#qAttendees.LastName#" />
							<poi:cell value="#qAttendees.StatusName#" />
							<poi:cell value="#registrationDate#" />
							<poi:cell value="#completionDate#" />
                            <poi:cell value="#qAttendees.degreeName#" />
							<poi:cell value="#qAttendees.email#" />
                            <poi:cell value="#qAttendees.address1#" />
                            <poi:cell value="#qAttendees.address2#" />
                            <poi:cell value="#qAttendees.city#" />
                            <poi:cell value="#qAttendees.state#" />
                            <poi:cell value="#qAttendees.zipCode#" />
                            <poi:cell value="#qAttendees.country#" />
							<cfif qAttendees.PersonId GT 0>
                            <poi:cell value="Yes" />
							<cfelse>
							
                            <poi:cell value="No" />
							</cfif>
                            <poi:cell value="#qAttendees.entryMethod#" />
						</poi:row>
					</cfloop>
					
				</poi:sheet>
			</poi:sheets>
		</poi:document>
		
    <cflog text="Attendance Report generated." file="ccpd_report_log">
		
		<cfheader name="Content-Type" value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
		<cfheader name="Content-Disposition" value="attachment; filename=#CurrFileName#">
		<cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#ReportExtendedPath#" deletefile="No">
    </cffunction>
</cfcomponent>