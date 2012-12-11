<cfparam name="Attributes.q" type="string" default="" />
<cfparam name="Attributes.type" default="all" />
<cfparam name="Attributes.activitytype" default="0" />
<cfparam name="Attributes.grouping" default="0" />
<cfparam name="Attributes.container" default="0" />
<cfparam name="Attributes.startdate" default="0" />
<cfparam name="Attributes.Category" default="0" />
<cfparam name="Attributes.Birthdate" default="By Birthdate" />
<cfparam name="Attributes.Email" default="By Email" />

<cfset SearchTypes = "Activities,People">

<cfset qSearchActivities.RecordCount = 0>
<cfset qSearchPeople.RecordCount = 0>

<cfswitch expression="#Attributes.type#">
	<cfcase value="activities">
		<cfset qSearchActivities = Application.Search.Activities(
					q=Attributes.q,
					ActivityType=Attributes.ActivityType,
					Grouping=Attributes.Grouping,
					Container=Attributes.Container,
					StartDate=Attributes.StartDate)>
		<cfset SearchPager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
		<cfset SearchPager.setQueryToPaginate(qSearchActivities)>
		<cfset SearchPager.setBaseLink("#myself##Attributes.fuseaction#?type=activities&q=#Attributes.q#&activitytype=#Attributes.activitytype#&grouping=#Attributes.grouping#&container=#Attributes.container#&startdate=#Attributes.startdate#") />
		<cfset SearchPager.setItemsPerPage(5) />
		<cfset SearchPager.setUrlPageIndicator("page") />
		<cfset SearchPager.setShowNumericLinks(true) />
		<cfset SearchPager.setClassName("green") />
	</cfcase>
	
	<cfcase value="people">
		<cfif Trim(Attributes.q) NEQ "">
			<cfset qSearchPeople = Application.Search.People(
				q=Attributes.q,
				birthdate=attributes.birthdate,
				email=attributes.email)>
			
			<cfset SearchPager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
			<cfset SearchPager.setQueryToPaginate(qSearchPeople)>
			<cfset SearchPager.setBaseLink("#myself##Attributes.fuseaction#?type=people&q=#Attributes.q#&birthdate=#Attributes.birthdate#&email=#Attributes.email#") />
			<cfset SearchPager.setItemsPerPage(5) />
			<cfset SearchPager.setUrlPageIndicator("page") />
			<cfset SearchPager.setShowNumericLinks(true) />
			<cfset SearchPager.setClassName("green") />
		</cfif>
	</cfcase>
	
</cfswitch>
