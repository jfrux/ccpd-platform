<cfparam name="SpecialtyList" default="" />

<!--- GET TOTAL SPECIALTIES --->
<cfset qSpecialties = Application.Com.SpecialtyGateway.getByViewAttributes(DeletedFlag='N',OrderBy="Name")>

<!--- FILL LIST VARIABLE --->
<cfloop query="qSpecialties">
	<cfset SpecialtyList = ListAppend(SpecialtyList, qSpecialties.SpecialtyID, "|")>
</cfloop>