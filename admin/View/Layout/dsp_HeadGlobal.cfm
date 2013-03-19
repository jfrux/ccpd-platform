
<cfoutput>
<link href="/static/css/screen.css" media="screen, projection" rel="stylesheet" type="text/css" />
<link href="/static/css/print.css" media="print" rel="stylesheet" type="text/css" />
<!--[if lt IE 8]>
  <link href="/stylesheets/ie.css" media="screen, projection" rel="stylesheet" type="text/css" />
<![endif]-->
<link rel="SHORTCUT ICON" href="/favicon.ico" type="image/x-icon" />
<cfif application.settings.dsn NEQ "CCPD_PROD">
	<style>
	.header-bg {
	  background-color: LIME;
	  box-shadow: 0 3px 0 ##000;
	}

	.data-source {
		position:absolute;
		color:##FFF;
		background-color:##FF0000;

	}
	</style>
</cfif>
<!---
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.js"></script>--->

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery-ui-1.8.9.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.maskedinput-1.1.3.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tmpl.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.hotkeys.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.dimensions.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/Global.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.blockUI.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.selectboxes.pack.js"></script><!---
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery-ui-1.7.custom.min.js"></script>--->
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tools.min.js"></script>
<!---<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.timepickr.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.timers.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tooltip.js"></script>--->
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.cfjs.packed.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.event.drag.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.event.drop.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.form.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.jgrowl.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.jLog.min.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.maskedinput-1.1.3.pack.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.scrollTo.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.tipsy.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.tmpl.min.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.translate.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.watermark.js"></script>
<script type="text/javascript" src="/static/js/lib/uiTypeahead.js"></script>
<script type="text/javascript" src="/static/js/lib/uiTokenizer.js"></script>
<script type="text/javascript" src="/static/js/json2.js"></script>
<script type="text/javascript" src="/static/js/global.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.periodicalupdater.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/encoder.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/history.js"></script>
<script type="text/javascript" src="/static/js/bugLogClient.js"></script>
<link href="#Application.Settings.RootPath#/_styles/StatusBar<cfif Request.Browser CONTAINS "MSIE">IE</cfif>.css?v=1" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/static/css/jquery-css/ui-lightness/jquery-ui-1.8.9.custom.css" media="screen" />
<link rel="stylesheet" href="/static/css/ceaui/tokenizer.css" media="screen" />

