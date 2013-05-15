<cfparam name="Attributes.ActivityTypeID" default="0">
<cfparam name="Attributes.CategoryID" default="0">
<cfparam name="Attributes.GroupingID" default="0">
<cfparam name="Attributes.Title" default="">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.CreatedBy" default="0">
<cfparam name="Attributes.UpdatedBy" default="0">
<cfparam name="Attributes.Search" default="">
<cfparam name="Attributes.q" default="">
<cfparam name="url.GroupingID" default="0">
<cfparam name="url.Clear" default="0">

<cfset statusIcons = {
	"1":"status",
	"2":"status-away",
	"3":"status-offline",
	"4":"status-busy"
} />

<cfif NOT isDefined("Cookie.USER_FindActivityTypeID") OR url.Clear EQ 1>
	<cfcookie name="USER_FindActivityTypeID" value="0">
	<cfcookie name="USER_FindGroupingID" value="0">
	<cfcookie name="USER_FindTitle" value="">
	<cfcookie name="USER_FindCategoryID" value="0">
	<cfcookie name="USER_FindPage" value="1">
	<cfcookie name="USER_FindStartDate" value="">
</cfif>

<cfif isDefined("url.Search") AND url.Search NEQ "">
	<cfcookie name="USER_FindActivityTypeID" value="#url.ActivityTypeID#">
	<cfcookie name="USER_FindGroupingID" value="#url.GroupingID#">
	<cfcookie name="USER_FindTitle" value="#url.Title#">
	<cfif NOT isDate(url.StartDate)>
		<cfset url.StartDate = "">
	</cfif>
	<cfcookie name="USER_FindStartDate" value="#url.StartDate#">
	<cfcookie name="USER_FindCategoryID" value="#url.CategoryID#">
</cfif>

<cfif isDefined("url.Page") AND url.Page NEQ "">
	<cfcookie name="USER_FindPage" value="#url.Page#">
<cfelseif NOT isDefined("url.Page") AND Cookie.USER_FindPage NEQ "">
	<cfset url.Page = Cookie.USER_FindPage>
</cfif>

<cfif Cookie.USER_FindActivityTypeID NEQ "">
	<cfset Attributes.Search = 1>
	<cfset Attributes.ActivityTypeID = Cookie.USER_FindActivityTypeID>
	<cfset Attributes.GroupingID = Cookie.USER_FindGroupingID>
	<cfset Attributes.Title = Cookie.USER_FindTitle>
	<cfset Attributes.StartDate = Cookie.USER_FindStartDate>
	<cfset Attributes.CategoryID = Cookie.USER_FindCategoryID>
	<cfset Attributes.Page = Cookie.USER_FindPage>
</cfif>


<cfif Request.Status.Errors EQ "">
	<cfif Attributes.Search NEQ "">		
		<cfset qActivities = Application.Com.ActivityGateway.getBySearch(ActivityTypeID=Attributes.ActivityTypeID,GroupingID=Attributes.GroupingID,CategoryID=Attributes.CategoryID,Title=Attributes.Title,StartDate=Attributes.StartDate,CreatedBy=Attributes.CreatedBy,UpdatedBy=Attributes.UpdatedBy,DeletedFlag='N',OrderBy="c.StartDate DESC")>
		<cfset ActivityPager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
		<cfset ActivityPager.setQueryToPaginate(qActivities)>
		<cfset ActivityPager.setBaseLink("#myself#Activity.Home?ActivityTypeID=#Attributes.ActivityTypeID#&GroupingID=#Attributes.GroupingID#&Title=#Attributes.Title#&StartDate=#Attributes.StartDate#&CategoryID=#Attributes.CategoryID#&CreatedBy=#Attributes.CreatedBy#&UpdatedBy=#Attributes.UpdatedBy#") />
		<cfset ActivityPager.setItemsPerPage(50) />
		<cfset ActivityPager.setUrlPageIndicator("page") />
		<cfset ActivityPager.setMissingNumbersHTML("<span>...</span>")>
		<cfset ActivityPager.setShowNumericLinks(true) />
		<cfset ActivityPager.setClassName("") />
		
		<!--- PERSONALIZED CONTAINER LIST --->
		<cfif Attributes.CategoryID GT 0>
			<cfif NOT ListFind(Cookie.USER_Containers,Attributes.CategoryID,",")>
				<cfcookie name="Settings.Containers" value="#ListSort(ListAppend(Cookie.USER_Containers,Attributes.CategoryID,','),'textnocase')#">
			</cfif>
		</cfif>
	</cfif>
</cfif>