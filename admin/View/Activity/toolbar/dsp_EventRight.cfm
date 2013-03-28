<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectSubTitle">Event Actions</div>
<div class="MultiFormRight_SectBody">
	<div class="clear"> 
		<cfoutput>
		#jButton("Save","javascript:void(0);","accept.gif","SubmitForm(document.frmEvent);")#
		<cfif Attributes.viewas>
			#jButton("Cancel","#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=month&date=#Attributes.viewas#","delete.gif")#
			<!--- Check to see if we have an existing event. --->
			<cfif qEvent.RecordCount>
				<br /><br /><br /><a href="#myself#Activity.DeleteEvent&ActivityID=#Attributes.ActivityID#&id=#qEvent.id#&viewas=#Attributes.viewas#">Delete Event</a>
			</cfif>
		<cfelse>
			<cfif qEvent.RecordCount>
				<cfset CancelLink = "#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Month&date=#Fix( qEvent.date_started )#">
			<cfelse>
				<cfset CancelLink = "#myself#Activity.Calendar&ActivityID=#Attributes.ActivityID#&Mode=Month">
			</cfif>
			#jButton("Cancel","#CancelLink#","delete.gif")#
			
			<!--- Check to see if we have an existing event. --->
			<cfif qEvent.RecordCount>
				<br /><br /><br /><a href="#myself#Activity.DeleteEvent&ActivityID=#Attributes.ActivityID#&&id=#qEvent.id#">Delete Event</a>
			</cfif>
		</cfif>
		</cfoutput>
	</div>
</div>
<cfif Attributes.EventID GT 0>
<div class="MultiFormRight_SectSubTitle">Attendance</div>
<div class="MultiFormRight_LinkList">
	<cfif qAttendance.RecordCount GT 0><a href="#myself#Activity.RecordAttendance&amp;ActivityID=#Attributes.ActivityID#&amp;EventID=#qEvent.id#&amp;Date=#Attributes.viewas#&amp;AttendanceID=#qAttendance.AttendanceID#">Modify Latest Attendance</a></cfif>
	<a href="#myself#Activity.RecordAttendance&amp;ActivityID=#Attributes.ActivityID#&amp;EventID=#qEvent.id#&amp;Date=#Attributes.viewas#">Record Attendance</a></div>
</cfif>
</cfoutput>