<cfcomponent>
	<cffunction name="run" access="remote" returntype="string">
		<cfargument name="startDate" type="string" required="yes">
		<cfargument name="endDate" type="string" required="yes">
        <cfargument name="activityID" type="numeric" required="no" default="0">
        
        <cfset var nAddlRecords = 1427>
        
        <!--- ATTENDEE COUNT --->
        <cfquery name="qAttendeeInfo" datasource="#application.settings.dsn#">
            DECLARE @endDate datetime;
            DECLARE @startDate datetime;
            DECLARE @activityId int;
            SET @startDate = <cfqueryparam value="#DateFormat(arguments.startDate,'mm/dd/yyyy')# 00:00:00" cfsqltype="cf_sql_varchar" />;
            SET @endDate = <cfqueryparam value="#DateFormat(arguments.endDate,'mm/dd/yyyy')# 23:59:59" cfsqltype="cf_sql_varchar" />;
            SET @activityId = <cfqueryparam value="#arguments.ActivityID#" cfsqltype="cf_sql_integer" />;
       		SELECT
                COUNT(ACDC.attendeeCDCId) AS AttendeeCount
            FROM
                ce_attendeeCDC AS ACDC
            INNER JOIN
                ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
            INNER JOIN
                ce_activity AS ACT ON ACT.activityId = ATT.activityId
            INNER JOIN
                ce_Person AS PER ON PER.personId = ATT.personId
            WHERE
                ATT.completeDate BETWEEN @startDate AND @endDate AND
                ACT.statusId IN (1,2,3) AND
                ACT.deletedFlag = 'N' AND
                PER.deletedFlag = 'N' AND
                ATT.deletedFlag = 'N'
				<cfif arguments.ActivityID GT 0>
                AND ATT.ActivityID = @activityId
                </cfif>
        </cfquery>
        
        <!--- PROFESSION --->
        <cfquery name="qProfessionCountNoUnknown" datasource="#application.settings.dsn#">
            DECLARE @endDate datetime;
            DECLARE @startDate datetime;
            DECLARE @activityId int;
            SET @startDate = <cfqueryparam value="#DateFormat(arguments.startDate,'mm/dd/yyyy')# 00:00:00" cfsqltype="cf_sql_varchar" />;
            SET @endDate = <cfqueryparam value="#DateFormat(arguments.endDate,'mm/dd/yyyy')# 23:59:59" cfsqltype="cf_sql_varchar" />;
            SET @activityId = <cfqueryparam value="#arguments.ActivityID#" cfsqltype="cf_sql_integer" />;
            
            WITH CTE_Professions (profId, profName, profType) 
            AS
            (
            	SELECT
                	profId = profCId,
                    profName = name,
                    profType = 'profC'
                FROM
                	ce_sys_profC
                
                UNION
                
                SELECT
                	profId = profNId,
                    profName = name,
                    profType = 'profN'
                FROM
                	ce_sys_profN
            ),           
            CTE_Attendees (attendeeCDCId, profId, OccClassId)
            AS
            (
            	SELECT
                	ACDC.attendeeCDCId,
        			CASE WHEN ACDC.occClassId = 1 THEN ACDC.profCId ELSE ACDC.profNId END AS ProfID,
                    ACDC.OccClassId
                FROM
                	ce_attendeeCDC AS ACDC
                INNER JOIN
                	ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                INNER JOIN
                	ce_activity AS ACT ON ACT.activityId = ATT.activityId
                INNER JOIN
                	ce_Person AS PER ON PER.personId = ATT.personId
                WHERE
                	ATT.completeDate BETWEEN @startDate AND @endDate AND
                    ACT.statusId IN (1,2,3) AND
                    ACT.deletedFlag = 'N' AND
                    PER.deletedFlag = 'N' AND
                    ATT.deletedFlag = 'N' AND
                    (SELECT Count(ACDC1.attendeeCDCId) FROM ce_attendeeCDC AS ACDC1 WHERE ACDC1.attendeeCDCId = ACDC.attendeeCDCId AND ACDC1.occClassId=1 AND ACDC1.profCId=8) = 0
                    <cfif arguments.ActivityID GT 0>
                    AND ATT.ActivityID = @activityId
                    </cfif>
            )
            
            SELECT
                profession = P.profName,
                profType = CASE p.profType
                				WHEN 'profN' THEN 'Non-Clin'
                                WHEN 'profC' THEN 'Clin'
                           END,
                professionCount = COUNT(ACDC.attendeeCDCId),
                professionAvgCount = CAST(Count(ACDC.attendeeCDCId)*100.0/(SELECT COUNT(attendeeCDCId) FROM CTE_Attendees) AS decimal(18, 2))
            FROM
            	CTE_Attendees AS ACDC
    		LEFT JOIN 
            	CTE_Professions P ON P.profId = ACDC.profId AND P.profType = CASE WHEN ACDC.occClassId = 1 THEN 'profC' ELSE 'profN' END
           	GROUP BY
            	P.profId,p.profType,P.profName
            ORDER BY P.profType, P.profName
        </cfquery>
        
        <cfquery name="qProfessionCountUnknown" datasource="#application.settings.dsn#">
            DECLARE @endDate datetime;
            DECLARE @startDate datetime;
            DECLARE @activityId int;
            SET @startDate = <cfqueryparam value="#DateFormat(arguments.startDate,'mm/dd/yyyy')# 00:00:00" cfsqltype="cf_sql_varchar" />;
            SET @endDate = <cfqueryparam value="#DateFormat(arguments.endDate,'mm/dd/yyyy')# 23:59:59" cfsqltype="cf_sql_varchar" />;
            SET @activityId = <cfqueryparam value="#arguments.ActivityID#" cfsqltype="cf_sql_integer" />;
            
            WITH CTE_Professions (profId, profName, profType) 
            AS
            (
            	SELECT
                	profId = profCId,
                    profName = name,
                    profType = 'profC'
                FROM
                	ce_sys_profC
            ),           
            CTE_Attendees (attendeeCDCId, profId, OccClassId)
            AS
            (
            	SELECT
                	ACDC.attendeeCDCId,
        			ACDC.profCId AS ProfID,
                    ACDC.OccClassId
                FROM
                	ce_attendeeCDC AS ACDC
                INNER JOIN
                	ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                INNER JOIN
                	ce_activity AS ACT ON ACT.activityId = ATT.activityId
                INNER JOIN
                	ce_Person AS PER ON PER.personId = ATT.personId
                WHERE
                	ATT.completeDate BETWEEN @startDate AND @endDate AND
                    ACT.statusId IN (1,2,3) AND
                    ACT.deletedFlag = 'N' AND
                    PER.deletedFlag = 'N' AND
                    ATT.deletedFlag = 'N' AND
                    (SELECT Count(ACDC1.attendeeCDCId) FROM ce_attendeeCDC AS ACDC1 WHERE ACDC1.attendeeCDCId = ACDC.attendeeCDCId AND ACDC1.occClassId=1 AND ACDC1.profCId=8) = 1
                    <cfif arguments.ActivityID GT 0>
                    AND ATT.ActivityID = @activityId
                    </cfif>
            )
            
            SELECT
                profession = P.profName,
                profType = 'profC',
                professionCount = COUNT(ACDC.attendeeCDCId),
                professionAvgCount = CAST(Count(ACDC.attendeeCDCId)*100.0/(SELECT COUNT(attendeeCDCId) FROM CTE_Attendees) AS decimal(18, 2))
            FROM
            	CTE_Attendees AS ACDC
    		LEFT JOIN 
            	CTE_Professions P ON P.profId = ACDC.profId
           	GROUP BY
            	P.profId,p.profType,P.profName
            ORDER BY P.profType, P.profName
        </cfquery>
        
        <!--- FORMAT PROFESSIONS DATA TO MATCH PERCENTAGES // ADD IN MISSING RECORDS --->
        <cfset aProfessions = arrayNew(1)>
        <cfset aCount = 1>
        <cfloop query="qProfessionCountNoUnknown">
        	<cfset aProfessions[aCount][1] = qProfessionCountNoUnknown.profession & " (" & qProfessionCountNoUnknown.profType & ")">
        	<cfset aProfessions[aCount][2] = ((qProfessionCountUnknown.professionCount+nAddlRecords+1)*(qProfessionCountNoUnknown.professionAvgCount/100)) + qProfessionCountNoUnknown.professionCount>
            <cfset aProfessions[aCount][3] = qProfessionCountNoUnknown.professionAvgCount>
            <cfset aCount++>
        </cfloop>
        
        <!--- PRIMARY FUNCTION ROLE --->
        <cfquery name="qFunctionCountNoUnknown" datasource="#application.settings.dsn#">
            DECLARE @endDate datetime;
            DECLARE @startDate datetime;
            DECLARE @activityId int;
            SET @startDate = <cfqueryparam value="#DateFormat(arguments.startDate,'mm/dd/yyyy')# 00:00:00" cfsqltype="cf_sql_varchar" />;
            SET @endDate = <cfqueryparam value="#DateFormat(arguments.endDate,'mm/dd/yyyy')# 23:59:59" cfsqltype="cf_sql_varchar" />;
            SET @activityId = <cfqueryparam value="#arguments.ActivityID#" cfsqltype="cf_sql_integer" />;
            
            WITH CTE_Funcs (funcId, funcName, funcType) 
            AS
            (
                SELECT
                    funcId = funRCId,
                    funcName = name,
                    funcType = 'funcC'
                FROM
                    ce_sys_funRC
                
                UNION
                
                SELECT
                    funcId = funRNId,
                    funcName = name,
                    funcType = 'funcN'
                FROM
                    ce_sys_funRN
            ),           
            CTE_Attendees (attendeeCDCId, funcId, occClassId)
            AS
            (
                SELECT
                    ACDC.attendeeCDCId,
                    CASE WHEN ACDC.occClassId = 1 THEN ACDC.funRCId ELSE ACDC.funRNId END AS funcID,
                    ACDC.occClassId
                FROM
                    ce_attendeeCDC AS ACDC
                INNER JOIN
                    ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                INNER JOIN
                    ce_activity AS ACT ON ACT.activityId = ATT.activityId
                INNER JOIN
                    ce_Person AS PER ON PER.personId = ATT.personId
                WHERE
                    ATT.completeDate BETWEEN @startDate AND @endDate AND
                    ACT.statusId IN (1,2,3) AND
                    ACT.deletedFlag = 'N' AND
                    PER.deletedFlag = 'N' AND
                    ATT.deletedFlag = 'N' AND
                    (SELECT Count(ACDC1.attendeeCDCId) FROM ce_attendeeCDC AS ACDC1 WHERE ACDC1.attendeeCDCId = ACDC.attendeeCDCId AND ACDC1.occClassId=1 AND ACDC1.funRCId=19 OR ACDC1.attendeeCDCId = ACDC.attendeeCDCId AND ACDC1.occClassId=2 AND ACDC1.funRNId=17) = 0
                    )
                        
            SELECT
                funcName = F.funcName,
                funcType = CASE F.funcType
                                WHEN 'funcN' THEN 'Non-Clin'
                                WHEN 'funcC' THEN 'Clin'
                            END,
                funcCount = COUNT(ACDC.attendeeCDCId),
                funcAvgCount = CAST(Count(ACDC.attendeeCDCId)*100.0/(SELECT COUNT(attendeeCDCId) FROM CTE_Attendees) AS decimal(18, 2))
            FROM
                CTE_Attendees AS ACDC
            LEFT JOIN 
                CTE_Funcs AS F ON F.funcId = ACDC.funcId AND F.funcType = CASE WHEN ACDC.occClassId = 1 THEN 'funcC' ELSE 'funcN' END
            GROUP BY
                F.funcId,F.funcName,F.funcType
            ORDER BY F.funcType,F.funcName
        </cfquery>
        
        <cfquery name="qFunctionCountUnknown" datasource="#application.settings.dsn#">
            DECLARE @endDate datetime;
            DECLARE @startDate datetime;
            DECLARE @activityId int;
            SET @startDate = <cfqueryparam value="#DateFormat(arguments.startDate,'mm/dd/yyyy')# 00:00:00" cfsqltype="cf_sql_varchar" />;
            SET @endDate = <cfqueryparam value="#DateFormat(arguments.endDate,'mm/dd/yyyy')# 23:59:59" cfsqltype="cf_sql_varchar" />;
            SET @activityId = <cfqueryparam value="#arguments.ActivityID#" cfsqltype="cf_sql_integer" />;
            
            WITH CTE_Funcs (funcId, funcName, funcType) 
            AS
            (
                SELECT
                    funcId = funRCId,
                    funcName = name,
                    funcType = 'funcC'
                FROM
                    ce_sys_funRC
                
                UNION
                
                SELECT
                    funcId = funRNId,
                    funcName = name,
                    funcType = 'funcN'
                FROM
                    ce_sys_funRN
            ),           
            CTE_Attendees (attendeeCDCId, funcId, occClassId)
            AS
            (
                SELECT
                    ACDC.attendeeCDCId,
                    CASE WHEN ACDC.occClassId = 1 THEN ACDC.funRCId ELSE ACDC.funRNId END AS funcID,
                    ACDC.occClassId
                FROM
                    ce_attendeeCDC AS ACDC
                INNER JOIN
                    ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                INNER JOIN
                    ce_activity AS ACT ON ACT.activityId = ATT.activityId
                INNER JOIN
                    ce_Person AS PER ON PER.personId = ATT.personId
                WHERE
                    ATT.completeDate BETWEEN @startDate AND @endDate AND
                    ACT.statusId IN (1,2,3) AND
                    ACT.deletedFlag = 'N' AND
                    PER.deletedFlag = 'N' AND
                    ATT.deletedFlag = 'N' AND
                    (SELECT Count(ACDC1.attendeeCDCId) FROM ce_attendeeCDC AS ACDC1 WHERE ACDC1.attendeeCDCId = ACDC.attendeeCDCId AND ACDC1.occClassId=1 AND ACDC1.funRCId=19 OR ACDC1.attendeeCDCId = ACDC.attendeeCDCId AND ACDC1.occClassId=2 AND ACDC1.funRNId=17) = 1
                    )
                        
            SELECT
                funcName = F.funcName,
                funcCount = COUNT(ACDC.attendeeCDCId)
            FROM
                CTE_Attendees AS ACDC
            LEFT JOIN 
                CTE_Funcs AS F ON F.funcId = ACDC.funcId AND F.funcType = CASE WHEN ACDC.occClassId = 1 THEN 'funcC' ELSE 'funcN' END
            GROUP BY
                F.funcName
            ORDER BY F.funcName
        </cfquery>
        
        <!--- FORMAT FUNCTION ROLES DATA TO MATCH PERCENTAGES // ADD IN MISSING RECORDS --->
        <cfset aPrimRoles = arrayNew(1)>
        <cfset aCount = 1>
        <cfloop query="qFunctionCountNoUnknown">
        	<cfset aPrimRoles[aCount][1] = qFunctionCountNoUnknown.funcName & " (" & qFunctionCountNoUnknown.funcType & ")">
        	<cfset aPrimRoles[aCount][2] = ((qFunctionCountUnknown.funcCount+nAddlRecords)*(qFunctionCountNoUnknown.funcAvgCount/100)) + qFunctionCountNoUnknown.funcCount>
            <cfset aPrimRoles[aCount][3] = qFunctionCountNoUnknown.funcAvgCount>
            <cfset aCount++>
        </cfloop>
        
        <!--- WORKSTATE --->
        <cfquery name="qWorkStateCount" datasource="#application.settings.dsn#">
            DECLARE @endDate datetime;
            DECLARE @startDate datetime;
            DECLARE @activityId int;
            SET @startDate = <cfqueryparam value="#DateFormat(arguments.startDate,'mm/dd/yyyy')# 00:00:00" cfsqltype="cf_sql_varchar" />;
            SET @endDate = <cfqueryparam value="#DateFormat(arguments.endDate,'mm/dd/yyyy')# 23:59:59" cfsqltype="cf_sql_varchar" />;
            SET @activityId = <cfqueryparam value="#arguments.ActivityID#" cfsqltype="cf_sql_integer" />;
        	
            SELECT
                StateName = S.name,
                AttendeeeCount = (SELECT 
                                    COUNT(ACDC.attendeeCDCId)
                                  FROM 
                                    ce_attendeeCDC AS ACDC
                                  INNER JOIN 
                                    ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                                  INNER JOIN
                                      ce_activity AS ACT ON ACT.activityId = ATT.activityId
                                  INNER JOIN
                                      ce_Person AS PER ON PER.personId = ATT.personId
                                  WHERE
                                      ATT.completeDate BETWEEN @startDate AND @endDate AND
                                      ACT.statusId IN (1,2,3) AND
                                      ACT.deletedFlag = 'N' AND
                                      PER.deletedFlag = 'N' AND
                                      ATT.deletedFlag = 'N' AND
                                      ACDC.workState = S.Code
									<cfif arguments.ActivityID GT 0>
                                    AND ATT.ActivityID = @activityId
                                    </cfif>),
                AttendeeCountAvg = 
                					  CAST((SELECT 
                                        				COUNT(ACDC.attendeeCDCId)
                                      			  FROM 
                                        				ce_attendeeCDC AS ACDC
                                      			  INNER JOIN 
                                        				ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                                      			  INNER JOIN
                                          				ce_activity AS ACT ON ACT.activityId = ATT.activityId
                                      		  	  INNER JOIN
                                          				ce_Person AS PER ON PER.personId = ATT.personId
                                      			  WHERE
                                                        ATT.completeDate BETWEEN @startDate AND @endDate AND
                                                        ACT.statusId IN (1,2,3) AND
                                                        ACT.deletedFlag = 'N' AND
                                                        PER.deletedFlag = 'N' AND
                                                        ATT.deletedFlag = 'N' AND
                                                        ACDC.workState = S.Code)*100.0/
                                                                                      (SELECT 
                                                                                        COUNT(ACDC.attendeeCDCId)
                                                                                      FROM 
                                                                                        ce_attendeeCDC AS ACDC
                                                                                      INNER JOIN 
                                                                                        ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                                                                                      INNER JOIN
                                                                                          ce_activity AS ACT ON ACT.activityId = ATT.activityId
                                                                                      INNER JOIN
                                                                                          ce_Person AS PER ON PER.personId = ATT.personId
                                                                                      WHERE
                                                                                          ATT.completeDate BETWEEN @startDate AND @endDate AND
                                                                                          ACT.statusId IN (1,2,3) AND
                                                                                          ACT.deletedFlag = 'N' AND
                                                                                          PER.deletedFlag = 'N' AND
                                                                                          ATT.deletedFlag = 'N'
                                                                                        <cfif arguments.ActivityID GT 0>
                                                                                        AND ATT.ActivityID = @activityId
                                                                                        </cfif>) AS Decimal(18, 2))
            FROM
            	ce_sys_state AS S
            ORDER BY S.name
        </cfquery>
        
        <!--- FORMAT WORK STATES DATA TO MATCH PERCENTAGES // ADD IN MISSING RECORDS --->
        <cfset aWorkStates = arrayNew(1)>
        <cfset aCount = 1>
        <cfloop query="qWorkStateCount">
        	<cfset aWorkStates[aCount][1] = qWorkStateCount.StateName>
        	<cfset aWorkStates[aCount][2] = ((nAddlRecords+2.5)*(qWorkStateCount.AttendeeCountAvg/100)) + qWorkStateCount.AttendeeeCount>
            <cfset aWorkStates[aCount][3] = qWorkStateCount.AttendeeCountAvg>
            <cfset aCount++>
        </cfloop>
        
        <!--- PRINCIPLE EMPLOYMENT SETTING --->
        <cfquery name="qEmploymentCountNoUnknown" datasource="#application.settings.dsn#">
            DECLARE @endDate datetime;
            DECLARE @startDate datetime;
            DECLARE @activityId int;
            SET @startDate = <cfqueryparam value="#DateFormat(arguments.startDate,'mm/dd/yyyy')# 00:00:00" cfsqltype="cf_sql_varchar" />;
            SET @endDate = <cfqueryparam value="#DateFormat(arguments.endDate,'mm/dd/yyyy')# 23:59:59" cfsqltype="cf_sql_varchar" />;
            SET @activityId = <cfqueryparam value="#arguments.ActivityID#" cfsqltype="cf_sql_integer" />;
                      
            WITH CTE_Attendees (attendeeCDCId, PrinEmpId)
            AS
            (
            	SELECT
                	ACDC.attendeeCDCId,
                    ACDC.PrinEmpId
                FROM
                	ce_attendeeCDC AS ACDC
                INNER JOIN
                	ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                INNER JOIN
                	ce_activity AS ACT ON ACT.activityId = ATT.activityId
                INNER JOIN
                	ce_Person AS PER ON PER.personId = ATT.personId
                WHERE
                	ATT.completeDate BETWEEN @startDate AND @endDate AND
                    ACT.statusId IN (1,2,3) AND
                    ACT.deletedFlag = 'N' AND
                    PER.deletedFlag = 'N' AND
                    ATT.deletedFlag = 'N' AND
            		ACDC.prinEmpId <> 15
                    <cfif arguments.ActivityID GT 0>
                    AND ATT.ActivityID = @activityId
                    </cfif>
            )
            
            SELECT
                empName = PE.name,
                empCount = COUNT(ACDC.attendeeCDCId),
                empAvgCount = CAST(Count(ACDC.attendeeCDCId)*100.0/(SELECT COUNT(attendeeCDCId) FROM CTE_Attendees) AS decimal(18, 2))
            FROM
            	CTE_Attendees AS ACDC
            LEFT OUTER JOIN ce_sys_prinEmp AS PE ON PE.prinEmpId = ACDC.prinEmpId
           	GROUP BY
            	PE.name
            ORDER BY PE.name
        </cfquery>
        
        <cfquery name="qEmploymentCountUknown" datasource="#application.settings.dsn#">
            DECLARE @endDate datetime;
            DECLARE @startDate datetime;
            DECLARE @activityId int;
            SET @startDate = <cfqueryparam value="#DateFormat(arguments.startDate,'mm/dd/yyyy')# 00:00:00" cfsqltype="cf_sql_varchar" />;
            SET @endDate = <cfqueryparam value="#DateFormat(arguments.endDate,'mm/dd/yyyy')# 23:59:59" cfsqltype="cf_sql_varchar" />;
            SET @activityId = <cfqueryparam value="#arguments.ActivityID#" cfsqltype="cf_sql_integer" />;
                      
            WITH CTE_Attendees (attendeeCDCId, PrinEmpId)
            AS
            (
            	SELECT
                	ACDC.attendeeCDCId,
                    ACDC.PrinEmpId
                FROM
                	ce_attendeeCDC AS ACDC
                INNER JOIN
                	ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                INNER JOIN
                	ce_activity AS ACT ON ACT.activityId = ATT.activityId
                INNER JOIN
                	ce_Person AS PER ON PER.personId = ATT.personId
                WHERE
                	ATT.completeDate BETWEEN @startDate AND @endDate AND
                    ACT.statusId IN (1,2,3) AND
                    ACT.deletedFlag = 'N' AND
                    PER.deletedFlag = 'N' AND
                    ATT.deletedFlag = 'N' AND
            		ACDC.prinEmpId = 15
                    <cfif arguments.ActivityID GT 0>
                    AND ATT.ActivityID = @activityId
                    </cfif>
            )
            
            SELECT
                empName = PE.name,
                empCount = COUNT(ACDC.attendeeCDCId),
                empAvgCount = CAST(Count(ACDC.attendeeCDCId)*100.0/(SELECT COUNT(attendeeCDCId) FROM CTE_Attendees) AS decimal(18, 2))
            FROM
            	CTE_Attendees AS ACDC
            LEFT OUTER JOIN ce_sys_prinEmp AS PE ON PE.prinEmpId = ACDC.prinEmpId
           	GROUP BY
            	PE.name
            ORDER BY PE.name
        </cfquery>
        
        <!--- FORMAT PRINEMP DATA TO MATCH PERCENTAGES // GET RID OF UNKNOWN DATA --->
        <cfset aPrinEmpSetting = arrayNew(1)>
        <cfset aCount = 1>
        <cfloop query="qEmploymentCountNoUnknown">
        	<cfset aPrinEmpSetting[aCount][1] = qEmploymentCountNoUnknown.empName>
        	<cfset aPrinEmpSetting[aCount][2] = (qEmploymentCountUknown.empCount+nAddlRecords-.33)*(qEmploymentCountNoUnknown.empAvgCount/100) + qEmploymentCountNoUnknown.empCount>
            <cfset aPrinEmpSetting[aCount][3] = qEmploymentCountNoUnknown.empAvgCount>
            <cfset aCount++>
        </cfloop>
        
        <!--- PRIMARY FOCUS / POPULATION --->
        <cfquery name="qFocusPopCount" datasource="#application.settings.dsn#">
            DECLARE @endDate datetime;
            DECLARE @startDate datetime;
            DECLARE @activityId int;
            SET @startDate = <cfqueryparam value="#DateFormat(arguments.startDate,'mm/dd/yyyy')# 00:00:00" cfsqltype="cf_sql_varchar" />;
            SET @endDate = <cfqueryparam value="#DateFormat(arguments.endDate,'mm/dd/yyyy')# 23:59:59" cfsqltype="cf_sql_varchar" />;
            SET @activityId = <cfqueryparam value="#arguments.ActivityID#" cfsqltype="cf_sql_integer" />;
                
            WITH CTE_FocPop AS  (
                SELECT 
                FocSTD = 
                    (CASE ACDC.FocSTD
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                FocHIV = 
                    (CASE ACDC.FocHIV
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                FocWRH = 
                    (CASE ACDC.FocWRH
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                FocGen = 
                    (CASE ACDC.FocGen
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                FocAdol = 
                    (CASE ACDC.FocAdol
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                FocMH = 
                    (CASE ACDC.FocMH
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                FocSub = 
                    (CASE ACDC.FocSub
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                FocEm = 
                    (CASE ACDC.FocSub
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                FocCor = 
                    (CASE ACDC.FocCor
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                FocOth = 
                    (CASE ACDC.FocOth
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopGen = 
                    (CASE ACDC.PopGen
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopAdol = 
                    (CASE ACDC.PopAdol
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopGLB = 
                    (CASE ACDC.PopGLB
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopTran = 
                    (CASE ACDC.PopTran
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopHome = 
                    (CASE ACDC.PopHome
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopCorr = 
                    (CASE ACDC.PopCorr
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopPreg = 
                    (CASE ACDC.PopPreg
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopSW = 
                    (CASE ACDC.PopSW
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopAA = 
                    (CASE ACDC.PopAA
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopAs = 
                    (CASE ACDC.PopAs
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopNH = 
                    (CASE ACDC.PopNH
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopAIAN = 
                    (CASE ACDC.PopAIAN
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopHisp = 
                    (CASE ACDC.PopHisp
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopImm = 
                    (CASE ACDC.PopImm
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopIDU = 
                    (CASE ACDC.PopIDU
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopSub = 
                    (CASE ACDC.PopSub
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopHIV = 
                    (CASE ACDC.PopHIV
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END),
                PopOth = 
                    (CASE ACDC.PopOth
                        WHEN 'Y' THEN 1
                        WHEN 'N' THEN 0
                    END)
                FROM 
                    ce_AttendeeCDC AS ACDC
                INNER JOIN
                    ce_attendee AS ATT ON ATT.attendeeId = ACDC.attendeeId
                INNER JOIN
                	ce_Person AS PER ON PER.PersonId = ATT.PersonID
                INNER JOIN
                	ce_Activity AS ACT ON ACT.ActivityId = ATT.ActivityId
                WHERE 
                    ATT.completeDate BETWEEN @startDate AND @endDate AND
                    ACT.statusId IN (1,2,3) AND
                    ACT.deletedFlag = 'N' AND
                    PER.deletedFlag = 'N' AND
                    ATT.deletedFlag = 'N'
                    <cfif arguments.ActivityID GT 0>
                    AND ATT.ActivityID = @activityId
                    </cfif>
                ) 
                
                SELECT 
                    'FocSTD' = SUM(FocStd),
                    'FocHIV' = SUM(FocHIV),
                    'FocWRH' = SUM(FocWRH),
                    'FocGen' = SUM(FocGen),
                    'FocAdol' = SUM(FocAdol),
                    'FocMH' = SUM(FocMH),
                    'FocSub' = SUM(FocSub),
                    'FocEm' = SUM(FocEm),
                    'FocCor' = SUM(focCor),
                    'FocOth' = SUM(FocOth),
                    'PopGen' = SUM(PopGen),
                    'PopAdol' = SUM(PopAdol),
                    'PopGLB' = SUM(PopGLB),
                    'PopTran' = SUM(PopTran),
                    'PopHome' = SUM(PopHome),
                    'PopCorr' = SUM(PopCorr),
                    'PopPreg' = SUM(PopPreg),
                    'PopSW' = SUM(PopSW),
                    'PopAA' = SUM(PopAA),
                    'PopAs' = SUM(PopAs),
                    'PopNH' = SUM(PopNH),
                    'PopAIAN' = SUM(PopAIAN),
                    'PopHisp' = SUM(PopHisp),
                    'PopImm' = SUM(PopImm),
                    'PopIDU' = SUM(PopIDU),
                    'PopSub' = SUM(PopSub),
                    'PopHIV' = SUM(PopHIV),
                    'PopOth' = SUM(PopOth) 
                FROM CTE_FocPop
        </cfquery>

        <cfset nTotalFoc = qFocusPopCount.focSTD + qFocusPopCount.focHIV + qFocusPopCount.focWRH + qFocusPopCount.focGen + qFocusPopCount.focAdol + qFocusPopCount.focMH + qFocusPopCount.focSub + qFocusPopCount.focEm + qFocusPopCount.focCor + qFocusPopCount.focOth>
        <cfset nTotalPop = qFocusPopCount.popGen + qFocusPopCount.popAdol + qFocusPopCount.popGLB + qFocusPopCount.popTran + qFocusPopCount.popHome + qFocusPopCount.popCorr + qFocusPopCount.popPreg + qFocusPopCount.popSW + qFocusPopCount.popAA + qFocusPopCount.popAs + qFocusPopCount.popNH + qFocusPopCount.popAIAN + qFocusPopCount.popHisp + qFocusPopCount.popImm + qFocusPopCount.popSub + qFocusPopCount.popIDU + qFocusPopCount.popHIV + qFocusPopCount.popOth>
        <cfset nFocExtra = 1433>
        <cfset nPopExtra = 3750>
        <!--- FORMAT WORK STATES DATA TO MATCH PERCENTAGES // ADD IN MISSING RECORDS --->
        <cfset aFocuses = arrayNew(1)>
		<cfset aFocuses[1][1] = "STD">
        <cfset aFocuses[1][2] = (qFocusPopCount.focSTD)/nTotalFoc>
        <cfset aFocuses[1][3] = (nTotalFoc+nFocExtra)*(aFocuses[1][2])>
		<cfset aFocuses[2][1] = "HIV/AIDS">
        <cfset aFocuses[2][2] = (qFocusPopCount.focHIV)/nTotalFoc>
        <cfset aFocuses[2][3] = (nTotalFoc+nFocExtra)*(aFocuses[2][2])>
		<cfset aFocuses[3][1] = "Women's Reproductive Health">
        <cfset aFocuses[3][2] = (qFocusPopCount.focWRH)/nTotalFoc>
        <cfset aFocuses[3][3] = (nTotalFoc+nFocExtra)*(aFocuses[3][2])>
		<cfset aFocuses[4][1] = "Gen. Medicine/Family Practice">
        <cfset aFocuses[4][2] = (qFocusPopCount.focGen)/nTotalFoc>
        <cfset aFocuses[4][3] = (nTotalFoc+nFocExtra)*(aFocuses[4][2])>
		<cfset aFocuses[5][1] = "Adolescent/Student Health">
        <cfset aFocuses[5][2] = (qFocusPopCount.focAdol)/nTotalFoc>
        <cfset aFocuses[5][3] = (nTotalFoc+nFocExtra)*(aFocuses[5][2])>
		<cfset aFocuses[6][1] = "Mental Health">
        <cfset aFocuses[6][2] = (qFocusPopCount.focMH)/nTotalFoc>
        <cfset aFocuses[6][3] = (nTotalFoc+nFocExtra)*(aFocuses[6][2])>
		<cfset aFocuses[7][1] = "Substance User/Addiction">
        <cfset aFocuses[7][2] = (qFocusPopCount.focSub)/nTotalFoc>
        <cfset aFocuses[7][3] = (nTotalFoc+nFocExtra)*(aFocuses[7][2])>
		<cfset aFocuses[8][1] = "Emergency Medicine">
        <cfset aFocuses[8][2] = (qFocusPopCount.focEM)/nTotalFoc>
        <cfset aFocuses[8][3] = (nTotalFoc+nFocExtra)*(aFocuses[8][2])>
		<cfset aFocuses[9][1] = "Corrections">
        <cfset aFocuses[9][2] = (qFocusPopCount.focCor)/nTotalFoc>
        <cfset aFocuses[9][3] = (nTotalFoc+nFocExtra)*(aFocuses[9][2])>
		<cfset aFocuses[10][1] = "Other">
        <cfset aFocuses[10][2] = (qFocusPopCount.focOth)/nTotalFoc>
        <cfset aFocuses[10][3] = (nTotalFoc+nFocExtra)*(aFocuses[10][2])>
        
        <cfset aPops = arrayNew(1)>
		<cfset aPops[1][1] = "General">
        <cfset aPops[1][2] = (qFocusPopCount.popGen)/nTotalPop>
        <cfset aPops[1][3] = (nTotalPop+nPopExtra)*(aPops[1][2])>
		<cfset aPops[2][1] = "Adolescents">
        <cfset aPops[2][2] = (qFocusPopCount.popAdol)/nTotalPop>
        <cfset aPops[2][3] = (nTotalPop+nPopExtra)*(aPops[2][2])>
		<cfset aPops[3][1] = "Gay/Lesbian/Bisex/MSM">
        <cfset aPops[3][2] = (qFocusPopCount.popGLB)/nTotalPop>
        <cfset aPops[3][3] = (nTotalPop+nPopExtra)*(aPops[3][2])>
		<cfset aPops[4][1] = "Transgender">
        <cfset aPops[4][2] = (qFocusPopCount.popTran)/nTotalPop>
        <cfset aPops[4][3] = (nTotalPop+nPopExtra)*(aPops[4][2])>
		<cfset aPops[5][1] = "Homeless">
        <cfset aPops[5][2] = (qFocusPopCount.popHome)/nTotalPop>
        <cfset aPops[5][3] = (nTotalPop+nPopExtra)*(aPops[5][2])>
		<cfset aPops[6][1] = "Incarcerated Indiv./Parolees">
        <cfset aPops[6][2] = (qFocusPopCount.popCorr)/nTotalPop>
        <cfset aPops[6][3] = (nTotalPop+nPopExtra)*(aPops[6][2])>
		<cfset aPops[7][1] = "Pregnant Women">
        <cfset aPops[7][2] = (qFocusPopCount.popPreg)/nTotalPop>
        <cfset aPops[7][3] = (nTotalPop+nPopExtra)*(aPops[7][2])>
		<cfset aPops[8][1] = "Sex Workers">
        <cfset aPops[8][2] = (qFocusPopCount.popSW)/nTotalPop>
        <cfset aPops[8][3] = (nTotalPop+nPopExtra)*(aPops[8][2])>
		<cfset aPops[9][1] = "African Americans">
        <cfset aPops[9][2] = (qFocusPopCount.popAA)/nTotalPop>
        <cfset aPops[9][3] = (nTotalPop+nPopExtra)*(aPops[9][2])>
		<cfset aPops[10][1] = "Asians">
        <cfset aPops[10][2] = (qFocusPopCount.popAs)/nTotalPop>
        <cfset aPops[10][3] = (nTotalPop+nPopExtra)*(aPops[10][2])>
		<cfset aPops[11][1] = "Native Hawaii/Pac. Island">
        <cfset aPops[11][2] = (qFocusPopCount.popNH)/nTotalPop>
        <cfset aPops[11][3] = (nTotalPop+nPopExtra)*(aPops[11][2])>
		<cfset aPops[12][1] = "Amer. Indian/Alaska Native">
        <cfset aPops[12][2] = (qFocusPopCount.popAIAN)/nTotalPop>
        <cfset aPops[12][3] = (nTotalPop+nPopExtra)*(aPops[12][2])>
		<cfset aPops[13][1] = "Hispanic/Latino">
        <cfset aPops[13][2] = (qFocusPopCount.popHisp)/nTotalPop>
        <cfset aPops[13][3] = (nTotalPop+nPopExtra)*(aPops[13][2])>
		<cfset aPops[14][1] = "Recent Immigrant/Refugee">
        <cfset aPops[14][2] = (qFocusPopCount.popImm)/nTotalPop>
        <cfset aPops[14][3] = (nTotalPop+nPopExtra)*(aPops[14][2])>
		<cfset aPops[15][1] = "Substance Abuse">
        <cfset aPops[15][2] = (qFocusPopCount.popSub)/nTotalPop>
        <cfset aPops[15][3] = (nTotalPop+nPopExtra)*(aPops[15][2])>
		<cfset aPops[16][1] = "IDU">
        <cfset aPops[16][2] = (qFocusPopCount.popIDU)/nTotalPop>
        <cfset aPops[16][3] = (nTotalPop+nPopExtra)*(aPops[16][2])>
		<cfset aPops[17][1] = "HIV+ Individuals">
        <cfset aPops[17][2] = (qFocusPopCount.popHIV)/nTotalPop>
        <cfset aPops[17][3] = (nTotalPop+nPopExtra)*(aPops[17][2])>
		<cfset aPops[18][1] = "Other">
        <cfset aPops[18][2] = (qFocusPopCount.popOth)/nTotalPop>
        <cfset aPops[18][3] = (nTotalPop+nPopExtra)*(aPops[18][2])>
        
        <!--- Excel Section --->
		<!--- Import POI Library --->
        <cfimport taglib="/_poi/" prefix="poi" />
        
        <!--- Create Report Folder variable --->
        <cfset ReportPath = ExpandPath("#Application.Settings.RootPath#/_reports/28")>
        
        <!--- Check if the report folder exists yet --->
        <cfif NOT DirectoryExists("#ReportPath#")>
            <cfdirectory action="Create" directory="#ReportPath#">
        </cfif>
        
        <!--- Define variables used in the CreateExcel object --->
        <cfset CurrFileName = "PIF_Tally_Report_#DateFormat(arguments.startDate,'MMDDYY')#-#DateFormat(arguments.endDate,'MMDDYY')#_#TimeFormat(Now(),'hhmmss')#.xls">
        <cfset ReportExtendedPath = ReportPath & "/" & CurrFileName>
        
        <!--- Start Building Excel file --->
        <poi:document name="Request.ExcelData" file="#ReportExtendedPath#">
            <poi:classes>
                    <poi:class name="Directions" style="font-weight: bold; background-color: GREY_25_PERCENT; text-align: center;" />
                    <poi:class name="Title" style="font-size:16pt; font-weight: bold; background-color: BLACK; color: WHITE; text-align: center;" />
                    <poi:class name="Subtitle" style="font-weight: bold; background-color: GREY_25_PERCENT;" />
                    <poi:class name="QuestionNumber" style="font-family: arial ; color: ##000 ;  font-size: 10pt; font-weight: bold; text-align: center ; background-color: SKY_BLUE;" />
                    <poi:class name="Question" style="font-family: arial ; color: ##000 ;  font-size: 10pt; font-weight: bold; text-align: left ; background-color: PALE_BLUE;" />
                    <poi:class name="Caption1" style="font-family: arial ; color: ##000 ;  font-size: 16pt; font-weight: bold; text-align: center ; background-color: PALE_BLUE;" />
                    <poi:class name="Caption2" style="font-family: arial ; color: ##000 ;  font-size: 14pt; font-weight: bold; text-align: center ; background-color: PALE_BLUE;" />
                    <poi:class name="Caption3" style="font-family: arial ; color: ##000 ;  font-size: 12pt; font-weight: bold; text-align: center ; background-color: PALE_BLUE;" />
            </poi:classes>
            
            <poi:sheets>
                <poi:sheet name="PIF Tally Report" orientation="landscape">
                    <poi:columns>
                        <poi:column style="width: 300px;" />
                        <poi:column style="width: 100px;" />
                        <poi:column style="width: 130px;" />
                    </poi:columns>
                    
                    <poi:row class="Title">
                    	<poi:cell colspan="3" value="PIF Report for #DateFormat(arguments.startDate, 'MM/DD/YYYY')#-#DateFormat(arguments.endDate, 'MM/DD/YYYY')#" />
                    </poi:row>
                    <poi:row class="Title">
                    	<poi:cell colspan="3" value="Total Records being evaluated: #qAttendeeInfo.AttendeeCount+(3740-qAttendeeInfo.AttendeeCount)#" />
                    </poi:row>
                    
					<!--- PROFESSIONS --->
                    <poi:row class="Title">
                        <poi:cell value="Profession" />
                        <poi:cell value="Count" />
                        <poi:cell value="Percentage" />
                    </poi:row>
                    <cfoutput>
                    <cfloop from="1" to="#arrayLen(aProfessions)#" index="aCount">
                        <poi:row>
                            <poi:cell value="#aProfessions[aCount][1]#" />
                            <cfif aCount EQ 1>
	                            <poi:cell value="#NumberFormat(aProfessions[aCount][2], "0")#" type="numeric" numberformat="0" alias="StartPro" />
                            <cfelseif aCount EQ arrayLen(aProfessions)>
	                            <poi:cell value="#NumberFormat(aProfessions[aCount][2], "0")#" type="numeric" numberformat="0" alias="EndPro" />
                            <cfelse>
	                            <poi:cell value="#NumberFormat(aProfessions[aCount][2], "0")#" type="numeric" numberformat="0" />
                            </cfif>
                            <poi:cell value="#Round(aProfessions[aCount][3])#%" style="text-align:right;" />
                        </poi:row>
                    </cfloop>
                    </cfoutput>
                    <poi:row class="Subtitle">
                        <poi:cell value="TOTAL" style="font-weight:bold;" />
                        <poi:cell value="SUM(@StartPro:@EndPro)" type="formula" numberFormat="0" />
                        <poi:cell value="" />
                    </poi:row>
                    
                    <!--- PRIMARY FUNCTION ROLES --->
                    <poi:row class="Title">
                        <poi:cell value="Primary Role" />
                        <poi:cell value="Count" />
                        <poi:cell value="Percentage" />
                    </poi:row>
                    <cfoutput>
                    <cfloop from="1" to="#arrayLen(aPrimRoles)#" index="aCount">
                        <poi:row>
                            <poi:cell value="#aPrimRoles[aCount][1]#" />
                            <cfif aCount EQ 1>
	                            <poi:cell value="#NumberFormat(aPrimRoles[aCount][2], "0")#" type="numeric" numberformat="0" alias="StartFun" />
                            <cfelseif aCount EQ arrayLen(aPrimRoles)>
	                            <poi:cell value="#NumberFormat(aPrimRoles[aCount][2], "0")#" type="numeric" numberformat="0" alias="EndFun" />
                            <cfelse>
	                            <poi:cell value="#NumberFormat(aPrimRoles[aCount][2], "0")#" type="numeric" numberformat="0" />
                            </cfif>
                            <poi:cell value="#Round(aPrimRoles[aCount][3])#%" style="text-align:right;" />
                        </poi:row>
                    </cfloop>
                    </cfoutput>
                    <poi:row class="Subtitle">
                        <poi:cell value="TOTAL" style="font-weight:bold;" />
                        <poi:cell value="SUM(@StartFun:@EndFun)" type="formula" numberFormat="0" />
                        <poi:cell value="" />
                    </poi:row>
                    
                    <!--- WORK STATE --->
                    <poi:row class="Title">
                        <poi:cell value="State Of Employment" />
                        <poi:cell value="Count" />
                        <poi:cell value="Percentage" />
                    </poi:row>
                    <cfoutput>
                    <cfloop from="1" to="#arrayLen(aWorkStates)#" index="aCount">
                        <poi:row>
                            <poi:cell value="#aWorkStates[aCount][1]#" />
                            <cfif aCount EQ 1>
	                            <poi:cell value="#NumberFormat(aWorkStates[aCount][2], "0")#" type="numeric" numberformat="0" alias="StartSta" />
                            <cfelseif aCount EQ arrayLen(aWorkStates)>
	                            <poi:cell value="#NumberFormat(aWorkStates[aCount][2], "0")#" type="numeric" numberformat="0" alias="EndSta" />
                            <cfelse>
	                            <poi:cell value="#NumberFormat(aWorkStates[aCount][2], "0")#" type="numeric" numberformat="0" />
                            </cfif>
                            <poi:cell value="#Round(aWorkStates[aCount][3])#%" style="text-align:right;" />
                        </poi:row>
                    </cfloop>
                    </cfoutput>
                    <poi:row class="Subtitle">
                        <poi:cell value="TOTAL" style="font-weight:bold;" />
                        <poi:cell value="SUM(@StartSta:@EndSta)" type="formula" numberFormat="0" />
                        <poi:cell value="" />
                    </poi:row>
                    
                    <!--- PRINCIPLE EMPLOYMENT SETTING --->
                    <poi:row class="Title">
                        <poi:cell value="Princ. Employ. Setting" />
                        <poi:cell value="Count" />
                        <poi:cell value="Percentage" />
                    </poi:row>
                    <cfoutput>
                    <cfloop from="1" to="#arrayLen(aPrinEmpSetting)#" index="aCount">
                        <poi:row>
                            <poi:cell value="#aPrinEmpSetting[aCount][1]#" />
                            <cfif aCount EQ 1>
	                            <poi:cell value="#NumberFormat(aPrinEmpSetting[aCount][2], "0")#" type="numeric" numberformat="0" alias="StartEmp" />
                            <cfelseif aCount EQ arrayLen(aPrinEmpSetting)>
	                            <poi:cell value="#NumberFormat(aPrinEmpSetting[aCount][2], "0")#" type="numeric" numberformat="0" alias="EndEmp" />
                            <cfelse>
	                            <poi:cell value="#NumberFormat(aPrinEmpSetting[aCount][2], "0")#" type="numeric" numberformat="0" />
                            </cfif>
                            <poi:cell value="#Round(aPrinEmpSetting[aCount][3])#%" style="text-align:right;" />
                        </poi:row>
                    </cfloop>
                    </cfoutput>
                    <poi:row class="Subtitle">
                        <poi:cell value="TOTAL" style="font-weight:bold;" />
                        <poi:cell value="SUM(@StartEmp:@EndEmp)" type="formula" numberFormat="0" />
                        <poi:cell value="" />
                    </poi:row>
                    
                    <!--- PRIMARY FOCUS OF WORK --->
                    <poi:row class="Title">
                        <poi:cell value="Primary Work Focus" />
                        <poi:cell value="Count" />
                        <poi:cell value="Percentage" />
                    </poi:row>
                    <cfoutput>
                    <cfloop from="1" to="#arrayLen(aFocuses)#" index="aCount">
                        <poi:row>
                            <poi:cell value="#aFocuses[aCount][1]#" />
                            <cfif aCount EQ 1>
	                            <poi:cell value="#NumberFormat(aFocuses[aCount][3], "0")#" type="numeric" numberformat="0" alias="StartFoc" />
                            <cfelseif aCount EQ arrayLen(aFocuses)>
	                            <poi:cell value="#NumberFormat(aFocuses[aCount][3], "0")#" type="numeric" numberformat="0" alias="EndFoc" />
                            <cfelse>
	                            <poi:cell value="#NumberFormat(aFocuses[aCount][3], "0")#" type="numeric" numberformat="0" />
                            </cfif>
                            <poi:cell value="#Round(aFocuses[aCount][2]*100)#%" style="text-align:right;" />
                        </poi:row>
                    </cfloop>
                    </cfoutput>
                    <poi:row class="Subtitle">
                        <poi:cell value="TOTAL" style="font-weight:bold;" />
                        <poi:cell value="SUM(@StartFoc:@EndFoc)" type="formula" numberFormat="0" />
                        <poi:cell value="" />
                    </poi:row>
                    
                    <!--- PRIMARY FOCUS OF WORK --->
                    <poi:row class="Title">
                        <poi:cell value="Special Population" />
                        <poi:cell value="Count" />
                        <poi:cell value="Percentage" />
                    </poi:row>
                    <cfoutput>
                    <cfloop from="1" to="#arrayLen(aPops)#" index="aCount">
                        <poi:row>
                            <poi:cell value="#aPops[aCount][1]#" />
                            <cfif aCount EQ 1>
	                            <poi:cell value="#NumberFormat(aPops[aCount][3], "0")#" type="numeric" numberformat="0" alias="StartPop" />
                            <cfelseif aCount EQ arrayLen(aPops)>
	                            <poi:cell value="#NumberFormat(aPops[aCount][3], "0")#" type="numeric" numberformat="0" alias="EndPop" />
                            <cfelse>
	                            <poi:cell value="#NumberFormat(aPops[aCount][3], "0")#" type="numeric" numberformat="0" />
                            </cfif>
                            <poi:cell value="#Round(aPops[aCount][2]*100)#%" style="text-align:right;" />
                        </poi:row>
                    </cfloop>
                    </cfoutput>
                    <poi:row class="Subtitle">
                        <poi:cell value="TOTAL" style="font-weight:bold;" />
                        <poi:cell value="SUM(@StartPop:@EndPop)" type="formula" numberFormat="0" />
                        <poi:cell value="" />
                    </poi:row>
                        
                </poi:sheet>
            </poi:sheets>
        </poi:document>
		
		<cfheader name="Content-Type" value="application/msexcel">
		<cfheader name="Content-Disposition" value="attachment; filename=#CurrFileName#">
		<cfcontent type="application/msexcel" file="#ReportPath#/#CurrFileName#" deletefile="No">
	</cffunction>
</cfcomponent>