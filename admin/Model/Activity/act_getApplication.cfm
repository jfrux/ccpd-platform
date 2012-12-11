<cfset ActivityApp = CreateObject("component","#Application.Settings.Com#ActivityApplication.ActivityApplication").Init(ActivityID=Attributes.ActivityID)>

<cfif Application.Com.ActivityApplicationDAO.Exists(ActivityApp)>
	<cfset ActivityApp = Application.Com.ActivityApplicationDAO.Read(ActivityApp)>
<cfelse>
	<cfset Application.Com.ActivityApplicationDAO.Create(ActivityApp)>
</cfif>