<cfparam name="Attributes.AgendaID" default="">
<cfif Attributes.AgendaID GT 0>
	<cfset AgendaDetail = CreateObject("component","#Application.Settings.Com#Agenda.Agenda").init(AgendaID=Attributes.AgendaID)>
	<cfset AgendaDetail = Application.Com.AgendaDAO.Read(AgendaDetail)>
	
	<cfset Attributes.Description = AgendaDetail.getDescription()>
	<cfset Attributes.EventDate = AgendaDetail.getEventDate()>
	<cfset Attributes.StartTime = AgendaDetail.getStartTime()>
	<cfset Attributes.EndTime = AgendaDetail.getEndTime()>
</cfif>