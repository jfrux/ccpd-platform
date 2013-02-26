<cfparam name="Attributes.Title" default="">
<cfparam name="Attributes.ActivityType" default="1">
<cfparam name="Attributes.Grouping" default="">
<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.Sponsorship" default="">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.Description" default="">
<cfparam name="Attributes.Location" default="">
<cfparam name="Attributes.Address1" default="">
<cfparam name="Attributes.Address2" default="">
<cfparam name="Attributes.City" default="">
<cfparam name="Attributes.State" default="">
<cfparam name="Attributes.PostalCode" default="">
<cfparam name="Attributes.Sessions" default="1">
<cfparam name="Attributes.SessionType" default="S">
<cfparam name="Attributes.ExternalID" default="">
<cfparam name="Attributes.ReleaseDate" default="#DateFormat(Now(),"MM/DD/YYYY")#">

<cfif IsDefined("Attributes.Submitted") AND Attributes.Submitted EQ 1>	
	<!--- PARENT ACTIVITY --->
	<!--- Create Bean --->
	<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(Attributes.ActivityID)>

	<!--- Fills the Bean with user defined vars --->
	<cfset ActivityBean.setActivityTypeID(Attributes.ActivityType)>
	<cfset ActivityBean.setTitle(Attributes.Title)>
	<cfset ActivityBean.setDescription(Attributes.Description)>
	<cfset ActivityBean.setSponsorship(Attributes.Sponsorship)>
	<cfset ActivityBean.setExternalID(Attributes.ExternalID)>

	<cfset ActivityBean.setReleaseDate(Attributes.ReleaseDate)>

	<cfif Attributes.StartDate NEQ "">
		<cfset ActivityBean.setStartDate(Attributes.StartDate)>
	</cfif>
	<cfif Attributes.EndDate NEQ "">
		<cfset ActivityBean.setEndDate(Attributes.EndDate)>
	</cfif>
	
	<cfset ActivityBean.setLocation(Attributes.Location)>
	<cfset ActivityBean.setAddress1(Attributes.Address1)>
	<cfset ActivityBean.setAddress2(Attributes.Address2)>
	<cfset ActivityBean.setCity(Attributes.City)>
	<cfset ActivityBean.setState(Attributes.State)>
	<cfset ActivityBean.setPostalCode(Attributes.PostalCode)>
	<cfset ActivityBean.setGroupingID(Attributes.Grouping)>

	<cfset ActivityBean.setCreatedBy(Session.Person.getPersonID())>
	
	<cfset ActivityBean.setStatusID(2)>
	<cfset ActivityBean.setSessionType(Attributes.SessionType)>
	<cfset ActivityBean.setStatAttendees(0)>
	<cfset ActivityBean.setStatMD(0)>
	<cfset ActivityBean.setStatNonMD(0)>
	<cfset ActivityBean.setStatSupporters(0)>
	<cfset ActivityBean.setStatSuppAmount(0)>
	<cfset aErrors = ActivityBean.validate()>
	
	<cfloop from="1" to="#ArrayLen(aErrors)#" index="i">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,aErrors[i].Message,"|")>
	</cfloop>
    
    <cfif ListFind("1,2",ActivityBean.getActivityTypeID(), ",") AND ActivityBean.getGroupingID() EQ "">
    	<cfset Request.Status.Errors = ListAppend(Request.Status.Errors, "Grouping is required.", "|")>
    </cfif>
    
	<cfif Request.Status.Errors EQ "">		
		<!--- Submits the Bean for data saving --->
		<cfset ParentActivityID = Application.Com.ActivityDAO.Create(ActivityBean)>
		<cfset ActivityBean.setParentActivityID(ParentActivityID)>
		<cfif Attributes.SessionType EQ "M">
			<cfloop from="1" to="#Attributes.Sessions#" index="i">
				<cfset ActivityBean.setTitle("#Attributes.Title#")>
				<cfset Application.Com.ActivityDAO.Create(ActivityBean)>
			</cfloop>
		</cfif>
		
		<!--- HISTORY --->
		<cfset Application.History.Add(
                            HistoryStyleID=2,
                            FromPersonID=Session.PersonID,
                            ToActivityID=ParentActivityID)>
		
		<cflocation url="#myself#Activity.Detail?ActivityID=#ParentActivityID#" addtoken="no" />
	</cfif>
</cfif>