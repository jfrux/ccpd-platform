<cfparam name="Request.Page.Title" default="">
<cfparam name="Request.Page.Body" default="No Body Found">
<cfparam name="Request.Page.Desc" default="">
<cfparam name="Request.Page.Breadcrumbs" default="">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<cfoutput>
	<meta name="keywords" content="" />
	<meta name="description" content="#stripHTML(Request.Page.Desc)#" />
	<title><cfif Request.Page.Title NEQ "">#Request.Page.Title# - </cfif>#Application.Settings.AppName#</title>
	</cfoutput>
	<cfinclude template="dsp_HeadGlobal.cfm" />
	<script>
	$(document).ready(function() {
		var CompatibilityMsg = '';
		
		$('.TopLoginField').keydown(function(e){
			console.log(e.keyCode);
			if (e.keyCode == 13) {
				document.frmTopLogin.submit();
				return false;
			}
		});
		$("#LoginLink").click(function() {
			$("#myController").hide().css('top','470px').fadeTo(0,1).fadeIn(100);
			$("#LoginForm").slideDown(500);
			$("#LoginLinkText").hide();
			$("#LoginCancelText").show();
			$("#LoginLine").css("color","#434343");
			$("#LoginLine").fadeTo("slow", 1, function() {
				$('#Email:first').focus();
			});
			return false;
			
		});
		$("#LoginCancel").click(function() {
			$("#myController").hide().css('top','320px').fadeTo(0,1).fadeIn(100);
			$("#LoginForm").slideUp(500);
			$("#LoginCancelText").hide();
			$("#LoginLinkText").show();
			$("#LoginLine").css("color","#FFF");
			return false;
		});
		
		if ((screen.width<1024) && (screen.height<768))
		{
			CompatibilityMsg = CompatibilityMsg + '<li>Your monitor screen resolution needs to be at least 1024x768. <a href=\"/support/kb/9\" target=\"_blank\">Learn How</a></li>';
		}
		
		if (CompatibilityMsg) {
			$("#CompatibilityAny").show();
			$("#CompatibilityAny ul").html(CompatibilityMsg);
		}
	});
	</script>
	
	<script type="text/javascript">
	
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-10861484-1']);
	  _gaq.push(['_trackPageview']);
	
	  (function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();
	
	</script>
</head>

<body>
<cfoutput>
<div id="MainContainer">
	<noscript>
	<div class="Compatibility" id="CompatibilityJS">
		<div class="CompatibilityIcon"><img src="/lms/_images/Compatibility_Icon.gif" /></div>
		<div class="CompatibilityInfo"><h4>One or more possible compatibility issues with our website were detected...</h4>
		<ul class="CompatibilityList">
			<li>Your browser has Javascript DISABLED. Please enable it to continue utilizing our site. <a href="/support/kb/12" target="_blank">Learn How</a></li>
		</ul>
		</div>
	</div>
	</noscript>
	<div class="Compatibility" id="CompatibilityAny" style="display:none;">
		<div class="CompatibilityIcon"><img src="/lms/_images/Compatibility_Icon.gif" /></div>
		<div class="CompatibilityInfo"><h4>One or more possible compatibility issues with our website were detected...</h4>
		<ul class="CompatibilityList">
			
		</ul>
		</div>
	</div>
	<cfif Session.LoggedIn>
	<div id="LoginLine"><div class="widthlimiter">Welcome, #Session.Person.getFirstName()#<!--(#Session.PersonID#)-->!  <a href="#myself#Main.doLogout">Sign-out</a></div></div>
	<cfelse>
	<script>
	
	</script>
	<div id="LoginLine">
	<div class="widthlimiter">Already have an account? <span id="LoginLinkText"><a href="#Application.Settings.RootPath#/login" id="LoginLink">Sign-in</a> to get started.</span><span id="LoginCancelText" style="display:none;"><a href="javascript:void(0);" id="LoginCancel">Cancel</a> to get started.</span></div></div>
	<div id="LoginForm" style="display:none;">
		<form action="#myself#Main.doLogin" method="post" name="frmTopLogin">
		<table width="700" cellspacing="1" cellpadding="3" border="0" align="center">
			<tr>
				<td width="350">
				<h3 style="margin:0px; font-size:18px;">Sign-in</h3>
				<p>
				<strong>Simply enter your Account ID and Password to begin taking courses.</strong><br />

				<br />
				Don't have an account?<br />
				<a href="#myself#Main.Register">Sign up now &raquo;</a>
				</p>
				</td>
				<td width="489">
					<label for="username" style="display:block; font-weight:bold; padding:4px 0px;">Email</label>

					<input type="text" name="Email" id="Email" class="TopLoginField" />
					
					<label for="password" style="display:block; font-weight:bold; padding:4px 0px;">Password</label>
					<input type="password" name="password" id="password" class="TopLoginField" />
					<a href="#myself#Main.ForgotPW" style="font-size:10px;">Forgot your password?</a><br />
					<!---<input name="RememberMe" type="checkbox" value="1" checked /> Remember me--->
					<input type="hidden" name="Submitted" value="1" />
					<div style="padding:3px 0px;"><input type="submit" value="SIGN-IN" name="Submit" /></div>
				</td>
			</tr>

		</table>
		</form>
	</div>
	</cfif>
	
	<div id="Header">
		<div class="widthlimiter">
			<div id="HeaderLogo"><a href="/"><img src="/lms/_images/Header_CCPD.gif" border="0" alt="University of Cincinnati UC Center for Continuous Professional Development CCPD CE" /></a></div>
			<div id="HeaderMiddle"><img src="/lms/_images/Header_Middle.gif" alt="Continuing Education for Medicine, Nursing, Pharmacy, and more. Cincinnati, Ohio" /></div>
			<div id="HeaderRight"><a href="http://www.uc.edu/" target="_blank"><img src="/lms/_images/Header_UC.gif" alt="University of Cincinnati" border="0" /></a></div>
		</div>
	</div>
	<div id="HeaderNav">
		<div class="widthlimiter">
		<cfif Session.LoggedIn><a href="#Application.Settings.RootPath#/home">My CCPD</a><a href="#Application.Settings.RootPath#/browse">Browse Activities</a><a href="#Application.Settings.RootPath#/transcript">My Transcript</a><a href="#Application.Settings.RootPath#/preferences">My Preferences</a>
		<cfelse>
		<a href="/">Welcome</a><a href="#Application.Settings.RootPath#/about">What is this?</a><a href="#Application.Settings.RootPath#/browse">Browse Activities</a><cfif NOT isDefined("Session.PersonID") OR isDefined("Session.PersonID") AND Session.PersonID EQ ""><a href="#Application.Settings.RootPath#/signup">Sign-up</a></cfif>
		</cfif>
		<a href="http://www.hipchat.com/ggNgWf8Pv">Get Help</a>
		</div>
	</div>
	<cfif Request.Page.Breadcrumbs NEQ ""><div id="Breadcrumbs"></div>
	</cfif>
	
	<div id="Content">
		<div class="widthlimiter">
		#Request.Page.Body#		</div>
	</div>
	
	<div id="Footer">
		<div class="widthlimiter">
		<div id="FooterCopy">Copyright &copy;#Year(now())# CCPD. All Rights Reserved.</div>
		<div id="FooterLinks"><a href="#myself#Main.Welcome">Welcome</a><a href="#Application.Settings.RootPath#/about">What is this?</a><a href="#Application.Settings.RootPath#/browse">Browse Activities</a><a href="#Application.Settings.RootPath#/signup">Sign-up</a><a href="http://www.hipchat.com/gKwFPKLXl">Get Help</a></div>
		</div>
	</div>
	<div id="SessionTimeout" style="display:none; padding:5px; cursor: default;text-align:center;"> 
	   <p style="font-size:14px;"><strong>SESSION ENDED</strong></p>
		<p>Your session has expired, you will now be redirected to Login.</p>
		<input type="button" id="SessionOkay" value="Okay" style="width:50px;" /> 
	</div>
	<div id="question232" style="display:none; padding:5px; cursor: default;text-align:center;"> 
       <p style="font-size:14px;"><strong>You have unsaved changes...</strong></p>
		<p>Are you sure you wish to navigate away from this page?</p>
        <input type="button" id="yes" value="Yes" style="width:50px;" /> 
        <input type="button" id="no" value="No" style="width:50px;" /> 
	</div>
</div>
<div id="StatusBar" style="display:none; height:0px;">
	<div style="display:none;" class="PageStandard" id="StatusBox0">
		
	</div>
</div>
</cfoutput>


<!---<script type="text/javascript" charset="utf-8">
  var is_ssl = ("https:" == document.location.protocol);
  var asset_host = is_ssl ? "https://s3.amazonaws.com/getsatisfaction.com/" : "http://s3.amazonaws.com/getsatisfaction.com/";
  document.write(unescape("%3Cscript src='" + asset_host + "javascripts/feedback-v2.js' type='text/javascript'%3E%3C/script%3E"));
</script>

<script type="text/javascript" charset="utf-8">
  var feedback_widget_options = {};

  feedback_widget_options.display = "overlay";  
  feedback_widget_options.company = "uc_ccpd";
  feedback_widget_options.placement = "left";
  feedback_widget_options.color = "#222";
  feedback_widget_options.style = "idea";
  
  
  
  
  
  

  var feedback_widget = new GSFN.feedback_widget(feedback_widget_options);
</script>--->
<div class="ce-dialog" id="AssessmentDiv" style="height:527px;
left:50%;
margin-left:-350px;
position:absolute;
top:0;
width:705px;
z-index:9999;display:none;">
<div class="ce-dialog-titlebar">Assessment</div>
<div class="ce-dialog-close"></div>
<div class="ce-dialog-content" id="AssessContent">

</div>
<div class="ce-dialog-buttons" id="AssessButtons">
	<button id="CompleteAssessment" class="button-gray">Complete</button><!---&nbsp;
	<a href="javascript://" id="CloseAssessment">Save and Close</button>--->
</div>
</div>
<!---
<strong>DEBUG INFO! PLEASE IGNORE.</strong><br />
COOKIES:<br />
<cfdump var="#cookie#">
SESSION:<br />
<cfdump var="#Session#">--->
<div id="link-container" class="linkviewer">
	<div id="link-container-close" class="linkviewer-close">
		<a href="javascript://" class="link-container-close"><img src="/lms/_images/overlay_close.png" border="0" /></a>
	</div>
	<iframe src="" id="link-container-frame"></iframe>
	<div id="link-container-buttons" class="linkviewer-buttons">
		<input type="button" name="btnClose" class="link-container-close MainButton" value="Finished" />
	</div>
</div>

</body>
</html>
