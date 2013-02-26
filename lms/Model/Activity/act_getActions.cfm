<cfparam name="Request.ActionsLimit" default="">
<cfif Request.ActionsLimit NEQ "">
	<cfset qActions = Application.Com.ActionGateway.getByViewAttributes(Limit=Request.ActionsLimit,ActivityID=Attributes.ActivityID,OrderBy="Created DESC")>
<cfelse>
	<cfset qActions = Application.Com.ActionGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,OrderBy="Created DESC")>
</cfif>
