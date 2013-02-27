<cfparam name="Attributes.Submitted" default="0">

<cfif Attributes.Submitted NEQ 0>
	<cfparam name="Attributes.Mode" type="string">
	<cfparam name="Attributes.ID" type="numeric" default="0">
	<cfparam name="Attributes.FileType" type="numeric" default="0">
	
	<cfset Request.Status.Errors = "">
	
	<cfif Len(FORM["FileField"]) LTE 0>
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must select a File.","|")>
	</cfif>
	
	<cfif Attributes.FileType EQ 0>
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must select a File Type.","|")>
	</cfif>
	
	<cfif ListLen(Request.Status.Errors) LTE 0>
		<!--- Main Upload Path --->
		<cfset FilePath = "#ExpandPath("/_uploads")#">
		
		<!--- Set Mode Specifics --->
		<cfswitch expression="#Attributes.Mode#">
			<cfcase value="Person">
				<cfset ExtendedPath = "#FilePath#/PersonFiles/#Attributes.ModeID#" />
			</cfcase>
			<cfcase value="Activity">
				<cfset ExtendedPath = "#FilePath#/ActivityFiles/#Attributes.ModeID#" />
			</cfcase>
			<cfcase value="PublishActivity">
				<cfset ExtendedPath = "#FilePath#/ActivityFiles/#Attributes.ModeID#" />
			</cfcase>
		</cfswitch>
		
		<!--- Create MODE Folder --->
		<cfif NOT DirectoryExists(ExtendedPath)>
			<cfdirectory action="Create" directory="#ExtendedPath#" />
		</cfif>
	
			<cffile
				action="upload"
				destination="#ExtendedPath#\"
				filefield="FileField"
				nameconflict="makeunique" />
                
                <cfset NewFileName = cffile.ServerFile>
			
            <cfif cffile.serverFileExt EQ "avi" OR cffile.serverFileExt EQ "asx" OR cffile.serverFileExt EQ "mjpg" OR cffile.serverFileExt EQ "mov" OR cffile.serverFileExt EQ "mpeg" OR cffile.serverFileExt EQ "qt" OR cffile.serverFileExt EQ "rv" OR cffile.serverFileExt EQ "wmv">
				
				<cfset FFPath = "#ExpandPath("/_ffmpeg")#">
                
                <cfset newfile = "#REPLACELIST(cffile.ServerFile, ' ', '')#">
                <cfset cffile.ServerFile = "#REPLACELIST(cffile.ServerFile, ' ', '')#">
                
                <cfset newflv = "#replace(newfile, ".", "")#.flv">
                <cfset newjpg = "#replace(newfile, ".", "")#.jpg">
                
                <cfset NewFileName = newflv>
                
                <!--- convert the video with FFMPEG ---> 
                <cfexecute name = "#FFPath#\ffmpeg.exe" 
                    arguments = "-i #ExtendedPath#\#cffile.ServerFile# -s 424x344 -r 15 -b 200k -ar 44100 -ab 64 -ac 2 #ExtendedPath#\#newflv#"  
                    timeout = "90000000"> 
                </cfexecute> 
                
                <cfexecute name = "#FFPath#\ffmpeg.exe" 
                    arguments = "-i #ExtendedPath#\#cffile.ServerFile# -y -f image2 -ss 16 -sameq -t 0.001 -s 424x334 #ExtendedPath#\#newjpg#" 
                    timeout = "90000000"> 
                </cfexecute> 
                
            </cfif>
        	
		<cftry>
			<cfcatch>
				<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Error Uploading File: #CFCATCH.Message#","|")>
			</cfcatch>
		</cftry>
	</cfif>
</cfif>