<cfparam name="Attributes.Mode" type="string">
<cfparam name="Attributes.ModeID" type="numeric" default="0">
<cfparam name="Attributes.FileType" type="numeric" default="0">

<cfset Request.Status.Errors = "">

<cfif ListLen(Request.Status.Errors) LTE 0>
	<!--- Main Upload Path --->
	<cfset FilePath = "#ExpandPath("/_uploads")#">
	
	<!--- Set Mode Specifics --->
	<cfswitch expression="#Attributes.Mode#">
		<cfcase value="Person">
			<cfset ExtendedPath = "#FilePath#\PersonFiles\#Attributes.ModeID#" />
		</cfcase>
		<cfcase value="Activity">
			<cfset ExtendedPath = "#FilePath#\ActivityFiles\#Attributes.ModeID#" />
		</cfcase>
	</cfswitch>
	
	<!--- Create MODE Folder --->
	<cfif NOT DirectoryExists(ExtendedPath)>
		<cfdirectory action="Create" directory="#ExtendedPath#" />
	</cfif>

	<cftry>
		<cffile
			action="upload"
			destination="#ExtendedPath#\"
			filefield="RemoteFile"
			nameconflict="makeunique" />
		
		<cfcatch>
			<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Error Uploading File: #CFCATCH.Message#","|")>
		</cfcatch>
	</cftry>
</cfif>