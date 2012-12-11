<cfparam name="Attributes.AttendanceID" default="0">

<cfif Attributes.AttendanceID EQ 0>
	<!--- Create the bean --->
	<cfset AttendanceBean = CreateObject("component","#Application.Settings.Com#Attendance.Attendance").Init(Attributes.AttendanceID)>
	
	<!--- Fills the Bean with values from Create Person form --->
	<cfset AttendanceBean.setEventID(Attributes.EventID)>
	<cfset AttendanceBean.setEventDate(Attributes.Date)>
	<cfset AttendanceBean.setEventTime(Attributes.StartTime)>
	
	<!--- Uses the Bean to submit data into the database --->
	<cfset NewAttendance = Application.Com.AttendanceDAO.Save(AttendanceBean)>
	
	<cflocation url="#myself#Activity.RecordAttendance&ActivityID=#Attributes.ActivityID#&EventID=#Attributes.EventID#&AttendanceID=#NewAttendance#&Date=#Attributes.Date#" addtoken="no">
</cfif>
