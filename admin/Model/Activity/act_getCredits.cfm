<cfparam name="Attributes.Credits" default="">
<!---Creates the List of Existing Credits for the Activity --->
<cfset qActivityCredits = Application.Com.ActivityCreditGateway.getByViewAttributes(ActivityID=Attributes.ActivityID)>
<cfset qCredits = Application.Com.CreditGateway.getByAttributes()>

<cfloop query="qCredits">
	<cfparam name="Attributes.CreditAmount#qCredits.CreditID#" default="0" />
	<cfparam name="Attributes.Credits#qCredits.CreditID#" default="0" />
	<cfparam name="Attributes.ReferenceFlag#qCredits.CreditID#" default="N" />
	<cfparam name="Attributes.ReferenceNo#qCredits.CreditID#" default="" />
</cfloop>

<cfloop query="qCredits">
	<cfset Attributes.Credits = ListAppend(Attributes.Credits,Evaluate("Attributes.Credits#qCredits.CreditID#"),",")>
</cfloop>
		
<cfloop query="qActivityCredits">
	<cfset Attributes.Credits = ListAppend(Attributes.Credits,qActivityCredits.CreditID,",")>
	<cfset "Attributes.CreditAmount#qActivityCredits.CreditID#" = qActivityCredits.Amount>
	<cfset "Attributes.ReferenceNo#qActivityCredits.CreditID#" = qActivityCredits.ReferenceNo>
</cfloop>