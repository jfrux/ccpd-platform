<cfparam name="Request.ActionsLimit" default="">
<cfif Request.ActionsLimit NEQ "">
	<cfset qActions = Application.Com.ActionGateway.getByViewAttributes(Limit=Request.ActionsLimit,PersonID=Attributes.PersonID,OrderBy="Created DESC")>
<cfelse>
	<cfset qActions = Application.Com.ActionGateway.getByViewAttributes(PersonID=Attributes.PersonID,OrderBy="Created DESC")>
</cfif>
