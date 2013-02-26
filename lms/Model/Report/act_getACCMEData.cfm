<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.Submitted" default="">

<cfif Attributes.Submitted EQ 1>
	<cfif Attributes.StartDate EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a Start Date.","|")>
	</cfif>
	
	<cfif Attributes.EndDate EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter an End Date.","|")>
	</cfif>
	
	<cfif Request.Status.Errors EQ "">
		<cfquery name="qACCMEData" datasource="#Application.Settings.DSN#">
			SELECT 	
					a.ActivityID,
					a.Title AS ActivityTitle,
					a.StartDate AS ActivityDate,
					a.Location AS ActivityLocation,
					(CASE a.Sponsorship
						WHEN 'J' THEN 'Jointly'
						WHEN 'D' THEN 'Directly'
					END) AS Sponsorship,
					sat.Name AS ActivityTypeName,
					isNull((SELECT SUM(AC.Amount) AS TotalHours
							FROM ce_Activity_Credit AS AC 
							INNER JOIN ce_Activity AS A2 ON AC.ActivityID = A2.ActivityID
							WHERE (AC.CreditID = 1) AND (A2.ParentActivityID = a.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (A2.StartDate BETWEEN <cfqueryparam value="#Attributes.StartDate# 00:00:00" cfsqltype="cf_sql_timestamp" /> AND <cfqueryparam value="#Attributes.EndDate# 23:59:59" cfsqltype="cf_sql_timestamp" />)),0) AS CMEHrs,
					(SELECT Count(At.AttendeeID)
					 FROM ce_Attendee AS At 
					 INNER JOIN ce_Activity AS Ac ON At.ActivityID = Ac.ActivityID
					 WHERE 
					 	(At.ActivityID = a.ActivityID) AND (At.MDflag = 'Y') AND (Ac.StatusID IN (1,2,3)) AND (Ac.StartDate BETWEEN <cfqueryparam value="#Attributes.StartDate# 00:00:00" cfsqltype="cf_sql_timestamp" /> AND <cfqueryparam value="#Attributes.EndDate# 23:59:59" cfsqltype="cf_sql_timestamp" />) 
					 OR
                      	(Ac.ParentActivityID = a.ActivityID) AND (At.MDflag = 'Y') AND (Ac.StatusID IN (1,2,3)) AND (Ac.StartDate BETWEEN <cfqueryparam value="#Attributes.StartDate# 00:00:00" cfsqltype="cf_sql_timestamp" /> AND <cfqueryparam value="#Attributes.EndDate# 23:59:59" cfsqltype="cf_sql_timestamp" />)) As StatMD,
					(SELECT Count(At.AttendeeID)
					 FROM ce_Attendee AS At 
					 INNER JOIN ce_Activity AS Ac ON At.ActivityID = Ac.ActivityID
					 WHERE 
					 	(At.ActivityID = a.ActivityID) AND (At.MDflag = 'N') AND (Ac.StatusID IN (1,2,3)) AND (Ac.StartDate BETWEEN <cfqueryparam value="#Attributes.StartDate# 00:00:00" cfsqltype="cf_sql_timestamp" /> AND <cfqueryparam value="#Attributes.EndDate# 23:59:59" cfsqltype="cf_sql_timestamp" />) 
					 OR
                      	(Ac.ParentActivityID = a.ActivityID) AND (At.MDflag = 'N') AND (Ac.StatusID IN (1,2,3)) AND (Ac.StartDate BETWEEN <cfqueryparam value="#Attributes.StartDate# 00:00:00" cfsqltype="cf_sql_timestamp" /> AND <cfqueryparam value="#Attributes.EndDate# 23:59:59" cfsqltype="cf_sql_timestamp" />)) As StatNonMD,
					a.StatSupporters,
					(CASE a.StatSupporters
						WHEN '0' THEN 'No'
						ELSE 'Yes'
					END) AS SupportReceived,
					a.StatSuppAmount,
					sg.Name AS GroupingName
			FROM 	ce_Activity a
			LEFT OUTER JOIN ce_Sys_ActivityType sat ON sat.ActivityTypeID = a.ActivityTypeID
			LEFT OUTER JOIN ce_Sys_Grouping sg ON sg.GroupingID = a.GroupingID
			WHERE 
				(a.StatusID IN (1,2,3) AND a.StartDate BETWEEN <cfqueryparam value="#Attributes.StartDate# 00:00:00" cfsqltype="cf_sql_timestamp" /> AND <cfqueryparam value="#Attributes.EndDate# 23:59:59" cfsqltype="cf_sql_timestamp" /> AND a.ParentActivityID IS NULL AND a.DeletedFlag = 'N') 
			OR
				a.StatusID IN (1,2,3) AND (a.ParentActivityID IS NULL AND a.DeletedFlag = 'N') AND (SELECT Count(A2.ActivityID) FROM ce_Activity A2 WHERE A2.StatusID IN (1,2,3) AND A2.ParentActivityID=a.ActivityID AND A2.StartDate BETWEEN <cfqueryparam value="#Attributes.StartDate# 00:00:00" cfsqltype="cf_sql_timestamp" /> AND <cfqueryparam value="#Attributes.EndDate# 23:59:59" cfsqltype="cf_sql_timestamp" />) > 0
		</cfquery>
		
		<!--- Define NewQuery Variable and RowCount Variable --->
		<cfset qReport = QueryNew("ActivityID,ActivityTitle,ActivityDate,ActivityLocation,Sponsorship,ActivityTypeName,CMEHrs,StatMD,StatNonMD,StatSupporters,SupportReceived,StatSuppAmount,GroupingName")>
		<cfset RowCount = 0>
		
		<!--- Fill NewQuery Variable --->
		<cfloop from="1" to="#qACCMEData.RecordCount#" index="Index1">
			<cfscript>
				queryAddRow(qReport,1);
				RowCount = IncrementValue(RowCount);
				
				querySetCell(qReport,"ActivityID",qACCMEData.ActivityID[Index1],RowCount);
				querySetCell(qReport,"ActivityTitle",qACCMEData.ActivityTitle[Index1],RowCount);
				querySetCell(qReport,"ActivityDate",qACCMEData.ActivityDate[Index1],RowCount);
				querySetCell(qReport,"ActivityLocation",qACCMEData.ActivityLocation[Index1],RowCount);
				querySetCell(qReport,"Sponsorship",qACCMEData.Sponsorship[Index1],RowCount);
				querySetCell(qReport,"GroupingName",qACCMEData.GroupingName[Index1],RowCount);
				querySetCell(qReport,"CMEHrs",qACCMEData.CMEHrs[Index1],RowCount);
				querySetCell(qReport,"StatMD",qACCMEData.StatMD[Index1],RowCount);
				querySetCell(qReport,"StatNonMD",qACCMEData.StatNonMD[Index1],RowCount);
				querySetCell(qReport,"SupportReceived",qACCMEData.SupportReceived[Index1],RowCount);
				querySetCell(qReport,"StatSuppAmount",qACCMEData.StatSuppAmount[Index1],RowCount);
				querySetCell(qReport,"StatSupporters",qACCMEData.StatSupporters[Index1],RowCount);
			</cfscript>
		</cfloop>
		
		<!--- Excel Section --->
		<cftry>
			<!--- Import POI Library --->
			<cfimport taglib="/_poi/" prefix="poi" />
			
			<!--- Create Report Folder variable --->
			<cfset ReportPath = ExpandPath("/_reports")>
			
			<!--- Check if the report folder exists yet --->
			<cfif NOT DirectoryExists("#ReportPath#\#Attributes.ReportID#")>
				<cfdirectory action="Create" directory="#ReportPath#\#Attributes.ReportID#">
			</cfif>
			
			<!--- Define variables used in the CreateExcel object --->
			<cfset ReportExtendedPath = ReportPath & "\" & Attributes.ReportID & "\ACCME_Report_#DateFormat(Attributes.StartDate,'MDDYY')#-#DateFormat(Attributes.EndDate,'MDDYY')#_#DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#.xls">
			
			<!--- Start Building Excel file --->
			<poi:document name="Request.ExcelData" file="#ReportExtendedPath#">
				<poi:classes>
					<poi:class name="title" style="font-family: arial ; color: WHITE ;  font-size: 10pt ; font-weight: bold; text-align: center ; background-color: GREY_50_PERCENT;" />
				</poi:classes>
				
				<poi:sheets>
					<poi:sheet name="ACCME Report" orientation="landscape">
						<poi:columns>
							<poi:column style="width:272px;" />
							<poi:column style="width:79px;" />
							<poi:column style="width:111px;" />
							<poi:column style="width:100px;" />
							<poi:column style="width:186px;" />
							<poi:column style="width:71px;" />
							<poi:column style="width:64px;" />
							<poi:column style="width:92px;" />
							<poi:column style="width:120px;" />
							<poi:column style="width:104px;" />
							<poi:column style="width:129px;" />
						</poi:columns>
						
						<poi:row class="title">
							<poi:cell value="Activity Title" />
							<poi:cell value="Date" />
							<poi:cell value="Location" />
							<poi:cell value="Sponsorship" />
							<poi:cell value="Type of Activity" />
							<poi:cell value="## of Hours" />
							<poi:cell value="## of MD's" />
							<poi:cell value="## of non-MD's" />
							<poi:cell value="Commercial Support Receieved?" />
							<poi:cell value="Amount of Commercial Support Received" />
							<poi:cell value="Number of Commercial Supporters" />
						</poi:row>
						
						<cfloop query="qReport">
							<poi:row>
								<poi:cell value="#qReport.ActivityTitle#" />
								<poi:cell value="#DateFormat(qReport.ActivityDate,'M/D/YYYY')#" />
								<poi:cell value="#qReport.ActivityLocation#" />
								<poi:cell value="#qReport.Sponsorship#" />
								<poi:cell value="#qReport.GroupingName#" />
								<poi:cell type="numeric" value="#qReport.CMEHrs#" />
								<poi:cell type="numeric" value="#qReport.StatMD#" />
								<poi:cell type="numeric" value="#qReport.StatNonMD#" />
								<poi:cell value="#qReport.SupportReceived#" />
								<poi:cell type="numeric" value="#qReport.StatSuppAmount#" />
								<poi:cell type="numeric" value="#qReport.StatSupporters#" />
							</poi:row>
						</cfloop>
					</poi:sheet>
				</poi:sheets>
			</poi:document>
			<cfcatch type="any">
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Error: " & cfcatch.Message,"|")>
			</cfcatch>
		</cftry>
	</cfif>
</cfif>
