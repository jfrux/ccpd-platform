<!DOCTYPE html>
<html lang="en">
<cfoutput>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
  <meta charset="utf-8">
  <title>PAGE TITLE</title>
  <cfinclude template="dsp_HeadGlobal.cfm" />
  <script>
  sMyself = "#Myself#";
  sRootPath = "#Application.Settings.RootPath#";
  </script>
</head>

<body data-controller="#params.controller#" data-action="#params.action#" data-event="#params.event#" class="#params.controller# #params.action# #params.event# tabs tab#Request.NavItem#">
  <div id='app'>
    <div id='header'>
      <cfinclude template="includes/global_nav.cfm" />
    </div>
    <div id='content'>
      <div class='container'>
        <div id='content-inner'>
          #request.page.body#
        </div>
      </div>
    </div>
    <div class='footer' id='footer'>
      <div class='text-center'>
        Copyright &copy;#year(now())# University of Cincinnati. All Rights Reserved.
      </div>
    </div>
  </div>
  <div class='modal'>
    <div class='modal-dialog'>
      <div class='modal-content'></div>
    </div>
  </div>
</body>
</cfoutput>
</html>