<cfswitch expression="#Attributes.FileExt#">
	<cfcase value="Doc">
    </cfcase>
    <cfdefaultcase>
		<!--- INCLUDE THE FLOWPLAYER JAVASCRIPT --->
        <script type="text/javascript" src="/lms/_scripts/flowplayer-3.0.6.min.js"></script>
        
        <!--- INCLUDE THE FLOWPLAYER CSS --->
        <link href="/lms/_styles/flowplayer.css" rel="stylesheet" type="text/css" />
        
        <!--- INSTALL FLOWPLAYER ON PAGE ---> 
        <script language="JavaScript"> 
            flowplayer("div.player", "/lms/_images/_flowplayer/flowplayer-3.0.7.swf"); 
        </script>
        
        <cfoutput>
          <table>
            <tr>
                <td>
                <div class="player"  
                    href="#Application.Settings.WebURL#_uploads/activityfiles/#Attributes.ActivityID#/#Attributes.FileName#" 
                    style="background-image:url(/lms/_images/uc_logo.png)"> 
                 
                    <!-- play button --> 
                    <img src="/lms/_images/_flowplayer/play_large.png" alt="Play this video" /> 
                 
                    <!-- info --> 
                    <div class="info"> 
                        #Attributes.FileCaption#
                        <span>duration: 20 seconds</span> 
                    </div>
                </div>
                </td>
            </tr>
        </table>
        </cfoutput>
    </cfdefaultcase>
</cfswitch>