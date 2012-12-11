<cfparam name="Attributes.EmailStyleID" default="0" />

<cfset EmailStyleInfo = Application.Com.EmailStyleGateway.getByAttributes(EmailStyleID=Attributes.EmailStyleID)>

<cfparam name="Attributes.Subject" default="#EmailStyleInfo.Subject#" />
<cfparam name="Attributes.TemplateHTML" default="#EmailStyleInfo.TemplateHTML#" />
<cfparam name="Attributes.TemplatePlain" default="#EmailStyleInfo.TemplatePlain#" />