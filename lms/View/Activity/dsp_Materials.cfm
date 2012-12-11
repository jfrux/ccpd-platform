<cfparam name="Session.PersonID" default="" />

<cfscript>
function DownLoadTime56k(fileSize) {
    var totalSeconds = (fileSize * 10) / 57600;
    var tempstring = "";
    var tempstring2 = "";
    var hours = totalSeconds / 3600;
    var minutes = totalSeconds / 60;
    var seconds = totalSeconds MOD 60;
    var hourText = "";
    var minuteText = "";

    // if over 60 minutes...get just minutes left from hours
    if (minutes gte 60) minutes = minutes MOD 60;
    
    if (hours gte 1) {
        if (hours gt 2) hourText = " hours ";
        else hourText = " hour ";
        tempstring = Fix(hours) & hourText;
    }

    if (minutes gte 1) {
        if (minutes gt 2) minuteText = " minutes ";
        else minuteText = " minute ";
        tempstring = tempstring & Fix(minutes) & minuteText;
    }
    
    if (seconds gt 0) tempstring = tempstring & seconds & " seconds";

    return tempstring ;
}
</cfscript>
<cfoutput>
<script>
$(document).ready(function() {
	var bDocViewOpen = false;
	
	<cfif Session.PersonID GT 0>
		// LOCK THE DOCUMENT TO BE IN MAIN VIEW EVEN DURING PAGE SCROLLING
		$(document).scroll(function() {
			if(bDocViewOpen) {
				$("##DocumentDiv").css({
					"display":"",
					"top":$(document).scrollTop()+20,
					"left":"50%",
					"margin-left":"-350px",
					"position":"absolute"
				});
			}
		});
		
		$(".DocLink").bind("click", this, function() {
			nFileID = $.ListGetAt(this.id,2,"|");
			sFileTitle = $.ListGetAt(this.id,3,"|");
			ActiveFileLink = this.id;
			
			// BUILD DOCVIEWER
			$("##DocHeader").html("<h3>Document: " +sFileTitle + "</h3>");
			$("##frmDocView").attr("src","#Application.Settings.WebURL#admin/index.cfm/event/Public.FileView?ActivityID=#Attributes.ActivityID#&FileID=" + nFileID);
			$("##DocumentDiv").expose({ closeOnClick: false });
			$("##DocumentDiv").show();
			
			// REVEAL DOCVIEWER
			$("##DocumentDiv").css({
				"display":"",
				"top":$(document).scrollTop()+20,
				"left":"50%",
				"margin-left":"-350px",
				"position":"absolute"
			});
			
			bDocViewOpen = true; 
		
		});
		
		// CLOSE BUTTON FUNCTION
		$(".CloseDocument").click(function() {
			$("##DocumentDiv").css("display","none");
				$.expose.close();
				bDocViewOpen = false;
		});
		
		$(".activity-link").click(function() {
			$("##link-container-frame").attr("src",$(this).attr("href"));
			$("##link-container").show();
			return false;
		});
		
		$(".link-container-close").click(function() {
			$("##link-container").hide();
			$("##link-container-frame").attr("src","");
		});
		
		/*$(".AudioLink").bind("click", this, function() {
			sFileName = $.ListGetAt(this.id,2,"|");
			
			
			soundManager.url = '/_sm2/'; // directory where SM2 .SWFs live
			soundManager.debugMode = false; // true for debug mode
			
			soundManager.onload = function() {
			  // SM2 is ready to go!
			  var AudioFile = soundManager.createSound({
				id: 'aSound',
				url: '#Application.Settings.WebURL#_uploads/ActivityFiles/#Attributes.ActivityID#/' + sFileName,
				volume: 50,
				autoPlay: true
			  });
			}
		});*/
	</cfif>
});
</script>

