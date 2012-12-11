<cffunction name="getMemberInfo" hint="Returns Member information." access="public" output="false">
	<cfargument name="PersonID" type="numeric" required="yes">
    
    <cfquery name="MemberInfo" datasource="#Application.Settings.DSN#">
    	SELECT 
        	P.FirstName, 
            P.MiddleName, 
			P.LastName, 
            P.DisplayName,
            P.Birthdate,  
            P.password, 
            P.Email, 
            P.EthnicityID, 
            <!---pd_person.OMBEthnicityId, --->
            P.Gender, 
            SD.Name AS DegreeName 
        FROM   ce_Person P
        LEFT OUTER JOIN ce_Person_Degree PD ON PD.PersonID = P.PersonID AND PD.DeletedFlag = 'N'
        LEFT OUTER JOIN ce_Sys_Degree SD ON SD.DegreeID = PD.DegreeID
        WHERE  P.Personid = <cfqueryparam value="#Arguments.PersonID#" cfsqltype="cf_sql_integer" />
    </cfquery>
	
	<cfif MemberInfo.RecordCount GT 0>
		<cfset Session.FirstName = MemberInfo.FirstName>
		<cfset Session.MiddleName = MemberInfo.MiddleName>
		<cfset Session.LastName = MemberInfo.LastName>
		<cfset Session.DisplayName = MemberInfo.DisplayName>
		<cfset Session.Birthdate = MemberInfo.Birthdate>
		<cfset Session.Email = MemberInfo.Email>
		<cfset Session.EthnicityID = MemberInfo.EthnicityID>
		<!---<cfset Session.OMBEthnicityID = MemberInfo.ombethnicityid>--->
		<cfset Session.Gender = MemberInfo.gender>
		<cfset Session.Degree = MemberInfo.DegreeName>
		
		<cfif Session.Degree NEQ "">
			<cfset Session.NameWithDegree = Session.DisplayName & ", " & Session.Degree>
		<cfelse>
			<cfset Session.namewithdegree = Session.DisplayName>
		</cfif>
	</cfif>
</cffunction>