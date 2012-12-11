<cfparam name="Attributes.ActivityNoteID" default="0">
<cfparam name="Attributes.Submitted" default="">

<cfif Attributes.Submitted EQ 1>
	<cfset Request.Status.Errors = "">
	
	<cfif Attributes.NoteBody EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a body for the note.","|")>
	</cfif>
	
	<cfif Request.Status.Errors EQ "">
		<cfset ActivityNoteBean = CreateObject("component","#Application.Settings.Com#ActivityNote.ActivityNote").Init(ActivityNoteID=Attributes.ActivityNoteID,ActivityID=Attributes.ActivityID,Body=Attributes.NoteBody,CreatedBy=Session.Person.getPersonID())>
		<cfset ActivityNoteBean = Application.Com.ActivityNoteDAO.Save(ActivityNoteBean)>
		
		<cflocation url="#Myself#Activity.Notes&ActivityID=#Attributes.ActivityID#" addtoken="no">
	</cfif>
</cfif>