<cfparam name="Attributes.AttendanceID" default="0">
<cfif Attributes.AttendanceID GT 0>
	<cfset AttendanceDetailsBean = CreateObject('component','#Application.Settings.Com#Attendance.Attendance').init(AttendanceID=Attributes.AttendanceID)>
	<cfset AttendanceDetailsBean = Application.Com.AttendanceDAO.read(AttendanceDetailsBean)>
	
	<cfset Attributes.EventDate = AttendanceDetailsBean.getEventDate()>
	<cfset Attributes.EventTime = AttendanceDetailsBean.getEventTime()>
	<cfset Attributes.AdditionalCount = AttendanceDetailsBean.getAdditionalCount()>
</cfif>