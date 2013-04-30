<cfset SupporterBean = CreateObject("component","#Application.Settings.Com#System.Supporter").Init(ContributorID=Attributes.SupporterID)>
<cfif attributes.supporterId GT 0>
  <cfset SupporterBean = Application.Com.SupporterDAO.Read(SupporterBean)>
</cfif>
<cfset supporter = Attributes['supporter'] = {} />
<cfset supporter['id'] = Attributes.SupporterID />
<cfset supporter['name'] = SupporterBean.getName()>
<cfset supporter['description'] = SupporterBean.getDescription()>