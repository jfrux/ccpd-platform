<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.MultiFormContent" default="">
<cfparam name="Request.MultiFormRight" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">
<cfparam name="Attributes.UCID" default="">
<cfoutput>
<script>
App.User.start({
  model:{
    'id':#session.personid#,
    'account_id':#session.account.getAccountId()#,
    'name':'#session.person.getDisplayName()#'
  }
});
</script>
</cfoutput>
<cfoutput>
<div class="user profile">

  <div class="profile-bg">
    <div class="profile-bg-inner"></div>
  </div>
  <div class="row">
    <div class="span5">
      <cfoutput>
      <div class="projectbar js-projectbar">
        <div class="box">
          <div class="thumbnail">
          <img src="http://placehold.it/182x113">
          </div>
        </div>
        <div class="box js-profile-menu">
          <cf_ce_profilemenu type="user" typeid="#session.personid#" settings="#request.tabSettings#" current="#Attributes.Fuseaction#">
        </div>
      </div>
      </cfoutput>
    </div>
    <div class="span19">
      <div class="titlebar">
        <div class="row-fluid">
          <div class="span16">
            <div class="ContentTitle">
              <span title="">User Pages</span>
            </div>
          </div>
          <div class="span8">
            <div class="action-buttons pull-right">

            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="span19">
      <div class="content js-profile-content">
        <cfoutput>
        <div class="row-fluid">
          <div class="span18 js-content-toggle">
            <div class="row-fluid">
              <div class="content-title">
                <h3>#request.tabSettings.tabs[lcase(attributes.fuseaction)].title#</h3>
              </div>
            </div>
            <div class="MultiFormContent content-inner">
              <div id="js-#replace(request.tabSettings.tabs[lcase(attributes.fuseaction)].event,'.','-')#">
              <cfif structKeyExists(variables,'multiformcontent')>
                #multiformcontent#
              </cfif>
              </div>
            </div>
          </div>
          <div class="span6 js-infobar-outer">
            <div class="InfoBar infobar js-infobar">

            </div>
          </div>
        </div>
        </cfoutput>
      </div>
    </div>
  </div>
</cfoutput>
