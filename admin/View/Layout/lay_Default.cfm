<cfparam name="Request.Page.Title" default="Untitled Page">
<cfparam name="Request.Page.Body" default="No Body Found">
<cfparam name="Request.Page.Breadcrumbs" default="">
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>#Request.Page.Title# - #Application.Settings.AppName#</title>
	<cfinclude template="dsp_HeadGlobal.cfm" />
</head>

<body class="tabs tab#Request.NavItem#">
	<div id="container">
		<div id="MainContainer">
			<style>
			##header { position:relative; }
			.getHelpLink {     
			-moz-border-radius: 5px 5px 5px 5px;
			background-color: ##EEEEEE;
			border: 1px solid ##FFFFFF;
			color: ##555555 !important;
			display: block;
			line-height: 22px;
			padding: 0 5px;
			position: absolute;
			right: 1px;
			text-decoration: none;
			top: 33px;
			z-index: 100;
			}
			.getHelpLink:hover { background-color:##FFF;
			border: 1px solid ##FFF;
			color: ##000 !important; }
			.getHelpLink i {
				background-image: url("/admin/_images/icons/support.png");
				display: block;
				float: left;
				height: 16px;
				margin-right: 4px;
				margin-top: 4px;
				width: 16px;
			}
			<cfif Session.Person.getPersonID() NEQ 169841>
			.joshonly {
			 display:none;
			}
			</cfif>
			</style>
			<div class="header-bg"></div>
			<div id="header" class="clearfix">
				
				<div class="header-search">
					<form id="navSearch" name="navSearch" method="get" action="#myself#main.search">
					<span class="uiSearchInput ">
						<span class="fieldWrapper">
							<input id="q" name="q" class="inputtext hide" type="text"><div style="width: 309px;" class="uiTypeahead imageTypeahead uiClearableTypeahead"><div class="wrap"><label class="clear uiCloseButton"><input title="Remove" type="button"></label><img class="photo img"></div><div class="uiTypeaheadView clearfix"><ul style="z-index: 1; top: 0px; left: 0px; display: none;" aria-activedescendant="ui-active-menuitem" role="listbox" class="ui-autocomplete ui-menu ui-widget ui-widget-content ui-corner-all"></ul></div></div>
						<button title="Search" type="submit" class="gblSearchBtn"><span class="hide">Search</span></button>
						</span>
					</span>
					</form>
				</div>
			
				<div id="BottomBar">
					<!---<a href="http://ccpd.uc.edu/lms/support" class="BottomLink supportLink getHelpLink hide"><i></i>GET HELP!</a>--->
					<div id="BottomBarTitle"><a href="#myself#Main.Welcome">CCPD</a><cfif Session.Account.getAuthorityID() EQ 3></cfif></div>
					<!---<div><div class="header-search joshonly">
							<form action="/search/" method="get" name="navSearch" id="navSearch">
							<span class="uiSearchInput ">
								<span class="fieldWrapper">
									<input type="text" class="inputtext hide" id="q" style=""><div class="uiTypeahead imageTypeahead uiClearableTypeahead" style="width: 309px;"><div class="wrap"><label class="clear uiCloseButton"><input type="button" title="Remove"></label><img class="photo img"><input type="text" autocomplete="off" spellcheck="false" class="inputtext textInput ui-autocomplete-input ui-autocomplete-loading" style="width: 309px;" role="textbox" aria-autocomplete="list" aria-haspopup="true" placeholder="Type to search..."></div><div class="uiTypeaheadView clearfix"><ul class="ui-autocomplete ui-menu ui-widget ui-widget-content ui-corner-all" role="listbox" aria-activedescendant="ui-active-menuitem" style="z-index: 1; top: 0px; left: 0px; display: none;"></ul></div></div>
									<button type="submit" title="Search"><span class="hide">Search</span></button>
								</span>
							</span>
							</form>
						</div>
					</div>--->
					<div id="BottomBarLinks" class="menu menu-top">
						<ul>
							<li class="menu-item"><a id="HeaderTab1" href="#myself#main.welcome">Home</a></li>
							<li class="menu-item"><a id="HeaderTab2" href="#myself#activity.home">Activities</a></li>
							<li class="menu-item"><a id="HeaderTab3" href="#myself#person.home">People</a></li>
							<li class="menu-item"><a id="HeaderTab4" href="#myself#report.home">Reports</a></li>
							<li class="menu-item">
								<span class="vr"></span>							</li>
							<li class="menu-item"><a href="#myself#admin.home">Setup</a></li>
							<li class="menu-item"><a href="#myself#support.home">Help</a></li>
							<li class="menu-item">
								<span class="vr"></span>							</li>
							<li class="menu-item"><a href="#myself#Main.doLogout" class="BottomLink">Logout</a></li>
							<!---<cfif Session.Account.getAuthorityID() EQ 3>
							<li class="menu-item"><a href="#myself##Attributes.Fuseaction#?#CGI.QUERY_STRING#<cfif NOT isDefined("Attributes.Fusebox.Load")>&fusebox.load=1&fusebox.password=05125586</cfif>" class="BottomLink">RELOAD</a></li>
							</cfif>--->
						</ul>
					</div>
					
					
				</div>
				<div id="HeaderNav" class="clearfix hide">
					<a href="#myself#main.welcome" id="HeaderTab1" class="HeaderTab">Dashboard</a><img src="#Application.Settings.RootPath#/_images/Header_Separator.gif" />
					<a href="#myself#activity.home" id="HeaderTab2" class="HeaderTab">Activities</a><img src="#Application.Settings.RootPath#/_images/Header_Separator.gif" />
					<a href="#myself#person.home" id="HeaderTab3" class="HeaderTab">People</a><img src="#Application.Settings.RootPath#/_images/Header_Separator.gif" />
					<a href="#myself#report.home" id="HeaderTab4" class="HeaderTab">Reporting</a><img src="#Application.Settings.RootPath#/_images/Header_Separator.gif" />	
					<a href="#myself#admin.home" id="HeaderTab5" class="HeaderTab">Administration</a><img src="#Application.Settings.RootPath#/_images/Header_Separator.gif" />
					<a href="#myself#support.home" id="HeaderTab6" class="HeaderTab">Support</a><img src="#Application.Settings.RootPath#/_images/Header_Separator.gif" />
					</div>
					<cfif Request.NavItem GT 0>
					<div id="HeaderSubNav" class="HeaderSubNav hide">
					<cfswitch expression="#Request.NavItem#">
						<cfcase value="1">
								<a href="javascript:void(0);">&nbsp;</a>
						</cfcase>
						<cfcase value="2">
								<a href="#myself#activity.create">Create Activity</a><a href="#myself#activity.home">Search</a>
						</cfcase>
						<cfcase value="3">
								<a href="#myself#person.create">Create Person</a><a href="#myself#person.home">Search</a>
						</cfcase>
						<cfcase value="4">
								<a href="javascript:void(0);">&nbsp;</a>
						</cfcase>
						<cfcase value="5">
								<a href="javascript:void(0);">&nbsp;</a><!---<a href="#myself#process.home">Processes &amp; Queues</a><a href="#myself#admin.comments">Comments</a>--->
						</cfcase>
						<cfcase value="6">
								<a href="javascript:void(0);" class="supportLink">New Ticket</a><!---<a href="#myself#process.home">Processes &amp; Queues</a><a href="#myself#admin.comments">Comments</a>--->
						</cfcase>
					</cfswitch>
						<div style="clear:both;"></div>
					</div>
				</cfif>
				<cfif Request.Page.Breadcrumbs NEQ ""><div id="Breadcrumbs">#Request.Page.Breadcrumbs#<div style="clear:both;"></div></div></cfif>
			</div>
			<div id="BodyWrapper">
				<div id="Content">
					#Request.Page.Body#
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
		<div id="StatusBar">
			<div style="display:none;" class="PageStandard" id="StatusBox0">
				
			</div>
		</div>
		
		
		<div class="jclock"></div>
	</div>
	
	<div id="ajax-issue">
		<div id="ajax-issue-title"></div>
		<div id="ajax-issue-details"></div>
		<div id="ajax-issue-buttons"><input type="button" name="ajax-issue-button" id="ajax-issue-button" value="Okay" class="button" /></div>
	</div>
</body>
</html>
</cfoutput>