<link href="#Application.Settings.RootPath#/_styles/overlay.css?v=2" rel="stylesheet" type="text/css" />
<!---<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/Masks.js"></script>--->

		
<script>
	<cfif session.loggedIn>
	var user = {
		firstName: '#session.person.getFirstName()#',
		lastName: '#session.person.getLastName()#',
		email: '#session.person.getEmail()#'
	};
	</cfif>
	var popSupport = '';
	function popupSupport() {
		var w = 500;
		var h = 600;
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		var extraData = '&firstname=' + user.firstName + '&lastname=' + user.lastName + '&email1=' + user.email + '&email2=' + user.email + '&supporttype=ADMIN';
		popSupport = window.open('http://ccpd.uc.edu/lms/support?Display=popup' + extraData, 'support', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	}
	$(document).ready(function() {
		$(document).bind('keydown', 'space', function (evt){
			$('.header-search .ui-autocomplete-input').focus();


			return false; 
		});
			
		$(".supportLink").click(function() {
			popupSupport();
			return false;
		});
	});
	</script>
<script type="text/javascript">
	BugLog.listener = "#Application.settings.bugLogServer#/listeners/bugLogListenerREST.cfm";
	BugLog.appName = "#Application.settings.appname#";

	
// Method 1: Within your own error handler (full stacktrace)
	// try {
	// 	.... code that throws an error ...			
	// } catch(e) {
		
	// }
	
// Method 2:  Within a global error handler (no stacktrace)
	window.onerror = function(message, file, line) {
	  	BugLog.notifyService({
				  message: message,
				  extraInfo: 'Error occurred in: ' + file + ':' + line,
				  severity:"ERROR"
		  });
		  return true;
	};		

var loggedIn = false;
var StatusCount = 0;
var currPersonId = 0;
<cfif structKeyExists(session,'personid')>
currPersonId = <cfif isDefined("session.personId") AND len(trim(session.personId)) GT 0>#session.personid#<cfelse>0</cfif>;
</cfif>

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

sMyself = "#Myself#";
sRootPath = "#Application.Settings.RootPath#";

jQuery().ready(function(){
	$("##ajax-issue-button").click(function() {
		$("##ajax-issue").hide();
	});
	$.ajaxSetup({
		error:function(x,e){
			console.log(x);
			console.log(e);
			var sTitle = "Unexpected Error";
			var sMessage = "";
			if(x.status==0){
				//sMessage = "Connection to CCPD failed... please check your internet connection.";
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
				error: JSON.stringify(x),
				severity: "ERROR"
			});

			$("##ajax-issue").show();
		}
	});  
	  
	$(".BreadcrumbIcon").attr("src","#Application.Settings.RootPath#/admin/_images/icons/bullet_go#Request.NavItem#.png");
	$("##PageStandard").hide();
	/* SESSION TIMEOUT REDIRECT */
	function sessionTimeout() {
		window.location='#myself#Main.Login';
	}
	<cfif NOT isDefined("Client.Login") OR Client.Login EQ "">
	window.setTimeout(sessionTimeout, 10800000);
	</cfif>
	
	 LoadDocWidth = $(document).width();
	
<cfswitch expression="#Request.NavItem#">
	<cfcase value="1">
		$("##HeaderTab1").removeClass("HeaderTab");
		$("##HeaderTab1").addClass("HeaderTabOn");
		
	</cfcase>
	<cfcase value="2">
		$("##HeaderTab2").removeClass("HeaderTab");
		$("##HeaderTab2").addClass("HeaderTabOn");
	</cfcase>
	<cfcase value="3">
		$("##HeaderTab3").removeClass("HeaderTab");
		$("##HeaderTab3").addClass("HeaderTabOn");
	</cfcase>
	<cfcase value="4">
		$("##HeaderTab4").removeClass("HeaderTab");
		$("##HeaderTab4").addClass("HeaderTabOn");
	</cfcase>
	<cfcase value="5">
		$("##HeaderTab5").removeClass("HeaderTab");
		$("##HeaderTab5").addClass("HeaderTabOn");
	</cfcase>
	<cfcase value="6">
		$("##HeaderTab6").removeClass("HeaderTab");
		$("##HeaderTab6").addClass("HeaderTabOn");
	</cfcase>
</cfswitch>

	<cfparam name="Attributes.Message" default="">
	<cfif Attributes.Message NEQ "">
		<cfset Request.Status.Messages = Attributes.Message>
	</cfif>
	
	
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
});
</script>
</cfoutput>
<script>
$(document).ready(function() {
	$("#q").uiTypeahead({
		watermarkText:'Type to search...',
		queryParam:'q',
		size:'full',
		bucketed:'true',
		allowViewMore:true,
		useExistingInput:true,
		ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
		ajaxSearchType:"GET",
		ajaxSearchParams:{
			method:'search',
			max:4
		},
		allowAdd:false,
		clearOnSelect:true,
		onSelect:function(item) {
			if(item.link) {
			window.location=item.link;
			}
		}
	});
	
	$("#navSearch .calltoaction").live("click",function() {
		$(".gblSearchBtn").click();
	});
	
	$("#navSearch").submit(function() {
		var $gblInput = $("#navSearch").find('.ui-autocomplete-input');
		var gblQuery = $gblInput.val();
		
		if(gblQuery.length) {
			return true;
		} else {
			return false;
		}
	});
	
	$(".gblSearchBtn").click(function() {
		var qVal = $("#navSearch").find('.ui-autocomplete-input').val();
		var $qField = $("#navSearch").find("#q");
		
		$qField.val(qVal);
		
	});
});
</script>