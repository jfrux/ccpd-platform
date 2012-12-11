<cfoutput>
<link href="#Application.Settings.RootPath#/_styles/styles.css?v=3" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.js"></script>

<script type="text/javascript" src="/static/js/jquery-plugins/jquery-ui-1.8.9.min.js"></script>
<script type="text/javascript" src="/static/js/jquery-plugins/jquery.watermark.js"></script>
<script type="text/javascript" src="/static/js/lib/uiTypeahead.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.maskedinput-1.1.3.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tmpl.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.cfjs.packed.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.dimensions.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/Global.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.blockUI.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tools.min.js"></script>

<cfif Request.Browser DOES NOT CONTAIN "MSIE">
<!---<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.utils.ui.min.js"></script>--->
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.timepickr.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.timers.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.tooltip.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.selectlist.min.js"></script>
</cfif>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.placeholder.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.selectboxes.pack.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.form.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.dropshadow.js"></script>
<!---<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.autocomplete.pack.js"></script>--->
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.ajaxQueue.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.MetaData.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.print.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.scrollTo-min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/thickbox-compressed.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/ZeroClipboard.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/jquery.periodicalupdater.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/encoder.js"></script>
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/history.js"></script>

<link href="#Application.Settings.RootPath#/_styles/ZeroClipboard.css?v=1" rel="stylesheet" type="text/css" />

<link href="#Application.Settings.RootPath#/_styles/StatusBar<cfif Request.Browser CONTAINS "MSIE">IE</cfif>.css?v=1" rel="stylesheet" type="text/css" />

<cfswitch expression="#Request.NavItem#">
	<cfcase value="1">
		<link href="#Application.Settings.RootPath#/_styles/Tab1.css?v=2" rel="stylesheet" type="text/css" />
	</cfcase>
	<cfcase value="2">
		<link href="#Application.Settings.RootPath#/_styles/Tab2.css?v=2" rel="stylesheet" type="text/css" />
	</cfcase>
	<cfcase value="3">
		<link href="#Application.Settings.RootPath#/_styles/Tab3.css?v=2" rel="stylesheet" type="text/css" />
	</cfcase>
	<cfcase value="4">
		<link href="#Application.Settings.RootPath#/_styles/Tab4.css?v=2" rel="stylesheet" type="text/css" />
	</cfcase>
	<cfcase value="5">
		<link href="#Application.Settings.RootPath#/_styles/Tab5.css?v=2" rel="stylesheet" type="text/css" />
	</cfcase>
	<cfcase value="6">
		<link href="#Application.Settings.RootPath#/_styles/Tab6.css?v=2" rel="stylesheet" type="text/css" />
	</cfcase>
</cfswitch>
<link href="#Application.Settings.RootPath#/_styles/TabControl.css?v=2" rel="stylesheet" type="text/css" />
<link href="#Application.Settings.RootPath#/_styles/overlay.css?v=2" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="#Application.Settings.RootPath#/_scripts/Masks.js"></script>
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
		 $(".supportLink").click(function() {
		 	popupSupport();
			return false;
		 });
	});
	</script>
<cfif session.person.getPersonId() EQ 169841>
<script>
$(document).ready(function() {
	$("##q").uiTypeahead({
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
});
</script>
</cfif>
<script type="text/javascript">
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
			var sTitle = "Unexpected Error";
			var sMessage = "";
			if(x.status==0){
				sMessage = "Connection to CCPD failed... please check your internet connection.";
			}else if(x.status==404){
				sMessage = "OOPS! An error occurred during your last request. Page not found!";
			}else if(x.status==500){
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
			$("##ajax-issue").show();
		}
	});  
	  
	$(".BreadcrumbIcon").attr("src","#Application.Settings.RootPath#/admin/_images/icons/bullet_go#Request.NavItem#.png");
	$("##PageStandard").hide();
	/* SESSION TIMEOUT ALERT BOX */
	var divObject = $('##SessionTimeout')[0]; 
	
	$('##SessionOkay').click(function() { 
		$.unblockUI();
		window.location='#myself#Main.Login';
	}); 
	
	function sessionTimeout() {
		$.extend($.blockUI.defaults.overlayCSS, { backgroundColor: '##000' });
		$.blockUI({message: divObject, width: '275px' });
	}
	<cfif NOT isDefined("Client.Login") OR Client.Login EQ "">
	window.setTimeout(sessionTimeout, 3600000);
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