<cfset qAllActions = Application.Com.ActionGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,OrderBy="Created DESC")>
<cfset ActionPager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
<cfset ActionPager.setQueryToPaginate(qAllActions)>
<cfset ActionPager.setBaseLink("#myself#Activity.Actions?ActivityID=#Attributes.ActivityID#") />
<cfset ActionPager.setItemsPerPage(15) />
<cfset ActionPager.setUrlPageIndicator("page") />
<cfset ActionPager.setShowNumericLinks(true) />
<cfset ActionPager.setClassName("green") />