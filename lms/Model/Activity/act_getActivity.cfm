<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.ActivityTypeID" default="" />
<cfparam name="Attributes.ActivityTitle" default="" />
<cfparam name="Attributes.ParentActivityID" default="" />
<cfparam name="Attributes.AddlAttendees" default="" />
<cfparam name="Attributes.MaxRegistrants" default="" />
<cfparam name="Attributes.Title" default="" />
<cfparam name="Attributes.Description" default="" />
<cfparam name="Attributes.SessionType" default="" />
<cfparam name="Attributes.GroupingID" default="" />
<cfparam name="Attributes.Location" default="" />
<cfparam name="Attributes.Address1" default="" />
<cfparam name="Attributes.Address2" default="" />
<cfparam name="Attributes.City" default="" />
<cfparam name="Attributes.State" default="" />
<cfparam name="Attributes.PostalCode" default="" />
<cfparam name="Attributes.ReleaseDate" default="" />
<cfparam name="Attributes.Sponsorship" default="" />
<cfparam name="Attributes.Sponsor" default="" />
<cfparam name="Attributes.ExternalID" default="" />
<cfparam name="Attributes.StartDate" default="" />
<cfparam name="Attributes.StartTime" default="" />
<cfparam name="Attributes.EndDate" default="" />
<cfparam name="Attributes.EndTime" default="" />
<cfparam name="Attributes.Updated" default="" />
<cfparam name="Attributes.Created" default="" />
<cfparam name="Attributes.CreatedBy" default="" />
<cfparam name="Attributes.updatedBy" default="" />
<cfparam name="Attributes.Permalink" default="" />

<cfparam name="PublishFlag" default="false">

<!--- GET ExternalID OR PublishURL --->
<cfif NOT isNumeric(Attributes.ActivityID)>
	<!--- By ExternalID --->
	<cfquery name="qActivity" datasource="#Application.Settings.DSN#">
		SELECT ActivityID FROM ce_Activity WHERE ExternalID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_varchar" /> AND DeletedFlag='N'
	</cfquery>
	
	<cfif qActivity.RecordCount GT 0>
		<cfset Attributes.ActivityID = qActivity.ActivityID>
	<cfelse>
		<!--- By PublishURL --->
		<cfquery name="qActivity" datasource="#Application.Settings.DSN#">
			SELECT ActivityID FROM ce_Activity_PubGeneral
			WHERE LinkName = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		
		<cfif qActivity.RecordCount GT 0>
			<cfset Attributes.ActivityID = qActivity.ActivityID>
		<cfelse>
			INVALID ACTIVITY!<cfabort>
		</cfif>
	</cfif>
</cfif>

<!--- CHECK IF PUBLISHED --->
<cfquery name="qPubCheck" datasource="#Application.Settings.DSN#">
	SELECT     COUNT(A.ActivityID) AS PublishCount
	FROM         ce_Activity AS A INNER JOIN
		  ce_Activity_PubGeneral AS PG ON A.ActivityID = PG.ActivityID
	WHERE     (A.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />) AND (A.StatusID = 1) AND (A.DeletedFlag = 'N') AND (PG.PublishDate <= GETDATE()) AND (PG.RemoveDate > GETDATE()) OR
		  (A.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />) AND (A.StatusID = 1) AND (A.DeletedFlag = 'N') AND (PG.PublishDate <= GETDATE()) AND (PG.RemoveDate IS NULL)
</cfquery>

<cfif qPubCheck.PublishCount GT 0>
	<cfset PublishFlag = true>
<cfelse>
	<cfset PublishFlag = false>
</cfif>

<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=Attributes.ActivityID)>
<cfset PubGeneralBean = CreateObject("component","#Application.Settings.Com#ActivityPubGeneral.ActivityPubGeneral").Init(ActivityID=Attributes.ActivityID)>

