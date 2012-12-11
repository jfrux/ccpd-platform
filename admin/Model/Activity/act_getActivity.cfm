<cfparam name="Attributes.Step" default="Login" />

<!--- Create Bean --->
<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=Attributes.ActivityID)>

<cfif application.Com.ActivityDAO.Exists(ActivityBean)>
	<!---- ACTIVITY EXISTS CASE --->
	<cfset ActivityBean = Application.Com.ActivityDAO.Read(ActivityBean)>
    <cfset Request.TESTTEST = "KFJSKLDFKLJSD">
    <cfset Attributes.ActivityTypeID = ActivityBean.getActivityTypeID()>
    <cfset Attributes.ActivityTitle = ActivityBean.getTitle()>
    <cfset Attributes.ParentActivityID = ActivityBean.getParentActivityID()>
    <cfset Attributes.AddlAttendees = ActivityBean.getStatAddlAttendees()>
    <cfset Attributes.MaxRegistrants = ActivityBean.getStatMaxRegistrants()>
    
    <!--- PARENT BEAN --->
    <cfif Attributes.ParentActivityID NEQ "" AND attributes.parentActivityId NEQ 0>
        <cfswitch expression="#Attributes.ActivityTypeID#">
            <cfcase value="1"> <!--- Live Program --->
                <cfset ParentBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=ActivityBean.getParentActivityID())>
                <cfset ParentBean = Application.Com.ActivityDAO.Read(ParentBean)>
            </cfcase>
            <cfcase value="2"> <!--- Stand-alone Live Program --->
                <cfset ParentBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=ActivityBean.getActivityID())>
                <cfset ParentBean = Application.Com.ActivityDAO.Read(ParentBean)>
            </cfcase>
            <cfcase value="3"> <!--- Stand-alone Activity --->
                <cfset ParentBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=ActivityBean.getActivityID())>
                <cfset ParentBean = Application.Com.ActivityDAO.Read(ParentBean)>
            </cfcase>
            <cfcase value="6"> <!--- Performance Improvement --->
                <cfset ParentBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=ActivityBean.getActivityID())>
                <cfset ParentBean = Application.Com.ActivityDAO.Read(ParentBean)>
            </cfcase>
        </cfswitch>
    <cfelse>
        <cfset ParentBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=ActivityBean.getActivityID())>
        <cfset ParentBean = Application.Com.ActivityDAO.Read(ParentBean)>
        <cfset Attributes.ParentActivityID = ParentBean.getActivityID()>
    </cfif>
<cfelse>
	<!---- DELETED ACTIVITY / ACTIVITY DOES NOT EXIST CASE --->
	<cfset Attributes.ActivityTitle = "">
	<cfset Attributes.ActivityTypeID = "0">
	<cfset Attributes.Description = "">
	<cfset Attributes.SessionType = "">
	<cfset Attributes.GroupingID = "">
	<cfset Attributes.Location = "">
	<cfset Attributes.Address1 = "">
	<cfset Attributes.Address2 = "">
	<cfset Attributes.City = "">
	<cfset Attributes.State = "">
	<cfset Attributes.Country = "">
	<cfset Attributes.PostalCode = "">
	<cfset Attributes.ReleaseDate = "">
	<cfset Attributes.Sponsorship = "">
	<cfset Attributes.Sponsor = "">
    <cfset Attributes.ExternalID = "">
	<cfset Attributes.StartDate = "">
	<cfset Attributes.StartTime = "">
	<cfset Attributes.EndDate = "">
	<cfset Attributes.EndTime = "">
	<cfset Attributes.Updated = "">
	<cfset Attributes.Created = "">
	<cfset Attributes.CreatedBy = "">
	<cfset Attributes.UpdatedBy = "">
    <cfset Attributes.ParentActivityId = 0>
    <cfset ActivityBean.setDeletedFlag("Y")>
    <cfset ParentBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init()>
</cfif>
<cfif NOT IsDefined("Attributes.Submitted")>
	<cfset Attributes.Title = ActivityBean.getTitle()>
	<cfset Attributes.Description = ActivityBean.getDescription()>
	<cfset Attributes.SessionType = ActivityBean.getSessionType()>
	<cfset Attributes.GroupingID = ActivityBean.getGroupingID()>
	<cfset Attributes.Location = ActivityBean.getLocation()>
	<cfset Attributes.Address1 = ActivityBean.getAddress1()>
	<cfset Attributes.Address2 = ActivityBean.getAddress2()>
	<cfset Attributes.City = ActivityBean.getCity()>
	<cfset Attributes.State = ActivityBean.getState()>
	<cfset Attributes.Country = ActivityBean.getCountry()>
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
    
    <cfif ActivityBean.getUpdated() NEQ "">
    	<cfset attributes.thisUpdated = ActivityBean.getUpdated()>
    <cfelse>
    	<cfset attributes.thisUpdated = ActivityBean.getCreated()>
    </cfif>
</cfif>