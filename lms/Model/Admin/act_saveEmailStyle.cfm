<cfparam name="Attributes.EmailStyleID" default="0" />
<cfparam name="Attributes.Subject" default="" />
<cfparam name="Attributes.TemplateHTML" default="" />
<cfparam name="Attributes.TemplatePlain" default="" />
<cfparam name="Attributes.Submitted" default="0" />


<cfif Attributes.Submitted EQ 1>
	<cfset EmailStyle = CreateObject("component","#Application.Settings.Com#EmailStyle.EmailStyle").init(EmailStyleID=Attributes.EmailStyleID)>
	<cfif Application.Com.EmailStyleDAO.Exists(EmailStyle)>
		<cfset EmailStyle = Application.Com.EmailStyleDAO.Read(EmailStyle)>
	</cfif>
	
	<cfset EmailStyle.setSubject(Attributes.Subject)>
	<cfset EmailStyle.setTemplateHTML(Attributes.TemplateHTML)>
	<cfset EmailStyle.setTemplatePlain(Attributes.TemplatePlain)>
	<cfset NewEmailStyle = Application.Com.EmailStyleDAO.Save(EmailStyle)>

	<cfoutput><script>window.location='#myself#Admin.EmailStyles';</script></cfoutput>
</cfif>