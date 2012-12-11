<script type="text/javascript">
// demo only..
function setTheme(sTheme) {
  var o = document.getElementsByTagName('ul')[0];
  o.className = 'playlist'+(sTheme?' '+sTheme:'');
  return false;
}
</script>
<!--- END AUDIO PLAYER CODE --->

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

function stripHTML(str) {
	return REReplaceNoCase(str,"<[^>]*>","","ALL");
}
</cfscript>

<cfoutput>
<table>
	<tr>
    	<td>
        <cfswitch expression="#Attributes.FileExt#">
        	<cfcase value="FLV">
				<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/flowplayer-3.1.2.min.js"></script>
                
				<link rel="stylesheet" type="text/css" href="#Application.Settings.RootPath#/_styles/flowplayer.css" />
                
                
                <div class="player"  
                    href="#Application.Settings.RootPath#/_uploads/ActivityFiles/#Attributes.ActivityID#/#Attributes.FileName#" 
                    style="background-image:url(#Application.Settings.RootPath#/_uploads/ActivityFiles/#Attributes.ActivityID#/#Left(Attributes.FileName,Len(Attributes.FileName)-4)#.jpg)"> 
                 
                    <!-- play button --> 
                    <img src="#Application.Settings.RootPath#/_flowplayer/play_large.png" alt="Play this video" /> 
                 
                    <!-- info --> 
                    <div class="info"> 
                        #Attributes.DisplayName#
                        <span>#Left(Attributes.Description,40)#<cfif Len(Attributes.Description) GT 40>...</cfif></span>
                    </div> 
                <script language="JavaScript">
					flowplayer("div.player", "#Application.Settings.RootPath#/_flowplayer/flowplayer-3.1.2.swf");
                </script>
                </div> 
<!-- let page float normally after this --> 
<br clear="all" />
            </cfcase>
            <cfcase value="MP3">
				<link rel="stylesheet" type="text/css" href="#Application.Settings.RootPath#/_styles/page-player.css" />
				<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/soundmanager2.js"></script>
                <script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/page-player.js"></script>
				
				<cfset FileExt = UCase(getToken(Attributes.FileName,2,"."))>
                <ul class="playlist">
                    <li><a href="#Application.Settings.RootPath#/_uploads/ActivityFiles/#Attributes.ActivityID#/#Attributes.FileName#">#Attributes.DisplayName#</a> </li>
            	</ul>
                
                <div id="control-template">
					<!--- control markup inserted dynamically after each link --->
                    <div class="controls">
                        <div class="statusbar">
                            <div class="loading"></div>
                            <div class="position"></div>
                        </div>
                	</div>
                    <div class="timing">
                        <div id="sm2_timing" class="timing-data">
                            <span class="sm2_position">%s1</span> / <span class="sm2_total">%s2</span>
                        </div>
                    </div>
                    <div class="peak">
                        <div class="peak-box">
                            <span class="l"></span><span class="r"></span>
                        </div>
                    </div>
                </div>
                
                <div id="spectrum-container" class="spectrum-container">
                    <div class="spectrum-box">
                        <div class="spectrum"></div>
                    </div>
                </div>
            </cfcase>
        	<cfcase value="MPG">MPG
            </cfcase>
            <cfcase value="PDF">
            	<cfcontent file="#ExpandPath('#Application.Settings.RootPath#/_uploads/ActivityFiles/#Attributes.ActivityID#/#Attributes.FileName#')#" />
            </cfcase>
            <cfdefaultcase>
            	This is not an accepted file format, sorry.
            </cfdefaultcase>
        </cfswitch>
        </td>
    </tr>
</table>
</cfoutput>