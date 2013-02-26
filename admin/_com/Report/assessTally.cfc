<cfcomponent displayname="Activities by Categories" output="no">
	<cfimport taglib="/_poi/" prefix="poi" />
	
	<!--- CONFIGURATION --->
	<cfset ReportPath = ExpandPath("#Application.Settings.RootPath#/_reports/27/")>
	<cfset ReportFileName = "assessTally-#DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#.xls">
	<cfset ColumnCount = 3>
	<cfset Title = "Assessment Tally">
	<cfset BookName = "Questions">
	
	<cfif NOT DirectoryExists("#ReportPath#")><cfdirectory action="Create" directory="#ReportPath#"></cfif>
	
	<!--- RUN METHOD --->
	<cffunction name="Run" access="remote" output="yes">
		<cfargument name="assessmentid" type="numeric" required="no" default="0" />
		<cfargument name="startDate" type="string" required="no" default="" />
		<cfargument name="endDate" type="string" required="no" default="" />
		<cfquery name="ReportData" datasource="#Application.Settings.DSN#">
			WITH CTE_Totals AS (
			SELECT  
				AQ.QuestionID,
				vc1Count = COUNT((CASE 
					WHEN AA.VC1=AQ.VC1 THEN AQ.VC1
				END
				)),
				vc2Count = COUNT((CASE
					WHEN AA.VC1=AQ.VC2 THEN AQ.VC2
				END)),
				vc3Count = COUNT((CASE
					WHEN AA.VC1=AQ.VC3 THEN AQ.VC3
				END)),
				vc4Count = COUNT((CASE
					WHEN AA.VC1=AQ.VC4 THEN AQ.VC4
				END)),
				vc5Count = COUNT((CASE
					WHEN AA.VC1=AQ.VC5 THEN AQ.VC5
				END)),
				vc6Count = COUNT((CASE
					WHEN AA.VC1=AQ.VC6 THEN AQ.VC6
				END)),
				vc7Count = COUNT((CASE
					WHEN AA.VC1=AQ.VC7 THEN AQ.VC7
				END)),
				vc8Count = COUNT((CASE
					WHEN AA.VC1=AQ.VC8 THEN AQ.VC8
				END)),
				vc9Count = COUNT((CASE
					WHEN AA.VC1=AQ.VC9 THEN AQ.VC9
				END)),
				vc10Count = COUNT((CASE
					WHEN AA.VC1=AQ.VC10 THEN AQ.VC10
				END))
			FROM         
				ce_AssessQuestion AS AQ 
			INNER JOIN
				ce_AssessAnswer AS AA ON AQ.QuestionID = AA.QuestionID 
			INNER JOIN
				ce_Assessment AS Ass ON AQ.AssessmentID = Ass.AssessmentID
			WHERE 
				AQ.DeletedFlag='N' AND 
				AA.DeletedFlag='N' AND 
				Ass.DeletedFlag='N'
				<cfif structKeyExists(arguments,"assessmentid") AND isNumeric(arguments.assessmentid) AND arguments.assessmentid GT 0>
				AND Ass.assessmentid = <cfqueryparam value="#arguments.assessmentid#" cfsqltype="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"activityid") AND isNumeric(arguments.activityid)>
				AND Ass.ActivityID = <cfqueryparam value="#arguments.activityid#" cfsqltype="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"assesstype") AND len(arguments.assesstype) GT 0>
				AND Ass.AssessTypeID = <cfqueryparam value="#arguments.assesstype#" cfsqltype="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"startDate") AND len(arguments.startDate) GT 0 AND structKeyExists(arguments,"endDate") AND len(arguments.endDate) GT 0>
				AND AA.Created BETWEEN <cfqueryparam value="#arguments.startDate# 00:00:00" cfsqltype="cf_sql_varchar" /> AND <cfqueryparam value="#arguments.EndDate# 23:59:59" cfsqltype="cf_sql_varchar" />
				</cfif>
			GROUP BY AQ.QuestionID
			) 
			SELECT 
				A.AssessmentID,
				Assessment = A.Name,
				AssessType = AT.Name,
				Question = Q.LabelText,
				Q.QuestionTypeID,
				totalCount = (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count),
				vc1Label = Q.vc1,
				vc1Count,
				vc2Label = Q.vc2,
				vc2Count,
				vc3Label = Q.vc3,
				vc3Count,
				vc4Label = Q.vc4,
				vc4Count,
				vc5Label = Q.vc5,
				vc5Count,
				vc6Label = Q.vc6,
				vc6Count,
				vc7Label = Q.vc7,
				vc7Count,
				vc8Label = Q.vc8,
				vc8Count,
				vc9Label = Q.vc9,
				vc9Count,
				vc10Label = Q.vc10,
				vc10Count,
				vc1Perc = 
				CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc1Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100)
				END,
				vc2Perc = CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc2Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100)
					END,
				vc3Perc = CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc3Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100)
					END,
				vc4Perc = CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc4Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100)  
					END,
				vc5Perc = CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc5Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
					END,
				vc6Perc = CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc6Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
					END ,
				vc7Perc = CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc7Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
					
					END,
				vc8Perc = CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc8Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
					END,
				vc9Perc = CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc9Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
					END,
				vc10Perc = CASE
					WHEN (vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count) = 0 THEN 0.0
					ELSE (convert(numeric(5,2),vc10Count) / convert(numeric(5,2),(vc1Count+vc2Count+vc3Count+vc4Count+vc5Count+vc6Count+vc7Count+vc8Count+vc9Count+vc10Count))*100) 
					
					END
			FROM CTE_Totals As T 
			INNER JOIN ce_AssessQuestion As Q ON Q.QuestionID=T.QuestionID
			INNER JOIN ce_Assessment As A ON Q.AssessmentID = A.AssessmentID
			INNER JOIN ce_Sys_AssessType As AT ON A.AssessTypeID = AT.AssessTypeID
			ORDER BY Q.Sort
		</cfquery>
		
		<cfquery name="Sheets" dbtype="query">
		SELECT
			DISTINCT
			AssessmentID,
			Assessment,
			AssessType
		FROM  ReportData
		ORDER BY AssessType,Assessment
		</cfquery>
        
		<poi:document name="Request.ExcelData" file="#ReportPath##ReportFileName#">
			<poi:classes>
				<poi:class name="title" style="font-family: arial; vertical-align:middle; color: ##000; font-size:12pt; height:28px; font-weight:bold;  background-color: PALE_BLUE; border-top: 3px BLACK; border-bottom:3px BLACK; border-left: 2px BLACK; border-right:2px BLACK;" />
				<poi:class name="headers" style="font-family: arial ; color: WHITE; padding:3px; background-color:BLACK;  font-size: 10pt; font-weight: bold; border: 5px BLACK;" />
				<poi:class name="question" style="font-family: arial ; color: ##000 ;  font-size: 10pt; font-weight:bold;" />
				<poi:class name="caption1" style="font-family: arial ; color: ##000 ;  font-size: 14pt; font-weight:bold;" />
				<poi:class name="caption2" style="font-family: arial ; color: ##000 ;  font-size: 12pt; font-weight:bold;" />
				<poi:class name="caption3" style="font-family: arial ; color: ##000 ;  font-size: 10pt; font-weight:bold;" />
			</poi:classes>
			
			<poi:sheets>
				<cfloop query="Sheets">
					<cfset SheetName = Application.UDF.StripAllBut(Left(Sheets.AssessType,4),'abcdefghijklmnopqrstuvwxyz0123456789 &_-',false)>
					<cfif SheetName EQ "">
						<cfset SheetName = "Unknown">
					</cfif>
					<cfquery name="ReportDataSub" dbtype="query">
						SELECT * FROM ReportData
						WHERE AssessmentID = <cfqueryparam value="#Sheets.AssessmentID#" cfsqltype="cf_sql_integer" />
					</cfquery>
                    <poi:sheet name="#SheetName#" orientation="landscape">
                        <poi:columns>
                            <cfloop from="1" to="#ColumnCount#" index="i">
                            <poi:column style="width:150px;" />
                            </cfloop>
                        </poi:columns>
                        
                        <poi:row class="title">
							<cfif arguments.startdate NEQ "">
                            <poi:cell value="#Sheets.AssessType# ###Sheets.AssessmentID# // #DateFormat(Arguments.StartDate,'mm/dd/yyyy')# -to- #DateFormat(Arguments.EndDate,'mm/dd/yyyy')#" colspan="#ColumnCount#" />
                       		<cfelse>
							<poi:cell value="#Sheets.AssessType# ###Sheets.AssessmentID#" colspan="#ColumnCount#" />
							</cfif>
					    </poi:row>
                        
                        <poi:row class="headers">
                            <poi:cell value="Question / Caption" />
                            <poi:cell value="Option" />
                            <poi:cell value="Count / Percentage" />
                        </poi:row>
					<cfloop query="ReportDataSub">
						<cfswitch expression="#ReportDataSub.QuestionTypeID#">
							<cfcase value="5">
								<cfset className="caption1">
							</cfcase>
							<cfcase value="6">
								<cfset className="caption2">
							</cfcase>
							<cfcase value="7">
								<cfset className="caption3">
							</cfcase>
							<cfdefaultcase>
								<cfset className="question">
							</cfdefaultcase>
						</cfswitch>
						<poi:row class="#className#">
							<poi:cell value="#ReportDataSub.Question#" colspan="#columncount#" />
						</poi:row>
						
						<cfloop from="1" to="10" index="i">
							<cfset optionLabel = evaluate('ReportDataSub.vc#i#Label')>
							<cfset optionCount = evaluate('ReportDataSub.vc#i#Count')>
							<cfset optionPerc = evaluate('ReportDataSub.vc#i#Perc')>
							<cfif len(trim(optionLabel)) GT 0>
						<poi:row class="options">
							<poi:cell value="" />
							<poi:cell value="#optionLabel#" />
							<poi:cell value="#Round(optionPerc)#% (#optionCount#)" />
						</poi:row>
							</cfif>
						</cfloop>
                    </cfloop>
                    </poi:sheet>
				</cfloop>
			</poi:sheets>
		</poi:document>
		
		<cfheader name="Content-Type" value="application/msexcel">
		<cfheader name="Content-Disposition" value="attachment; filename=#ReportFileName#">
		<cfcontent type="application/msexcel" file="#ReportPath##ReportFileName#" deletefile="No">
	</cffunction>
</cfcomponent>