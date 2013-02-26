<cfcomponent displayname="ACCME Preparation" output="no">
	<cfimport taglib="/_poi/" prefix="poi" />
	
	<!--- CONFIGURATION --->
	<cfset ReportPath = ExpandPath("#Application.Settings.RootPath#/_reports/21/")>
	<cfset ReportFileName = "accmeprep-#DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#-#Session.AccountID#.xlsx">
	<cfset ColumnCount = 3>
	<cfset Title = "ACCME Preparation">
	<cfset BookName = "ACCME Prep">
	
	<cfif NOT DirectoryExists("#ReportPath#")><cfdirectory action="Create" directory="#ReportPath#"></cfif>
	
	<!--- RUN METHOD --->
	<cffunction name="Run" access="remote" output="yes">
		<cfargument name="StartDate" required="true" type="string">
		<cfargument name="EndDate" required="true" type="string">
		<cfargument name="requireCredit" required="false" type="string">
		<cfargument name="requireAttendee" required="false" type="string">
	
		<cfset Status = "">
		
		<cfif Arguments.StartDate EQ "">
			<cfset Status = "Fail|Start Date is required.">
		</cfif>
		
		<cfif Arguments.EndDate EQ "">
			<cfif Status EQ "">
				<cfset Status = "Fail|End Date is required.">
			<cfelse>
				<cfset Status = "Fail|Start Date and End Date is required.">
			</cfif>
		</cfif>
		
		<cfif Status EQ "">
			<cfset qACCMEData = createObject("component","admin._com.Report.accmePARS").getACCMEData(startDate=arguments.startDate,endDate=arguments.endDate,requireCredit=arguments.requireCredit,requireAttendees=arguments.requireAttendees) />
			
			<cfset qReport = QueryNew("
										ActivityID,
										ParentFlag,
										ParentTitle,
										ActivityTitle,
										ActivityDate,
										ActivityLocation,
										City,
										State,
										Country,
										Sponsorship,
										Sponsor,
										ActivityTypeName,
										CMEHrs,
										StatMD,
										StatNonMD,
										StatSupporters,
										SupportReceived,
										StatSuppAmount,
										GroupingName,
										TotalExhibit,
										TotalRegistration,
										compDesign,
										perfDesign,
										outDesign,
										compEval,
										perfEval,
										outEval",
										"
										cf_sql_integer,
										cf_sql_varchar,
										cf_sql_varchar,
										cf_sql_varchar,
										cf_sql_date,
										cf_sql_varchar,
										cf_sql_varchar,
										cf_sql_varchar,
										cf_sql_varchar,
										cf_sql_varchar,
										cf_sql_varchar,
										cf_sql_varchar,
										cf_sql_decimal,
										cf_sql_integer,
										cf_sql_integer,
										cf_sql_integer,
										cf_sql_varchar,
										cf_sql_decimal,
										cf_sql_varchar,
										cf_sql_decimal,
										cf_sql_decimal,
										cf_sql_integer,
										cf_sql_integer,
										cf_sql_integer,
										cf_sql_integer,
										cf_sql_integer,
										cf_sql_integer
										")>
			<cfset RowCount = 0>
			
			<cfloop query="qACCMEData">
				
				<!--- ACTIVITY TYPE ALIAS --->
				<cfset ActivityType = getTypeAlias(qACCMEData.ActivityTypeName)>
				
				<cfscript>
					queryAddRow(qReport);
					
					querySetCell(qReport,"ActivityID",qACCMEData.ActivityID);
					querySetCell(qReport,"ParentFlag","Y");
					querySetCell(qReport,"ActivityTitle",qACCMEData.ActivityTitle);
					querySetCell(qReport,"ActivityDate",qACCMEData.ActivityDate);
					querySetCell(qReport,"ActivityLocation",qACCMEData.ActivityLocation);
					querySetCell(qReport,"City",qACCMEData.City);
					querySetCell(qReport,"State",qACCMEData.State);
					querySetCell(qReport,"Country",qACCMEData.Country);
					querySetCell(qReport,"Sponsorship",qACCMEData.Sponsorship);
					querySetCell(qReport,"Sponsor",qACCMEData.Sponsor);
					querySetCell(qReport,"ActivityTypeName",ActivityType);
					querySetCell(qReport,"CMEHrs",qACCMEData.CMEHrs);
					querySetCell(qReport,"StatMD",qACCMEData.StatMD);
					querySetCell(qReport,"StatNonMD",qACCMEData.StatNonMD);
					querySetCell(qReport,"SupportReceived",qACCMEData.SupportReceived);
					querySetCell(qReport,"StatSuppAmount",qACCMEData.StatSuppAmount);
					querySetCell(qReport,"StatSupporters",qACCMEData.StatSupporters);
					querySetCell(qReport,"TotalExhibit",qACCMEData.TotalExhibit);
					querySetCell(qReport,"TotalRegistration",qACCMEData.TotalRegistration);
					querySetCell(qReport,"compDesign",qACCMEData.competenceDesign);
					querySetCell(qReport,"perfDesign",qACCMEData.performanceDesign);
					querySetCell(qReport,"outDesign",qACCMEData.outcomesDesign);
					querySetCell(qReport,"compEval",qACCMEData.competenceEval);
					querySetCell(qReport,"perfEval",qACCMEData.performanceEval);
					querySetCell(qReport,"outEval",qACCMEData.outcomesEval);
				</cfscript>
				
				
				<!---[#DateFormat(qACCMEData.ActivityDate,'mm-dd-yyyy')#] #qACCMEData.ActivityTitle#<br />--->
				<cfquery name="qChild" datasource="#Application.Settings.DSN#">
					DECLARE @StartDate datetime;
					DECLARE @EndDate datetime;
					DECLARE @ActivityID int;
					
					SET @StartDate = #CreateODBCDateTime("#DateFormat(Arguments.StartDate,'mm/dd/yyyy')# 00:00:00")#;
					SET @EndDate = #CreateODBCDateTime("#DateFormat(Arguments.EndDate,'mm/dd/yyyy')# 23:59:59")#;
					SET @ActivityID = <cfqueryparam value="#qACCMEData.ActivityID#" cfsqltype="cf_sql_integer" />;
					
					SELECT 
						A.ActivityID,
						A.ParentActivityID,
						ActivityTitle = A.Title,
						A.ActivityTypeID,
						ActivityTypeName = AT.Name,
						ActivityLocation = isNull(A.City,'') + ', ' + isNull((SELECT Code FROM ce_Sys_State WHERE StateID = A.State),''),
						Sponsorship = (CASE A.Sponsorship
											WHEN 'J' THEN 'Jointly'
											WHEN 'D' THEN 'Directly'
										END),
						CMEHrs = 
							isNull((SELECT SUM(AC.Amount) AS TotalHours
									FROM ce_Activity_Credit AS AC 
									WHERE (AC.CreditID = 1) AND (AC.DeletedFlag='N') AND (AC.ActivityID = A.ActivityID)),0),
						StatMD,
						isNull(isNull(StatNonMD,0)+isNull(StatAddlAttendees,0),0) As StatNonMD,
						A.ReleaseDate,
						ActivityDate = A.StartDate,
						A.EndDate,
						StatSupporters = isNull((SELECT     COUNT(Amount) AS Expr1
								FROM         ce_Activity_FinSupport
								WHERE     (SupportTypeID = 1) AND (DeletedFlag = 'N') AND (ActivityID=a.ActivityID)),0),
						(CASE isNull((SELECT     COUNT(Amount) AS Expr1
								FROM         ce_Activity_FinSupport
								WHERE     (SupportTypeID = 1) AND (DeletedFlag = 'N') AND (ActivityID=a.ActivityID)),0)
							WHEN '0' THEN 'No'
							ELSE 'Yes'
						END) AS SupportReceived,
						StatSuppAmount = isNull((SELECT     SUM(Amount) AS Expr1
								FROM         ce_Activity_FinSupport
								WHERE     (SupportTypeID = 1) AND (DeletedFlag = 'N') AND (ActivityID=a.ActivityID)),0),
						Oth.competenceDesign,
						Oth.performanceDesign,
						Oth.outcomesDesign,
						Oth.competenceEval,
						Oth.performanceEval,
						Oth.outcomesEval
					FROM 
						ce_Activity AS A
					INNER JOIN 
						ce_Sys_Grouping AS AT ON A.GroupingID=AT.GroupingID
					LEFT OUTER JOIN
						ce_Activity_Other As Oth ON Oth.activityId = A.activityid
					WHERE 
							A.ActivityTypeID <> 2 AND
							A.StartDate BETWEEN @StartDate AND @EndDate AND
							A.DeletedFlag='N' AND
							A.StatusID IN (1,2,3) AND
							A.ParentActivityID = @ActivityID AND 
							isNull((SELECT SUM(AC.Amount) AS TotalHours
							FROM ce_Activity_Credit AS AC
							WHERE (AC.CreditID = 1) AND (AC.ActivityID = A.ActivityID) AND (AC.DeletedFlag='N')),0) > 0
							
							OR
							
							A.ActivityTypeID <> 2 AND
							A.EndDate BETWEEN @StartDate AND @EndDate AND
							A.DeletedFlag='N' AND
							A.StatusID IN (1,2,3) AND
							A.ParentActivityID = @ActivityID AND 
							isNull((SELECT SUM(AC.Amount) AS TotalHours
							FROM ce_Activity_Credit AS AC
							WHERE (AC.CreditID = 1) AND (AC.ActivityID = A.ActivityID) AND (AC.DeletedFlag='N')),0) > 0
					ORDER BY A.StartDate
				</cfquery>
				
				<cfif qChild.RecordCount GT 0>
					<cfloop query="qChild">
						<!--- ACTIVITY TYPE ALIAS --->
						<cfset ActivityType = getTypeAlias(qACCMEData.ActivityTypeName)>
						<!---[#DateFormat(qChild.ActivityDate,'mm-dd-yyyy')#] #qChild.ActivityTitle#<br>--->
						<cfscript>
							queryAddRow(qReport);
							RowCount = IncrementValue(RowCount);
							
							querySetCell(qReport,"ActivityID",qChild.ActivityID);
							querySetCell(qReport,"ParentFlag","N");
							querySetCell(qReport,"ParentTitle",qACCMEData.ActivityTitle);
							querySetCell(qReport,"ActivityTitle",qChild.ActivityTitle);
							querySetCell(qReport,"ActivityDate",qChild.ActivityDate);
							querySetCell(qReport,"ActivityLocation",qChild.ActivityLocation);
							querySetCell(qReport,"Sponsorship",qChild.Sponsorship);
							querySetCell(qReport,"ActivityTypeName",ActivityType);
							querySetCell(qReport,"CMEHrs",qChild.CMEHrs);
							querySetCell(qReport,"StatMD",qChild.StatMD);
							querySetCell(qReport,"StatNonMD",qChild.StatNonMD);
							querySetCell(qReport,"SupportReceived",qChild.SupportReceived);
							querySetCell(qReport,"StatSuppAmount",qChild.StatSuppAmount);
							querySetCell(qReport,"StatSupporters",qChild.StatSupporters);
						</cfscript>
					</cfloop>
				</cfif>
			</cfloop>
			<poi:document name="Request.ExcelData" file="#ReportPath##ReportFileName#" type="XSSF">
				<poi:classes>
					<poi:class name="title" style="font-family:Arial; color:white; font-size:13pt; vertical-align:center; font-weight:bold; text-align:center; background-color:lime; border-bottom:3px solid green;" />
				</poi:classes>
				
				<poi:classes>
					<poi:class name="parent" style="font-family:Arial; font-size:10pt; vertical-align:center; border-bottom:2px solid black; background-color:lemon_chiffon; font-weight:bold;" />
				</poi:classes>
				
				<poi:classes>
					<poi:class name="child" style="font-family:Arial; font-size:10pt; vertical-align:center; color:GREY_50_PERCENT; border-bottom:2px solid GREY_50_PERCENT;" />
				</poi:classes>
				
				<poi:sheets>
					<poi:sheet name="#BookName#" orientation="landscape">
						<poi:columns>
							<poi:column style="width:272px;" />
							<poi:column style="width:79px;" />
							<poi:column style="width:111px;" />
							<poi:column style="width:115px;" />
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
							<cfif qReport.ParentFlag EQ "Y"> 
								<cfset rowClass = "parent">
							<cfelse>
								<cfset rowClass = "child">
							</cfif>
						<poi:row class="#rowClass#">
							<poi:cell value="#qReport.ActivityTitle#" />
							<poi:cell value="#DateFormat(qReport.ActivityDate,'M/D/YYYY')#" type="date" dateformat="m/d/yy" style="text-align:center;" />
							<poi:cell value="#qReport.ActivityLocation#" />
							<poi:cell value="#qReport.Sponsorship#" style="text-align:center;" />
							<poi:cell value="#qReport.ActivityTypeName#" style="text-align:center;" />
							<poi:cell value="#qReport.CMEHrs#" style="text-align:center;" type="numeric" numberformat="0.00" />
							<poi:cell value="#qReport.StatMD#" style="text-align:center;" type="numeric" numberformat="0" />
							<poi:cell value="#qReport.StatNonMD#" style="text-align:center;" type="numeric" numberformat="0" />
							<poi:cell value="#qReport.SupportReceived#" style="text-align:center;" />
							<poi:cell value="#qReport.StatSuppAmount#" style="text-align:right;" type="numeric" numberformat="0.00" />
							<poi:cell value="#qReport.StatSupporters#" style="text-align:center;" type="numeric" numberformat="0"  />
						</poi:row>
						</cfloop>
					</poi:sheet>
				</poi:sheets>
			</poi:document>
		</cfif>
		
        <cflog text="ACCME Prep report generated." file="ccpd_report_log">
		
		<cfreturn "Success" />
	</cffunction>
	
	<cffunction name="getTypeAlias" access="private">
		<cfargument name="TypeName" type="string" required="yes">
		
		<cfset var ActivityTypeAlias = Arguments.TypeName>
		
		<cfswitch expression="#Arguments.TypeName#">
			<cfcase value="Internet Enduring">
				<cfset ActivityTypeAlias = "Enduring Material">
			</cfcase>
			<cfcase value="Course">
				<cfset ActivityTypeAlias = "Live Course">
			</cfcase>
			<cfcase value="Regularly Scheduled Series">
				<cfset ActivityTypeAlias = "RSS">
			</cfcase>
			<cfcase value="Print">
				<cfset ActivityTypeAlias = "Enduring Material">
			</cfcase>
			<cfcase value="Live Internet">
				<cfset ActivityTypeAlias = "Live Internet">
			</cfcase>
		</cfswitch>
		
		<cfreturn ActivityTypeAlias />
	</cffunction>
</cfcomponent>