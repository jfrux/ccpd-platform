<cfparam name="Attributes.Submitted" default="" />

<cfif Attributes.Submitted NEQ "">
	<cflocation url="/register/#Attributes.ActivityID#/Payment" addtoken="no" />
</cfif>