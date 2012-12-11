<cfswitch expression="#Attributes.FuseAction#">
	<cfcase value="Report.CMECert">
		<cfif qReportData.City EQ "" AND qReportData.State EQ "" OR qReportData.City EQ "" AND qReportData.State EQ "0">
            <!--- NO LOCATION --->
            <cfreport template="#ExpandPath('./_reports/#Left(ReportInfo.getFileName(),Len(ReportInfo.getFileName())-4)#')#_noloc.cfr" query="qReportData" format="pdf">
                <!--- SET REPORT PARAMS BASED ON FUSEACTION --->
                <cfswitch expression="#Attributes.Fuseaction#">
                    <!--- SIGNIN SHEET --->
                    <cfcase value="Report.SigninSheet">
                        <cfif Attributes.EndDate NEQ "" AND Attributes.StartDate NEQ Attributes.EndDate>
                            <cfset ActivityDate = MonthAsString(Month(Attributes.StartDate)) & " " & Day(Attributes.StartDate) & "-" & Day(Attributes.EndDate) & ", " & Year(Attributes.StartDate)>
                        <cfelse>
                            <cfset ActivityDate = MonthAsString(Month(Attributes.StartDate)) & " " & Day(Attributes.StartDate) & ", " & Year(Attributes.StartDate)>
                        </cfif>
                        
                        <cfreportparam name="ActivityTitle" value="#Attributes.Title#" />
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
                        <cfif Attributes.EndDate NEQ "" AND Attributes.StartDate NEQ Attributes.EndDate>
                            <cfset ActivityDate = MonthAsString(Month(Attributes.StartDate)) & " " & Day(Attributes.StartDate) & "-" & Day(Attributes.EndDate) & ", " & Year(Attributes.StartDate)>
                        <cfelse>
                            <cfset ActivityDate = MonthAsString(Month(Attributes.StartDate)) & " " & Day(Attributes.StartDate) & ", " & Year(Attributes.StartDate)>
                        </cfif>
                        
                        <cfreportparam name="ActivityTitle" value="#Attributes.Title#" />
                    </cfcase>
                </cfswitch>
            </cfreport>
        </cfif>
	</cfcase>
    <cfcase value="Report.MailingLabels">
        
        <!--- CREATE NEW ARRAY --->
        <cfset qMailingLabels = QueryNew("Name, StreetAddress1, StreetAddress2, Location")>
        
        <!--- LOOP THROUGH DATA --->
        <cfloop query="qReportData">
        	<!--- ADD NEW ARRAY ROW --->
        	<cfset QueryAddRow(qMailingLabels)>
            
            <!--- BUILD ARRAY DATA --->
        	<cfset QuerySetCell(qMailingLabels, "Name", qReportData.FirstName & " " & qReportData.LastName)>
            
            <cfset QuerySetCell(qMailingLabels, "StreetAddress1", qReportData.StreetLine1)>
            <cfset QuerySetCell(qMailingLabels, "StreetAddress2", qReportData.StreetLine2)>
            
            <cfif qReportData.Country NEQ "United States of America">
            	<cfif qReportData.Province NEQ "">
        			<cfset QuerySetCell(qMailingLabels, "Location", qReportData.City & ", " & qReportData.Province & ", " & qReportData.Country & " " & qReportData.PostalCode)>
                <cfelse>
        			<cfset QuerySetCell(qMailingLabels, "Location", qReportData.City & ", " & qReportData.Country & " " & qReportData.PostalCode)>
				</cfif>
            <cfelse>
        		<cfset QuerySetCell(qMailingLabels, "Location", qReportData.City & ", " & qReportData.State & " " & qReportData.PostalCode)>
            </cfif>
        </cfloop>
        
        <cfreport template="#ExpandPath('./_reports/#ReportInfo.getFileName()#')#" query="qMailingLabels" format="pdf"></cfreport>
    </cfcase>
    <cfdefaultcase>
        <cfreport template="#ExpandPath('./_reports/#ReportInfo.getFileName()#')#" query="qReportData" format="pdf">
            <!--- SET REPORT PARAMS BASED ON FUSEACTION --->
            <cfswitch expression="#Attributes.Fuseaction#">
                <!--- SIGNIN SHEET --->
                <cfcase value="Report.SigninSheet">
                    <cfif Attributes.EndDate NEQ "" AND Attributes.StartDate NEQ Attributes.EndDate>
                    	<cfif DateCompare(Attributes.StartDate, Attributes.EndDate, "yyyy") NEQ 0>
	                        <cfset ActivityDate = MonthAsString(Month(Attributes.StartDate)) & " " & Day(Attributes.StartDate) & ", " & Year(Attributes.StartDate) & "-" & MonthAsString(Month(Attributes.StartDate)) & " " & Day(Attributes.EndDate) & ", " & Year(Attributes.EndDate)>
                        <cfelse>
	                        <cfset ActivityDate = MonthAsString(Month(Attributes.StartDate)) & " " & Day(Attributes.StartDate) & "-" & Day(Attributes.EndDate) & ", " & Year(Attributes.StartDate)>
                        </cfif>
                    <cfelse>
                        <cfset ActivityDate = MonthAsString(Month(Attributes.StartDate)) & " " & Day(Attributes.StartDate) & ", " & Year(Attributes.StartDate)>
                    </cfif>
                    
                    <cfreportparam name="ActivityTitle" value="#Attributes.Title#" />
                    <cfreportparam name="ActivityDate" value="#ActivityDate#" />
                </cfcase>
            </cfswitch>
        </cfreport>
    </cfdefaultcase>
</cfswitch>