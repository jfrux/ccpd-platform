<cfcomponent>
	<cffunction name="Run" output="yes" access="remote" returntype="string" returnformat="plain">
        <cfloop condition="#needsMoreUpdating()# EQ true">
        	<cfset qPeople = getRecords()>
            
            <cfloop query="qPeople">
            	<cftry>
					<!--- INSERT EMAIL RECORD --->
                    <cfquery name="qInsertEmail" datasource="#application.settings.dsn#" result="newEmail">
                        INSERT INTO ce_Person_Email
                            (
                                person_id,
                                email_address,
                                is_verified,
                                verification_key,
                                allow_login
                            )
                        VALUES
                            (
                                <cfqueryparam value="#qPeople.personId#" cfsqltype="cf_sql_integer" />,
                                <cfqueryparam value="#qPeople.email#" cfsqltype="cf_sql_varchar" />,
                                <cfqueryparam value="1" cfsqltype="cf_sql_integer" />,
                                <cfqueryparam value="#application.UDF.getRandomString()#" cfsqltype="cf_sql_varchar" />,
                                <cfqueryparam value="1" cfsqltype="cf_sql_integer" />
                            )
                    </cfquery>
                    
                    <!--- DETERMINE IF AN INSERT OR UPDATE SHOULD HAPPEN TO PERSON PREFERENCES --->
                    <cfif len(qPeople.personPrefId) GT 0>
                        <!--- UPDATE --->
                        <cfquery name="qUpdatePref" datasource="#application.settings.dsn#">
                            UPDATE ce_Person_Pref
                            SET
                                primaryEmailId = <cfqueryparam value="#newEmail.IDENTITYCOL#" cfsqltype="cf_sql_integer" />,
                                updatedAt = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp" />
                            WHERE
                                personId = <cfqueryparam value="#qPeople.personId#" cfsqltype="cf_sql_integer" />
                        </cfquery>
                    <cfelse>
                        <!--- INSERT --->
                        <cfquery name="qInsertEmail" datasource="#application.settings.dsn#">
                            INSERT INTO ce_Person_Pref
                                (
                                    personId,
                                    emailSpecialtyFlag,
                                    PrimaryEmailId
                                )
                            VALUES
                                (
                                    <cfqueryparam value="#qPeople.personId#" cfsqltype="cf_sql_integer" />,
                                    <cfqueryparam value="Y" cfsqltype="cf_sql_varchar" />,
                                    <cfqueryparam value="#newEmail.IDENTITYCOL#" cfsqltype="cf_sql_integer" />
                                )
                        </cfquery>
                    </cfif>
                    <cfcatch type="any">
                    	<cfquery name="qDeleteEmailRecord" datasource="#application.settings.dsn#">
                        	DELETE FROM ce_person_email
                            WHERE email_address=<cfqueryparam value="#qPeople.email#" cfsqltype="cf_sql_varchar" />
                        </cfquery>
                        
			            <cfdump var="#qPeople.personId#"><cfabort>
                    </cfcatch>
                </cftry>
            </cfloop>
        </cfloop>
	</cffunction>
    
    <cffunction name="needsMoreUpdating" access="private" output="false" returntype="boolean">
    	<cfset var status = false>
        
        <cfquery name="qPeople" datasource="#application.settings.dsn#">
        	SELECT
            	COUNT(p.personId) AS emailCount
            FROM
            	ce_person AS p
            LEFT JOIN 
            	ce_person_pref AS pr ON pr.personId = p.personId
            WHERE
            	p.deletedFlag='N' AND
                p.email <> '' AND
                p.email IS NOT NULL AND
                pr.primaryEmailId IS NULL AND
                (SELECT COUNT(person_Id) FROM ce_person_email AS pe WHERE pe.person_Id = p.personId) = 0
        </cfquery>
        
        <cfif qPeople.emailCount GT 0>
        	<cfset status = true>
        </cfif>
        
        <cfreturn status />
    </cffunction>
    
    <cffunction name="getRecords" access="private" output="false" returntype="query">
        <cfquery name="qPeople" datasource="#application.settings.dsn#">
        	SELECT TOP 5000
            	p.personId,
                p.email,
                pr.personPrefId
            FROM
            	ce_person AS p
            LEFT JOIN 
            	ce_person_pref AS pr ON pr.personId = p.personId
            WHERE
            	p.deletedFlag='N' AND
                p.email <> '' AND
                p.email IS NOT NULL AND
                pr.primaryEmailId IS NULL AND
                (SELECT COUNT(person_Id) FROM ce_person_email AS pe WHERE pe.person_Id = p.personId) = 0
        </cfquery>
        
        <cfreturn qPeople />
    </cffunction>
</cfcomponent>