<cfcomponent displayname="API">
	<cffunction name="signup" access="remote" output="false" returntype="string" returnformat="plain">
		<cfargument name="PersonID" type="numeric" required="no" default="0">
        <cfargument name="FirstName" type="string" required="no" default="">
        <cfargument name="MiddleName" type="string" required="no" default="">
        <cfargument name="LastName" type="string" required="no" default="">
        <cfargument name="DisplayName" type="string" required="no" default="#Arguments.FirstName# #Arguments.LastName#">
        <cfargument name="Suffix" type="string" required="no" default="">
        <cfargument name="Email1" type="string" required="no" default="">
        <cfargument name="Email2" type="string" required="no" default="">
        <cfargument name="Gender" type="string" required="no" default="">
        <cfargument name="Password1" type="string" required="no" default="">
        <cfargument name="Password2" type="string" required="no" default="">
        <cfargument name="autoauth" type="string" required="no" default="false">
		<cfargument name="clientid" type="string" required="yes" />
		<cfargument name="authkey" type="string" required="yes" />
        
        <cfset var Status = createobject("component","#application.settings.com#returnData.buildStruct").init()>
		
		
		<cfset Status = Application.Auth.Validate(
							FirstName=Arguments.FirstName,
							MiddleName=Arguments.MiddleName,
							LastName=Arguments.LastName,
							DisplayName=Arguments.DisplayName,
							Suffix=Arguments.Suffix,
							Email1=Arguments.Email1,
							Email2=Arguments.Email2,
							Gender=Arguments.Gender,
							Password1=Arguments.Password1,
							Password2=Arguments.Password2)>
        
		<cfif status.getStatus()>
			<!--- CREATE PERSON RECORD --->
			<cfset ProperlyRegistered = Application.Auth.Register(
								PersonID=Arguments.PersonID,
								FirstName=Arguments.FirstName,
								MiddleName=Arguments.MiddleName,
								LastName=Arguments.LastName,
								DisplayName=Arguments.DisplayName,
								Suffix=Arguments.Suffix,
								Email1=Arguments.Email1,
								Gender=Arguments.Gender,
								Password1=Arguments.Password1)>
		</cfif>
        
		<cfreturn status.getJSON()>
    </cffunction>
</cfcomponent>