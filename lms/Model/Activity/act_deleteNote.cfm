<cfsetting enablecfoutputonly="yes">
<cfif IsDefined("Attributes.ActivityNoteID")>
	<cftry>
		<cfset Attributes.Deleted = CreateODBCDateTime(Now())>
		<cfset Status = "Fail|Could not delete note.">
		
		<cfset ActivityNoteBean = CreateObject("component","#Application.Settings.Com#ActivityNote.ActivityNote").Init()>
		<cfset ActivityNoteBean.setActivityNoteID(Attributes.ActivityNoteID)>
		<cfset ActivityNoteBean.setDeleted(Attributes.Deleted)>
		<cfset ActivityNoteBean.setDeletedFlag('Y')>
		<cfset ActivityNoteBean.setUpdatedBy(Session.Person.getPersonID())>
		
		<cfset ActivityNoteBean = Application.Com.ActivityNoteDAO.Save(ActivityNoteBean)>
				
		<cfset Status = "Success|Note has been deleted!">
	<cfcatch type="any">
		<cfset Status = "Fail|Could not delete note for an unknown reason, please try again.">
	</cfcatch>
	</cftry>
	<cfoutput>#Status#</cfoutput>
</cfif>