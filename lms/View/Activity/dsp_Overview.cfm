<cfparam name="Attributes.TotalAmount" default="0">
<link href="#Application.Settings.RootPath#/_styles/Activity.css" rel="stylesheet" type="text/css" />

<cfoutput>
<!--- GENERAL INFORMATION --->
<div class="ViewSection" style="float:left; width:50%;">
    <div class="OverviewSectionLeft">
        <h3>General Information</h3>
        <table>
                <tr>
                    <td class="ViewSectionDetailLabel">Title</td>
                    <td class="ViewSectionDetailData">#Attributes.ActivityTitle#</td>
                </tr>
                <tr>
                    <td class="ViewSectionDetailLabel">Description</td>
                    <td class="ViewSectionDetailData">#Attributes.Description#</td>
                </tr>
                <tr>
                    <td class="ViewSectionDetailLabel">Type</td>
                    <td class="ViewSectionDetailData"><cfloop query="qActivityTypeList"><cfif Attributes.ActivityTypeID EQ qActivityTypeList.ActivityTypeID>#qActivityTypeList.Name#</cfif></cfloop></td>
                </tr>
                <cfif Attributes.StartDate NEQ Attributes.EndDate>
                    <tr>
                        <td class="ViewSectionDetailLabel">Dates</td>
                        <td class="ViewSectionDetailData">#Attributes.StartDate# - #Attributes.EndDate#</td>
                    </tr>
                <cfelse>
                    <tr>
                        <td class="ViewSectionDetailLabel">Date</td>
                        <td class="ViewSectionDetailData">#Attributes.StartDate#</td>
                    </tr>
                </cfif>
                <tr>
                    <td class="ViewSectionDetailLabel">Release Date</td>
                    <td class="ViewSectionDetailData">#Attributes.ReleaseDate#</td>
                </tr>
        </table>
    </div>
    <!--- DOCUMENTS --->
    <div class="OverviewSectionLeft">
        <h3>Documents</h3>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ViewSectionGrid">
                <cfscript>
                    function FileType(path) {
                        Var fso = CreateObject("COM", "Scripting.FileSystemObject");
                        Var theFile = fso.GetFile(path);
                        Return theFile.Type;
                    }
                </cfscript>
                <cfset FilePath = "#ExpandPath("./_uploads/ActivityFiles/#Attributes.ActivityID#/")#">
                
                <tbody>
                <cfif qFileList.RecordCount GT 0>
                    <cfloop query="qFileList">
                        <cfset FileType = Right(qFileList.FileName,Len(qFileList.FileName)-Find(".",qFileList.FileName))>
                        <tr id="DocRow#qFileList.FileID#" class="AllDocs">
                            <td valign="top" style="padding-top:7px;" width="16"><img src="#Application.Settings.RootPath#/_images/file_icons/#FileType#.png" /></td>
                            <td>
                                <span style="text-decoration:none; font-size:15px;"><strong>#qFileList.FileName#</strong></span>
                                <div style="font-size:10px; color:##555;">
                                    <strong>Document Type:</strong> #qFileList.FileTypeName#<br />
                                </div>
                            </td>
                        </tr>
                    </cfloop>
                <cfelse>
                    <tr>
                        <td>Currently, there are no documents for this activity.</td>
                    </tr>
                </cfif>
            </tbody>
        </table>
    </div>
	<!--- CREDITS --->
    <div class="OverviewSectionLeft">
        <h3>Credits</h3>
        <table>
            <cfloop query="qCredits">
                <cfif Evaluate('Attributes.CreditAmount#qCredits.CreditID#') NEQ 0>
                    <tr>
                        <td class="ViewSectionDetailLabel">#qCredits.Name#</td>
                        <td class="ViewSectionDetailData">#Evaluate('Attributes.CreditAmount#qCredits.CreditID#')# cr.</td>
                        <td class="ViewSectionDetailData"><cfif qCredits.ReferenceFlag EQ "Y">(Ref No. #Evaluate('Attributes.ReferenceNo#qCredits.CreditID#')#)<cfelse>&nbsp;</cfif></td>
                    </tr>
                </cfif>
            </cfloop>
        </table>
    </div>
    <!--- CDC INFO --->
    <cfif ActivityOtherExists>
        <div class="OverviewSectionLeft">
            <h3>CDC Information</h3>
            <table>
                <tr>
                    <td class="ViewSectionDetailLabel">Didactic Hours</td>
                    <td class="ViewSectionDetailData">#Attributes.DidacticHrs# Hr</td>
                </tr>
                <tr>
                    <td class="ViewSectionDetailLabel">Experimental Hours</td>
                    <td class="ViewSectionDetailData">#Attributes.ExperimentalHrs# Hr</td>
                </tr>
                <tr>
                    <td class="ViewSectionDetailLabel">Sponsered by Second Clinical Site?</td>
                    <td class="ViewSectionDetailData">
						<cfif Attributes.SecClinSiteFlag EQ "Y">
                        	Yes
						<cfelse>
                        	No
						</cfif>
                    </td>
                </tr>
                <tr>
                    <td valign="top" class="ViewSectionDetailLabel">Provided in Collaboration with another PTC?</td>
                    <td class="ViewSectionDetailData"><cfif Attributes.CollabPTCFlag EQ "Y">Yes<cfif Attributes.CollabPTCSpecify NEQ "">, #Attributes.CollabPTCSpecify#</cfif><cfelse>No</cfif></td>
                </tr>
                <tr>
                    <td valign="top" class="ViewSectionDetailLabel">Provided in Collaboration with another agency?</td>
                    <td class="ViewSectionDetailData"><cfif Attributes.CollabAgencyFlag EQ "Y">Yes<cfif Attributes.CollabAgencySpecify NEQ "">, #Attributes.CollabAgencySpecify#</cfif><cfelse>No</cfif></td>
                </tr>
            </table>
        </div>
    </cfif>
	<!--- FINANCES  --->
    <div class="OverviewSectionLeft">
        <h3>Financial Budget</h3>
        <table cellspacing="0" width="100%">
            <tr>
                <td><strong>Type</strong></td>
                <td><strong>Ledger</strong></td>
                <td><strong>Budget</strong></td>
            </tr>
            <cfloop from="1" to="#ArrayLen(aFinances)#" index="CurrRec">
                <tr>
                    <td class="ViewSectionDetailLabel"<cfif aFinances[CurrRec][3] GT aFinances[CurrRec][2]> style="background-color:##FFDDDD;"<cfelseif aFinances[CurrRec][3] LT aFinances[CurrRec][2]> style="background-color:##DDFFDD;"</cfif>><strong>#aFinances[CurrRec][4]#</strong></td>
                    <td class="ViewSectionDetailData"<cfif aFinances[CurrRec][3] GT aFinances[CurrRec][2]> style="background:##FFDDDD;"<cfelseif aFinances[CurrRec][3] LT aFinances[CurrRec][2]> style="background-color:##DDFFDD;"</cfif>>#LSCurrencyFormat(aFinances[CurrRec][3])#</td>
                    <td class="ViewSectionDetailData"<cfif aFinances[CurrRec][3] GT aFinances[CurrRec][2]> style="background:##FFDDDD;"<cfelseif aFinances[CurrRec][3] LT aFinances[CurrRec][2]> style="background-color:##DDFFDD;"</cfif>>#LSCurrencyFormat(aFinances[CurrRec][2])#</td>
                </tr>
            </cfloop>
        </table>
    </div>
</div>
<div class="ViewSection" style="float:left; width:50%;">
    <!--- SUPPORTERS --->
    <div class="OverviewSectionRight">
        <h3>Supporters</h3>
        <table width="100%">
            <cfif qActivitySupportersList.RecordCount NEQ 0>
                <tr>
                    <td><strong>Name</strong></td>
                    <td><strong>Type</strong></td>
                    <td><strong>Amount</strong></td>
                </tr>
                <cfloop query="qActivitySupportersList">
                    <tr>
                        <td class="ViewSectionDetailLabel">#qActivitySupportersList.SupporterName#</td>
                        <td class="ViewSectionDetailData">#qActivitySupportersList.SupportTypeName#</td>
                        <td class="ViewSectionDetailData">#LSCurrencyFormat(qActivitySupportersList.Amount)#</td>
                    </tr>
                </cfloop>
            <cfelse>
            	<tr>
                	<td>Currently, there are no supporters for this activity.</td>
                </tr>
            </cfif>
        </table>
    </div>
	<!--- FACULTY --->
    <div class="OverviewSectionRight">
        <h3>Faculty</h3>
        <table width="100%">
            <cfif qActivityFacultyList.RecordCount NEQ 0>
                <tr>
                    <td><strong>Name</strong></td>
                    <td align="center"><strong>CV</strong></td>
                    <td align="center"><strong>Disclosure</strong></td>
                </tr>
                <cfloop query="qActivityFacultyList">
                    <tr>
                        <td class="ViewSectionDetailLabel">#FirstName# #LastName#</td>
                        <cfif qActivityFacultyList.CVFileID NEQ "" OR qActivityFacultyList.DisclosureFileID NEQ "">
                        	<td class="ViewSectionDetailData" align="center">
								<cfif qActivityFacultyList.CVFileID NEQ "">
                                    <img src="#Application.Settings.RootPath#/_images/icons/tick.png">
                                </cfif>
                            </td>
                            <td class="ViewSectionDetailData" align="center">
                                <cfif qActivityFacultyList.DisclosureFileID NEQ "">
                                    <img src="#Application.Settings.RootPath#/_images/icons/tick.png">
                                </cfif>
                        	</td>
                        </cfif>
                    </tr>
                </cfloop>
            <cfelse>
            	<tr>
                	<td>Currently, there are no faculty members for this activity.</td>
                </tr>
            </cfif>
        </table>
    </div>
	<!--- COMMITTEE --->
    <div class="OverviewSectionRight">
        <h3>Committee</h3>
        <table width="100%">
            <cfif qActivityCommitteeList.RecordCount NEQ 0>
                <tr>
                    <td><strong>Name</strong></td>
                </tr>
                <cfloop query="qActivityCommitteeList">
                    <tr>
                        <td class="ViewSectionDetailLabel">#FirstName# #LastName#</td>
                    </tr>
                </cfloop>
            <cfelse>
            	<tr>
                	<td>Currently, there are no committee members for this activity.</td>
                </tr>
            </cfif>
        </table>
    </div>
	<!--- REGISTRANTS --->
    <div class="OverviewSectionRight">
        <h3>Registrants</h3>
        <table width="100%">
            <cfif qAttendees.RecordCount NEQ 0>
                <tr>
                    <td><strong>Name</strong></td>
                    <td><strong>Registration Date</strong></td>
                    <td><strong>Is MD</strong></td>
                </tr>
                <cfloop query="qAttendees">
                    <tr>
                        <td class="ViewSectionDetailLabel">#LastName#, #FirstName#</td>
                        <td class="ViewSectionDetailData"><cfif CheckIn NEQ "">(#DateFormat(CheckIn,"m/d/yy")# #TimeFormat(CheckIn,"h:mmT")#)<cfelse>N/A</cfif></td>
                        <td class="ViewSectionDetailData"><cfif MDFlag EQ "Y"><img src="#Application.Settings.RootPath#/_images/icons/tick.png"></cfif></td>
                    </tr>
                </cfloop>
            <cfelse>
            	<tr>
                	<td>Currently, there are no registrants for this activity.</td>
                </tr>
            </cfif>
        </table>
    </div>
</div>
</cfoutput>