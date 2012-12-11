<cfcomponent displayname="Activities by Categories" output="no">
	<cfimport taglib="/_poi/" prefix="poi" />
	
	<!--- CONFIGURATION --->
	<cfset ReportPath = ExpandPath("#Application.Settings.RootPath#/_reports/7/")>
	<cfset ReportFileName = "container-#DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#-#Session.AccountID#.xlsx">
	<cfset ColumnCount = 5>
	<cfset Title = "Activities by Container">
	<cfset BookName = "Activities by Container">
	
	<cfif NOT DirectoryExists("#ReportPath#")><cfdirectory action="Create" directory="#ReportPath#"></cfif>
	
	<!--- RUN METHOD --->
	<cffunction name="Run" access="remote" output="yes">
		<cfargument name="Categories" type="string" required="no" default="0" />
		<cfargument name="StartDate" type="string" required="yes" />
		<cfargument name="EndDate" type="string" required="yes" />
		
		<cfquery name="ReportData" datasource="#Application.Settings.DSN#">
			DECLARE @StartDate datetime
			DECLARE @EndDate datetime
			
			SET @StartDate = <cfqueryparam value="#Arguments.StartDate# 00:00:00" cfsqltype="cf_sql_varchar" />
			SET @EndDate = <cfqueryparam value="#Arguments.EndDate# 23:59:59" cfsqltype="cf_sql_varchar" />
			
			SELECT     
				A.ActivityID, A.ParentActivityID, A.Title, A.StartDate, A.EndDate, C.Name AS Category, A.StatAttendees, A.StatMD
			FROM         
				ce_Activity_Category AS AC 
			INNER JOIN
				ce_Activity AS A ON AC.ActivityID = A.ActivityID 
			INNER JOIN
			ce_Category AS C ON AC.CategoryID = C.CategoryID
			WHERE 
				(A.DeletedFlag = 'N') AND 
				(C.CategoryID IN (#Arguments.Categories#)) AND 
				A.StartDate BETWEEN @StartDate AND @EndDate AND
                AC.DeletedFlag = 'N'
			ORDER BY A.ActivityID,A.ParentActivityID,A.StartDate
		</cfquery>
        
		<cfquery name="qSheets" dbtype="query">
		SELECT
			DISTINCT
			Category
		FROM  ReportData
		ORDER BY Category
		</cfquery>
		
        <cfif qSheets.recordCount GT 0>
            <poi:document name="Request.ExcelData" file="#ReportPath##ReportFileName#" type="XSSF">
                <poi:classes>
                    <poi:class name="title" style="font-family: arial; vertical-align:middle; color: ##000; font-size:12pt; font-weight:bold;  background-color: PALE_BLUE; border-top: 3px BLACK; border-bottom:3px BLACK; border-left: 2px BLACK; border-right:2px BLACK;" />
                    <poi:class name="headers" style="font-family: arial ; color: ##000; background-color:GREY_25_PERCENT;  font-size: 10pt; font-weight: bold; border-top: 3px BLACK; border-bottom:3px BLACK; border-left: 2px BLACK; border-right:2px BLACK;" />
                    <poi:class name="data" style="font-family: arial ; color: ##000 ;  font-size: 10pt; border-bottom:2px GREY_50_PERCENT;" />+
                    <poi:class name="parent" style="font-family:Arial; font-size:10pt; vertical-align:center; border-bottom:2px solid black; background-color:lemon_chiffon; font-weight:bold;" />
                </poi:classes>
                
                <poi:sheets>
                    <cfloop query="qSheets">
                        <cfset SheetName = Application.UDF.StripAllBut(Left(qSheets.Category,30),'abcdefghijklmnopqrstuvwxyz0123456789 &_-',false)>
                        <cfif SheetName EQ "">
                            <cfset SheetName = "Unknown">
                        </cfif>
                        <cfquery name="ReportDataSub" dbtype="query">
                            SELECT * FROM ReportData
                            WHERE Category = <cfqueryparam value="#qSheets.Category#" cfsqltype="cf_sql_varchar" />
                        </cfquery>
                    <poi:sheet name="#SheetName#" orientation="landscape">
                        <poi:columns>
                            <cfloop from="1" to="#ColumnCount#" index="i">
                            <poi:column style="width:150px;" />
                            </cfloop>
                        </poi:columns>
                        
                        <poi:row class="title">
                            <poi:cell value="#qSheets.Category# // #DateFormat(Arguments.StartDate,'mm/dd/yyyy')# -to- #DateFormat(Arguments.EndDate,'mm/dd/yyyy')#" colspan="#ColumnCount#" />
                        </poi:row>
                        
                        <poi:row class="headers">
                            <poi:cell value="Activity Title" />
                            <poi:cell value="Start Date" />
                            <poi:cell value="End Date" />
                            <poi:cell value="Attendees" />
                            <poi:cell value="MDs" />
                        </poi:row>
                        <cfloop query="ReportDataSub">
                        <cfif ReportDataSub.ParentActivityID NEQ "">
                            <cfset ClassName = "data">
                        <cfelse>
                            <cfset ClassName = "parent">
                        </cfif>
                        <poi:row class="#ClassName#">
                            <poi:cell value="#ReportDataSub.Title#" />
                            <poi:cell value="#DateFormat(ReportDataSub.StartDate,'M/D/YYYY')#"  />
                            <poi:cell value="#DateFormat(ReportDataSub.EndDate,'M/D/YYYY')#" />
                            <poi:cell value="#ReportDataSub.StatAttendees#" numberformat="0.00" />
                            <poi:cell value="#ReportDataSub.StatMD#" numberformat="0.00" />
                        </poi:row>
                        </cfloop>
                    </poi:sheet>
                    </cfloop>
                </poi:sheets>
            </poi:document>
            
            <cfheader name="Content-Type" value="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
            <cfheader name="Content-Disposition" value="attachment; filename=#ReportFileName#">
            <cfcontent type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" file="#ReportPath##ReportFileName#" deletefile="No">
        <cfelse>
        	<script>
				window.location = 'http://ccpd.uc.edu/admin/index.cfm/event/report.ContainerSummary?message=No report was generated for provided containers.';
			</script>
		</cfif>
	</cffunction>
</cfcomponent>