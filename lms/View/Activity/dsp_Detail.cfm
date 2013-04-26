<cfparam name="Attributes.ATTENDEESTATUSID" default="0" />
<!--- STEP LOGIC --->
<cfquery name="qGetPostTest" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID
	FROM ce_Activity_PubComponent
	WHERE ComponentID = 11 AND ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>
<cfquery name="qGetPretest" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID
	FROM ce_Activity_PubComponent
	WHERE ComponentID = 12 AND ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>
<cfquery name="qGetEval" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID
	FROM ce_Activity_PubComponent
	WHERE ComponentID = 5 AND ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>

<cfparam name="PreTestExists" default="false" />
<cfif qGetPretest.RecordCount GT 0>
	<cfset PreTestExists = true>
</cfif>
<cfparam name="PostTestExists" default="false" />
<cfif qGetPostTest.RecordCount GT 0>
	<cfset PostTestExists = true>
</cfif>
<cfparam name="EvalExists" default="false" />
<cfif qGetEval.RecordCount GT 0>
	<cfset EvalExists = true>
</cfif>

<!--- COUNTS --->
<cfquery name="qAssCount" datasource="#Application.Settings.DSN#">SELECT COUNT(PubComponentID) AS AssessCount FROM ce_Activity_PubComponent	WHERE (ComponentID IN (5,11,12)) AND (ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />) AND (DeletedFlag = 'N')</cfquery>
<cfquery name="qMatCount" datasource="#Application.Settings.DSN#">SELECT COUNT(PubComponentID) AS MaterialCount FROM ce_Activity_PubComponent	WHERE (ComponentID IN (3, 4, 9, 13, 14, 10)) AND (ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />) AND (DeletedFlag = 'N')</cfquery>

<cfset Steps = "Status">
<cfif PretestExists>
	<cfset Steps = ListAppend(Steps,"PreTest",",")>
</cfif>
<cfif qMatCount.MaterialCount GT 0>
	<cfset Steps = ListAppend(Steps,"Material",",")>
</cfif>
<cfif PostTestExists>
	<cfset Steps = ListAppend(Steps,"PostTest",",")>
</cfif>
<cfif EvalExists>
	<cfset Steps = ListAppend(Steps,"Eval",",")>
</cfif>

<cfloop from="1" to="#ListLen(Steps,',')#" index="i">
	<cfset "#ListGetAt(Steps,i)#Step" = i>
</cfloop>

<!--- INCLUDE THE FLOWPLAYER CSS --->
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

