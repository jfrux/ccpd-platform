<cfparam name="date1" default="#qTranscript.StartDate[1]#">
<cfparam name="date2" default="#qTranscript.StartDate[qTranscript.RecordCount]#">

<cfdocument format="PDF" saveAsName="Transcript_#Session.PersonID#_#DateFormat(Now(), 'mmddyyyy')#">
    <div class="ViewContainer">
    <cfoutput>
    <table width="100%" border="0" cellspacing="0" cellpadding="2">
        <tr>
            <td><img src="/admin/_images/uc_logo_50percent.png"></td>
            <td align="center" style="color: ##006;">
                <h3>Center for Continuing Professional Development</h3><br>
                <h1><em>CCPD Transcript</em></h1>
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="3" style="border-top: 1px solid ##000;">
                <table style="border-top: 3px solid ##000;border-bottom: 3px solid ##000;" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                    	<td>
                        	<table>
                            	<tr>
                                    <td style="color: ##006;"><strong>Name:</strong></td>
                                    <td>#Attributes.DisplayName#</td>
                                </tr>
                                <tr>
                                    <td style="color: ##006;"><strong>Period of Transcript:</strong></td>
                                    <td>#DateFormat(Attributes.StartDate,"MMM D, YYYY")# - #DateFormat(Attributes.EndDate,"MMM D, YYYY")#</td>
                                </tr>
                                <tr>
                                    <td style="color: ##006;"><strong>Date of Transcript:</strong></td>
                                    <td>#DateFormat(Now(),"M/DD/YYYY")#</td>
                                </tr>
                            </table>
                        </td>
                    	<td valign="top">
                        	<table>
                            	<tr>
                                    <cfif nTotalCME NEQ 0>
                                        <td style="color: ##006;"><strong>Total category 1 CME credits:</strong></td>
                                        <td>#nTotalCME#</td>
                                    </cfif>
                                    <cfif nTotalCNE NEQ 0>
                                        <td style="color: ##006;"><strong>Total CNE contact hours:</strong></td>
                                        <td>#nTotalCNE#</td>
                                    </cfif>
                                    <cfif nTotalCPE NEQ 0>
                                        <td style="color: ##006;"><strong>Total CPE credits:</strong></td>
                                        <td>#nTotalCPE#</td>
                                    </cfif>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table width="100%">
                    <tr>
                        <td><strong>Date(s)</strong></td>
                        <td><strong>Activity Title</strong></td>
                        <td><strong>## of Hours Credit</strong></td>
                    </tr>
                    <cfset CurrActivity = "">
                    <cfloop query="qTranscript">
                        <cfif CurrActivity NEQ qTranscript.AttendeeID>
                            <tr>
                                <td valign="top">#DateFormat(qTranscript.StartDate,"M/DD/YYYY")#</td>
                                <td>#qTranscript.Title#</td>
                                <td>#qTranscript.CreditAmount# (#qTranscript.CreditType#)</td>
                            </tr>
                            <cfset CurrActivity = qTranscript.AttendeeID>
                        <cfelse>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>#qTranscript.CreditAmount# (#qTranscript.CreditType#)</td>
                            </tr>
                        </cfif>
                    </cfloop>
                </table>
            </td>
        <tr>
            <td colspan="3">This transcript reflects our records for your attendance at University of Cincinnati sponsored activities.  If you believe that this transcript is incomplete or incorrect please contact our office: (513) 558-7399.</td>
        </tr>
    </table>
    </cfoutput>
    </div>
</cfdocument>