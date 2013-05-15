<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Main -->
<circuit access="public" xmlns:cs="coldspring/">
  <prefuseaction callsuper="true">
    <set name="Request.NavItem" value="2" />
    <do action="mMain.TabControl" />
    <set name="request.page.action" value="#listLast(attributes.fuseaction,'.')#" />
  </prefuseaction>
  <postfuseaction>
    <if condition="isPjax()">
      <true>
          <if condition="#request.currentTab.hasToolbar#">
          <true>
            <invoke object="myFusebox" 
                methodcall="do('vMain.#request.page.action#right','multiformright')" />
          </true>
          </if>
          <invoke object="myFusebox" 
              methodcall="do('vMain.#request.page.action#','multiformcontent')" />
        <do action="vLayout.Blank" />
      </true>
       <false>
        <if condition="isAjax()">
          <true>
          <do action="vLayout.Blank" />
          </true>
          <false>
            <if condition="#request.currentTab.hasToolbar#">
            <true>
              <invoke object="myFusebox" 
                  methodcall="do('vMain.#request.page.action#right','multiformright')" />
            </true>
            </if>
            <invoke object="myFusebox" 
                methodcall="do('vMain.#request.page.action#','multiformcontent')" />
            <do action="vLayout.Sub_User" contentvariable="request.page.body" />

           <do action="vLayout.Default" />
          </false>
        </if>
      </false>
    </if>
  </postfuseaction>
  <fuseaction name="Welcome">
    <do action="mMain.TabControl" />
    <set name="Request.Page.Title" value="CE Dashboard" />
  </fuseaction>

  <fuseaction name="activities">
    <do action="mActivity.getActivities" />
    <do action="mActivity.getActivityTypes" />
    <do action="mActivity.getLiveGroupings" />
    <do action="mActivity.getEMGroupings" />
    <do action="mMain.TabControl" />
    <set name="request.page.title" value="Activities" />
  </fuseaction>

  <fuseaction name="people">
    <xfa name="SearchSubmit" value="Person.Home" />
    <do action="mPerson.Search" />
    <do action="mMain.TabControl" />
    <set name="request.page.title" value="People" />
    <xfa name="FrmSubmit" value="person.home" />
    <do action="mMain.TabControl" />
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