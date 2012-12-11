<cfparam name="AttendeeCertificateType" default="None" />

<cfswitch expression="#AttendeeCertificateType#">
	<cfcase value="CME">
    	<cfset qReportData = CreateObject("component","#Application.Settings.Com#CertificateData").getCMEData(ActivityID=Attributes.ActivityID,PersonID=Attributes.PersonID)>
        
		<cfset ReportInfo = CreateObject("component","#Application.Settings.Com#System.Report").init(ReportID=5)>
        <cfset ReportInfo = Application.Com.ReportDAO.read(ReportInfo)>
    </cfcase>
	<cfcase value="CNE">
    	<cfset qReportData = CreateObject("component","#Application.Settings.Com#CertificateData").getCNEData(ActivityID=Attributes.ActivityID,PersonID=Attributes.PersonID)>
        
		<cfset ReportInfo = CreateObject("component","#Application.Settings.Com#System.Report").init(ReportID=6)>
        <cfset ReportInfo = Application.Com.ReportDAO.read(ReportInfo)>
    </cfcase>
	<cfcase value="CPE">
    </cfcase>
</cfswitch>