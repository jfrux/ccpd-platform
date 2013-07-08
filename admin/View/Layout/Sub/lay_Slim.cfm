<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.MultiFormContent" default="">
<cfparam name="Request.MultiFormRight" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">
<cfparam name="right" default="">
<cfparam name="content" default="">
<cfparam name="infobar" default="">
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
<div class="slim profile">
  <div class="row">
    <div class="span24">
      <div class="content js-profile-content">
        <cfoutput>
        <div class="content-title">
          <h3><i class=""></i> <span>#request.page.title#</span></h3>
        </div>
        <div class="row-fluid">
          <div class="span24 js-content-toggle">
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
