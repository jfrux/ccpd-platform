<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Main -->
<circuit access="public" xmlns:cs="coldspring/">
    
	<fuseaction name="Welcome">
    <set name="Request.NavItem" value="1" />
    <do action="mMain.TabControl" />
    <do action="mMain.Welcome" />
    <set name="Request.Page.Title" value="CE Dashboard" />
    <do action="vMain.Welcome" contentvariable="multiformcontent" />
    <set name="Request.Page.Breadcrumbs" value="" />
    <do action="mPage.ParseCrumbs" />
    <do action="vLayout.Sub_User" contentvariable="request.page.body" />
    <do action="vLayout.Default" />
	</fuseaction>
  
  <fuseaction name="Login">
    <set name="Request.Page.Title" value="Login" />
    <xfa name="Authenticate" value="Main.doLogin" />
    <do action="vMain.Login" contentvariable="Request.Page.Body" />
    <do action="vLayout.None" />
  </fuseaction>
	
	<fuseaction name="doLogin">
		<do action="mMain.doLogin" />
	</fuseaction>
	
	<fuseaction name="doLogout">
        <do action="mMain.doLogout" />
    </fuseaction>
	
	<fuseaction name="BlankTest">
		<do action="vMain.BlankTest" contentvariable="Request.Page.Body" />
		<do action="vLayout.None" />
	</fuseaction>
	
	<fuseaction name="Search">
		<set name="Request.NavItem" value="1" />
        <set name="Request.Page.Title" value="Search" />
        <do action="vMain.Search" contentvariable="Request.Page.Body" />
        <set name="Request.Page.Breadcrumbs" value="" />
        <do action="mPage.ParseCrumbs" />
        <do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="searchResults">
		<do action="mMain.doSearch" />
        <do action="vMain.SearchResults" />
	</fuseaction>
</circuit>