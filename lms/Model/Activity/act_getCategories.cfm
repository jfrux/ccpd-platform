<cfparam name="CategoryList" default="" />

<!--- GET TOTAL SPECIALTIES --->
<cfset qCategories = Application.Com.CategoryLMSGateway.getByViewAttributes(DeletedFlag='N',OrderBy="Name")>

<!--- FILL LIST VARIABLE --->
<cfloop query="qCategories">
	<cfset CategoryList = ListAppend(CategoryList, qCategories.CategoryID, "|")>
</cfloop>