<cfcomponent>
	<cffunction name="requestPassword" access="remote" returntype="string">
    	<cfargument name="Email" type="string" required="yes">
        
        <cfset Status = Application.Person.requestPassword(Arguments.Email)>
        
        <cfif getToken(Status, 1, "|") EQ "Success">
        	<cflocation url="#Request.RootPath#/ForgotPW.cfm?Message=#getToken(Status, 2, "|")#" addtoken="no">
        <cfelse>
        	<cflocation url="#Request.RootPath#/ForgotPW.cfm?Error=#getToken(Status, 2, "|")#" addtoken="no">
        </cfif>
    </cffunction>
    
	<cffunction name="saveCredentials" access="remote" returntype="string">
        <cfargument name="Pass" type="string" required="yes">
        <cfargument name="ConPass" type="string" required="yes">
        <cfargument name="Email" type="string" required="no">
        <cfargument name="ConEmail" type="string" required="no">
        <cfset var Status = Application.Person.saveCredentials(Session.PersonID,Arguments.Pass, Arguments.ConPass, Arguments.Email, Arguments.ConEmail)>
        
        <cfif getToken(Status, 1, "|") EQ "Success">
        	<cflocation url="#Request.RootPath#/Credentials.cfm?Message=#getToken(Status, 2, "|")#" addtoken="no">
        <cfelse>
        	<cflocation url="#Request.RootPath#/Credentials.cfm?Error=#getToken(Status, 2, "|")#" addtoken="no">
        </cfif>
	</cffunction>
</cfcomponent>