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

<body class="tabs tab#Request.NavItem#">
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
                <li><a href="#myself#main.welcome">News Feed</a></li>
                <li><a href="#myself#activity.home">Activities</a></li>
                <li><a href="#myself#person.home">People</a></li>
                <li><a href="#myself#report.home">Reports</a></li>
                <li class="divider-vertical"></li>
                <li><a href="#myself#person.detail?personid=#session.person.getPersonId()#">#session.person.getdisplayname()#</a></li>
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

    <!---     <div id="SessionTimeout" style="display:none; padding:5px; cursor: default;text-align:center;"> 
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

        <div id="StatusBar">
          <div style="display:none;" class="PageStandard" id="StatusBox0">
            
          </div>
        </div>
        
        <div id="ajax-issue">
          <div id="ajax-issue-title"></div>
          <div id="ajax-issue-details"></div>
          <div id="ajax-issue-buttons"><input type="button" name="ajax-issue-button" id="ajax-issue-button" value="Okay" class="button" /></div>
        </div> --->
      </div>
    </cfoutput>
    </div>
    <script>
    App.init();
    </script>
  </body>
</html>