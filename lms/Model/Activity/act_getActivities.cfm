<cfparam name="Attributes.Title" default="" />
<cfparam name="Attributes.q" default="" />
<cfparam name="Attributes.Specialty" default="" />
<cfparam name="Attributes.Category" default="" />
<cfparam name="Attributes.Tag" default="" />
<cfparam name="Attributes.Submitted" default="0" />

<cfif Attributes.Submitted EQ 1>
	<cfif Attributes.Category NEQ "">
		<cfset CategoryInfo = Application.Com.CategoryLMSDAO.Read(CreateObject("component","#Application.Settings.Com#CategoryLMS.CategoryLMS").init(CategoryID=Attributes.Category))>
		
		<cfset Request.Page.Title = "#CategoryInfo.getName()#" />
	</cfif>
	<cfif Attributes.Tag NEQ "">
		<cfquery name="TagInfo" datasource='#application.settings.dsn#'>
			SELECT * FROM ce_activity_tags
			WHERE id=<cfqueryparam value="#attributes.tag#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfset Request.Page.Title = "#TagInfo.name#" />
	</cfif>
	<cfif Attributes.Specialty NEQ "">
		<cfset SpecialtyInfo = Application.Com.SpecialtyLMSDAO.Read(CreateObject("component","#Application.Settings.Com#Specialty.Specialty").init(SpecialtyID=Attributes.Specialty))>
		
		<cfset Request.Page.Title = "#SpecialtyInfo.getName()#" />
	</cfif>
	<cfset qActivities = Application.Com.ActivityGateway.getBySearchLMS(Limit=20,Title=Attributes.q,TagID=attributes.tag,SpecialtyID=Attributes.Specialty,CategoryLMSID=Attributes.Category, OrderBy="c.startDate DESC")>

	<cfset ActivityPager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
	<cfset ActivityPager.setQueryToPaginate(qActivities)>
	<cfset ActivityPager.setBaseLink("#myself#Activity.Browse?q=#Attributes.q#&Category=#Attributes.Category#&Specialty=#Attributes.Specialty#&Submitted=1") />
	<cfset ActivityPager.setItemsPerPage(10) />
	<cfset ActivityPager.setUrlPageIndicator("page") />
	<cfset ActivityPager.setShowNumericLinks(true) />
	<cfset ActivityPager.setClassName("green") />
</cfif>