<cfif Session.PersonID GT 0>
	<cfset AttendeeStatus = Application.ActivityAttendee.getActivityStatus(ActivityID=Attributes.ActivityID,PersonID=Session.PersoniD)>
	<cfif PretestStatus EQ 1 AND AttendeeStatus NEQ "Terminated" AND AttendeeStatus NEQ "">
        <cfloop query="qMaterials">
			<cfset Material = StructNew()>
			<cfif qMaterials.DisplayName NEQ "">
				<cfset Material.DisplayName = qMaterials.DisplayName>
			<cfelse>
				<cfset Material.DisplayName = qMaterials.FileName>
			</cfif>
			<cfset Material.Desc = ActivateURL(qMaterials.Description,'_blank')>
            <cfset FileExt = UCase(getToken(qMaterials.FileName,2,"."))>
            <cfswitch expression="#qMaterials.ComponentID#">
                <!--- FILE DOWNLOAD --->
                <cfcase value="3">
                    <h4><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#"/> <a href="/download/Activity/#Attributes.ActivityID#/#qMaterials.FileID#">#Material.DisplayName#</a></h4>
					<div class="RecordInfoLine">File Size: (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB) Est. Download Time: #DownLoadTime56k(qMaterials.FileSize)# [56k Modem] <a href="/download/Activity/#Attributes.ActivityID#/#qMaterials.FileID#">Download Now &raquo;</a></div>
                </cfcase>
                <!--- DOCUMENT VIEWER --->
                <cfcase value="4">
                    <h4><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#"/> <a href="javascript://" class="DocLink" id="Document|#qMaterials.FileID#|#Material.DisplayName#">#Material.DisplayName#</a></h4>
                    #Material.Desc#
                    <div class="RecordInfoLine">File Size: (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB) <a href="/download/Activity/#Attributes.ActivityID#/#qMaterials.FileID#">Download Now &raquo;</a></div>				
                </cfcase>
                 <!--- EXTERNAL URL --->
                <cfcase value="10">
                    <h4><a href="#myself#activity.link?activityid=#Attributes.ActivityID#&component=#qMaterials.PubComponentID#">#Material.DisplayName#</a></h4>
                    <div class="RecordInfoLine">#Material.Desc#</div>
                </cfcase>
                
                <!--- VIDEO --->
                <cfcase value="13">
                    <div class="ComponentBox" style="padding:0px;">
                        <div class="VideoFileIcon" id="VideoFileIcon#qMaterials.FileID#" style="position:relative; float:left; height:60px;"><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#" /></div>
                        <div class="VideoContentBox" id="VideoContentBox#qMaterials.FileID#"><iframe src="#Application.Settings.WebURL#index.cfm/event/Public.FileView?ActivityID=#Attributes.ActivityID#&FileID=#qMaterials.FileID#" style="border:0px; overflow:hidden; height:255px; width: 335px; vertical-align:top;"></iframe></div>
                        <div class="VideoFileDescrip" id="VideoFileName#qMaterials.FileID#">
                        	
                            	<strong>Name:</strong> #stripHTML(qMaterials.DisplayName)#<br />
                        		<strong>Description:</strong> #stripHTML(qMaterials.Description)#<br />
                            	<strong>File Size:</strong> (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB)
                            
                        </div>
                    </div>		
                </cfcase>
                <!--- AUDIO --->
                <cfcase value="14">
                    <div class="ComponentBox" style="padding:0px;">
                        <div class="AudioFileIcon" id="AudioFileIcon#qMaterials.FileID#" style="position:relative; float:left; height:60px;"><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#" /></div>
                        <div class="AudioContentBox" id="AudioContentBox#qMaterials.FileID#"><iframe src="#Application.Settings.WebURL#index.cfm/event/Public.FileView?ActivityID=#Attributes.ActivityID#&FileID=#qMaterials.FileID#" style="border:0px; overflow:hidden; height:70px; width: 345px; vertical-align:top;"></iframe></div>
                        <div class="VideoFileDescrip" id="VideoFileName#qMaterials.FileID#">
                        	
                            	<strong>Name:</strong> #stripHTML(qMaterials.DisplayName)#<br />
                        		<strong>Description:</strong> #stripHTML(qMaterials.Description)#<br />
                            	<strong>File Size:</strong> (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB)
                            
                        </div>
                    </div>
                </cfcase>
            </cfswitch>
        </cfloop>
    <cfelse>
        <cfloop query="qMaterials">
            <cfset FileExt = UCase(getToken(qMaterials.FileName,2,"."))>
			<cfset Material = StructNew()>
			<cfif qMaterials.DisplayName NEQ "">
				<cfset Material.DisplayName = qMaterials.DisplayName>
			<cfelse>
				<cfset Material.DisplayName = qMaterials.FileName>
			</cfif>
			<cfset Material.Desc = ActivateURL(qMaterials.Description,'_blank')>
            <cfswitch expression="#qMaterials.ComponentID#">
                <!--- FILE DOWNLOAD --->
                <cfcase value="3">
                    <h4><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#"/> #Material.DisplayName#</h4>
                    #Material.Desc#
                    <div class="RecordInfoLine">File Size: (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB) Est. Download Time: #DownLoadTime56k(qMaterials.FileSize)# [56k Modem]</div>
                </cfcase>
                <!--- DOCUMENT VIEWER --->
                <cfcase value="4">
                    <h4><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#"/> #Material.DisplayName#</h4>
                    #Material.Desc#
                    <div class="RecordInfoLine">File Size: (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB)</div>				
                </cfcase>
                 <!--- EXTERNAL URL --->
                <cfcase value="10">
                    <h4>#Material.DisplayName#</h4>
                    <div class="RecordInfoLine">#Material.Desc#</div>
                </cfcase>
                
                <!--- VIDEO --->
                <cfcase value="13">
                    <h4><cfset FileExt = UCase(getToken(qMaterials.FileName,2,"."))>VIDEO: #Material.DisplayName#</h4>
					#Material.Desc#
                </cfcase>
                <!--- AUDIO --->
                <cfcase value="14">
                    <h4><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#"/> #Material.DisplayName#</h4>
                    #Material.Desc#
                    <div class="RecordInfoLine">File Size: (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB)</div>
                </cfcase>
            </cfswitch>
        </cfloop>
    </cfif>
