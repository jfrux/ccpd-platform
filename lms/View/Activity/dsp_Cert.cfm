<cfparam name="AttendeeCertificateType" default="None" />

<cfswitch expression="#AttendeeCertificateType#">
	<cfcase value="CME">
		<cfif qReportData.City EQ "" AND qReportData.State EQ "">
            <!--- NO LOCATION --->
            <cfreport template="#ExpandPath('./_reports/#Left(ReportInfo.getFileName(),Len(ReportInfo.getFileName())-4)#')#_noloc.cfr" query="qReportData" format="pdf">
                <!--- SET REPORT PARAMS BASED ON FUSEACTION --->
                <cfswitch expression="#Attributes.Fuseaction#">
                    <!--- SIGNIN SHEET --->
                    <cfcase value="Report.SigninSheet">
                        <cfif Attributes.EndDate NEQ "" AND Attributes.ReleaseDate NEQ Attributes.EndDate>
                            <cfset ActivityDate = MonthAsString(Month(Attributes.ReleaseDate)) & " " & Day(Attributes.ReleaseDate) & "-" & Day(Attributes.EndDate) & ", " & Year(Attributes.ReleaseDate)>
                        <cfelse>
                            <cfset ActivityDate = MonthAsString(Month(Attributes.ReleaseDate)) & " " & Day(Attributes.ReleaseDate) & ", " & Year(Attributes.ReleaseDate)>
                        </cfif>
                    </cfcase>
                </cfswitch>
            </cfreport>
        <cfelse>
            <!--- LOCATION GIVEN --->
            <cfreport template="#ExpandPath('./_reports/#ReportInfo.getFileName()#')#" query="qReportData" format="pdf">
                <!--- SET REPORT PARAMS BASED ON FUSEACTION --->
                <cfswitch expression="#Attributes.Fuseaction#">
                    <!--- SIGNIN SHEET --->
                    <cfcase value="Report.SigninSheet">
                        <cfif Attributes.EndDate NEQ "" AND Attributes.ReleaseDate NEQ Attributes.EndDate>
                            <cfset ActivityDate = MonthAsString(Month(Attributes.ReleaseDate)) & " " & Day(Attributes.ReleaseDate) & "-" & Day(Attributes.EndDate) & ", " & Year(Attributes.ReleaseDate)>
                        <cfelse>
                            <cfset ActivityDate = MonthAsString(Month(Attributes.ReleaseDate)) & " " & Day(Attributes.ReleaseDate) & ", " & Year(Attributes.ReleaseDate)>
                        </cfif>
                    </cfcase>
                </cfswitch>
            </cfreport>
        </cfif>
    </cfcase>
	<cfcase value="CNE">
        <cfreport template="#ExpandPath('./_reports/#ReportInfo.getFileName()#')#" query="qReportData" format="pdf">
        </cfreport>
    </cfcase>
	<cfcase value="CPE">
    </cfcase>
    <cfdefaultcase>
    	To find out more information on why a certificate does not show for you, please contact 
    </cfdefaultcase>
</cfswitch>