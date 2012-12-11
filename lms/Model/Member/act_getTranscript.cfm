<cfparam name="Attributes.StartDate" default="" />
<cfparam name="Attributes.EndDate" default="" />
<cfparam name="Attributes.CreditID" default="" />

<!--- CHECK FOR ERRORS --->
<cfset Status = "">

<cfif Attributes.StartDate EQ "" AND Attributes.EndDate EQ "">
	<cfset Status = "Please select a Start date and End Date." />
<cfelseif Attributes.StartDate EQ "__/__/____" AND Attributes.EndDate EQ "__/__/____">
	<cfset Status = "Please select a Start date and End Date." />
<cfelseif Attributes.StartDate EQ "" OR Attributes.StartDate EQ "__/__/____">
	<cfset Status = "Please select an Start date." />
<cfelseif Attributes.EndDate EQ "" OR Attributes.EndDate EQ "__/__/____">
	<cfset Status = "Please select an End date." />
</cfif>

<cfif Attributes.CreditID EQ "null">
	<cfset Status = "Please select a type of credit." />
</cfif>

<cfif Status EQ "">
	<!--- GET TRANSCRIPT INFORMATION --->
	<cfset qTranscriptPre = Application.Com.AttendeeGateway.getByReportAttributes(PersonID=Session.PersonID,DeletedFlag='N',StartDate=Attributes.StartDate,EndDate=Attributes.EndDate,DeletedFlag="N")>
	
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
<cfelse>
	<cfdump var="#Status#"><cfabort>
</cfif>