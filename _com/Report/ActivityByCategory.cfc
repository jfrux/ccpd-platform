<cfcomponent displayname="Activities by Categories" output="no">
	<cfimport taglib="/_poi/" prefix="poi" />
	
	<!--- CONFIGURATION --->
	<cfset ReportPath = ExpandPath("#Application.Settings.RootPath#/_reports/20/")>
	<cfset ReportFileName = "category-#DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#.xls">
	<cfset ColumnCount = 3>
	<cfset Title = "Activities by Categories">
	<cfset BookName = "Activities by Categories">
	
	<cfif NOT DirectoryExists("#ReportPath#")><cfdirectory action="Create" directory="#ReportPath#"></cfif>
	
	<!--- RUN METHOD --->
	<cffunction name="Run" access="remote" output="yes">
		<cfquery name="ReportData" datasource="#Application.Settings.DSN#">
			SELECT     A.ActivityID, A.Title, A.StartDate, A.EndDate, Sp.Name AS Category
			FROM         Activities_CategoryLMS AS S INNER JOIN
				  Activities AS A ON S.ActivityID = A.ActivityID INNER JOIN
				  sys_categorylms AS Sp ON S.CategoryID = Sp.CategoryID
			WHERE (A.DeletedFlag = 'N') AND (Sp.CategoryID IN (#Arguments.Categories#)) AND A.StartDate BETWEEN <cfqueryparam value="#Arguments.StartDate# 00:00:00" cfsqltype="cf_sql_varchar" /> AND <cfqueryparam value="#Arguments.EndDate# 23:59:59" cfsqltype="cf_sql_varchar" />
			ORDER BY A.StartDate
		</cfquery>
		
		<cfquery name="Sheets" dbtype="query">
		SELECT
			DISTINCT
			Category
		FROM  ReportData
		ORDER BY Category
		</cfquery>
		
		<poi:document name="Request.ExcelData" file="#ReportPath##ReportFileName#">
			<poi:classes>
				<poi:class name="title" style="font-family: arial; vertical-align:middle; color: ##000; height:45px; font-size:12pt; font-weight:bold;  background-color: PALE_BLUE; border-top: 3px BLACK; border-bottom:3px BLACK; border-left: 2px BLACK; border-right:2px BLACK;" />
				<poi:class name="headers" style="font-family: arial ; color: ##000; background-color:GREY_25_PERCENT;  font-size: 10pt; font-weight: bold; border-top: 3px BLACK; border-bottom:3px BLACK; border-left: 2px BLACK; border-right:2px BLACK;" />
				<poi:class name="data" style="font-family: arial ; color: ##000 ;  font-size: 10pt; border-bottom:2px GREY_50_PERCENT;" />
			</poi:classes>
			
			<poi:sheets>
				<cfloop query="Sheets">
					<cfset SheetName = Application.UDF.StripAllBut(Left(Sheets.Category,30),'abcdefghijklmnopqrstuvwxyz0123456789 &_-',false)>
					<cfif SheetName EQ "">
						<cfset SheetName = "Unknown">
					</cfif>
					<cfquery name="ReportDataSub" dbtype="query">
						SELECT * FROM ReportData
						WHERE Category = <cfqueryparam value="#Sheets.Category#" cfsqltype="cf_sql_varchar" />
					</cfquery>
				<poi:sheet name="#SheetName#" orientation="landscape">
					<poi:columns>
						<cfloop from="1" to="#ColumnCount#" index="i">
						<poi:column style="width:150px;" />
						</cfloop>
					</poi:columns>
					
					<poi:row class="title">
						<poi:cell value="#Sheets.Category# // #DateFormat(Arguments.StartDate,'mm/dd/yyyy')# -to- #DateFormat(Arguments.EndDate,'mm/dd/yyyy')#" colspan="#ColumnCount#" />
					</poi:row>
					
					<poi:row class="headers">
						<poi:cell value="Activity Title" />
						<poi:cell value="Start Date" />
						<poi:cell value="End Date" />
					</poi:row>
					
					<cfloop query="ReportDataSub">
					<poi:row class="data">
						<poi:cell value="#ReportDataSub.Title#" />
						<poi:cell value="#DateFormat(ReportDataSub.StartDate,'M/D/YYYY')#"  />
						<poi:cell value="#DateFormat(ReportDataSub.EndDate,'M/D/YYYY')#" />
					</poi:row>
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