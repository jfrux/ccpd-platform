<cfswitch expression="#Attributes.Fuseaction#">
	<cfcase value="Activity.Committee">
    	<cfset qRoles = Application.Com.RoleGateway.getByAttributes(Description="Committee",OrderBy="Name")>
    </cfcase>
    <cfcase value="Activity.Faculty">
    	<cfset qRoles = Application.Com.RoleGateway.getByAttributes(Description="Faculty",OrderBy="Name")>
    </cfcase>
</cfswitch>