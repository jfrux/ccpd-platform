<cfcomponent>
	<cfinclude template="#Request.RootPath#/Includes/inc_User_Info.cfm" />
    
	<cffunction name="Validate" access="Remote" output="false" returntype="string">
		<cfargument name="PersonID" type="numeric" required="no" default="0">
        <cfargument name="Birthdate" type="string" required="no">
        <cfargument name="FirstName" type="string" required="yes">
        <cfargument name="MiddleName" type="string" required="no" default="">
        <cfargument name="LastName" type="string" required="yes">
        <cfargument name="DisplayName" type="string" required="no" default="#Arguments.FirstName# #Arguments.LastName#">
        <cfargument name="Suffix" type="string" required="no" default="">
        <cfargument name="Email1" type="string" required="yes">
        <cfargument name="Email2" type="string" required="yes">
        <cfargument name="SSN" type="string" required="yes">
        <cfargument name="Gender" type="string" required="yes">
        <cfargument name="Password1" type="string" required="yes">
        <cfargument name="Password2" type="string" required="yes">
        
        <cfset var Status = "Fail|Cannot access validate function for authentication information.">
        
        <!--- CREATE PERSON RECORD --->
        <cfset Status = Application.Auth.Validate(
							Birthdate=Arguments.Birthdate,
							FirstName=Arguments.FirstName,
							MiddleName=Arguments.MiddleName,
							LastName=Arguments.LastName,
							DisplayName=Arguments.DisplayName,
							Suffix=Arguments.Suffix,
							Email1=Arguments.Email1,
							Email2=Arguments.Email2,
							SSN=Arguments.SSN,
							Gender=Arguments.Gender,
							Password1=Arguments.Password1,
							Password2=Arguments.Password2,
							SiteID=4)>
    
    	<cfreturn Status />
	</cffunction>
    
	<cffunction name="Register" access="Remote" output="false" returntype="string">
		<cfargument name="PersonID" type="numeric" required="no" default="0">
        <cfargument name="Birthdate" type="string" required="no">
        <cfargument name="FirstName" type="string" required="yes">
        <cfargument name="MiddleName" type="string" required="no" default="">
        <cfargument name="LastName" type="string" required="yes">
        <cfargument name="DisplayName" type="string" required="no" default="#Arguments.FirstName# #Arguments.LastName#">
        <cfargument name="Suffix" type="string" required="no" default="">
        <cfargument name="Email1" type="string" required="yes">
        <cfargument name="Email2" type="string" required="yes">
        <cfargument name="SSN" type="string" required="yes">
        <cfargument name="Gender" type="string" required="yes">
        <cfargument name="Password1" type="string" required="yes">
        <cfargument name="Password2" type="string" required="yes">
        
        <cfset var Status = "Fail|Cannot access register function for authentication information.">
        
        <!--- CREATE PERSON RECORD --->
        <cfset ProperlyRegistered = Application.Auth.Register(
							PersonID=Arguments.PersonID,
							Birthdate=Arguments.Birthdate,
							FirstName=Arguments.FirstName,
							MiddleName=Arguments.MiddleName,
							LastName=Arguments.LastName,
							DisplayName=Arguments.DisplayName,
							Suffix=Arguments.Suffix,
							Email1=Arguments.Email1,
							SSN=Arguments.SSN,
							Gender=Arguments.Gender,
							Password1=Arguments.Password1,
							SiteID=4)>
        
        <cfif ProperlyRegistered>
        	<cflocation url="#Request.RootPath#/Welcome.cfm" addtoken="no">
        <cfelse>
        	<cflocation url="#Request.RootPath#/Register.cfm?e=Registration is currently experiencing issues.  Please <a href='#Request.RootPath#/cdc_contact.cfm?type=1'>contact us</a> regarding your issue." addtoken="no">
        </cfif>
        
        <cfreturn Status />
    </cffunction>
</cfcomponent>