<cfcomponent>
	<cffunction name="getAttendees" access="private" output="false" returntype="query">
    	<cfargument name="startDate" type="string" required="yes">
    	<cfargument name="endDate" type="string" required="yes">
        
        <cfquery name="qAttendees" datasource="#application.settings.dsn#" timeout="600">
            DECLARE @StartDate datetime;
            DECLARE @EndDate datetime;
            
            SET @StartDate = <cfqueryparam value="#DateFormat(arguments.startDate, 'MM/DD/YYYY')#" cfsqltype="cf_sql_date" />;
            SET @EndDate = <cfqueryparam value="#DateFormat(arguments.endDate, 'MM/DD/YYYY')#" cfsqltype="cf_sql_date" />;
            
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
                            ELSE NULL 
                        END 
                    ELSE
                        sd.name
                END As degree,
                zips.*  
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
                        (att.completeDate BETWEEN '1/1/2008 00:00:00' AND '12/31/2011 23:59:59')  AND
                        A.activityId IN (
                                         SELECT actcat.ActivityID
                                         FROM ce_Activity_Category AS actcat 
                                         INNER JOIN ce_Category AS cat ON actcat.CategoryID = cat.CategoryID
                                         WHERE 
                                            <cfloop from="#datePart('yyyy', currStartDate)#" to="#datePart('yyyy', currEndDate)#" index="currYear">
                                            (cat.Name LIKE 'ACCME #currYear#') AND actcat.deletedFlag='N'<cfif currYear NEQ datePart('yyyy', currEndDate)> OR </cfif>
                                            </cfloop>
                                        )
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
        
        <!--- QUERY qAttendees FOR GROUPED DEGREE INFO --->
        <cfquery name="qDegrees" dbtype="query">
            SELECT	
                degree,
                Count(PersonID) AS AttendeeCount
            FROM qAttendees
            GROUP BY degree
        </cfquery>
        
        <!--- CREATE STAT LOG RECORD --->
        <cfquery name="qCreateLog" datasource="#application.settings.dsn#" result="newLog">
            INSERT INTO ce_stat_log 
            (
                logTypeId,
                created
            )
            VALUES
            (
                <cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
                <cfqueryparam value="#dateFormat(arguments.startDate, 'MM/DD/YYYY')#" cfsqltype="cf_sql_timestamp" />
            )
        </cfquery>
    </cffunction>
    
	<cffunction name="loopedRun" access="remote" output="false" returntype="string">
    	<cfargument name="startDate" type="string" required="no" default="#dateAdd('d', -1, now())#">
    	<cfargument name="endDate" type="string" required="no" default="#dateAdd('d', -1, now())#">
    	<cfargument name="message" type="string" required="no" default="">
        
		<cfset var status = createObject("component","_com.returnData.buildStruct").init()>
        
        <cfloop from="#arguments.startDate# 00:00:00" to="#arguments.endDate# 23:59:59" step="#createTimeSpan(1,0,0,0)#" index="currDay">
        	<cfset currStartDate = DateFormat(currDay, 'MM/DD/YYYY') & " 00:00:00">
        	<cfset currEndDate = DateFormat(currDay, 'MM/DD/YYYY') & " 23:59:59">
            
            <!--- GET THE ATTENDEE DATA --->
        	<cfset qAttendees = getAttendees(currStartDate, currEndDate)>
            
            <!--- QUERY qAttendees FOR GROUPED STATE INFO --->
			<cfquery name="qStates" dbtype="query">
            	SELECT	
                	adminCode1 AS state,
                    Count(PersonID) AS AttendeeCount
                FROM qAttendees
                GROUP BY adminCode1
            </cfquery>
            
            <!--- QUERY qAttendees FOR GROUPED DEGREE INFO --->
			<cfquery name="qDegrees" dbtype="query">
            	SELECT	
                	degree,
                    Count(PersonID) AS AttendeeCount
                FROM qAttendees
                GROUP BY degree
            </cfquery>
            
            <!--- CREATE STAT LOG RECORD --->
            <cfquery name="qCreateLog" datasource="#application.settings.dsn#" result="newLog">
            	INSERT INTO ce_stat_log 
                (
                	logTypeId,
                    created
                )
                VALUES
                (
                	<cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
                    <cfqueryparam value="#dateFormat(currDay, 'MM/DD/YYYY')#" cfsqltype="cf_sql_timestamp" />
                )
            </cfquery>
            
            <!--- SET THE LOGID --->
            <cfset currLogId = newLog.identityCol>
            
            <!--- CREATE STATE STRUCTURE --->
            <cfset states = {} />
            
            <!--- LOOP OVER STATE INFO --->
            <cfloop query="qStates">
            	<!--- DETERMINE IF CURRENT STATE IS IN THE STATE STRUCT --->
            	<cfif NOT structKeyExists(states, qStates.state)>
                	<cfif len(trim(qStates.state)) EQ 0>
                    	<cfset qStates.state = "NoState">
                    </cfif>
                    
                	<cfset states[qStates.state] = qStates.attendeeCount>
                <cfelse>
                	<cfset states[qStates.state] += qStates.attendeeCount>
                </cfif>
                
                <cfquery name="qStateStat" datasource="#application.settings.dsn#">
                	SELECT statTypeId, name
                    FROM ce_sys_stat_type
                    WHERE name LIKE '#qStates.state#_attendees'
                </cfquery>
                
                <cfif qStateStat.recordCount GT 0>
                	<cfquery name="qInsertStat" datasource="#application.settings.dsn#">
                    	INSERT INTO ce_stat_entry
                        (
                        	logId,
                            statTypeId,
                            value
                        )
                        VALUES
                        (
                        	#currLogId#,
                            #qStateStat.statTypeId#,
                            #states[qStates.state]#
                        )
                    </cfquery>
                </cfif>
            </cfloop>
        </cfloop>
    
		<cfset status.setStatus(true)>
        
        <cfreturn status.getJSON() />
    </cffunction>
    
	<cffunction name="report" access="remote" output="false" returntype="string">
    	<cfargument name="startDate" type="string" required="no" default="#dateAdd('d', -1, now())#">
    	<cfargument name="endDate" type="string" required="no" default="#dateAdd('d', -1, now())#">
        
		<cfset var status = createObject("component","_com.returnData.buildStruct").init()>
        
		<cfset currStartDate = DateFormat(arguments.startDate, 'MM/DD/YYYY') & " 00:00:00">
        <cfset currEndDate = DateFormat(arguments.endDate, 'MM/DD/YYYY') & " 23:59:59">
        
        <cfset qAttendees = getAttendees(currStartDate, currEndDate)>
        
        <!--- SET THE LOGID --->
        <cfset currLogId = newLog.identityCol>
        
        <!--- CREATE STATE STRUCTURE --->
        <cfset states = {} />
        
        <!--- LOOP OVER STATE INFO --->
        <cfloop query="qStates">
            <!--- DETERMINE IF CURRENT STATE IS IN THE STATE STRUCT --->
            <cfif NOT structKeyExists(states, qStates.state)>
                <cfif len(trim(qStates.state)) EQ 0>
                    <cfset qStates.state = "NoState">
                </cfif>
                
                <cfset states[qStates.state] = qStates.attendeeCount>
            <cfelse>
                <cfset states[qStates.state] += qStates.attendeeCount>
            </cfif>
            
            <cfquery name="qStateStat" datasource="#application.settings.dsn#">
                SELECT statTypeId, name
                FROM ce_sys_stat_type
                WHERE name LIKE '#qStates.state#_attendees'
            </cfquery>
            
            <cfif qStateStat.recordCount GT 0>
                <cfquery name="qInsertStat" datasource="#application.settings.dsn#">
                    INSERT INTO ce_stat_entry
                    (
                        logId,
                        statTypeId,
                        value
                    )
                    VALUES
                    (
                        #currLogId#,
                        #qStateStat.statTypeId#,
                        #states[qStates.state]#
                    )
                </cfquery>
            </cfif>
        </cfloop>
    
		<cfset status.setStatus(true)>
        
        <cfreturn status.getJSON() />
    </cffunction>
</cfcomponent>