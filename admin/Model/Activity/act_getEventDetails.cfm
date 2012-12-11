<cfparam name="Attributes.EventID" default="">
<cfoutput>
	<cfset EventDetailsBean = CreateObject('component','#Application.Settings.Com#Event.Event').init(id=Attributes.EventID)>
	
	<cfset EventDetailsBean = Application.Com.EventDAO.read(EventDetailsBean)>
	
	<cfset Attributes.EventName = EventDetailsBean.getname()>
	<cfset Attributes.EventDescription = EventDetailsBean.getdescription()>
	<cfset Attributes.StartTime = EventDetailsBean.gettime_started()>

</cfoutput>