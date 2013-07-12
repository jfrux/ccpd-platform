<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.content" default="">
<cfparam name="Request.right" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">

<cfset hub_classes = "" />
<cfset params.id = attributes.entityid />
<cfset params.title = EntityBean.getTitle() />
<cfset params.primary_photo = EntityBean.getPrimary_photo() />