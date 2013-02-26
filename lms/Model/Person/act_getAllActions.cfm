<cfset qAllActions = Application.Com.ActionGateway.getByViewAttributes(PersonID=Attributes.PersonID,OrderBy="Created DESC")>
<cfset ActionPager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
<cfset ActionPager.setQueryToPaginate(qAllActions)>
<cfset ActionPager.setBaseLink("#myself#Person.Actions?PersonID=#Attributes.PersonID#") />
<cfset ActionPager.setItemsPerPage(50) />
<cfset ActionPager.setUrlPageIndicator("page") />
<cfset ActionPager.setShowNumericLinks(true) />
<cfset ActionPager.setClassName("green") />