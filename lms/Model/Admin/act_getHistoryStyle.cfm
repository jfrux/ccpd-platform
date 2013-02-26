<cfparam name="Attributes.HistoryStyleID" default="0" />

<cfset HistoryStyleInfo = Application.Com.HistoryStyleGateway.getByAttributes(HistoryStyleID=Attributes.HistoryStyleID)>

<cfparam name="Attributes.Title" default="#HistoryStyleInfo.Title#" />
<cfparam name="Attributes.TemplateFrom" default="#HistoryStyleInfo.TemplateFrom#" />
<cfparam name="Attributes.HistoryType" default="#HistoryStyleInfo.HistoryTypeID#" />
<cfparam name="Attributes.IconImg" default="#HistoryStyleInfo.IconImg#" />