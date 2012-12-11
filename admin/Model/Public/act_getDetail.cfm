<cfparam name="CertType" default="Participation">
<cfparam name="ReportInfo" default="">

<cfswitch expression="#CertType#">
	<cfcase value="CME">
    	<cfset Attributes.ReportID = 5>
    </cfcase>
	<cfcase value="CNE">
    	<cfset Attributes.ReportID = 6>
    </cfcase>
	<cfcase value="CPE">
    	<cfset Attributes.ReportID = 0>
    </cfcase>
	<cfcase value="Participation">
    	<cfset Attributes.ReportID = 24>
    </cfcase>
</cfswitch>

<cfif Attributes.ReportID NEQ 0>
	<cfset ReportInfo = CreateObject("component","#Application.Settings.Com#System.Report").init(ReportID=Attributes.ReportID)>
    <cfset ReportInfo = Application.Com.ReportDAO.read(ReportInfo)>
</cfif>