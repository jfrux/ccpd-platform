<cfcomponent>
    <cffunction name="run" hint="A detailed report on activities and attendees based on date range and location" access="remote" output="true" returntype="string">
    	<cfargument name="StartDate" default="" required="true" />
    	<cfargument name="EndDate" default="" required="true" />
    	<cfargument name="ReportID" default="16" required="true" />
        
        <cfset var Status = createObject("component", "_com.returnData.buildStruct").init()>
        
        <cfif Arguments.StartDate EQ "" AND Arguments.EndDate EQ "">
        	<cfset status.setStatusMsg("You must enter a Start and End Date.")>
        <cfelseif Arguments.StartDate EQ "" AND Arguments.EndDate NEQ "">
        	<cfset status.setStatusMsg("You must enter a Start Date.")>
        <cfelseif Arguments.StartDate NEQ "" AND Arguments.EndDate EQ "">
        	<cfset status.setStatusMsg("You must enter an End Date.")>
        </cfif>
        
        <cfif len(trim(status.getStatusMsg())) EQ 0>
        	<!--- GET CDC COURSES --->
            <cfquery name="qAttendees" datasource="#application.settings.dsn#" timeout="600">
                DECLARE @StartDate datetime;
                DECLARE @EndDate datetime;
                
                SET @StartDate = <cfqueryparam value="#DateFormat(arguments.startDate, 'MM/DD/YYYY')# 00:00:00" cfsqltype="cf_sql_date" />;
                SET @EndDate = <cfqueryparam value="#DateFormat(arguments.endDate, 'MM/DD/YYYY')# 23:59:59" cfsqltype="cf_sql_date" />;
                
                SELECT 
                    att.AttendeeID,
                    att.PersonID,
                    CASE 
                        WHEN isNull(att.PersonId,0) = 0 THEN
                            isNull(att.firstname,'')
                        ELSE
                            isNull(p1.firstname,'')
                    END As FirstName,
                    CASE 
                        WHEN isNull(att.PersonId,0) = 0 THEN
                            isNull(att.middlename,'')
                        ELSE
                            isNull(p1.middlename,'')
                    END As middlename,
                    CASE 
                        WHEN isNull(att.PersonId,0) = 0 THEN
                            isNull(att.lastname,'')
                        ELSE
                            isNull(p1.lastname,'')
                    END As lastname,
                    p1.Email,
                    CASE 
                        WHEN isNull(att.PersonId,0) = 0 THEN
                            isNull(att.city,'')
                        ELSE
                            isNull(address.City,'')
                    END As City,
                    CASE 
                        WHEN isNull(att.PersonId,0) = 0 THEN
                            isNull(att.stateProvince,'')
                        ELSE
                            isNull(address.Province,'')
                    END As StateProv,
                    CASE 
                        WHEN isNull(att.PersonId,0) = 0 THEN
                            isNull(att.stateId,'')
                        ELSE
                            isNull(address.stateId,'')
                    END As stateId,
                    zips.postalcode As ZipCode,
                    CASE 
                        WHEN isNull(att.PersonId,0) = 0 THEN
                            isNull(att.countryId,'')
                        ELSE
                            isNull(address.countryId,'')
                    END As CountryId,
                    CASE 
                        WHEN isNull(att.PersonId,0) = 0 THEN
                            0 
                        ELSE
                            1
                    END As hasAcctFlag,
                    CASE 
                        WHEN isNull(att.PersonId,0) = 0 THEN
                            CASE att.mdFlag 
                                WHEN 'Y' THEN 'MD' 
                                ELSE ':No Degree' 
                            END 
                        ELSE
                            isNull(sd.name,':No Degree')
                    END As degree,
                    isNull(zips.adminCode1,':No State') AS adminCode1,
                    zips.adminCode3,
                    zips.adminCode3,
                    zips.adminName1,
                    zips.adminName2,
                    zips.adminName3,
                    zips.postalCode,
                    zips.placeName
                FROM     
                    ce_Attendee AS att 
                INNER JOIN 
                    ce_Activity AS A ON att.ActivityID = A.ActivityID 
                LEFT OUTER JOIN 
                    ce_person AS p1 ON p1.personid = att.PersonID
                LEFT OUTER JOIN 
                    ce_Person_Address AS Address ON p1.PrimaryAddressID=Address.addressid
                LEFT OUTER JOIN 
                    ce_Sys_AttendeeStatus AS ats ON ats.AttendeeStatusID = att.StatusID
                LEFT OUTER JOIN
                    ce_person_degree AS pd ON pd.personId = att.personId
                LEFT OUTER JOIN
                    ce_sys_degree AS sd ON sd.degreeId = pd.degreeId
                LEFT OUTER JOIN
                    geonames_zip As zips ON (zips.postalcode = CASE 
                                                                        WHEN isNull(att.PersonId,0) = 0 THEN
                                                                            RIGHT('00000' + RTRIM(isNull(att.postalCode,'')), 5)
                                                                        ELSE
                                                                            RIGHT('00000' + RTRIM(isNull(address.zipCode,'')), 5)
                                                                    END AND zips.countrycode = 'US')
                WHERE (
                            (A.DeletedFlag='N') AND
                            (A.statusid IN (1,2,3)) AND
                            (att.deletedFlag='N') AND
                            (att.statusId = 1) AND 
                            (att.completeDate BETWEEN @StartDate AND @EndDate)
                    )
            </cfquery>
            
            <!--- QUERY qAttendees FOR GROUPED STATE INFO --->
            <cfquery name="qStates" dbtype="query">
                SELECT	
                    adminCode1 AS state,
                    Count(PersonID) AS AttendeeCount
                FROM qAttendees
                GROUP BY adminCode1
            </cfquery>
            
            <!--- GET TOTAL ATTENDEE COUNT --->
            <cfquery name="qStateAttendee" dbtype="query">
            	SELECT SUM(attendeeCount) AS total
                FROM qStates
            </cfquery>
            
            <!--- QUERY qAttendees FOR GROUPED DEGREE INFO --->
            <cfquery name="qDegrees" dbtype="query">
                SELECT	
                    degree,
                    Count(PersonID) AS AttendeeCount
                FROM qAttendees
                GROUP BY degree
            </cfquery>
            
            <!--- GET TOTAL ATTENDEE COUNT --->
            <cfquery name="qDegreeAttendee" dbtype="query">
            	SELECT SUM(attendeeCount) AS total
                FROM qDegrees
            </cfquery>
            
            <!--- Excel Section --->
			<!--- Import POI Library --->
            <cfimport taglib="/_poi/" prefix="poi" />
            
            <!--- Create Report Folder variable --->
            <cfset ReportPath = ExpandPath("#Application.Settings.RootPath#/_reports")>
            
            <!--- Check if the report folder exists yet --->
            <cfif NOT DirectoryExists("#ReportPath#/#Arguments.ReportID#")>
                <cfdirectory action="Create" directory="#ReportPath#/#Arguments.ReportID#">
            </cfif>
            
            <!--- Define variables used in the CreateExcel object --->
            <cfset ReportExtendedPath = ReportPath & "/" & Arguments.ReportID & "/Activity_Overview_#DateFormat(Arguments.StartDate,'MDDYY')#-#DateFormat(Arguments.EndDate,'MDDYY')#_#DateFormat(Now(),'MMDDYY')##TimeFormat(Now(),'hhmmss')#.xlsx">
            
            <!--- Start Building Excel file --->
            <poi:document name="Request.ExcelData" file="#ReportExtendedPath#" type="xssf">
                <poi:classes>
                    <poi:class name="title" style="font-family: arial ; color: WHITE ;  font-size: 16pt ; font-weight: bold; text-align: center ; background-color: GREY_50_PERCENT;" />
                    <poi:class name="subtitle" style="font-family: arial ; color: WHITE ;  font-size: 12pt ; font-weight: bold; text-align: center ; background-color: GREY_50_PERCENT;" />
                    <poi:class name="sectionheader" style="font-family: arial ; color: WHITE ;  font-size: 10pt ; font-weight: bold; text-align: center ; background-color: GREY_25_PERCENT;" />
                </poi:classes>
                
                <poi:sheets>
                    <poi:sheet name="Overview Report" orientation="landscape">
                        <poi:columns>
                            <poi:column style="width:272px;" />
                            <poi:column style="width:125px;" />
                            <poi:column style="width:125px;" />
                        </poi:columns>
                        
                        <poi:row class="title">
                            <poi:cell value="#DateFormat(Arguments.StartDate,'MMM D, YYYY')# - #DateFormat(Arguments.EndDate,'MMM D, YYYY')#"
                                      colspan="3" />
                        </poi:row>
                        
                        <poi:row class="title">
                            <poi:cell value="ACCME Statistical Data"
                                      colspan="3" />
                        </poi:row>
                        
                        <!--- DEGREE DATA --->
                        <poi:row class="subtitle">
                            <poi:cell value="Summary of Degrees - #DateFormat(Arguments.StartDate,'MMM D, YYYY')# - #DateFormat(Arguments.EndDate,'MMM D, YYYY')#"
                                      colspan="3" />
                        </poi:row>
                        
                        <poi:row class="sectionheader">
                            <poi:cell value="Degree" />
                            <poi:cell value="Count" />
                            <poi:cell value="Percent" />
                        </poi:row>

                        <cfloop query="qDegrees">
                        <poi:row>
                            <poi:cell value="#qDegrees.degree#" />
                            <poi:cell value="#qDegrees.attendeeCount#" type="numeric" numberformat="0" />
                            <poi:cell value="#DecimalFormat((qDegrees.attendeeCount/qDegreeAttendee.total)*100)	#%" />
                        </poi:row>
                        </cfloop>
                        
                        <poi:row>
                            <poi:cell value="Total" />
                            <poi:cell value="#qDegreeAttendee.total#" colspan="2" type="numeric" numberformat="0" />
                        </poi:row>
                        
                        <poi:row>
                            <poi:cell value=" "
                                      colspan="3" />
                        </poi:row>
                        
                        <!--- STATE DATA --->
                        <poi:row class="subtitle">
                            <poi:cell value="Summary of States - #DateFormat(Arguments.StartDate,'MMM D, YYYY')# - #DateFormat(Arguments.EndDate,'MMM D, YYYY')#"
                                      colspan="3" />
                        </poi:row>
                        
                        <poi:row class="sectionheader">
                            <poi:cell value="State" />
                            <poi:cell value="Count" />
                            <poi:cell value="Percent" />
                        </poi:row>

                        <cfloop query="qStates">
                        <poi:row>
                            <poi:cell value="#qStates.state#" />
                            <poi:cell value="#qStates.attendeeCount#" type="numeric" numberformat="0"  />
                            <poi:cell value="#DecimalFormat((qStates.attendeeCount/qStateAttendee.total)*100)#%" />
                        </poi:row>
                        </cfloop>
                        
                        <poi:row>
                            <poi:cell value="Total" />
                            <poi:cell value="#qStateAttendee.total#" colspan="2" type="numeric" numberformat="0" />
                        </poi:row>
                        
                        <poi:row>
                            <poi:cell value=" "
                                      colspan="2" />
                        </poi:row>
                    </poi:sheet>
                </poi:sheets>
            </poi:document>
                                
            <cfset status.setStatus(true)>
            <cfset status.setStatusMsg("Your report has been generated!")>
            <cftry>
                <cfcatch type="any">
                	<cfset status.setStatusMsg("Error: " & cfcatch.Message)>
                </cfcatch>
            </cftry>
        </cfif>
        
        <cfreturn Status.getJSON() />
    </cffunction>
</cfcomponent>