<script>
	<cfoutput>
	var bAssessOpen = false;
	var nActivity = #Attributes.ActivityID#;
	var nPerson = <cfif isDefined("session.personId") AND len(session.personId) GT 0>#Session.PersonID#<cfelse>0</cfif>;
	var nResult = 0;
	</cfoutput>
	function updateAssess() {
		$("#AssessLoading").show();
		$.post(sMyself + "Activity.Assessments", { ActivityID: nActivity },
			function(data) {
				$("#AssessContainer").html(data);
				$("#AssessLoading").hide();
			});
	}
	
	function updateComments() {
		$("#CommentsLoading").show();
		$.post(sMyself + "Activity.Comments", { ActivityID: nActivity },
			function(data) {
				$("#CommentsContainer").html(data);
				$("#CommentsLoading").hide();
			});
	}
	
	function updateLinks() {
		$("#LinksLoading").show();
		$.post(sMyself + "Activity.Links", { ActivityID: nActivity },
			function(data) {
				$("#LinksContainer").html(data);
				$("#LinksLoading").hide();
			});
	}
	
	function updateMaterials() {
		$("#MaterialsLoading").show();
		$.post(sMyself + "Activity.Materials", { ActivityID: nActivity },
			function(data) {
				$("#MaterialsContainer").html(data);
				$("#MaterialsLoading").hide();
			});
	}
	
	function updateStatus() {
		$("#StatusLoading").show();
		$.post(sMyself + "Activity.Status", { ActivityID: nActivity },
			function(data) {
				$("#StatusContainer").html(data);
				$("#StatusLoading").hide();
			});
	}
	<cfif isDefined("Session.PersonID") AND Session.PersonID NEQ "">
	function completeActivity() {
		$.getJSON("/lms/_com/AJAX_Activity.cfc", { method: "markComplete", ActivityID: nActivity, PersonID: nPerson, returnFormat: "plain" },
			function(data) {
				if(data.STATUS) {
					updateAssess();
					updateComments();
					updateLinks();
					updateMaterials();
					addMessage(data.STATUSMSG,250,6000,4000);
					
					// OPEN CERTIFICATE
					$("#divCert").dialog("open");
				}
		});
	}
	</cfif>
	$(document).ready(function() {		
		$("#OverviewReadMore").click(function() {
			$(this).hide();
			$("#OverviewDetail").css({
				'height':'',
				'overflow':'visible',
				'border-bottom':'0'
			});
		});
		<!---$(document).scroll(function() {
			var nBottom = ($(document).scrollTop() + $(window).height());
			var nMatBoxTop = $("##MaterialsBox").position().top;
			if(nMatBoxTop > nBottom) {
				$("##HiddenStep-Mat").slideDown();
			} else {
				$("##HiddenStep-Mat").slideUp();
			}
		});	--->
		
		updateAssess();
		updateComments();
		updateLinks();
		updateStatus();
		updateMaterials();
			
		// INSTALL FLOWPLAYER ONTO WEBPAGE
		flowplayer("div.player", "/lms/_images/_flowplayer/flowplayer-3.0.7.swf");
	
		$(".CertificateButton").live("click", function() {
			$("#frmCert").attr('src','/admin/event/Public.Cert?ActivityID=' + nActivity + '&PersonID=' + nPerson);
		});
		
		$(".AssessLink").live("click", function() {
			EvalType = $.ListGetAt(this.id,1,"|");
			nEvalID = $.ListGetAt(this.id,2,"|");
			AssessControlMsg1 = $.ListGetAt(this.id,3,"|");
			AssessControlMsg2 = $.ListGetAt(this.id,4,"|");
			ActiveAssessLink = this.id;
			ActiveRequiredSpan = this.id + "|Required";
			EvalContainer = "Eval" + $.ListGetAt(ActiveAssessLink,2,"|");
			
			$("#CloseAssessment").attr("title",AssessControlMsg1);
			$("#CompleteAssessment").attr("title",AssessControlMsg2);
			
			// GRAB ASSESSMENTRESULT INFO
			$.post("/lms/_com/AJAX_Assessment.cfc", { method: "getResult", AssessmentID: nEvalID, PersonID: nPerson, EvalType: EvalType, returnFormat: "plain" },
				function(data) {
					var ResultID = $.trim(data);
					nResult = ResultID;
					
					// BUILD ASSESSMENT
					$.post(sMyself + "Assessment.Build?AssessmentID=" + nEvalID + "&ActivityID=" + nActivity + "&Personid=" + nPerson + "&ResultID=" + ResultID + "&type=" + EvalType,
						function(data){
							CleanData = $.trim(data);
							
							$(".AssessmentDiv").show();
							// FILL ASSESSSCONTENT DIV
							$("#AssessContent").html(data);
							
					});
			});
			
			// REVEAL ASSESSMENT
			$("#AssessmentDiv").css({
				"display":"",
				"top":$(document).scrollTop()+25,
				"left":"50%",
				"margin-left":"-350px",
				"position":"absolute",
				"z-index":"9999"
			});
			
			bAssessOpen = true; 
		});
		
		// CLOSE BUTTON FUNCTION
		$("#CloseAssessment, .ce-dialog-close").live('click', function() {
			$("#AssessmentDiv").css("display","none");
			$.expose.close();
			bAssessOpen = false;
			updateAssess();
		});
		
		// COMPLETE ASSESSMENT BUTTON FUNCTION
		$("#CompleteAssessment").live('click', function() {	
			$.ajax({
				url: sRootPath + "/_com/AJAX_Assessment.cfc",
				type: 'post',
				data: { method: "markComplete", ActivityID: nActivity, AssessmentID: nEvalID, ResultID: nResult, PersonID: nPerson, returnFormat: "plain" },
				dataType: 'json',
				success: function(data) {
					if(data.STATUS) {
						// HIDE ASSESSMENT
						$("#AssessmentDiv").css("display","none");
						
						$.expose.close();
						updateAssess();
						updateLinks();
						updateMaterials();
						addMessage(data.STATUSMSG,250,6000,4000);
						bAssessOpen = false;
						
						completeActivity();
						
						updateStatus();
					} else {
						$.each(data.ERRORS, function(i, item) {
							$("#progressbar-item-" + data.ERRORS[i].MESSAGE).addClass('error');
							$("#progressbar-item-" + data.ERRORS[i].MESSAGE + " .progressbar-value").html('Answer Required!');
						});
						
						firstErrorID = $(".error:first").attr('id').replace('progressbar-item-','');
						$(".questionslist").scrollTo('#Question_' + firstErrorID,800);
						$(".progressbar").scrollTo('#progressbar-item-' + firstErrorID,800);
						
						bAssessOpen = false;
					}
				}
			});
	});
});
</script>
<cfoutput>
<cfif Len(Trim(StripHTML(Attributes.Overview))) LTE 0 AND Len(Trim(StripHTML(Attributes.Objectives))) LTE 0 AND qMatCount.MaterialCount LTE 0>
	<cfset ShowLeftArea = false>
