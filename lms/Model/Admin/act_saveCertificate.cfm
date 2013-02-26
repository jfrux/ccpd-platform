<cfparam name="Attributes.certId" default="0" />
<cfparam name="Attributes.Title" default="" />
<cfparam name="Attributes.TemplateFrom" default="<div style='position: absolute; left: 187px; top: 236px; width: 653px; height: 75px; text-align: center;'><span style='font-size: x-large;'>%ActivityTitle%</span></div>" />
<cfparam name="Attributes.IconImg" default="" />
<cfparam name="Attributes.HistoryType" default="" />
<cfparam name="Attributes.Submitted" default="0" />

<cfif Attributes.Submitted EQ 1>
	<cfset HistoryStyle = CreateObject("component","#Application.Settings.Com#HistoryStyle.HistoryStyle").init(HistoryStyleID=Attributes.HistoryStyleID)>
	<cfif Application.Com.HistoryStyleDAO.Exists(HistoryStyle)>
		<cfset HistoryStyle = Application.Com.HistoryStyleDAO.Read(HistoryStyle)>
	</cfif>
	
	<cfset HistoryStyle.setTitle(Attributes.Title)>
	<cfset HistoryStyle.setTemplateFrom(Attributes.TemplateFrom)>
	<cfset HistoryStyle.setTemplateTo(Attributes.TemplateFrom)>
	<cfset HistoryStyle.setIconImg(Attributes.IconImg)>
	<cfset HistoryStyle.setHistoryTypeID(Attributes.HistoryType)>
	<cfset NewHistoryStyle = Application.Com.HistoryStyleDAO.Save(HistoryStyle)>

	<cfoutput><script>window.location='#myself#Admin.HistoryStyles';</script></cfoutput>
</cfif>