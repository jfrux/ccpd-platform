<cfparam name="Attributes.ProcessID" default="0">

<cfset qManagers = Application.Com.ProcessManagerGateway.getByViewAttributes(ProcessID=Attributes.ProcessID,DeletedFlag='N')>

<cfset ManagerPager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
<cfset ManagerPager.setQueryToPaginate(qManagers)>
<cfset ManagerPager.setBaseLink("#myself#Process.Managers&ProcessID=#Attributes.ProcessID#") />
<cfset ManagerPager.setItemsPerPage(50) />
<cfset ManagerPager.setUrlPageIndicator("page") />