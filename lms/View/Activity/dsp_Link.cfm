<style>
html { overflow-y:hidden; }
#extlink-header {
	background-color:#000000;
border-bottom:3px solid #C00307;
margin:auto;
position:absolute;
top:0;
width:100%;
z-index:100;
}

#extlink-loader { 
	bottom:0;
	height:100%;
	left:0;
	margin:auto;
	position:absolute;
	right:0;
	top:0px;
	width:100%;
}

#extlink-loader iframe {
	bottom:0;
	height:100%;
	left:0;
	margin:auto;
	position:absolute;
	right:0;
	top:51px;
	width:100%;
	border:0;
}

#extlink-header div { float:left; margin:10px; }

#extlink-activitytitle { font-size:21px; color:#FFF; min-width:300px; }

#extlink-info { color:#DDDDDD; }
</style>
<script>
function setFrame() {
	nWindowHeight = $(window).height();
	//console.log(nWindowHeight-51);
	
	$("#extlink-loader iframe").css({'height':nWindowHeight-51 + 'px'});
}

$(document).ready(function() {
	$(window).resize(function () {
		setFrame();
	});
	
	setFrame();
	
	$("#btnReturn").click(function() {
		window.location='https://ccpd.uc.edu/activity/<cfoutput>#Attributes.ActivityID#</cfoutput>';
	});
});
</script>
<cfoutput>
<div id="extlink-header">
	<div id="extlink-returnbtn"><button id="btnReturn">Return to Activity</button><noscript><a href="https://ccpd.uc.edu/activity/#Attributes.ActivityID#">Return to Activity</a></noscript></div>
	<div id="extlink-activitytitle">#Left(Attributes.Title,29) & "..."#</div>
	<div id="extlink-info">You are viewing an external website.<br>When finished, press 'Return to Activity' to complete the activity.</div>
</div>

<div id="extlink-loader">
	<iframe src="#qGetLink.ExternalURL#"></iframe>
</div>
</cfoutput>