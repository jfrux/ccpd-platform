<cfparam name="Attributes.PhotoID" type="numeric" />
<cfparam name="Attributes.Mode" default="" />
<cfset PhotoPath = "#ExpandPath(".\_uploads\Photos\#Session.Church.getChurchID()#")#">
<cfswitch expression="#Attributes.Mode#">
	<cfcase value="T">
		<cfset PhotoSizePath = "#PhotoPath#\Tiny">
	</cfcase>
	<cfcase value="S">
		<cfset PhotoSizePath = "#PhotoPath#\Small">
	</cfcase>
	<cfcase value="M">
		<cfset PhotoSizePath = "#PhotoPath#\Medium">
	</cfcase>
	<cfcase value="L">
		<cfset PhotoSizePath = "#PhotoPath#\Large">
	</cfcase>
	<cfcase value="O">
		<cfset PhotoSizePath = "#PhotoPath#\_original">
	</cfcase>
	<cfdefaultcase>
		<cfset PhotoSizePath = "#PhotoPath#\_original">
	</cfdefaultcase>
</cfswitch>

<cfquery name="qPhoto" datasource="#Application.Settings.DSN#">
	SELECT PhotoID, FileName FROM ch_Photo WHERE PhotoID=#Attributes.PhotoID#
</cfquery>

<cfset Request.PhotoFilePath = "#PhotoSizePath#\#qPhoto.FileName#">
