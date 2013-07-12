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

<cfset hub_classes = "" />
<cfset params.id = attributes.personid />
<cfset params.title = PersonBean.getCertName() />
<cfset params.profile_picture = PersonBean.getPrimary_Photo() />

<script>
<cfoutput>
nPerson = #Attributes.PersonID#;
sPersonName = '#replace(Attributes.FirstName, "'", "\'", "ALL")# #replace(Attributes.LastName, "'", "\'", "ALL")#';
nAccount = #Attributes.AccountID#;
</cfoutput>

App.Person.start({
  model:{
    'id':nPerson,
    'account_id':nAccount,
    'name':sPersonName
  }
});
</script>