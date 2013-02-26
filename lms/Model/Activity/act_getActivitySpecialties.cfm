<cfparam name="ActivitySpecialtyList" default="" />

<!--- GET SPECIALTIES FOR CURRENT ACTIVITY --->
<cfset qActivitySpecialties = Application.Com.ActivitySpecialtyGateway.getByAttributes(ActivityID=Attributes.ActivityID)>

<!--- FILL LIST VARIABLE --->
<cfloop query="qActivitySpecialties">
	<cfset ActivitySpecialtyList = ListAppend(ActivitySpecialtyList, qActivitySpecialties.SpecialtyID, "|")>
    <cfset Attributes.ThisUpdated = qActivitySpecialties.Created>
</cfloop>