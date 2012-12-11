<cfset ReportInfo = CreateObject("component","#Application.Settings.Com#System.Report").init(ReportID=Attributes.ReportID)>
<cfset ReportInfo = Application.Com.ReportDAO.read(ReportInfo)>