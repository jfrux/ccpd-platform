<cfset qProcesslist = Application.Com.ProcessGateway.getByAttributes(DeletedFlag="N")>
<cfset ProcessPager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
<cfset ProcessPager.setQueryToPaginate(qProcesslist)>
<cfset ProcessPager.setBaseLink("#myself#Groups.Home") />
<cfset ProcessPager.setItemsPerPage(15) />
<cfset ProcessPager.setUrlPageIndicator("page") />
<cfset ProcessPager.setShowNumericLinks(true) />
<cfset ProcessPager.setClassName("green") />