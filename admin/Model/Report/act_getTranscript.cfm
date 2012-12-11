<cfparam name="Attributes.StartDate" default="" />
<cfparam name="Attributes.EndDate" default="" />

<cfset qTranscriptPre = Application.Com.AttendeeGateway.getByReportAttributes(PersonID=Attributes.PersonID,DeletedFlag='N',StartDate=DateFormat(Attributes.StartDate, 'MM/DD/YYYY') & ' 00:00:00',EndDate=DateFormat(Attributes.EndDate, 'MM/DD/YYYY') & ' 23:59:59')>

<!--- ORDER TRANSCRIPT DATA --->
<cfquery name="qTranscript" dbtype="query">
	SELECT *
    FROM qTranscriptPre
    ORDER BY StartDate
</cfquery>

<cfset nTotalCME = 0>
<cfset nTotalCNE = 0>
<cfset nTotalCPE = 0>

<cfloop query="qTranscript">
	<cfswitch expression="#qTranscript.CreditType#">
		<cfcase value="CME">
			<cfset nTotalCME = nTotalCME + qTranscript.CreditAmount>
		</cfcase>
		<cfcase value="CNE">
			<cfset nTotalCNE = nTotalCNE + qTranscript.CreditAmount>
		</cfcase>
		<cfcase value="CPE">
			<cfset nTotalCPE = nTotalCPE + qTranscript.CreditAmount>
		</cfcase>
	</cfswitch>
</cfloop>