<cfelse>
	<cfset ShowLeftArea = true>
</cfif>

<div class="ContentBlock">
    <h1>#Attributes.Title#</h1>
	<cfif NOT PublishFlag>
    <cfif attributes.attendeeStatusId EQ 1 AND attributes.deletedFlag EQ "N">
	<h2>You completed this activity!</h2>
	<div style="margin-top:10px;">
		<div style="border-width: 1px; width:140px; border-style: solid; border-color: rgb(59, 110, 34) rgb(59, 110, 34) rgb(44, 81, 21); background-color: rgb(105, 167, 78);"><div style="padding: 4px 10px 5px; border-top: 1px solid rgb(149, 191, 130);">
        	<a href="/admin/index.cfm/event/Public.Cert?ActivityID=#Attributes.ActivityID#&PersonID=#Session.PersonID#" style="color: rgb(255, 255, 255); text-decoration: none; font-weight: bold; font-size: 12px; font-family: Arial,Helvetica,sans-serif;">Download Certificate</a>
        </div>
    </div>
    
	</div>
    <cfelse>
		<h2>Activity content is not available.</h2>
    </cfif>
	<p style="margin-top:8px;">The activity you are trying to view is no longer published.  You may begin looking through our new catelog of activities that are published by clicking here or continue browsing other portions of our website.</p>
	<ul>
		<li><a href="/lms/browse">Browse Activities</a></li>
		<cfif NOT isDefined("session.personId") OR isDefined("session.personId") AND session.personId EQ 0><li><a href="/lms/signup">Sign-up</a> or <a href="/lms/login">Login</a></li></cfif>
		<li><a href="/lms/about">What is this?</a></li>
		<li>Contact Support by clicking the "Get Help" button on the right of the screen.</li>
	</ul>
	<cfelse>
	<div id="ActivityWrapper">
    <div id="ActivityLeft">
		<!--- OVERVIEW --->
		<cfif Len(Trim(StripHTML(Attributes.Overview))) GT 0>
		<div class="Act-Box" id="OverviewBox">
			<h2 class="Head DarkGray">Overview</h2>
			<div class="Act-BoxContent" id="OverviewDetail"<cfif Len(Trim(StripHTML(Attributes.Overview))) GT 400> style="margin-bottom:4px; height:90px; overflow:hidden; border-bottom:1px dashed ##999;"</cfif>>
				#activateLinks(Attributes.Overview)#
			</div>
			<cfif Len(Trim(StripHTML(Attributes.Overview))) GT 400>
			<div style="margin-left:6px;"><a href="javascript:void(0);" id="OverviewReadMore" style="font-size:.95em; text-decoration:none; color:##993300; font-weight:bold;">Expand Overview &raquo;</a></div>
			</cfif>
		</div>
		</cfif>
		
		<!--- OBJECTIVES --->
		<cfif Len(Trim(StripHTML(Attributes.Objectives))) GT 0>
		<div class="Act-Box" id="ObjectivesBox">
			<h2 class="Head DarkGray">Objectives</h2>
			<div class="Act-BoxContent">
				#activateLinks(Attributes.Objectives)#
			</div>
		</div>
		</cfif>
		
		<!--- MATERIALS --->
		<cfif qMatCount.MaterialCount GT 0>
			<div class="Act-Box" id="MaterialsBox">
				<h2 class="Head DarkGray">Materials</h2>
				<div class="Act-BoxStep">
					<h5>STEP</h5>
					<div class="StepNumber">#MaterialStep#</div>
				</div>
				<div class="Act-BoxContent Step">
					<div id="MaterialsContainer"></div>
					<div id="MaterialsLoading" style="display:none; padding:15px; text-align:center; font-size:11px; color:##555;">
					<img src="/lms/_images/loading.gif" /><br />Loading...</div>        
				</div>
			</div>
		</cfif>
		
		<cfif qStatements.RecordCount GT 0>
		<div class="Act-Box" id="StatementsBox">
			<h2 class="Head DarkGray">Statements</h2>
			<div class="Act-BoxContent">
				<!--- THIS IS STUPID HOW I'M DOING THIS BUT I'M LEAVING IT FOR NOW... --->
				<cfloop query="qStatements">
				#Replace(Replace(qStatements.CreditStatement,'%ReferenceNumber%',Trim(qStatements.ReferenceNo),'ALL'),'%Credit%',qStatements.Amount,'ALL')#
				</cfloop>
			</div>
		</div>
		</cfif>
	</div>
	<div id="ActivityRight">
		<div class="Act-Box" id="StatusBox">
			<h2 class="Head DarkGray">Your Status</h2>
			<div class="Act-BoxItem">
				<div class="Act-BoxStep">
					<h5>STEP</h5>
					<div class="StepNumber">#StatusStep#</div>
				</div>
				<div class="Act-BoxItemContent">
					<div id="StatusContainer"></div>
					<div id="StatusLoading" style="display:none; padding:15px; text-align:center; font-size:11px; color:##555;">
						<img src="/lms/_images/loading.gif" /><br />Loading...						</div>
				</div>
			</div>
		</div>
		
		<!--- ASSESSMENTS --->
		<cfif qAssCount.AssessCount GT 0>
		<div class="Act-Box" id="AssessBox">
			<h2 class="Head DarkGray">Assessments</h2>
			
			<div id="AssessContainer"></div>
			<div id="AssessLoading" style="display:none; padding:15px; text-align:center; font-size:11px; color:##555;">
			<img src="/lms/_images/loading.gif" /><br />Loading...</div>
		</div>
		</cfif>
		
		<!---<cfquery name="qStatements" dbtype="query">
			SELECT *
			FROM qActivityPubComponents
			WHERE ComponentName = 'Statements'
		</cfquery>--->
		
		<!--- COMMENTS SECTION --->
		<!--- CHECK IF COMMENTS ARE TO BE SHOWN --->
		<cfif Attributes.AllowCommentsFlag EQ "Y">
		<h2 class="Head DarkGray">Comments</h2>
		<p>
			<div id="CommentsContainer">                    </div>
			<div id="CommentsLoading" style="display:none; padding:15px; text-align:center; font-size:11px; color:##555;">
				<img src="/lms/_images/loading.gif" /><br />Loading...                    </div>
		</p>
		</cfif>
		
		<!---<style>
		.Act-ShareBtn { float:left;height:75px;width:70px; margin-top:5px; text-align:center; }
		</style>
		<div class="Act-Box" id="ShareBox">
			<h2 class="Head DarkGray">Share</h2>
			<div class="Act-ShareBtn">
			<script>var fbShare = {
			url: 'https://ccpd.uc.edu/activity/#Attributes.ActivityID#'
			}</script>
			<script src="https://widgets.fbshare.me/files/fbshare.js"></script>
			</div>
			<div class="Act-ShareBtn">
			<script type="text/javascript">
			tweetmeme_url = 'https://ccpd.uc.edu/activity/#Attributes.ActivityID#';
			tweetmeme_source = 'UC_CCPD';
			</script>
			<script type="text/javascript" src="https://tweetmeme.com/i/scripts/button.js"></script>
			</div>
			<div class="Act-ShareBtn">
				<a href="http://digg.com/submit?url=https://ccpd.uc.edu/activity/#Attributes.ActivityID#&title=#Attributes.Title#&bodytext=#StripHTML(Attributes.Overview)#&media=news&topic=educational" style="text-decoration:none;"><img src="/lms/_images/icon_digg.jpg" border="0" /><br />DIGG IT!</a>
			</div>
		</div>--->
		
		<div class="Act-Box" id="RecommendBox">
			<h2 class="Head DarkGray">People have also taken...</h2>
			<!---<ul>
				<cfloop query="qAlsoTaken">
				<li><a href="#qAlsoTaken.Permalink#">#qAlsoTaken.Title#</a></li>
				</cfloop>
			</ul>--->
		</div>
	</div>
    </div>
	</cfif>
	<cfset MaxRating = 5>
	<cfset Rating = 0>
	<cfif Attributes.StatVoteCount GT 0>
		<cfset Rating = Round(Attributes.StatVoteValue/Attributes.StatVoteCount)>
	</cfif>
	<div id="ActivityRatingBox">
		<div class="ActivityRatingLabel" style="float:left;">Rating</div>
		<cfloop from="1" to="#MaxRating#" index="i">
		<input name="Rating-Detail-#Attributes.ActivityID#" type="radio" value="#i#" style="display:none;" class="StarRating"<cfif i EQ Rating> checked</cfif><cfif Attributes.AttendeeStatusID NEQ 1> disabled="disabled"</cfif> />
		</cfloop>
	</div>
	<!--- AttendeeExists IS DEFINED IN mActivity.getAttendee --->
    <!--- USER IS LOGGED IN AND CURRENTLY TAKING THE ACTIVITY, HAS NOT FAILED YET --->
    <cfif Session.LoggedIn>
		<cfif Session.PersonID GT 0 AND AttendeeExists AND AttendeeBean.getStatusID() EQ 2>
            <!-- a button that triggers overlay. rel- attribute is a jQuery selector to the overlay --> 
           
            <div id="VideoDialog"></div>
            <div class="DocumentDiv" id="DocumentDiv" style="display:none;">
                <div id="DocHeader" style="position:relative; left:10px;">
                    <img src="#application.settings.rootpath#/_images/icons/red_x.png" class="CloseDocument" style="position:relative; left:650px; top:10px;" />
                    <h3>Document Viewer</h3>
                </div>
                <iframe name="frmDocView" id="frmDocView" style="position: relative; left:10px; height:460px; width:675px;border:1px solid ##000;"></iframe>
                <div id="DocViewControls" style="position:absolute;top:535px;left:35px;">
                    <input type="button" class="CloseDocument" value="Close" align="right" />
                </div>
            </div>
        </cfif>
        <div id="divCert">
            <iframe src="" width="700" height="346" frameborder="0" scrolling="auto" name="frmCert" id="frmCert"></iframe>
        </div>
    </cfif>