<cfelse>
    <cfloop query="qMaterials">
        <cfset FileExt = UCase(getToken(qMaterials.FileName,2,"."))>
        <cfset Material = StructNew()>
		<cfset Material.DisplayName = qMaterials.DisplayName>
		<cfif qMaterials.DisplayName NEQ "">
			<cfset Material.DisplayName = qMaterials.DisplayName>
		<cfelse>
			<cfset Material.DisplayName = qMaterials.FileName>
		</cfif>
		<cfset Material.Desc = ActivateURL(qMaterials.Description,'_blank')>
		
        <cfswitch expression="#qMaterials.ComponentID#">
            <!--- FILE DOWNLOAD --->
            <cfcase value="3">
                <h4><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#"/> #Material.DisplayName#</h4>
				#Material.Desc#
                <div class="RecordInfoLine">File Size: (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB) Est. Download Time: #DownLoadTime56k(qMaterials.FileSize)# [56k Modem]</div>
            </cfcase>
            <!--- DOCUMENT VIEWER --->
            <cfcase value="4">
                <h4><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#"/> #Material.DisplayName#</h4>
                #Material.Desc#
                <div class="RecordInfoLine">File Size: (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB)</div>				
            </cfcase>
             <!--- EXTERNAL URL --->
            <cfcase value="10">
                <h4>#Material.DisplayName#</h4>
				<div class="RecordInfoLine">#Material.Desc#</div>
            </cfcase>
            
            <!--- VIDEO --->
            <cfcase value="13">
                <h4><cfset FileExt = UCase(getToken(qMaterials.FileName,2,"."))> VIDEO: #Material.DisplayName#</h4>
                #Material.Desc#
            </cfcase>
            <!--- AUDIO --->
            <cfcase value="14">
                <h4><img src="/lms/_images/File_Icons/#FileExt#.png" title="#FileExt#"/> #Material.DisplayName#</h4>
                #Material.Desc#
                <div class="RecordInfoLine">File Size: (#NumberFormat(qMaterials.FileSize/1024,"0.00")# KB)</div>	
            </cfcase>
        </cfswitch>
    </cfloop>
</cfif>

</cfoutput>