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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<cfoutput>
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
    <cfinclude template="includes/global_nav.cfm" />
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
  </div>
</body>
</cfoutput>
</html>