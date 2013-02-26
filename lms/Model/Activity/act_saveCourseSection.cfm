<cfparam name="Attributes.ActivitiesectionID" default="-1">

<cfif IsDefined("Attributes.FormSubmit")>
	<cfset Request.Status.Errors = "">
	
	<cfif Attributes.StartDate EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a Start Date.","|")>
	</cfif>
	
	<cfif Attributes.StartTime EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a Start Time.","|")>
	</cfif>
	
	<cfif Attributes.EndDate EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a End Date.","|")>
	</cfif>
	
	<cfif Attributes.EndTime EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a End Time.","|")>
	</cfif>
	
	<cfif Request.Status.Errors EQ "">
		<!--- Create Bean --->
		<cfset ActivitiesectionBean = CreateObject("component","#Application.Settings.Com#Activitiesect").Init(Attributes.ActivitiesectionID)>
		
		<cfset Attributes.StartDate = CreateODBCDateTime(Attributes.StartDate)>
		
		
		<!--- Fills the Bean with user defined vars --->
		<cfset ActivitiesectionBean.setActivityID(Attributes.ActivityID)> 
		<cfset ActivitiesectionBean.setActivitiesectionID(Attributes.ActivitiesectionID)> 
		<cfset ActivitiesectionBean.setStartDate(Attributes.StartDate)> 
		<cfset ActivitiesectionBean.setStartTime(Attributes.StartTime)> 
		<cfset ActivitiesectionBean.setEndDate(Attributes.EndDate)> 
		<cfset ActivitiesectionBean.setEndTime(Attributes.EndTime)>
		<cfif Attributes.ActivitiesectionID EQ -1>
			<cfset ActivitiesectionBean.setCreatedBy(Session.Person.getPersonID())>
		<cfelse>
			<cfset ActivitiesectionBean.setUpdatedBy(Session.Person.getPersonID())>
		</cfif>
		
		<!--- Submits the Bean for data saving --->
		<cfset NewActivitiesectID = Application.Com.ActivitiesectDAO.Save(ActivitiesectionBean)>
		
		<cfif Attributes.ActivitiesectionID EQ -1>
			<cfset Attributes.ActivitiesectionID = NewActivitiesectID>
		</cfif>
		
		<cflocation url="#Myself#Activity.EditSection&ActivityID=#Attributes.ActivityID#&ActivitiesectionID=#Attributes.ActivitiesectionID#&Message=Activity Section has been saved!" addtoken="no">
	</cfif>
</cfif>