</div>

<!---<div id="HiddenStep-Mat" class="HiddenStep">
	Scroll down for Step 2
</div>--->
</cfoutput>
<cfscript>
/**
 * Converts text links into HTML links within a string
 * 
 * @param string 	 Input string. (Required)
 * @return Returns a string. 
 * @author Robin Scherberich (&#115;&#99;&#104;&#101;&#114;&#98;&#101;&#114;&#105;&#99;&#104;&#46;&#114;&#64;&#103;&#109;&#97;&#105;&#108;&#46;&#99;&#111;&#109;) 
 * @version 1, February 22, 2011 
 */
function activateLinks( string )
{
	var stringLen = len( string );
	var currentPosition = 1;
	var urlArray = [];

	while( currentPosition < stringLen )
	{
		rezArray = REFindNoCase( "(?i)\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'"".,<>?«»‘’]))", arguments.string, currentPosition, true );
		
		if( rezArray.len[1] != 0 ){
			arrayAppend( urlArray, mid( string, rezArray.pos[1]-2, rezArray.len[1]+2 ) );
			currentPosition = rezArray.pos[1] + rezArray.len[1];
		} else {
			currentPosition = stringLen;
		}
	}

	for( i = 1; i <= arrayLen( urlArray ); i++ )
	{
		if( left( urlArray[i], 2 ) != '="' )
		{
			link = right( urlArray[i], len( urlArray[i] )-2 );
			string = replace( string, link, '<a href="'& link &'">'& link &'</a>', "all" );
		} else {
			i++;
		}
	}

	return string;
}
</cfscript>