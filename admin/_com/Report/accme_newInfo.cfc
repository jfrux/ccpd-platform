<cfcomponent displayname="ACCME Preparation" output="no">
	<cfimport taglib="/_poi/" prefix="poi" />
	
	<!--- CONFIGURATION --->
	<cfset ReportPath = ExpandPath("#Application.Settings.RootPath#/_reports/22/")>
	<cfset ReportFileName = "accme_newInfo-#DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#-#Session.AccountID#.xlsx">
	<cfset ColumnCount = 3>
	<cfset Title = "ACCME Preparation">
	<cfset BookName = "ACCME Prep">
	
	<cfif NOT DirectoryExists("#ReportPath#")><cfdirectory action="Create" directory="#ReportPath#"></cfif>
	
	<!--- RUN METHOD --->
	<cffunction name="Run" access="remote" output="yes">
		<cfargument name="StartDate" required="true" type="string">
		<cfargument name="EndDate" required="true" type="string">
	
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
			<cfquery name="qACCMEData" datasource="#Application.Settings.DSN#">
				DECLARE @StartDate datetime;
				DECLARE @EndDate datetime;
				DECLARE @ReportYear nvarchar(4);
				
				SET @StartDate = '#DateFormat(Arguments.StartDate,'mm/dd/yyyy')# 00:00:00';
				SET @EndDate = '#DateFormat(Arguments.EndDate,'mm/dd/yyyy')# 23:59:59';
				SET @ReportYear = '#year(arguments.StartDate)#';
				
				WITH CTE_Activities ( ActivityID,ParentActivityID,ActivityTitle,ActivityTypeID,ActivityTypeName,ActivityLocation,City,State,Country,Sponsorship,Sponsor,CMEHrs,StatMD,StatNonMD,ReleaseDate,ActivityDate,EndDate,StatSupporters,SupportReceived,StatSuppAmount,TotalExhibit,TotalRegistration,groupingid)
				AS (
					SELECT 
						A.ActivityID,
						A.ParentActivityID,
						ActivityTitle = upper(A.Title),
						A.ActivityTypeID,
						ActivityTypeName = AT.Name,
						ActivityLocation = isNull(A.City,'') + ', ' + isNull((SELECT Code FROM ce_Sys_State WHERE StateID = A.State),''),
						A.City,
						State = isNull((SELECT Code FROM ce_Sys_State WHERE StateID = A.State),''),
						Country = isNull((SELECT   geonameCountry.ISO3 FROM ce_Sys_Country AS country INNER JOIN geonameCountryInfo AS geonameCountry ON country.code = geonameCountry.ISO WHERE country.id = A.Country),''),
						Sponsorship = (CASE A.Sponsorship
											WHEN 'J' THEN 'Joint'
											WHEN 'D' THEN 'Direct'
										END),
						Sponsor,
						CMEHrs = (CASE isNull(A.SessionType,'S')
									WHEN 'M' THEN 
										isNull((SELECT SUM(AC.Amount) AS TotalHours
												FROM ce_Activity_Credit AS AC 
												INNER JOIN ce_Activity AS A4 ON AC.ActivityID = A4.ActivityID
												WHERE (A4.DeletedFlag='N') AND (AC.CreditID = 1) AND (A4.ParentActivityID = a.ActivityID) AND (A4.StatusID IN (1,2,3)) AND (AC.DeletedFlag='N') AND (A4.StartDate BETWEEN @StartDate AND @EndDate)
												OR
												(A4.DeletedFlag='N') AND (AC.CreditID = 1) AND (A4.ParentActivityID = a.ActivityID) AND (A4.StatusID IN (1,2,3)) AND (AC.DeletedFlag='N') AND (A4.EndDate BETWEEN @StartDate AND @EndDate)),0)
									WHEN 'S' THEN 
										isNull((SELECT SUM(AC.Amount) AS TotalHours
												FROM ce_Activity_Credit AS AC 
												WHERE (AC.CreditID = 1) AND (AC.ActivityID = A.ActivityID) AND (AC.DeletedFlag='N')),0)
								END),
						StatMD = 
							isNull((CASE
								/* ENDURING MATERIALS */
								WHEN A.ActivityTypeID = 2 THEN 
									(SELECT Count(Att.AttendeeID)
									 FROM ce_Attendee AS Att 
									 INNER JOIN ce_Activity AS A2 ON Att.ActivityID = A2.ActivityID
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
											 ce_Activity AS A2
											 WHERE 
												(A2.DeletedFlag='N') AND (A2.ParentActivityID = A.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (A2.StartDate BETWEEN @StartDate AND @EndDate)
												OR
												(A2.DeletedFlag='N') AND (A2.ParentActivityID = A.ActivityID) AND (A2.StatusID IN (1,2,3)) AND (A2.EndDate BETWEEN @StartDate AND @EndDate)
											)
										WHEN 'S' THEN
											(SELECT Sum(A2.StatMD)
											FROM
											 ce_Activity AS A2
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
											ce_Attendee AS Att2 
										INNER JOIN 
											ce_Activity AS A3 ON Att2.ActivityID = A3.ActivityID
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
														ce_Activity AS A3
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
												ce_Activity_FinSupport AS FS 
											INNER JOIN
												ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
												ce_Activity_FinSupport AS FS 
											INNER JOIN
												ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
											ce_Activity_FinSupport As FS
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
											ce_Activity_FinSupport As FS
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
														ce_Activity_FinSupport AS FS 
													INNER JOIN
														ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
														ce_Activity_FinSupport AS FS 
													INNER JOIN
														ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
													ce_Activity_FinSupport As FS
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
													ce_Activity_FinSupport As FS
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
														ce_Activity_FinSupport AS FS 
													INNER JOIN
														ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
														ce_Activity_FinSupport AS FS 
													INNER JOIN
														ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
													ce_Activity_FinSupport As FS
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
													ce_Activity_FinSupport As FS
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
														ce_Activity_FinSupport AS FS 
													INNER JOIN
														ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
														ce_Activity_FinSupport AS FS 
													INNER JOIN
														ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
													ce_Activity_FinSupport As FS
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
													ce_Activity_FinSupport As FS
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
														ce_Activity_FinSupport AS FS 
													INNER JOIN
														ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
														ce_Activity_FinSupport AS FS 
													INNER JOIN
														ce_Activity AS A5 ON FS.ActivityID = A5.ActivityID
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
													ce_Activity_FinSupport As FS
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
													ce_Activity_FinSupport As FS
												WHERE     
													(FS.SupportTypeID = 3) AND 
													(FS.DeletedFlag = 'N') AND 
													(FS.ActivityID=A.ActivityID)
												)
										END
										)
									END),0),

						A.groupingid
					FROM ce_Activity AS A
					INNER JOIN ce_Sys_Grouping AS AT ON A.GroupingID=AT.GroupingID
					WHERE 
						(
						A.ActivityTypeID <> 2 AND
						A.StartDate BETWEEN @StartDate AND @EndDate AND
						A.DeletedFlag='N' AND
						A.StatusID IN (1,2,3)
						OR
						A.ActivityTypeID <> 2 AND
						A.EndDate BETWEEN @StartDate AND @EndDate AND
						A.DeletedFlag='N' AND
						A.StatusID IN (1,2,3)
						OR
						A.ActivityTypeID <> 2 AND
						A.DeletedFlag='N' AND
						A.StatusID IN (1,2,3) AND
						A.activityId IN (SELECT     actcat.ActivityID
											FROM         ce_Activity_Category AS actcat INNER JOIN
																  ce_Category AS cat ON actcat.CategoryID = cat.CategoryID
											WHERE     (cat.Name LIKE 'ACCME ' + @ReportYear) AND actcat.deletedFlag='N')
						)
					OR
						(A.ActivityTypeID = 2 AND
						A.DeletedFlag='N' AND
						A.StartDate BETWEEN @StartDate AND @EndDate AND
						A.StatusID IN (1,2,3)
						OR
						A.ActivityTypeID = 2 AND
						A.DeletedFlag='N' AND
						A.EndDate BETWEEN @StartDate AND @EndDate AND
						A.StatusID IN (1,2,3)
						OR
						A.ActivityTypeID = 2 AND
						A.DeletedFlag='N' AND
						A.StatusID IN (1,2,3) AND
						A.activityId IN (SELECT     actcat.ActivityID
											FROM         ce_Activity_Category AS actcat INNER JOIN
																  ce_Category AS cat ON actcat.CategoryID = cat.CategoryID
											WHERE     (cat.Name LIKE 'ACCME ' + @ReportYear) AND actcat.deletedFlag='N')
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
				ce_Activity_Other As Oth ON Oth.activityId = CTE_Activities.activityid
				WHERE isNull(ParentActivityID,0) = 0 ORDER BY ActivityDate,ActivityTitle;
			</cfquery>
			
			<cfset qReport = QueryNew("
								ActivityID,
								ParentFlag,
								ParentTitle,
								ActivityTitle,
								ActivityDate,
								ActivityLocation,
								Sponsorship,
								ActivityTypeName,
								CMEHrs,
								StatMD,
								StatNonMD,
								StatSupporters,
								SupportReceived,
								StatSuppAmount,
								GroupingName,
								compDesign,
								perfDesign,
								outcomesDesign,
								compEval,
								perfEval,
								outcomesEval",
								"
								cf_sql_integer,
								cf_sql_varchar,
								cf_sql_varchar,
								cf_sql_varchar,
								cf_sql_date,
								cf_sql_varchar,
								cf_sql_varchar,
								cf_sql_varchar,
								cf_sql_decimal,
								cf_sql_decimal,
								cf_sql_decimal,
								cf_sql_decimal,
								cf_sql_varchar,
								cf_sql_decimal,
								cf_sql_varchar,
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
					RowCount = IncrementValue(RowCount);
					
					querySetCell(qReport,"ActivityID",qACCMEData.ActivityID);
					querySetCell(qReport,"ParentFlag","Y");
					querySetCell(qReport,"ParentTitle","");
					querySetCell(qReport,"ActivityTitle",qACCMEData.ActivityTitle);
					querySetCell(qReport,"ActivityDate",qACCMEData.ActivityDate);
					querySetCell(qReport,"ActivityLocation",qACCMEData.ActivityLocation);
					querySetCell(qReport,"Sponsorship",qACCMEData.Sponsorship);
					querySetCell(qReport,"ActivityTypeName",ActivityType);
					querySetCell(qReport,"CMEHrs",qACCMEData.CMEHrs);
					querySetCell(qReport,"StatMD",qACCMEData.StatMD);
					querySetCell(qReport,"StatNonMD",qACCMEData.StatNonMD);
					querySetCell(qReport,"SupportReceived",qACCMEData.SupportReceived);
					querySetCell(qReport,"StatSuppAmount",qACCMEData.StatSuppAmount);
					querySetCell(qReport,"StatSupporters",qACCMEData.StatSupporters);
					querySetCell(qReport,"compDesign",qACCMEData.competenceDesign);
					querySetCell(qReport,"perfDesign",qACCMEData.performanceDesign);
					querySetCell(qReport,"outcomesDesign",qACCMEData.outcomesDesign);
					querySetCell(qReport,"compEval",qACCMEData.competenceEval);
					querySetCell(qReport,"perfEval",qACCMEData.performanceEval);
					querySetCell(qReport,"outcomesEval",qACCMEData.outcomesEval);
				</cfscript>
				
				
				<!---[#DateFormat(qACCMEData.ActivityDate,'mm-dd-yyyy')#] #qACCMEData.ActivityTitle#<br />--->
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
							<poi:column style="width:64px;" />
							<poi:column style="width:272px;" />
							<poi:column style="width:79px;" />
							<poi:column style="width:111px;" />
							<poi:column style="width:115px;" />
							<poi:column style="width:129px;" />
							<poi:column style="width:115px;" />
							<poi:column style="width:129px;" />
							<poi:column style="width:115px;" />
							<poi:column style="width:129px;" />
						</poi:columns>
						
						<poi:row class="title">
							<poi:cell value="Activity ID" />
							<poi:cell value="Activity Title" />
							<poi:cell value="Date" />
							<poi:cell value="Type of Activity" />
							<poi:cell value="Designed to Change Competence" />
							<poi:cell value="Designed to Change Permformance" />
							<poi:cell value="Designed to Change Patient Outcomes" />
							<poi:cell value="Changes in Competence Evaluated" />
							<poi:cell value="Changes in Permformance Evaluated" />
							<poi:cell value="Changes in Patient Outcomes Evaluated" />
						</poi:row>

						<cfloop query="qReport">
							<cfif qReport.ParentFlag EQ "Y"> 
								<cfset rowClass = "parent">
							<cfelse>
								<cfset rowClass = "child">
							</cfif>
						<poi:row class="#rowClass#">
							<poi:cell value="#qReport.ActivityId#" />
							<poi:cell value="#qReport.ActivityTitle#" />
							<poi:cell value="#DateFormat(qReport.ActivityDate,'M/D/YYYY')#" type="date" dateformat="m/d/yy" style="text-align:center;" />
							<poi:cell value="#qReport.ActivityTypeName#" style="text-align:center;" />
							<poi:cell value="#yesNoFormat(qReport.compDesign)#" />
							<poi:cell value="#yesNoFormat(qReport.perfDesign)#"  />
							<poi:cell value="#yesNoFormat(qReport.outcomesDesign)#" />
							<poi:cell value="#yesNoFormat(qReport.compEval)#"  />
							<poi:cell value="#yesNoFormat(qReport.perfEval)#" />
							<poi:cell value="#yesNoFormat(qReport.outcomesEval)#"  />
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