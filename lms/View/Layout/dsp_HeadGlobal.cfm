<cfoutput>
<link href="#Application.Settings.RootPath#/_styles/Main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/static/js/bugLogClient.js"></script>
<script>
BugLog.listener = "#Application.settings.bugLogServer#/listeners/bugLogListenerREST.cfm";
BugLog.appName = "CCPD_LMS_PROD";

window.onerror = function(message, file, line) {
	BugLog.notifyService({
		message: message,
		extraInfo: 'Error occurred in: ' + file + ':' + line,
		severity:"ERROR"
	});
	return true;
};

</script>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js"></script>
<script type="text/javascript" src="/lms/_scripts/jquery.tokeninput.js"></script>

<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.scrollTo-min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/firebugx.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/flowplayer-3.0.6.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/Global.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.autocomplete.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.blockUI.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.cfjs.packed.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.dimensions.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.dropshadow.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.expose-1.0.0.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.form.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.maskedinput-1.1.3.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.overlay-1.0.1.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.selectboxes.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.timepicker.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.timers.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tooltip.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tmpl.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery-ui-1.6rc6.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/Masks.js"></script>

<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.rating.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.MetaData.js"></script>

<link href="#Application.Settings.RootPath#/_styles/StatusBar<cfif Request.Browser CONTAINS "MSIE">IE</cfif>.css" rel="stylesheet" type="text/css" />
<link href="#Application.Settings.RootPath#/_styles/Assessment.css" rel="stylesheet" type="text/css" />
<link href="#Application.Settings.RootPath#/_styles/flowplayer.css" rel="stylesheet" type="text/css" />
<link href="#Application.Settings.RootPath#/_styles/Overlay.css" rel="stylesheet" type="text/css" />
<link href="#Application.Settings.RootPath#/_styles/jquery.rating.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	
var StatusCount = 0;

function addMessage(sStatus,nFadeIn,nFadeTo,nFadeOut) {
	$("##StatusBar").show();
	StatusCount++;
	$("##StatusBar").append("<div style=\"display:none;\" class=\"PageMessages\" id=\"StatusBox" + StatusCount + "\">" + sStatus + "</div>");
	//console.log("Status: " + StatusCount);
	$("##StatusBox" + StatusCount).show("slide",{direction: "down"},500).fadeTo(nFadeTo,.9).hide("slide",{direction: "down"},nFadeOut);
}

function addError(sStatus,nFadeIn,nFadeTo,nFadeOut) {
	$("##StatusBar").show();
	StatusCount++;
	$("##StatusBar").append("<div style=\"display:none;\" class=\"PageErrors\" id=\"StatusBox" + StatusCount + "\">" + sStatus + "</div>");
	$("##StatusBox" + StatusCount).show("slide",{direction: "down"},500).fadeTo(nFadeTo,.9).hide("slide",{direction: "down"},nFadeOut);
}

$(document).ready(function() {
	$("##ajax-issue-button").click(function() {
		$("##ajax-issue").hide();
	});
	$.ajaxSetup({
		error:function(x,e){
			var sTitle = "Unexpected Error";
			var sMessage = "";
			if(x.status==0){
				//sMessage = "Connection to CCPD failed... please check your internet connection.";sMessage = "Connection to CCPD failed... please check your internet connection.";
			}else if(x.status==404){
				sMessage = "OOPS! An error occurred during your last request. Page not found!";
			}else if(x.status==500){
				errMsg = "500 Internal Server Error"
				sMessage = "OOPS! An error occurred during your last request.  We are sorry for the inconvenience.";
			}else if(e=="parsererror"){
				sMessage = "OOPS! An error occurred during your last request.  JSON parsing error.";
			}else if(e=="timeout"){
				sMessage = "OOPS! An error occurred during your last request.  REQUEST TIMED OUT";
			}else {
				sMessage = "OOPS! An error occurred during your last request. " + x.responseText;
			}
			
			$("##ajax-issue-title").html(sTitle);
			$("##ajax-issue-details").html(sMessage);

			BugLog.notifyService({
				message: "XHR: " + sMessage,
				error: x,
				severity: "ERROR"
			});

			$("##ajax-issue").show();
		}
	}); 

	$(".BreadcrumbIcon").attr("src","/lms/_images/bullet_go#Request.NavItem#.gif");
	$("##PageStandard").hide();
	/* SESSION TIMEOUT ALERT BOX */
	var divObject = $('##SessionTimeout')[0]; 
	
	$('##SessionOkay').click(function() { 
		$.unblockUI();
		window.location='#myself#Main.Login';
	}); 
	
	<!---function sessionTimeout() {
		$.extend($.blockUI.defaults.overlayCSS, { backgroundColor: '##000' });
		$.blockUI({message: divObject, width: '275px' });
	}
	<cfif NOT isDefined("Client.Login") OR Client.Login EQ "">
	window.setTimeout(sessionTimeout, 3600000);
	</cfif>--->
	
	 LoadDocWidth = $(document).width();

	<cfparam name="Attributes.Message" default="">
	<cfif Attributes.Message NEQ "">
		<cfset Request.Status.Messages = Attributes.Message>
	</cfif>

	sMyself = "#Myself#";
	sRootPath = "#Application.Settings.RootPath#";
	sWebURL = "#Application.Settings.WebURL#";
	
	
	<cfif Request.Status.Errors NEQ "">
		<cfloop list="#Request.Status.Errors#" delimiters="|" index="err">
			addError("#err#",250,8000,3500);
		</cfloop>
	</cfif>
	<cfif Request.Status.Messages NEQ "">
		<cfloop list="#Request.Status.Messages#" delimiters="|" index="msg">
			addMessage("#msg#",250,6000,4000);
		</cfloop>
	</cfif>
	
	$(".PageErrors span a").unbind("click");
	$(".PageMessages span a").unbind("click");
	
	$(".PageErrors span img").bind("click", this, function() {
		var nId = $.Replace(this.id,'Status','');
		$("##StatusBox" + nId).fadeOut("fast");
	});
	
	
	
	$(".PageStandard").hide();
	
	$('input.StarRating').rating({
		callback: function(value, link){
			var nActivity = $.ListGetAt($(this).attr('name'),3,'-');
			if(value != '') {
				$.post("/lms/_com/VoteAjax.cfc",{
					method: 'VoteSave',
					returnFormat: 'plain',
					ActivityID: nActivity,
					VoteValue: value
				},function(data) {
					
				});
			}
		}
	}); 
	<cfif NOT Session.LoggedIn>
	$('input.StarRating').rating('disable'); 
	
	
	</cfif>
});
</script>
</cfoutput>