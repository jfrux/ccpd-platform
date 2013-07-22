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
<cfparam name="tabSettings" default="#request.tabSettings.tabs[lcase(attributes.fuseaction)]#" />

<cfset hub_classes = "" />
<cfset params.id = #session.personid# />
<cfset params.title = request.page.title />
<cfset params.profile_picture = "" />
<cfset params.includekey = false />
<cfset params.has_infobar = false />
<cfoutput>
<script>
App.Main.start({
  linkbarSettings:#serializeJson(request.tabSettings)#,
  model:{
    'id':#session.personid#,
    'account_id':#session.account.getAccountId()#,
    'name':'#session.person.getDisplayName()#'
  }
});
</script>
</cfoutput>