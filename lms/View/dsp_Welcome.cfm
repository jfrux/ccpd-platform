<cfimport taglib="/lms/_tags/" prefix="lms">
<link href="/lms/_styles/karmicFlow.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lms/_scripts/karmic-flow-0.2.js"></script>
<script>
$(document).ready(function() {
	$('#HomepageSlides').karmicFlow({ auto: true, duration:200, timer: 4000 });
});
</script>
<cfoutput>
<div id="HomepageSlider">
	<div id="HomepageSlides" class="karmic_flow_container">
		<ul class="karmic_flow_slider">
			<li class="karmic_flow_slides karmic_flow_slide_selected" id="slide1">
				<div class="karmic_slideLeft">
					<h3>Welcome to the new CE portal...</h3>
					<p>We have completely revamped our system for growth.  It now has new features
					to better help you achieve all of your continuing education needs for Medicine, Nursing, Pharmacy, and more!</p>
					<a href="#myself#Main.About" class="LearnMore">Learn More</a>
				</div>
				<div class="karmic_slideRight"><img src="/lms/_images/HomepageSlides/slide1.png" border="0" /></div>
			</li>
			<li class="karmic_flow_slides" id="slide2">
				<div class="karmic_slideLeft">
					<h3>Where do I start?</h3>
					<p>If you're new to CCPD - it's time to get an account! <a href="#myself#Main.Register" class="LearnMore">Sign-up &raquo;</a></p>
					<p>
					If you already have an account, please update <a href="#myself#Member.Account" class="LearnMore">your preferences</a> or continue on to browse our <a href="#myself#Activity.Browse" class="LearnMore">catelog of activities</a>.</p>
				</div>
				<div class="karmic_slideRight"><img src="/lms/_images/HomepageSlides/slide2.png" border="0" /></div>
			</li>
			<li class="karmic_flow_slides" id="slide3">
				<div class="karmic_slideLeft">
					<h3>Featured Activities</h3>
					<p>We like to highlight our featured activities so you have all of our great new offerings at your fingertips!</p>
					<a href="#myself#Main.About##FeaturedActivities" class="LearnMore">Learn More</a>
				</div>
				<div class="karmic_slideRight">
					<cfset qFeatured = Application.Com.ActivityGateway.getBySearchLMS(Limit=3,MyPersonID=Session.PersonID,FeaturedFlag='Y',PublishedFlag='Y', OrderBy="C.ReleaseDate DESC")>
					<cfoutput>
					<cfif qFeatured.RecordCount GT 0>
					<ul>
					<cfloop query="qFeatured">
						<li><a href="/activity/#qFeatured.ActivityID#"><img src="/lms/_images/icons/star.png" border="0" align="left" style="margin-right:4px;margin-bottom:10px;" /> #qFeatured.Title#</a></li>
					</cfloop>
					</ul>
					<cfelse>
						There aren't any featured activities at this time.
					</cfif>
					</cfoutput>
				</div>
			</li>
			<li class="karmic_flow_slides" id="slide4">
				<div class="karmic_slideLeft">
					<h3>Your Transcript</h3>
					<p>The new CE portal offers you the ability to generate a transcript across multiple types of credit into the Adobe PDF format.</p>
					<a href="#myself#Main.About##YourTranscript" class="LearnMore">Learn More</a> or <a href="#myself#Member.Transcripts" class="LearnMore">Generate My Transcript</a>
				</div>
				<div class="karmic_slideRight"><img src="/lms/_images/HomepageSlides/slide4.png" border="0" /></div>
			</li>
		</ul>
	</div>
	<div id="HomepageSlider-Control">
		<a class="karmic_flow_controller karmic_flow_controller_selected" href="##slide1" target="HomepageSlides">New Look!</a>
		<a class="karmic_flow_controller" href="##slide2" target="HomepageSlides">Where do I start?</a>
		<a class="karmic_flow_controller" href="##slide3" target="HomepageSlides">Featured Activities</a>
		<a class="karmic_flow_controller" href="##slide4" target="HomepageSlides">Your Transcript</a>
	</div>	
</div>
</cfoutput>
<div id="HomepageBoxes">
	<div class="HomepageBox">
		<h3>What is this?</h3>
		<p>Center for Continuous Professional Development involves assessing your training needs, then developing and executing a plan that ensures you stay current with new developments in your field and compliant with regulatory requirements.</p>
		<p><a href="<cfoutput>#myself#</cfoutput>Main.About" class="LearnMore">Learn More &raquo;</a></p>
		<p>&nbsp;</p>
		<h3>Stay updated...</h3>
		<p><a href="http://www.twitter.com/uc_ccpd" class="LearnMore">Follow Us on Twitter &raquo;</a><br />
		<a href="http://www.facebook.com/pages/Cincinnati-OH/University-of-Cincinnati-Center-for-Continuous-Professional-Development/169509130897" class="LearnMore">Become a Fan on Facebook &raquo;</a></p>
	</div>
	<div class="HomepageBox">
		<h3>Features</h3>
		<p>
		- Browse catalog of CE courses.<br />
		- Printable transcript records.<br />
		- Easily print your certificates.<br />
		- Rate activities you like / dislike.<br />
		- Receive recommendations on CE activities based on your ratings and specialy interests.
		</p>
		<p><a href="<cfoutput>#Application.Settings.RootPath#</cfoutput>/about#Features" class="LearnMore">Learn More &raquo;</a></p>
		<p>&nbsp;</p>
		<h3>Compatibility</h3>
		<p>
		This web application is best optimized for Firefox 3+, Safari 4, and Internet Explorer 8.<br />
		Less testing has been done on Internet Explorer versions 6 and 7.<br />
		Javascript MUST be ENABLED at this time to use the core functions of this website.<br />
		Ensure your screen resolution is AT LEAST 1024x768.
		</p>
		<p><a href="<cfoutput>#Application.Settings.RootPath#</cfoutput>/about#Compatibility" class="LearnMore">Learn More &raquo;</a></p>
	</div>
	<div class="HomepageBox">
		<h3>Activities</h3>
		<p>
		Type below to lookup activity...
		<cfoutput>
		<form name="frmSearch" id="frmSearch" method="get" action="#Myself#Activity.Browse">
					<input type="text" name="q" id="q" value="" style="width: 180px;" />
					<input type="hidden" name="Submitted" value="1" />
					<input type="Submit" name="btnSubmit" id="btnSubmit" value="Search" />
		</form>
		<a href="#myself#Activity.Browse">Browse Activities &raquo;</a>
		</cfoutput>
		</p>
		<div style="position:relative; top:6px; left:-10px;">
			<cfoutput><a href="#Application.Settings.RootPath#/signup"><img src="/lms/_images/Button_Signup.png" alt="Sign-up Today!" border="0" /></a><a href="#Application.Settings.RootPath#/login"><img src="/lms/_images/Button_Login.png" alt="Member Login" border="0" /></a></cfoutput>		</div>
	</div>
</div>