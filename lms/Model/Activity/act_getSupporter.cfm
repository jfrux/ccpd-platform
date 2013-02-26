<cfset SupporterBean = CreateObject("component","#Application.Settings.Com#System.Supporter").Init(ContributorID=Attributes.SupporterID)>
<cfset SupporterBean = Application.Com.SupporterDAO.Read(SupporterBean)>

<cfset Attributes.Name = SupporterBean.getName()>
<cfset Attributes.Description = SupporterBean.getDescription()>