<cfif Application.Com.ActivityDAO.Exists(ActivityBean)>
    <cfset client.lastActivity = attributes.activityId>
    
	<cfset ActivityBean = Application.Com.ActivityDAO.Read(ActivityBean)>
    
	<cfset Attributes.ActivityTypeID = ActivityBean.getActivityTypeID()>
    <cfset Attributes.ActivityTitle = ActivityBean.getTitle()>
    <cfset Attributes.ParentActivityID = ActivityBean.getParentActivityID()>
    <cfset Attributes.AddlAttendees = ActivityBean.getStatAddlAttendees()>
    <cfset Attributes.MaxRegistrants = ActivityBean.getStatMaxRegistrants()>
	<cfset Attributes.Title = ActivityBean.getTitle()>
	<cfset Attributes.Description = ActivityBean.getDescription()>
	<cfset Attributes.SessionType = ActivityBean.getSessionType()>
	<cfset Attributes.GroupingID = ActivityBean.getGroupingID()>
	<cfset Attributes.Location = ActivityBean.getLocation()>
	<cfset Attributes.Address1 = ActivityBean.getAddress1()>
	<cfset Attributes.Address2 = ActivityBean.getAddress2()>
	<cfset Attributes.City = ActivityBean.getCity()>
	<cfset Attributes.State = ActivityBean.getState()>
	<cfset Attributes.PostalCode = ActivityBean.getPostalCode()>
	<cfset Attributes.ReleaseDate = DateFormat(ActivityBean.getReleaseDate(), "MM/DD/YYYY")>
	<cfset Attributes.Sponsorship = ActivityBean.getSponsorship()>
	<cfset Attributes.Sponsor = ActivityBean.getSponsor()>
    <cfset Attributes.ExternalID = ActivityBean.getExternalID()>
	<cfset Attributes.StartDate = DateFormat(ActivityBean.getStartDate(), "MM/DD/YYYY")>
	<cfset Attributes.StartTime = TimeFormat(ActivityBean.getStartDate(), "h:mm TT")>
	<cfset Attributes.EndDate = DateFormat(ActivityBean.getEndDate(), "MM/DD/YYYY")>
	<cfset Attributes.EndTime = TimeFormat(ActivityBean.getEndDate(), "h:mm TT")>
	<cfset Attributes.Updated = DateFormat(ActivityBean.getUpdated(), "MM/DD/YYYY")>
	<cfset Attributes.Created = DateFormat(ActivityBean.getCreated(), "MM/DD/YYYY")>
	<cfset Attributes.CreatedBy = ActivityBean.getCreatedBy()>
	<cfset Attributes.UpdatedBy = ActivityBean.getUpdatedBy()>
	<cfif ActivityBean.getSponsorship() EQ 'j'>
		<cfset Attributes.jointStatement = ' through the joint sponsorship of the University of Cincinnati and ' & ActivityBean.getSponsor()>
	<cfelse>
		<cfset Attributes.jointStatement = ''>
	</cfif>
    
	 <!--- CREATE PUBGENERALBEAN --->
	<cfset PubGeneralBean = CreateObject("component","#Application.Settings.Com#ActivityPubGeneral.ActivityPubGeneral").Init(ActivityID=Attributes.ActivityID)>
    <cfset pubGeneralExists = application.com.activityPubGeneralDAO.exists(pubGeneralBean)>
    
    <cfif pubGeneralExists>
		<!--- UPDATE STATVIEW --->
        <cfset PubGeneralBean = Application.Com.ActivityPubGeneralDAO.Read(PubGeneralBean)>
	
		<!--- CHECK IF COOKIE.VIEWEDACTIVITIES EXISTS --->
        <cfif NOT isDefined("Cookie.ViewedActivities")>
            <!--- CREATE COOKIE --->
            <cfcookie name="ViewedActivities" value="#Attributes.ActivityID#" expires="1" />
            
            <!--- UPDATE STATVIEWCOUNT --->
            <cfset PubGeneralBean.setStatViews(PubGeneralBean.getStatViews()+1)>
            
            <!--- SAVE ACTIVITYBEAN --->
            <cfset Application.Com.ActivityPubGeneralDAO.Save(PubGeneralBean)>
        <!--- CHECK IF ACTIVITY HAS BEEN VIEWED BEFORE --->
        <cfelseif NOT ListFind(Cookie.ViewedActivities,Attributes.ActivityID,"|")>
            <cfset Cookie.ViewedActivities = Cookie.ViewedActivities & "|" & Attributes.ActivityID>
            
            <!--- UPDATE STATVIEWCOUNT --->
            <cfset PubGeneralBean.setStatViews(PubGeneralBean.getStatViews()+1)>
            
            <!--- SAVE ACTIVITYBEAN --->
            <cfset Application.Com.ActivityPubGeneralDAO.Save(PubGeneralBean)>
        <cfelse>        
            <!--- UPDATE STATVIEWCOUNT --->
            <cfset PubGeneralBean.setStatViews(PubGeneralBean.getStatViews()+1)>
            
            <!--- SAVE ACTIVITYBEAN --->
            <cfset Application.Com.ActivityPubGeneralDAO.Save(PubGeneralBean)>
        </cfif>
	</cfif>
    
	<cfif PubGeneralBean.getLinkName() NEQ "">
		<cfset Attributes.Permalink = Application.Settings.WebURL & "/activity/" & PubGeneralBean.getLinkName()>
	<cfelse>
		<cfset Attributes.Permalink = Application.Settings.WebURL & "/activity/" & Attributes.ActivityID>
	</cfif>
</cfif>