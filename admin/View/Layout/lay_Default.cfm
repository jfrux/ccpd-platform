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
  <script>
  
  sMyself = "#Myself#";
  sRootPath = "#Application.Settings.RootPath#";
  </script>
</head>

<body class="#params.controller# #params.action# #params.event# tabs tab#Request.NavItem#">
  <div class="body-inner container-fluid">
      <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
          <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="brand" href="/">CCPD</a>
            <div class="nav-collapse collapse">
              <ul class="nav">
                <li<cfif params.event EQ "main-welcome"> class="active"</cfif>><a href="#myself#main.welcome"><i class="icon-bullhorn"></i> News Feed</a></li>
                <li<cfif params.event EQ "main-activities"> class="active"</cfif>><a href="#myself#main.activities"><i class="icon-book"></i> Activities</a></li>
                <li<cfif params.event EQ "main-people"> class="active"</cfif>><a href="#myself#main.people"><i class="icon-group"></i> People</a></li>
                <li<cfif params.event EQ "main-reports"> class="active"</cfif>><a href="#myself#main.reports"><i class="icon-bar-chart"></i> Reports</a></li>
              </ul>
              <ul class="nav pull-right">
                <li class="divider-vertical"></li>
                <li><a href="#myself#person.detail?personid=#session.person.getPersonId()#"><i class="icon-user-profile" style="background-image:url(#imageUrl('default_photo/person_m_i.png')#);"></i>#session.person.getdisplayname()#</a></li>
                <li><a href="#myself#Main.doLogout">Logout</a></li>
              </ul>
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
    <script>
    App.Components.Status.start();
    </script>
    <cfdump label="PARAMS" var="#params#" />
    <cfdump label="ATTRIBUTES" var="#attributes#" />
  </body>
</html>