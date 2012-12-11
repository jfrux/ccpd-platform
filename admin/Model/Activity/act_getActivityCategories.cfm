<cfparam name="ActivityCategoryList" default="" />

<!--- GET SPECIALTIES FOR CURRENT ACTIVITY --->
<cfset qActivityCategories = Application.Com.ActivityCategoryLMSGateway.getByAttributes(ActivityID=Attributes.ActivityID)>

<!--- FILL LIST VARIABLE --->
<cfloop query="qActivityCategories">
	<cfset ActivityCategoryList = ListAppend(ActivityCategoryList, qActivityCategories.CategoryID, "|")>
    <cfset Attributes.ThisUpdated = qActivityCategories.Created>
</cfloop>