<cfparam name="Request.Page.Title" default="Untitled Page">
<cfparam name="Request.Page.Body" default="No Body Found">
<cfparam name="Request.Page.Breadcrumbs" default="">
<cfparam name="tabSettings" default="{ 'title':'No Title' }" />
<cfif structkeyExists(request,'tabSettings') AND structKeyExists(request.tabSettings,attributes.fuseaction)>
  <cfset tabSettings = request.tabSettings.tabs[lcase(attributes.fuseaction)] />
<cfelse>
  <cfset tabSettings = {
    'title':""
  } />
</cfif>
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title><cfif structKeyExists(tabSettings,'title') AND len(trim(tabSettings.title)) GT 0>
    #tabSettings.title# - </cfif>#Application.Settings.AppName#</title>
  <cfinclude template="dsp_HeadGlobal.cfm" />
  <script>
  sMyself = "#Myself#";
  sRootPath = "#Application.Settings.RootPath#";
  
  </script>
</head>

<body class="#params.controller# #params.action# #params.event# tabs tab#Request.NavItem#">
  <div class="body-inner container-fluid">
      <div class="global-nav navbar navbar-inverse navbar-fixed-top">
        <div class="global-nav-inner navbar-inner">
          <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="brand" href="/">
              <div class="cropper">CCPD</div>
              <div class="logo3d"></div>
            </a>
            <div class="">
              <ul class="nav global-nav-links">
                <li<cfif params.event EQ "main-welcome"> class="active"</cfif>><a href="#myself#main.welcome"><i class="nav-home"></i><span class="text">Home</span></a></li>
                <li<cfif params.event EQ "main-activities" OR params.controller EQ "activity"> class="active"</cfif>><a href="#myself#main.activities"><i class="nav-activities"></i><span class="text">Activities</span></a></li>
                <li<cfif params.event EQ "main-people" OR params.controller EQ "person"> class="active"</cfif>><a href="#myself#main.people"><i class="nav-people"></i><span class="text">People</span></a></li>
                <li<cfif params.event EQ "main-reports"> class="active"</cfif>><a href="#myself#main.reports"><i class="nav-reports"></i><span class="text">Reports</span></a></li>
              </ul>
              <ul class="nav global-nav-links global-nav-panes pull-right">
                <li class="divider-vertical"></li>
                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" href="##">
                    <i class="nav-user-profile" style="background-image:url(#imageUrl('default_photo/person_m_i.png')#);"></i>
                  </a>
                  <ul class="dropdown-menu">
                    <li>#linkTo(controller="person",action="detail",params="personid=#session.person.getPersonId()#",text='Edit Profile')#</li>
                    <li>#linkTo(controller="person",action="preferences",params="personid=#session.person.getPersonId()#",text='Preferences')#</li>
                    <li>#linkTo(controller="main",action="dologout",text='Logout')#</li>
                  </ul>
                </li>
                <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" href="##"><i class="nav-alerts"></i></a>
                  <div class="alerts-menu dropdown-menu">
                    <div class="dropdown-menu-header">
                      <div class="title pull-left">Notifications</div>
                      <div class="actions pull-right">
                        <a href="##">Settings</a>
                      </div>
                    </div>
                    <div class="dropdown-menu-body">
                      No notifications at this time.
                    </div>
                  </div>
                </li>
              </ul>

              <form class="navbar-search pull-right">
                <input type="text" class="search-query span4" placeholder="Search">
              </form>
            </div>
          </div>
        </div>
      </div>
      <div class="container">
        <div id="Content">
          #request.page.body#
        </div>
        <div class="footer">
          <div class="footer-inner">
            Copyright &copy;#year(now())# University of Cincinnati. All Rights Reserved.
          </div>
        </div>
      </div>
    </cfoutput>
    </div>
    <div id="chatpanel">
    <div id="collective-xmpp-chat-data"></div>
    <div id="toggle-controlbox">
        <a href="#" class="chat toggle-online-users">
            <strong class="conn-feedback">Click here to chat</strong> <strong style="display: none" id="online-count">(0)</strong>
        </a>
    </div>
</div>
    <script>
    $.ajax({
      url: 'http://localhost:8888/admin/_com/ajax_chat.cfc',
      type:'get',
      dataType:'json',
      data:{
        method:'xmpp-auth'
      },
      success: function (data) {
          connection = new Strophe.Connection('http://localhost:8888/http-bind');
          connection.attach(data.jid, data.sid, data.rid, converse.onConnected);
      }
      });
    </script>
    <cfdump label="PARAMS" var="#params#" />
    <cfdump label="ATTRIBUTES" var="#attributes#" />
</body>
</html>