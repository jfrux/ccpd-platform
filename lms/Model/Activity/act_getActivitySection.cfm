<cfset ActivitiesectionBean = CreateObject("component","#Application.Settings.Com#Activitiesect").init(ActivitiesectionID=Attributes.ActivitiesectionID)>
<cfset ActivitiesectionBean = Application.Com.ActivitiesectDAO.read(ActivitiesectionBean)>

<cfset Attributes.StartDate = DateFormat(ActivitiesectionBean.getStartDate(), "MM/DD/YYYY")>
<cfset Attributes.StartTime = TimeFormat(ActivitiesectionBean.getStartTime(), "hh:mm:ss tt")>
<cfset Attributes.EndDate = DateFormat(ActivitiesectionBean.getEndDate(), "MM/DD/YYYY")>
<cfset Attributes.EndTime = TimeFormat(ActivitiesectionBean.getEndTime(), "hh:mm:ss tt")>
<cfset Attributes.CreatedBy = ActivitiesectionBean.getCreatedBy()>