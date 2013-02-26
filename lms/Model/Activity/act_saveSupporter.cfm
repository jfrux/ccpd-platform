<cfparam name="Attributes.SupporterID" default="0" />
<cfparam name="Attributes.Name" default="" />
<cfparam name="Attributes.Description" default="" />

<cfif IsDefined("Attributes.Submitted") AND Attributes.Submitted EQ 1>
	<cfset SupporterBean = CreateObject("component","#Application.Settings.Com#System.Supporter").Init(ContributorID=Attributes.SupporterID)>
    <cfset SupporterBean = Application.Com.SupporterDAO.Read(SupporterBean)>
    
    <cfset SupporterBean.setName(Attributes.Name)>
    <cfset SupporterBean.setDescription(Attributes.Description)>
    
    <cfset SupporterBean = Application.Com.SupporterDAO.Update(SupporterBean)>
</cfif>