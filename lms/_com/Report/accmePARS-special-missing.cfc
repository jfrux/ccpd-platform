<cfcomponent displayname="ACCME Summary Report" output="no">
	<cfinclude template="/_com/_UDF/Stripallbut.cfm" />
	<cfimport taglib="/_poi/" prefix="poi" />
	
	<!--- CONFIGURATION --->
	<cfset ReportPath = ExpandPath("/admin/_reports/25/")>
	<cfset ReportFileName = "accmePARS-#DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#-#Session.AccountID#.txt">
	<cfset ColumnCount = 3>
	<cfset Title = "ACCME PARS">
	<cfset BookName = "ACCME PARS">
	
	<cfif NOT DirectoryExists("#ReportPath#")>
		<cfdirectory action="Create" directory="#ReportPath#">
	</cfif>
	
	<!--- RUN METHOD --->
	<cffunction name="Run" access="remote" output="yes">
		<cfargument name="StartDate" required="true" type="string">
		<cfargument name="EndDate" required="true" type="string">
	
		<cfset Status = "">
		<cfset Delimiter = chr(9)>
		<cfset Newline = chr(13) & chr(10)>
		<cfset FileOutput = "">
		
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
			<cfquery name="qACCMEData" datasource="#Application.Settings.DSN#">
					
				DECLARE @StartDate datetime;
				DECLARE @EndDate datetime;
				DECLARE @ReportYear nvarchar(4);
				
				SET @StartDate = #CreateODBCDateTime("#DateFormat(Arguments.StartDate,'mm/dd/yyyy')# 00:00:00")#;
				SET @EndDate = #CreateODBCDateTime("#DateFormat(Arguments.EndDate,'mm/dd/yyyy')# 23:59:59")#;
				SET @ReportYear = '#Year(arguments.startDate)#';
				
				WITH CTE_Activities ( ActivityID,ParentActivityID,ActivityTitle,ActivityTypeID,ActivityTypeName,ActivityLocation,City,State,Country,Sponsorship,Sponsor,CMEHrs,StatMD,StatNonMD,ReleaseDate,ActivityDate,EndDate,StatSupporters,SupportReceived,StatSuppAmount,TotalExhibit,TotalRegistration,groupingid)
				AS (
					SELECT 
						A.ActivityID,
						A.ParentActivityID,
						ActivityTitle = upper(A.Title),
						A.ActivityTypeID,
						ActivityTypeName = AT.Name,
						ActivityLocation = isNull(A.City,'') + ', ' + isNull((SELECT Code FROM ceschema.ce_Sys_State WHERE StateID = A.State),''),
						A.City,
						State = isNull((SELECT Code FROM ceschema.ce_Sys_State WHERE StateID = A.State),''),
						Country = isNull((SELECT   geonameCountry.ISO3 FROM ceschema.ce_Sys_Country AS country INNER JOIN ceschema.geonameCountryInfo AS geonameCountry ON country.code = geonameCountry.ISO WHERE country.id = A.Country),''),
						Sponsorship = (CASE A.Sponsorship
											WHEN 'J' THEN 'Joint'
											WHEN 'D' THEN 'Direct'
										END),
						Sponsor,
						CMEHrs = (CASE isNull(A.SessionType,'S')
									WHEN 'M' THEN 
										isNull((SELECT SUM(AC.Amount) AS TotalHours
												FROM ceschema.ce_Activity_Credit AS AC 
												INNER JOIN ceschema.ce_Activity AS A4 ON AC.ActivityID = A4.ActivityID
												WHERE (A4.DeletedFlag='N') AND (AC.CreditID = 1) AND (A4.ParentActivityID = a.ActivityID) AND (A4.StatusID IN (1,2,3)) AND (AC.DeletedFlag='N') AND (A4.StartDate BETWEEN @StartDate AND @EndDate)
												OR
												(A4.DeletedFlag='N') AND (AC.CreditID = 1) AND (A4.ParentActivityID = a.ActivityID) AND (A4.StatusID IN (1,2,3)) AND (AC.DeletedFlag='N') AND (A4.EndDate BETWEEN @StartDate AND @EndDate)),0)
									WHEN 'S' THEN 
										isNull((SELECT SUM(AC.Amount) AS TotalHours
												FROM ceschema.ce_Activity_Credit AS AC 
												WHERE (AC.CreditID = 1) AND (AC.ActivityID = A.ActivityID) AND (AC.DeletedFlag='N')),0)
								END),
						StatMD = 
							isNull((CASE
								/* ENDURING MATERIALS */
								WHEN A.ActivityTypeID = 2 THEN 
									(SELECT Count(Att.AttendeeID)
									 FROM ceschema.ce_Attendee AS Att 
									 INNER JOIN ceschema.ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
									 WHERE 
										(A2.DeletedFlag='N') AND 
										(Att.ActivityID = a.ActivityID) AND
										(Att.MDflag = 'Y') AND 
										(A2.StatusID IN (1,2,3)) AND 
										(Att.CompleteDate BETWEEN @StartDate AND @EndDate) AND
										(A2.StartDate BETWEEN @StartDate AND @EndDate)
											OR
										(A2.DeletedFlag='N') AND 
										(Att.ActivityID = a.ActivityID) AND
										(Att.MDflag = 'Y') AND 
										(A2.StatusID IN (1,2,3)) AND 
										(Att.CompleteDate BETWEEN @StartDate AND @EndDate) AND
										(A2.EndDate BETWEEN @StartDate AND @EndDate)
									)
								WHEN A.ActivityTypeID <> 2 THEN 
									(CASE isNull(A.SessionType,'S')
										WHEN 'M' THEN 
											(SELECT Sum(A2.StatMD)
											FROM
											 ceschema.ce_Activity AS A2
											 WHERE 
												(A2.DeletedFlag='N') AND (A2.ParentActivityID = A.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (A2.StartDate BETWEEN @StartDate AND @EndDate)
												OR
												(A2.DeletedFlag='N') AND (A2.ParentActivityID = A.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (A2.EndDate BETWEEN @StartDate AND @EndDate)
											)
										WHEN 'S' THEN
											(SELECT Sum(A2.StatMD)
											FROM
											 ceschema.ce_Activity AS A2
											 WHERE 
												(A2.DeletedFlag='N') AND (A2.ActivityID = A.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (A2.StartDate BETWEEN @StartDate AND @EndDate)
												OR
												(A2.DeletedFlag='N') AND (A2.ActivityID = A.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (A2.EndDate BETWEEN @StartDate AND @EndDate)
											)
									END)
											
							END),0),
							StatNonMD = 
							isNull((
								CASE A.ActivityTypeID
									WHEN 2 THEN /* WHEN: ENDURING MATERIALS */


										(
										(
										SELECT 
											count(Att2.AttendeeID)
										FROM 
											ceschema.ce_Attendee AS Att2 
										INNER JOIN 
											ceschema.ce_Activity AS A3 ON Att2.ActivityID = A3.ActivityID
										WHERE 
											(A3.DeletedFlag='N') AND 
											(Att2.ActivityID = a.ActivityID) AND
											(Att2.MDflag = 'N') AND 
											(A3.StatusID IN (1,2,3)) AND 
											(Att2.CompleteDate BETWEEN @StartDate AND @EndDate) AND
											(A3.StartDate BETWEEN @StartDate AND @EndDate) AND
											(Att2.DeletedFlag='N')
												OR
											(A3.DeletedFlag='N') AND 
											(Att2.ActivityID = a.ActivityID) AND
											(Att2.MDflag = 'N') AND 
											(A3.StatusID IN (1,2,3)) AND 
											(Att2.CompleteDate BETWEEN @StartDate AND @EndDate) AND
											(A3.EndDate BETWEEN @StartDate AND @EndDate) AND
											(Att2.DeletedFlag='N')
										)+
										isNull(A.statAddlAttendees,0)
										)
									ELSE
										(CASE isNull(A.SessionType,'S')
												WHEN 'M' THEN 
													(
													SELECT 
														isNull(Sum(A3.StatNonMD),0)+isNull(Sum(A3.StatAddlAttendees),0)
													FROM
														ceschema.ce_Activity AS A3
													WHERE 
														(A3.DeletedFlag='N') AND 
														(A3.ParentActivityID = A.ActivityID) AND 
														(A3.StatusID IN (1,2,3)) AND 
														(A3.StartDate BETWEEN @StartDate AND @EndDate)
														OR
														(A3.DeletedFlag='N') AND 
														(A3.ParentActivityID = A.ActivityID) AND 
														(A3.StatusID IN (1,2,3)) AND 
														(A3.EndDate BETWEEN @StartDate AND @EndDate)
													)
												WHEN 'S' THEN 
													(
														isNull(A.StatNonMD,0)+isNull(A.StatAddlAttendees,0)
													)
											END)
											
									END),0),
						A.ReleaseDate,
						ActivityDate = A.StartDate,
						A.EndDate,
						/* 
						######################################
						NUMBER OF COMMERCIAL SUPPORTERS
						######################################
						*/
						StatSupporters = 
						isNull((CASE isNull(A.SessionType,'S')
							WHEN 'M' THEN
								(
								CASE A.GroupingID
									WHEN 2 THEN
										/* WHEN: RSS */
										(
											SELECT     
												COUNT(FS.Amount)
											FROM         
												ceschema.ce_Activity_FinSupport AS FS 
											INNER JOIN
												ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
											WHERE    
													(A5.ParentActivityID = A.ActivityID) AND 
													(A5.DeletedFlag='N') AND 
													(FS.SupportTypeID = 1) AND 
													(FS.DeletedFlag = 'N') AND
													(A5.StatusID IN (1,2,3)) AND
													(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
													(Year(A5.StartDate) = @ReportYear)
												OR
													(A5.ActivityID = A.ActivityID) AND 
													(FS.DeletedFlag = 'N') AND 
													(A5.DeletedFlag = 'N') AND
													(FS.SupportTypeID = 1) AND 
													(A5.StatusID IN (1,2,3)) AND
													(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
													(Year(A5.StartDate) = @ReportYear)
										)
									ELSE
										(
											SELECT     
												COUNT(FS.Amount)
											FROM         
												ceschema.ce_Activity_FinSupport AS FS 
											INNER JOIN
												ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
											WHERE    
													(A5.ParentActivityID = A.ActivityID) AND 
													(A5.DeletedFlag='N') AND 
													(FS.SupportTypeID = 1) AND 
													(FS.DeletedFlag = 'N') AND
													(A5.StatusID IN (1,2,3)) AND
													(A5.StartDate BETWEEN @StartDate AND @EndDate)
												OR
													(A5.ActivityID = A.ActivityID) AND 
													(FS.DeletedFlag = 'N') AND 
													(A5.DeletedFlag = 'N') AND
													(FS.SupportTypeID = 1) AND 
													(A5.StatusID IN (1,2,3)) AND
													(A5.StartDate BETWEEN @StartDate AND @EndDate)
										)
								END
								)
							WHEN 'S' THEN
								(
								CASE A.ActivityTypeID
									WHEN 2 THEN 
										/* WHEN: ENDURING MATERIAL */
										(
										SELECT     
											COUNT(FS.Amount)
										FROM         
											ceschema.ce_Activity_FinSupport As FS
										WHERE     
											(FS.SupportTypeID = 1) AND 
											(FS.DeletedFlag = 'N') AND 
											(FS.ActivityID=A.ActivityID) AND
											(Year(A.StartDate) = @ReportYear)
										)
									ELSE
										(
										SELECT     
											COUNT(FS.Amount)
										FROM         
											ceschema.ce_Activity_FinSupport As FS
										WHERE     
											(FS.SupportTypeID = 1) AND 
											(FS.DeletedFlag = 'N') AND 
											(FS.ActivityID=A.ActivityID)
										)
								END
								)
						END),0)
						,
						/* 
						######################################
						COMMERCIAL SUPPORT RECEIVED (YES / NO)
						######################################
						*/
						SupportReceived = 
							(
							CASE isNull(
								(CASE isNull(A.SessionType,'S')
									WHEN 'M' THEN 
										CASE A.GroupingID
											WHEN 2 THEN
												/* WHEN: RSS */
												(
													SELECT     
														COUNT(FS.Amount)
													FROM         
														ceschema.ce_Activity_FinSupport AS FS 
													INNER JOIN
														ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
													WHERE    
															(A5.ParentActivityID = A.ActivityID) AND 
															(A5.DeletedFlag='N') AND 
															(FS.SupportTypeID = 1) AND 
															(FS.DeletedFlag = 'N') AND
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
															(Year(A5.StartDate) = @ReportYear)
														OR
															(A5.ActivityID = A.ActivityID) AND 
															(FS.DeletedFlag = 'N') AND 
															(A5.DeletedFlag = 'N') AND
															(FS.SupportTypeID = 1) AND 
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
															(Year(A5.StartDate) = @ReportYear)
												)
											ELSE
												(
													SELECT     
														COUNT(FS.Amount)
													FROM         
														ceschema.ce_Activity_FinSupport AS FS 
													INNER JOIN
														ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
													WHERE    
															(A5.ParentActivityID = A.ActivityID) AND 
															(A5.DeletedFlag='N') AND 
															(FS.SupportTypeID = 1) AND 
															(FS.DeletedFlag = 'N') AND
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate)
														OR
															(A5.ActivityID = A.ActivityID) AND 
															(FS.DeletedFlag = 'N') AND 
															(A5.DeletedFlag = 'N') AND
															(FS.SupportTypeID = 1) AND 
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate)
												)
										END
									WHEN 'S' THEN
										(
										CASE A.ActivityTypeID
											WHEN 2 THEN 
												/* WHEN: ENDURING MATERIAL */
												(
												SELECT     
													COUNT(FS.Amount)
												FROM         
													ceschema.ce_Activity_FinSupport As FS
												WHERE     
													(FS.SupportTypeID = 1) AND 
													(FS.DeletedFlag = 'N') AND 
													(FS.ActivityID=A.ActivityID) AND
													(Year(A.StartDate) = @ReportYear)
												)
											ELSE
												(
												SELECT     
													COUNT(FS.Amount)
												FROM         
													ceschema.ce_Activity_FinSupport As FS
												WHERE     
													(FS.SupportTypeID = 1) AND 
													(FS.DeletedFlag = 'N') AND 
													(FS.ActivityID=A.ActivityID)
												)
										END
										)
								END),0)
							WHEN '0' THEN 
								'No'
							ELSE 
								'Yes'
							END
						),
						/* 
						######################################
						SUPPORT AMOUNT DOLLARS ($)
						######################################
						*/
						StatSuppAmount = 
							isNull(
								(CASE isNull(A.SessionType,'S')
									WHEN 'M' THEN 
										CASE A.GroupingID
											WHEN 2 THEN
												/* WHEN: RSS */
												(
													SELECT     
														SUM(FS.Amount)
													FROM         
														ceschema.ce_Activity_FinSupport AS FS 
													INNER JOIN
														ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
													WHERE    
															(A5.ParentActivityID = A.ActivityID) AND 
															(A5.DeletedFlag='N') AND 
															(FS.SupportTypeID = 1) AND 
															(FS.DeletedFlag = 'N') AND
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
															(Year(A5.StartDate) = @ReportYear)
														OR
															(A5.ActivityID = A.ActivityID) AND 
															(FS.DeletedFlag = 'N') AND 
															(A5.DeletedFlag = 'N') AND
															(FS.SupportTypeID = 1) AND 
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
															(Year(A5.StartDate) = @ReportYear)
												)
											ELSE
												(
													SELECT     
														SUM(FS.Amount)
													FROM         
														ceschema.ce_Activity_FinSupport AS FS 
													INNER JOIN
														ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
													WHERE    
															(A5.ParentActivityID = A.ActivityID) AND 
															(A5.DeletedFlag='N') AND 
															(FS.SupportTypeID = 1) AND 
															(FS.DeletedFlag = 'N') AND
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate)
														OR
															(A5.ActivityID = A.ActivityID) AND 
															(FS.DeletedFlag = 'N') AND 
															(A5.DeletedFlag = 'N') AND
															(FS.SupportTypeID = 1) AND 
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate)
												)
										END
									WHEN 'S' THEN
										(
										CASE A.ActivityTypeID
											WHEN 2 THEN 
												/* WHEN: ENDURING MATERIAL */
												(
												SELECT     
													SUM(FS.Amount)
												FROM         
													ceschema.ce_Activity_FinSupport As FS
												WHERE     
													(FS.SupportTypeID = 1) AND 
													(FS.DeletedFlag = 'N') AND 
													(FS.ActivityID=A.ActivityID) AND
													(Year(A.StartDate) = @ReportYear)
												)
											ELSE
												(
												SELECT     
													SUM(FS.Amount)
												FROM         
													ceschema.ce_Activity_FinSupport As FS
												WHERE     
													(FS.SupportTypeID = 1) AND 
													(FS.DeletedFlag = 'N') AND 
													(FS.ActivityID=A.ActivityID)
												)
										END
										)
									END),0),
						/* 
						######################################
						EXHIBIT AMOUNT DOLLARS ($)
						######################################
						*/
						TotalExhibit = 
						isNull(
								(CASE isNull(A.SessionType,'S')
									WHEN 'M' THEN 
										CASE A.GroupingID
											WHEN 2 THEN
												/* WHEN: RSS */
												(
													SELECT     
														SUM(FS.Amount)
													FROM         
														ceschema.ce_Activity_FinSupport AS FS 
													INNER JOIN
														ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
													WHERE    
															(A5.ParentActivityID = A.ActivityID) AND 
															(A5.DeletedFlag='N') AND 
															(FS.SupportTypeID = 2) AND 
															(FS.DeletedFlag = 'N') AND
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
															(Year(A5.StartDate) = @ReportYear)
														OR
															(A5.ActivityID = A.ActivityID) AND 
															(FS.DeletedFlag = 'N') AND 
															(A5.DeletedFlag = 'N') AND
															(FS.SupportTypeID = 2) AND 
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
															(Year(A5.StartDate) = @ReportYear)
												)
											ELSE
												(
													SELECT     
														SUM(FS.Amount)
													FROM         
														ceschema.ce_Activity_FinSupport AS FS 
													INNER JOIN
														ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
													WHERE    
															(A5.ParentActivityID = A.ActivityID) AND 
															(A5.DeletedFlag='N') AND 
															(FS.SupportTypeID = 2) AND 
															(FS.DeletedFlag = 'N') AND
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate)
														OR
															(A5.ActivityID = A.ActivityID) AND 
															(FS.DeletedFlag = 'N') AND 
															(A5.DeletedFlag = 'N') AND
															(FS.SupportTypeID = 2) AND 
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate)
												)
										END
									WHEN 'S' THEN
										(
										CASE A.ActivityTypeID
											WHEN 2 THEN 
												/* WHEN: ENDURING MATERIAL */
												(
												SELECT     
													SUM(FS.Amount)
												FROM         
													ceschema.ce_Activity_FinSupport As FS
												WHERE     
													(FS.SupportTypeID = 2) AND 
													(FS.DeletedFlag = 'N') AND 
													(FS.ActivityID=A.ActivityID) AND
													(Year(A.StartDate) = @ReportYear)
												)
											ELSE
												(
												SELECT     
													SUM(FS.Amount)
												FROM         
													ceschema.ce_Activity_FinSupport As FS
												WHERE     
													(FS.SupportTypeID = 2) AND 
													(FS.DeletedFlag = 'N') AND 
													(FS.ActivityID=A.ActivityID)
												)
										END
										)
									END),0),
						/* 
						######################################
						TOTAL REGISTRATION FEE DOLLARS ($)
						######################################
						*/
						TotalRegistration = 
						isNull(
								(CASE isNull(A.SessionType,'S')
									WHEN 'M' THEN 
										CASE A.GroupingID
											WHEN 2 THEN
												/* WHEN: RSS */
												(
													SELECT     
														SUM(FS.Amount)
													FROM         
														ceschema.ce_Activity_FinSupport AS FS 
													INNER JOIN
														ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
													WHERE    
															(A5.ParentActivityID = A.ActivityID) AND 
															(A5.DeletedFlag='N') AND 
															(FS.SupportTypeID = 3) AND 
															(FS.DeletedFlag = 'N') AND
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
															(Year(A5.StartDate) = @ReportYear)
														OR
															(A5.ActivityID = A.ActivityID) AND 
															(FS.DeletedFlag = 'N') AND 
															(A5.DeletedFlag = 'N') AND
															(FS.SupportTypeID = 3) AND 
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate) AND
															(Year(A5.StartDate) = @ReportYear)
												)
											ELSE
												(
													SELECT     
														SUM(FS.Amount)
													FROM         
														ceschema.ce_Activity_FinSupport AS FS 
													INNER JOIN
														ceschema.ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
													WHERE    
															(A5.ParentActivityID = A.ActivityID) AND 
															(A5.DeletedFlag='N') AND 
															(FS.SupportTypeID = 3) AND 
															(FS.DeletedFlag = 'N') AND
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate)
														OR
															(A5.ActivityID = A.ActivityID) AND 
															(FS.DeletedFlag = 'N') AND 
															(A5.DeletedFlag = 'N') AND
															(FS.SupportTypeID = 3) AND 
															(A5.StatusID IN (1,2,3)) AND
															(A5.StartDate BETWEEN @StartDate AND @EndDate)
												)
										END
									WHEN 'S' THEN
										(
										CASE A.ActivityTypeID
											WHEN 2 THEN
												/* WHEN: ENDURING MATERIAL */
												(
												SELECT     
													SUM(FS.Amount)
												FROM         
													ceschema.ce_Activity_FinSupport As FS
												WHERE     
													(FS.SupportTypeID = 3) AND 
													(FS.DeletedFlag = 'N') AND 
													(FS.ActivityID=A.ActivityID) AND
													(Year(A.StartDate) = @ReportYear)
												)
											ELSE
												(
												SELECT     
													SUM(FS.Amount)
												FROM         
													ceschema.ce_Activity_FinSupport As FS
												WHERE     
													(FS.SupportTypeID = 3) AND 
													(FS.DeletedFlag = 'N') AND 
													(FS.ActivityID=A.ActivityID)
												)
										END
										)
									END),0),

						A.groupingid
					FROM ceschema.ce_Activity AS A
					INNER JOIN ceschema.ce_Sys_Grouping AS AT ON A.GroupingID=AT.GroupingID
					WHERE 
						(
							A.ActivityTypeID <> 2 AND
							A.StartDate BETWEEN @StartDate AND @EndDate AND
							A.DeletedFlag='N' AND
							A.StatusID IN (1,2,3) AND
							(SELECT Count(Activity_CreditID) FROM ceschema.ce_Activity_Credit AS ACr WHERE ACr.ActivityID=A.ActivityID AND ACr.CreditID=1 AND ACr.DeletedFlag='N') = 0
						)			
						OR
						(
							A.ActivityTypeID = 2 AND
							A.DeletedFlag='N' AND
							A.StartDate BETWEEN @StartDate AND @EndDate AND
							A.StatusID IN (1,2,3) AND
							(SELECT Count(Activity_CreditID) FROM ceschema.ce_Activity_Credit AS ACr WHERE ACr.ActivityID=A.ActivityID AND ACr.CreditID=1 AND ACr.DeletedFlag='N') = 0
						)
						
				)
				SELECT *,
				ParentFlag = 'Y',
				Oth.competenceDesign,
				Oth.performanceDesign,
				Oth.outcomesDesign,
				Oth.competenceEval,
				Oth.performanceEval,
				Oth.outcomesEval 
				FROM CTE_Activities
				LEFT OUTER JOIN
				ceschema.ce_Activity_Other As Oth ON Oth.activityId = CTE_Activities.activityid
				WHERE isNull(ParentActivityID,0) = 0 ORDER BY ActivityDate,ActivityTitle;
			</cfquery>
			
			<!--- MAX SUPPORTER STATS --->
			<cfquery name="qMaxSupport" dbtype="query">
				SELECT MAX(statSupporters) As MaxSupporters
				FROM qACCMEData
			</cfquery>
			
			<!--- Define NewQuery Variable and RowCount Variable --->
			<cfset qReport = QueryNew("
										ActivityID,
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
			<cfset baseColSpan = 35 />
			<!--- Fill NewQuery Variable --->
			<cfloop query="qACCMEData">  
				<!--- ACTIVITY TYPE ALIAS --->
				<cfset ActivityType = getTypeAlias(qACCMEData.ActivityTypeName)>
				                  
				<cfscript>
					queryAddRow(qReport);
					querySetCell(qReport,"ActivityID",qACCMEData.ActivityID);
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
			</cfloop>
			
			<cfswitch expression="#arguments.format#">
				<cfcase value="excel">
				<poi:document name="Request.ExcelData" file="#ReportPath##ReportFileName#" type="XSSF">
					<poi:classes>
						<poi:class name="title" style="color:white; font-size:10pt; vertical-align:top; font-weight:bold; text-align:center; background-color:##4f81bd; border-right:3px solid ##000000; border-bottom:3px solid ##000000;" />
					</poi:classes>
					
					<poi:classes>
						<poi:class name="row" style="font-size:10pt; border-right:2px solid black; border-bottom:2px solid black; background-color:##FFFFFF; font-weight:normal;" />
					</poi:classes>
					
					<poi:sheets>
						<poi:sheet name="#BookName#" orientation="landscape">
							<poi:columns>
								<poi:column style="width:85px;" />
								<poi:column style="width:95px;" />
								<poi:column style="width:95px;" />
								<poi:column style="width:355px;" /> <!--- TITLE --->
								<poi:column style="width:80px;" />
								<poi:column style="width:150px;" /> <!--- CITY --->
								<poi:column style="width:50px;" /> <!--- STATE --->
								<poi:column style="width:70px;" /> <!--- COUNTRY --->
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<poi:column style="width:100px;" />
								<cfset currColumn = 36 />
								<cfif isNumeric(qMaxSupport.MaxSupporters)>
								<cfloop from="1" to="#qMaxSupport.MaxSupporters#" index="i">
									<cfset intRankTxt = "(#IntegerRankFormat(i)#)" />
									<poi:column style="width:200px;" />
									<poi:column style="width:110px;" />
									<poi:column style="width:110px;" />
									<poi:column style="width:110px;" />
									<poi:column style="width:110px;" />
									<poi:column style="width:110px;" />
									<poi:column style="width:110px;" />
									<poi:column style="width:130px;" />
								</cfloop>
								</cfif>
							</poi:columns>
							
							<!--- 2011+ template
							1. Template (DO NOT ALTER OR DELETE THIS COLUMN)	
							2. ACCME Activity ID	
							3. Provider Activity ID	
							4. Reporting Year	
							5. Activity Title	
							6. Activity Date	
							7. City	
							8. State	
							9. Country	
							10. Sponsorship	
							11. Activity Type	
							12. Hours of Instruction	
							13. # of Physicians	
							14. # of non-Physicians	
							15. Commercial Support Received?	
							16. # of Commercial Supporters	
							"17. Total Monetary Amount Received (Activity)	
							18. In Kind Support Received - Durable equipment? (Activity)
							19. In Kind Support Received - Facilities / Space? (Activity)
							20. In Kind Support Received - Disposable supplies (Non-biological)? (Activity)
							21. In Kind Support Received - Animal parts or tissue? (Activity)
							22. In Kind Support Received - Human parts or tissue? (Activity)
							23. In Kind Support Received - Other? (Activity)"	
							24. Designed to change Competence?	
							25. Changes in Competence evaluated?	
							26. Designed to change Performance?	
							27. Changes in Performance evaluated?	
							28. Designed to change Patient Outcomes?	
							29. Changes in Patient Outcomes evaluated?	
							30. Sub-category: Case based discussion	
							31. Sub-category: Lecture	
							32. Sub-category: Panel	
							33. Sub-category: Simulation	
							34. Sub-category: Skill-based training	
							35. Sub-category: Small group discussion	
							36. Sub-category: Other	
							37. Joint Sponsor	
							38. Number of AMA PRA Category 1 CreditsTM Designated	
							39. Description of Content	
							40. Advertising & Exhibit Income (Activity)	
							41. Other Income (Activity)"	
							42. Expenses (Activity)
							43. Commercial Support Source	
							44. Monetary Amount Received (from Commercial Support)
							45. In Kind Support Received - Durable equipment?	
							46. In Kind Support Received - Facilities / Space?	
							47. In Kind Support Received - Disposable supplies (Non-biological)?	
							48. In Kind Support Received - Animal parts or tissue?	
							49. In Kind Support Received - Human parts or tissue?	
							50. In Kind Support Received - Other?
 							--->
							<!---
							
								1. Reporting Year
								2. Provider Activity ID	
								3. ACCME Activity ID	
								4. Activity Title	
								5. Activity Date
									
								6. City	
								7. State	
								8. Country	
								
								9. Sponsorship
								
								10. Activity Type
								11. Hours of Instruction	
								12. # of Physicians	
								13. # of non-Physicians
									
								14. Commercial Support Received?	
								15. Total Value of Commercial Support Received (Monetary or In-Kind)	
								16. # of Commercial Supporters	
								
								17. Designed to change Competence?	
								18. Changes in Competence evaluated?	
								19. Designed to change Performance?	
								20. Changes in Performance evaluated?	
								21. Designed to change Patient Outcomes?	
								22. Changes in Patient Outcomes evaluated?	
								
								23. Sub-category: Case based discussion	
								24. Sub-category: Lecture	
								25. Sub-category: Panel	
								26. Sub-category: Simulation	
								27. Sub-category: Skill-based training	
								28. Sub-category: Small group discussion	
								29. Sub-category: Other	
								
								30.  Joint Sponsor
								
								31. Number of AMA PRA Category 1 CreditsTM Designated	
								32. Description of Content	
								33. Advertising & Exhibit Income (Activity)	
								34. Other Income (Activity)"	"
								35. Expenses(Activity)"	
								
								36. Commercial Support Source
								37. Monetary Amount Received
								 (from Commercial Support)"	
								38. In Kind Support Received - Durable equipment?	
								39. In Kind Support Received - Facilities / Space?	
								40. In Kind Support Received - Disposable supplies (Non-biological)?	
								41. In Kind Support Received - Animal parts or tissue?	
								42. In Kind Support Received - Human parts or tissue?	
								43. In Kind Support Received - Other?
							--->
							<poi:row class="title">
								<poi:cell value="1. Template (DO NOT ALTER)" />
								<poi:cell value="2. ACCME Activity ID" />
								<poi:cell value="3. Provider Activity ID" />
								<poi:cell value="4. Reporting Year" />
								<poi:cell value="5. Activity Title" />
								<poi:cell value="6. Activity Date" />
									
								<poi:cell value="7. City" />
								<poi:cell value="8. State" />
								<poi:cell value="9. Country" />
								
								<poi:cell value="10. Sponsorship" />
								
								<poi:cell value="11. Activity Type" />
								<poi:cell value="12. Hours of Instruction" />
								<poi:cell value="13. ## of Physicians" />
								<poi:cell value="14. ## of non-Physicians" />
									
								<poi:cell value="15. Commercial Support Received?" />
								<poi:cell value="16. ## of Commercial Supporters" />
								<poi:cell value="17. Total Monetary Amount Received (Activity)" />
								
								<poi:cell value="18. In Kind Support Received - Durable equipment? (Activity)" />
								<poi:cell value="19. In Kind Support Received - Facilities / Space? (Activity)" />
								<poi:cell value="20. In Kind Support Received - Disposable supplies (Non-biological)? (Activity)" />	
								<poi:cell value="21. In Kind Support Received - Animal parts or tissue? (Activity)" />
								<poi:cell value="22. In Kind Support Received - Human parts or tissue? (Activity)" />
								<poi:cell value="23. In Kind Support Received - Other? (Activity)" />
								
								<poi:cell value="24. Designed to change Competence?" />
								<poi:cell value="25. Changes in Competence evaluated?" />
								<poi:cell value="26. Designed to change Performance?" />
								<poi:cell value="27. Changes in Performance evaluated?" />
								<poi:cell value="28. Designed to change Patient Outcomes?" />
								<poi:cell value="29. Changes in Patient Outcomes evaluated?" />
								
								<poi:cell value="30. Sub-category: Case based discussion" />
								<poi:cell value="31. Sub-category: Lecture" />
								<poi:cell value="32. Sub-category: Panel" />
								<poi:cell value="33. Sub-category: Simulation" />
								<poi:cell value="34. Sub-category: Skill-based training" />
								<poi:cell value="35. Sub-category: Small group discussion" />
								<poi:cell value="36. Sub-category: Other" />
								
								<poi:cell value="37.  Joint Sponsor" />
								
								<poi:cell value="38. Number of AMA PRA Category 1 CreditsTM Designated	" />
								<poi:cell value="39. Description of Content" />
								<poi:cell value="40. Advertising & Exhibit Income (Activity)" />
								<poi:cell value="41. Other Income (Activity)" />
								<poi:cell value="42. Expenses (Activity)" />
								
								<cfset currColumn = 42 />
								<cfif isNumeric(qMaxSupport.MaxSupporters)>
								<cfloop from="1" to="#qMaxSupport.MaxSupporters#" index="i">
									<cfif i GT 1>
										<cfset intRankTxt = "(#IntegerRankFormat(i)#)" />
									<cfelse>
										<cfset intRankTxt = "" />
									</cfif>
									<poi:cell value="#currColumn++#. Commercial Support Source #intRankTxt#" />
									<poi:cell value="#currColumn++#. Monetary Amount Received (from Commercial Support) #intRankTxt#" />
									<poi:cell value="#currColumn++#. In Kind Support Received - Durable equipment? #intRankTxt#" />
									<poi:cell value="#currColumn++#. In Kind Support Received - Facilities / Space? #intRankTxt#" />
									<poi:cell value="#currColumn++#. In Kind Support Received - Disposable supplies (Non-biological)? #intRankTxt#" />	
									<poi:cell value="#currColumn++#. In Kind Support Received - Animal parts or tissue? #intRankTxt#" />
									<poi:cell value="#currColumn++#. In Kind Support Received - Human parts or tissue? #intRankTxt#" />
									<poi:cell value="#currColumn++#. In Kind Support Received - Other? #intRankTxt#" />
								</cfloop>
								</cfif>
							</poi:row>
	
							<cfloop query="qReport">
								<!--- final array --->
								<cfset supporters = [] />
								
								<cfif qReport.StatSupporters GT 0>
									<cfquery name="qSupportList" datasource="#Application.Settings.DSN#">
										DECLARE @activityId int;
										DECLARE @startDate datetime;
										DECLARE @endDate datetime;
										DECLARE @reportYear nchar(4);
										
										SET @activityId = <cfqueryparam value="#qReport.ActivityID#" cfsqltype="cf_sql_integer" />;
										SET @startDate = #CreateODBCDateTime("#DateFormat(Arguments.StartDate,'mm/dd/yyyy')# 00:00:00")#;
										SET @endDate = #CreateODBCDateTime("#DateFormat(Arguments.EndDate,'mm/dd/yyyy')# 23:59:59")#;
										SET @reportYear = '#year(arguments.startDate)#'
										
										SELECT 
											supportSource = supporter.Name,
											monetaryAmount = sum(support.Amount),
											inKindDurable = 'No',
											inKindSpace = 'No',
											inKindDispose = 'No',
											inKindAnimal = 'No',
											inKindHuman = 'No',
											inKindOther = 'No'
										FROM
											ceschema.ce_Activity_FinSupport AS support 
										INNER JOIN 
											ceschema.ce_activity AS activity ON activity.activityid = support.activityid
										LEFT OUTER JOIN
											ceschema.ce_Sys_SupportType AS suppType ON support.SupportTypeID = suppType.ContribTypeID 
										LEFT OUTER JOIN
											ceschema.ce_Sys_Supporter AS supporter ON support.SupporterID = supporter.ContributorID
										WHERE
											(
												/* ENDURING */
													/* MULTI SESSION */
													(activity.sessiontype = 'M') AND
													(activity.statusId IN (1,2,3)) AND
													(support.SupportTypeID = 1) AND
													(activity.activitytypeid = 2) AND
													(activity.parentactivityid=@activityId) AND 
													(activity.startDate BETWEEN @startDate AND @endDate) AND
													(support.deletedFlag='N') AND
													(Year(activity.StartDate) = @ReportYear)
												OR
													/* SINGLE SESSION */
													(activity.sessiontype = 'S') AND
													(activity.statusId IN (1,2,3)) AND
													(activity.activitytypeid = 2) AND
													(support.SupportTypeID = 1) AND
													(activity.activityid=@activityId) AND 
													(activity.startDate BETWEEN @startDate AND @endDate) AND
													(support.deletedFlag='N') AND
													(Year(activity.StartDate) = @ReportYear)
											)
											
											OR
											
											(
												/* NON-ENDURING */
													/* MULTI SESSION */
													(activity.sessiontype = 'M') AND
													(activity.statusId IN (1,2,3)) AND
													(activity.activitytypeid <> 2) AND
													(support.SupportTypeID = 1) AND
													(activity.parentactivityid=@activityId) AND 
													(activity.startDate BETWEEN @startDate AND @endDate) AND
													(support.deletedFlag='N')
												OR
													/* SINGLE SESSION */
													(activity.sessiontype = 'S') AND
													(activity.statusId IN (1,2,3)) AND
													(activity.activitytypeid <> 2) AND
													(support.SupportTypeID = 1) AND
													(activity.activityid=@activityId) AND 
													(activity.startDate BETWEEN @startDate AND @endDate) AND
													(support.deletedFlag='N')
											)
										GROUP BY supporter.name
									</cfquery>
									
									<cfloop from="1" to="#qMaxSupport.MaxSupporters#" index="i">
										<cfif i LTE qSupportList.RecordCount>
											<cfset suppItem = structNew() />
											
											<cfset  suppItem['supportSource'] = qSupportList['supportSource'][i] />
											<cfset  suppItem['monetaryAmount'] = qSupportList['monetaryAmount'][i] />
											<cfset  suppItem['inKindDurable'] = qSupportList['inKindDurable'][i] />
											<cfset  suppItem['inKindSpace'] = qSupportList['inKindSpace'][i] />
											<cfset  suppItem['inKindDispose'] = qSupportList['inKindDispose'][i] />
											<cfset  suppItem['inKindAnimal'] = qSupportList['inKindAnimal'][i] />
											<cfset  suppItem['inKindHuman'] = qSupportList['inKindHuman'][i] />
											<cfset  suppItem['inKindOther'] = qSupportList['inKindOther'][i] />
											
											<cfset arrayAppend(supporters,suppItem) />
										<cfelse>
											<cfset suppItem = structNew() />
											
											<cfset  suppItem['supportSource'] = "" />
											<cfset  suppItem['monetaryAmount'] = "" />
											<cfset  suppItem['inKindDurable'] = "" />
											<cfset  suppItem['inKindSpace'] = "" />
											<cfset  suppItem['inKindDispose'] = "" />
											<cfset  suppItem['inKindAnimal'] = "" />
											<cfset  suppItem['inKindHuman'] = "" />
											<cfset  suppItem['inKindOther'] = "" />
											
											<cfset arrayAppend(supporters,suppItem) />
										</cfif>
									</cfloop>
								<cfelse>
									<cfloop from="1" to="#qMaxSupport.MaxSupporters#" index="i">
										<cfset suppItem = structNew() />
										
										<cfset  suppItem['supportSource'] = "" />
										<cfset  suppItem['monetaryAmount'] = "" />
										<cfset  suppItem['inKindDurable'] = "" />
										<cfset  suppItem['inKindSpace'] = "" />
										<cfset  suppItem['inKindDispose'] = "" />
										<cfset  suppItem['inKindAnimal'] = "" />
										<cfset  suppItem['inKindHuman'] = "" />
										<cfset  suppItem['inKindOther'] = "" />
										
										<cfset arrayAppend(supporters,suppItem) />
									</cfloop>
								</cfif>
								
								<cfset activityInKind = {} />
								
								<cfset  activityInKind['inKindDurable'] = 0 />
								<cfset  activityInKind['inKindSpace'] = 0 />
								<cfset  activityInKind['inKindDispose'] = 0 />
								<cfset  activityInKind['inKindAnimal'] = 0 />
								<cfset  activityInKind['inKindHuman'] = 0 />
								<cfset  activityInKind['inKindOther'] = 0 />
								
								<cfloop from="1" to="#arrayLen(supporters)#" index="e">
									<cfset supporter = supporters[e] />
									
									<cfloop list="#structKeyList(supporter)#" index="key">
										<cfif key CONTAINS "inKind">
											<cfif supporter[key] EQ "Yes">
												<cfset activityInKind[key]++ />
											</cfif>
										</cfif>
									</cfloop>
								</cfloop>

							<poi:row class="row">
								<poi:cell value="Template B" />
								<poi:cell value="" />
								<poi:cell value="#qReport.ActivityID#" type="numeric" numberformat="0" />
								<poi:cell value="#arguments.reportYear#" type="numeric" numberformat="0" />
								<poi:cell value="#Replace(Replace(qReport.ActivityTitle,chr(10),'','ALL'),chr(13),'','ALL')#" />
								<poi:cell value="#DateFormat(qReport.ActivityDate,'mm/dd/yyyy')#" type="date" dateformat="m/d/yy" />
								
								<cfif qReport.ActivityTypeName EQ "C" OR qReport.ActivityTypeName EQ "RSS">
									<poi:cell value="#qReport.City#" />
									<poi:cell value="#qReport.State#" />
									<poi:cell value="#qReport.Country#" />
								<cfelse>
									<poi:cell value="" />
									<poi:cell value="" />
									<poi:cell value="" />
								</cfif>
								
								<poi:cell value="#qReport.Sponsorship#" />
								
								<poi:cell value="#qReport.ActivityTypeName#" />
								<poi:cell value="#qReport.CMEHrs#" type="numeric" numberformat="0.00" />
								<poi:cell value="#qReport.StatMD#" type="numeric" numberformat="0" />
								<poi:cell value="#qReport.StatNonMD#" type="numeric" numberformat="0" />
								
								<cfif qReport.StatSupporters>
									<poi:cell value="#qReport.SupportReceived#" />
									<poi:cell value="#qReport.StatSupporters#" type="numeric" numberformat="0" />
									<poi:cell value="#qReport.StatSuppAmount#" type="numeric" numberformat="0.00" />
								<cfelse>
									<poi:cell value="No" />
									<poi:cell value="" />
									<poi:cell value="" />
								</cfif>
								<cfset  activityInKind['inKindDurable'] = 0 />
								<cfset  activityInKind['inKindSpace'] = 0 />
								<cfset  activityInKind['inKindDispose'] = 0 />
								<cfset  activityInKind['inKindAnimal'] = 0 />
								<cfset  activityInKind['inKindHuman'] = 0 />
								<cfset  activityInKind['inKindOther'] = 0 />
								
								<!--- IN KIND (Activity) --->
								<cfloop list="#structKeylist(activityInKind)#" index="key">
									<cfset inKindObj = activityInKind[key] />
									<cfif inKindObj GT 0>
									<poi:cell value="Yes" />
									<cfelse>
									<poi:cell value="No" />
									</cfif>
								</cfloop>
								
								<!--- DESIGNED TO: QUESTIONS --->
								<poi:cell value="#YesNoFormat(qReport.compDesign)#" />
								<poi:cell value="#YesNoFormat(qReport.compEval)#" />
								<poi:cell value="#YesNoFormat(qReport.perfDesign)#" />
								<poi:cell value="#YesNoFormat(qReport.perfEval)#" />
								<poi:cell value="#YesNoFormat(qReport.outDesign)#" />
								<poi:cell value="#YesNoFormat(qReport.outEval)#" />
								
								<!--- SUB CATEGORIES --->
								<poi:cell value="No" />	
								<poi:cell value="No" />
								<poi:cell value="No" />
								<poi:cell value="No" />
								<poi:cell value="No" />
								<poi:cell value="No" />
								<poi:cell value="" />	
								
								<!--- JOINT SPONSOR --->
								<cfif qReport.Sponsorship EQ "Joint">
									<poi:cell value="#qReport.Sponsor#" />
								<cfelse>
									<poi:cell value="" />
								</cfif>
								
								<poi:cell value="#qReport.CMEHrs#" type="numeric" numberformat="0.00" />
								<poi:cell value="" />
								
								<!--- INCOME / EXPENSES --->
								<cfif qReport.TotalExhibit>
									<poi:cell value="#qReport.TotalExhibit#" type="numeric" numberformat="0.00" />
								<cfelse>
									<poi:cell value="" />
								</cfif>
								<cfif qReport.TotalRegistration>
									<poi:cell value="#qReport.TotalRegistration#" type="numeric" numberformat="0.00" />
								<cfelse>
									<poi:cell value="" />
								</cfif>
								<poi:cell value="" />
								
								<cfif qMaxSupport.MaxSupporters GT 0>
								<cfloop from="1" to="#arrayLen(supporters)#" index="i">
									<poi:cell value="#supporters[i].supportSource#" />
									<poi:cell value="#supporters[i].monetaryAmount#" type="numeric" numberformat="0.00" />
									<poi:cell value="#supporters[i].inKindDurable#" />
									<poi:cell value="#supporters[i].inKindSpace#" />
									<poi:cell value="#supporters[i].inKindDispose#" />
									<poi:cell value="#supporters[i].inKindAnimal#" />
									<poi:cell value="#supporters[i].inKindHuman#" />
									<poi:cell value="#supporters[i].inKindOther#" style="border-right:3px solid black;" />
								</cfloop>
								<cfelse>
									<poi:cell value="" />
									<poi:cell value="" />
									<poi:cell value="" />
									<poi:cell value="" />
									<poi:cell value="" />
									<poi:cell value="" />
									<poi:cell value="" />
									<poi:cell value="" style="border-right:3px solid black;" />
								</cfif>
							</poi:row>
							</cfloop>
						</poi:sheet>
					</poi:sheets>
				</poi:document>
				</cfcase>
				<cfcase value="tabbed">
					<cfloop query="qReport">
						<!--- final array --->
						<cfset supporters = [] />
						
						<cfif qReport.StatSupporters GT 0>
							<cfquery name="qSupportList" datasource="#Application.Settings.DSN#">
								DECLARE @activityId int;
								DECLARE @startDate datetime;
								DECLARE @endDate datetime;
								
								SET @activityId = <cfqueryparam value="#qReport.ActivityID#" cfsqltype="cf_sql_integer" />;
								SET @startDate = #CreateODBCDateTime("#DateFormat(Arguments.StartDate,'mm/dd/yyyy')# 00:00:00")#;
								SET @endDate = #CreateODBCDateTime("#DateFormat(Arguments.EndDate,'mm/dd/yyyy')# 23:59:59")#;
								
								SELECT 
									supportSource = supporter.Name,
									monetaryAmount = sum(support.Amount),
									inKindDurable = 'No',
									inKindSpace = 'No',
									inKindDispose = 'No',
									inKindAnimal = 'No',
									inKindHuman = 'No',
									inKindOther = 'No'
								FROM
									ceschema.ce_Activity_FinSupport AS support 
								INNER JOIN 
									ceschema.ce_activity AS activity ON activity.activityid = support.activityid
								LEFT OUTER JOIN
									ceschema.ce_Sys_SupportType AS suppType ON support.SupportTypeID = suppType.ContribTypeID 
								LEFT OUTER JOIN
									ceschema.ce_Sys_Supporter AS supporter ON support.SupporterID = supporter.ContributorID
								WHERE
									/* MULTI SESSION */
									/* START DATE */
									(activity.sessiontype = 'M') AND
									(activity.statusId IN (1,2,3)) AND
									(support.SupportTypeID = 1) AND
									(activity.parentactivityid=@activityId) AND 
									(activity.startDate BETWEEN @startDate AND @endDate)
										OR
									/* END DATE */
									(activity.sessiontype = 'M') AND
									(activity.statusId IN (1,2,3)) AND
									(support.SupportTypeID = 1) AND
									(activity.parentactivityid=@activityId) AND 
									(activity.endDate BETWEEN @startDate AND @endDate)
								OR
									/* SINGLE SESSION */
									/* START DATE */
									(activity.sessiontype = 'S') AND
									(activity.statusId IN (1,2,3)) AND
									(support.SupportTypeID = 1) AND
									(activity.activityid=@activityId) AND 
									(activity.startDate BETWEEN @startDate AND @endDate)
										OR
									/* END DATE */
									(activity.sessiontype = 'S') AND
									(activity.statusId IN (1,2,3)) AND
									(support.SupportTypeID = 1) AND
									(activity.activityid=@activityId) AND 
									(activity.endDate BETWEEN @startDate AND @endDate)
								GROUP BY supporter.name
							</cfquery>
							
							<cfloop from="1" to="#qMaxSupport.MaxSupporters#" index="i">
								<cfif i LTE qSupportList.RecordCount>
									<cfset suppItem = structNew() />
									
									<cfset  suppItem['supportSource'] = qSupportList['supportSource'][i] />
									<cfset  suppItem['monetaryAmount'] = qSupportList['monetaryAmount'][i] />
									<cfset  suppItem['inKindDurable'] = qSupportList['inKindDurable'][i] />
									<cfset  suppItem['inKindSpace'] = qSupportList['inKindSpace'][i] />
									<cfset  suppItem['inKindDispose'] = qSupportList['inKindDispose'][i] />
									<cfset  suppItem['inKindAnimal'] = qSupportList['inKindAnimal'][i] />
									<cfset  suppItem['inKindHuman'] = qSupportList['inKindHuman'][i] />
									<cfset  suppItem['inKindOther'] = qSupportList['inKindOther'][i] />
									
									<cfset arrayAppend(supporters,suppItem) />
								<cfelse>
									<cfset suppItem = structNew() />
									
									<cfset  suppItem['supportSource'] = "" />
									<cfset  suppItem['monetaryAmount'] = "" />
									<cfset  suppItem['inKindDurable'] = "" />
									<cfset  suppItem['inKindSpace'] = "" />
									<cfset  suppItem['inKindDispose'] = "" />
									<cfset  suppItem['inKindAnimal'] = "" />
									<cfset  suppItem['inKindHuman'] = "" />
									<cfset  suppItem['inKindOther'] = "" />
									
									<cfset arrayAppend(supporters,suppItem) />
								</cfif>
							</cfloop>
						<cfelse>
							<cfloop from="1" to="#qMaxSupport.MaxSupporters#" index="i">
								<cfset suppItem = structNew() />
								
								<cfset  suppItem['supportSource'] = "" />
								<cfset  suppItem['monetaryAmount'] = "" />
								<cfset  suppItem['inKindDurable'] = "" />
								<cfset  suppItem['inKindSpace'] = "" />
								<cfset  suppItem['inKindDispose'] = "" />
								<cfset  suppItem['inKindAnimal'] = "" />
								<cfset  suppItem['inKindHuman'] = "" />
								<cfset  suppItem['inKindOther'] = "" />
								
								<cfset arrayAppend(supporters,suppItem) />
							</cfloop>
						</cfif>
						
						<cfset tabRow = "2010" & Delimiter &
										"#qReport.ActivityID#" & Delimiter &
										"" & Delimiter &
										"#Replace(Replace(qReport.ActivityTitle,chr(10),'','ALL'),chr(13),'','ALL')#" & Delimiter &
										"#DateFormat(qReport.ActivityDate,'mm/dd/yyyy')#" & Delimiter />
					
					<!--- ADD LOCATION or NOT --->
					<cfif qReport.ActivityTypeName EQ "C" OR qReport.ActivityTypeName EQ "RSS">
						<cfset tabRow = tabRow &
										"#qReport.City#" & Delimiter &
										"#qReport.State#" & Delimiter &
										"#qReport.Country#" & Delimiter />
					<cfelse>
						<cfset tabRow = tabRow &
									"" & Delimiter &
									"" & Delimiter &
									"" & Delimiter />
					</cfif>
					
					
						<cfset tabRow = tabRow &
									"#qReport.Sponsorship#" & Delimiter &
									"#qReport.ActivityTypeName#" & Delimiter &
									"#numberFormat(qReport.CMEHrs,'00.00')#" & Delimiter &
									"#qReport.StatMD#" & Delimiter &
									"#qReport.StatNonMD#" & Delimiter />
						
						<!--- COMMERCIAL SUPPORT --->
					<cfif qReport.StatSupporters>
						<cfset tabRow = tabRow &
									"#qReport.SupportReceived#" & Delimiter &
									"#numberFormat(qReport.StatSuppAmount,'00.00')#" & Delimiter &
									"#qReport.StatSupporters#" & Delimiter />
					<cfelse>
						<cfset tabRow = tabRow &
									"No" & Delimiter &
									"" & Delimiter &
									"" & Delimiter />
					</cfif>
						<!--- DESIGNED TO: QUESTIONS --->
						<cfset tabRow = tabRow &
									"No" & Delimiter &
									"No" & Delimiter &
									"No" & Delimiter &
									"No" & Delimiter &
									"No" & Delimiter &
									"No" & Delimiter />
						
						<!--- CATEGORIES --->
						<cfset tabRow = tabRow &
									"No" & Delimiter &
									"No" & Delimiter &
									"No" & Delimiter &
									"No" & Delimiter &
									"No" & Delimiter &
									"No" & Delimiter &
									"" & Delimiter />
						
						<!--- JOINT SPONSOR --->
					<cfif qReport.Sponsorship EQ "Joint">
						<cfset tabRow = tabRow &
									"#qReport.Sponsor#" & Delimiter />
					<cfelse>
						<cfset tabRow = tabRow &
									"" & Delimiter />
					</cfif>
					
						<!--- TOTAL DESIGNATED CONTACT HOURS --->
						<cfset tabRow = tabRow &
									"#numberFormat(qReport.CMEHrs,'00.00')#" & Delimiter />
						
						<!--- CONTENT DESCRIPTION --->
						<cfset tabRow = tabRow &
									"" & Delimiter />
						
						<!--- INCOME / EXPENSES --->
						<cfset tabRow = tabRow &
									"" & Delimiter &
									"" & Delimiter &
									"" & Delimiter />
						
						<!--- COMM SUPPORT DETAIL LIST --->
					<cfif qMaxSupport.MaxSupporters GT 0>
					<cfloop from="1" to="#arrayLen(supporters)#" index="i">
						<cfset tabRow = tabRow &
									"#supporters[i].supportSource#" & Delimiter &
									"#supporters[i].monetaryAmount#" & Delimiter &
									"#supporters[i].inKindDurable#" & Delimiter &
									"#supporters[i].inKindSpace#" & Delimiter &
									"#supporters[i].inKindDispose#" & Delimiter &
									"#supporters[i].inKindAnimal#" & Delimiter &
									"#supporters[i].inKindHuman#" & Delimiter &
									"#supporters[i].inKindOther#" />
						
						<cfif i NEQ arrayLen(supporters)>
							<cfset tabRow = tabRow & Delimiter />
						</cfif>
					</cfloop>
					<cfelse>
						<cfset tabRow = tabRow &
								"" & Delimiter &
								"" & Delimiter &
								"" & Delimiter &
								"" & Delimiter &
								"" & Delimiter &
								"" & Delimiter &
								"" & Delimiter &
								"" />
						
						<cfif i NEQ arrayLen(supporters)>
							<cfset tabRow = tabRow & Delimiter />
						</cfif>
					</cfif>
						<cfset FileOutput = FileOutput & tabRow & NewLine>
					</cfloop>
					
					<cffile action="write" file="#ReportPath##ReportFileName#" output="#FileOutput#" addnewline="no" />
					
					<cfheader name="Content-Type" value="text/plain">
					<cfheader name="Content-Disposition" value="attachment; filename=#ReportFileName#">
					<cfcontent type="text/plain" file="#ReportPath##ReportFileName#" deletefile="No">
				</cfcase>
			</cfswitch>
			
		</cfif>
		
	</cffunction>
	<cfscript>
/**
* Turn 1 into 1st, 2 into 2nd, etc.
* 
* @param num      Number to format. (Required)
* @return Returns a string. 
* @author Nathan Dintenfass (&#110;&#97;&#116;&#104;&#97;&#110;&#64;&#99;&#104;&#97;&#110;&#103;&#101;&#109;&#101;&#100;&#105;&#97;&#46;&#99;&#111;&#109;)
* @version 1, December 23, 2002 
*/
function IntegerRankFormat(number){
    //grab the last digit
    var lastDigit = right(number,1);
    //grab the last two digits
    var lastTwoDigits = right(number,2);
    //use numberFormat() to put in commas for number larger than 999
    number = numberFormat(number);
    //11, 12, and 13 are special cases, so deal with them
    switch(lastTwoDigits){
        case 11:{
            return number & "th";
        }
        case 12:{
            return number & "th";
        }
        case 13:{
            return number & "th";
        }
    }
    //append the correct suffix based on the last number
    switch(lastDigit){
        case 1:{
            return number & "st";
        }
        case 2:{
            return number & "nd";
        }
        case 3:{
            return number & "rd";
        }
        default:{
            return number & "th";
        }
    }
}
</cfscript>
	<cffunction name="getTypeAlias" access="private">
		<cfargument name="TypeName" type="string" required="yes">
		
		<cfset var ActivityTypeAlias = Arguments.TypeName>
		
		<cfswitch expression="#Arguments.TypeName#">
			<cfcase value="Internet Activity Enduring Material">
				<cfset ActivityTypeAlias = "IEM">
			</cfcase>
			<cfcase value="Course">
				<cfset ActivityTypeAlias = "C">
			</cfcase>
			<cfcase value="Regularly Scheduled Series">
				<cfset ActivityTypeAlias = "RSS">
			</cfcase>
			<cfcase value="Print">
				<cfset ActivityTypeAlias = "EM">
			</cfcase>
			<cfcase value="Internet Live Course">
				<cfset ActivityTypeAlias = "IL">
			</cfcase>
		</cfswitch>
		
		<cfreturn ActivityTypeAlias />
	</cffunction>
</cfcomponent>