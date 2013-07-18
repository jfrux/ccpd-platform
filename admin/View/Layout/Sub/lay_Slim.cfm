<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.MultiFormContent" default="">
<cfparam name="Request.MultiFormRight" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">
<cfparam name="params.title" default="#request.page.title#">
<cfparam name="right" default="">
<cfparam name="content" default="">
<cfparam name="infobar" default="">
<cfparam name="Attributes.UCID" default="">
<cfoutput>
<script>
<cfif session.loggedIn>
App.User.start({
  model:{
    'id':#session.personid#,
    'account_id':#session.account.getAccountId()#,
    'name':'#session.person.getDisplayName()#'
  }
});
</cfif>
</script>
</cfoutput>
<cfoutput>
<div class="slim hub profile">
  <div class="hub-body project-body">
    <div class="titlebar">
      <div class="title-text">
          #params.title#
      </div>
      <div class="title-actions">
        <div class="action-buttons">
          <cfinclude template="includes/#lcase(params.controller)#/action_buttons.cfm" />
        </div>
      </div>
    </div>
    <div class="content js-hub-content">
      <cfoutput>
      <div class="hub-content">
        <!--- <div class="content-title">
          <h3><i class=""></i> <span>#request.page.title#</span></h3>
        </div> --->
        <div class="js-content-toggle">
          <div class="MultiFormContent content-inner">
            <div id="js-">
            <cfif structKeyExists(variables,'multiformcontent')>
              #multiformcontent#
            </cfif>
            </div>
          </div>
        </div>
      </div>
      </cfoutput>
    </div>
  </div>
</div>
</cfoutput>
