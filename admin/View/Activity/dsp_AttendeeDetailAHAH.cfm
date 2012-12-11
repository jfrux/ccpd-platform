<cfparam name="AttendeeStatusName" default="" />

<script>
	<cfoutput>
	var nAssessment = 0;
	var nPerson = #PersonBean.getPersonID()#;
	</cfoutput>
	
	function showContent(nAssessID) {
		$(".AssessmentContent").hide();
		$("#AssessmentContent" + nAssessID).show();
		$(".AssessmentLink").css("background-color","#FFFFFF");
		$("#AssessmentLink" + nAssessID).css("background-color","#DDDDDD");
	}
	
	$(document).ready(function() {
		showContent(<cfoutput>#qAssessments.AssessmentID#</cfoutput>);
		
		$(".AssessmentLink").bind("click", this, function() {
			var nAssessID = $.Replace(this.id, "AssessmentLink", "");
			showContent(nAssessID);
		});
		
		$(".Report").bind("click", this, function() {
			var nResultID = $.Replace(this.id, "Report", "");
			
			// ALERT USER OF REPORT GENERATION 
			$("#ReportDownload" + nResultID).html("<img src=\"" + sRootPath + "/admin/_images/ajax-loader.gif\" />");
			
			// POST TO REPORT GENERATOR
			$.post(sRootPath + "/_com/Report/ActivityReportAJAX.cfc", 
			{ method: "IndividualAssessmentReport", ReportID: '17', ResultID: nResultID, ActivityID: nActivity, Mode: "Activity", returnFormat: "plain" },
			function(returnData) {
				cleanData = $.trim(returnData);
				status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(status == 'Success') {
					$("#ReportDownload" + nResultID).html("<img src=\"" + sRootPath + "/admin/_images/file_icons/xls.png\" /> <a href=\"" + sMyself + "File.DownloadReport?ReportID=17&FileName=" + statusMsg + "\" title=\"Download Report\">Download</a>");
				} else if(status == 'Fail') {
					addError(statusMsg,250,6000,4000);
				}
			});
		});
		
		$(".assess-try-link").click(function() {
			var $AssessID = $.ListGetAt(this.id, 3, "-");
			var $ResultID = $.ListGetAt(this.id, 4, "-");
			
			$.post(sMyself + "Activity.Assessment", { ActivityID: nActivity, AssessmentID: $AssessID, ResultID: $ResultID, PersonID: nPerson },
				function(data) {
					$("#assessment-container").html(data);
			});
			
			$("#assessment-container").show();
		});
	});
</script>
<cfoutput>
<h1>#PersonBean.getFirstName()# #PersonBean.getLastName()#</h1>
<strong>Status: #AttendeeStatusName#</strong>
<div id="AssessmentLinks">
    <cfloop query="qAssessments">
    <a href="javascript://" class="AssessmentLink" id="AssessmentLink#qAssessments.AssessmentID#">#qAssessments.Name#</a><cfif qAssessments.CurrentRow NEQ qAssessments.RecordCount> | </cfif>
    </cfloop>
</div>
<div id="Content" style="height:300px; overflow:auto;">
	<!--- CREATE COUNTER VAR ---->
    <cfset ArrayCount = 1>
    
	<cfloop query="qAssessments">
	<div id="AssessmentContent#qAssessments.AssessmentID#" class="AssessmentContent">
        
        <cfif qAssessments.PassingScore NEQ "">
        	Assessment Passing Score: #qAssessments.PassingScore#%
		</cfif>
        <cfif qAssessments.MaxAttempts NEQ "" AND qAssessments.MaxAttempts GT 0>
        	| Assessment Max Attempts: #qAssessments.MaxAttempts#
        <cfelseif qAssessments.MaxAttempts NEQ "" AND qAssessments.MaxAttempts EQ 0>
        	| Assessment Max Attempts: Unlimited
		</cfif>
        <!--- GET ASSESSMENT RESULTS --->
    	<cfset qResults = Application.Com.AssessResultGateway.getByAttributes(AssessmentID=qAssessments.AssessmentID,PersonID=Attributes.PersonID,DeletedFlag="N",OrderBy="Created")>
        <br />
        <table class="DataGrid" width="100%" cellpadding="0" cellspacing="0" border="0">
        	<thead>
                <tr>
                    <th><a href="javascript:void(0);">Date</a></th>
                    <th><a href="javascript:void(0);">Status</a></th>
                    <th><a href="javascript:void(0);">Score</a></th>
                    <th><a href="javascript:void(0);">Pass/Fail</a></th>
                    <th><a href="javascript:void(0);">Review</a></th>
                    <th><a href="javascript:void(0);">Export</a></th>
                <tr>
            </thead>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><a href="javascript://" class="assess-try-link" id="assess-try-#qAssessments.AssessmentID#-0">Create Record</a></td>
                <td>&nbsp;</td>
            </tr>
            <cfloop query="qResults">
                <tr>
                    <td><cfif qResults.Created NEQ "">#DateFormat(qResults.Created, "MM/DD/YYYY")# @ #TimeFormat(qResults.Created, "hh:mmTT")#<cfelse>N/A</cfif></td>
                    <td>
                    	<!--- GET ASSESSMENT RESULT STATUS --->
                    	<cfloop list="#ResultStatuses#" index="CurrentResultStatus">
							<cfset CurrStatusID = getToken(CurrentResultStatus, 1, "|")>
							<cfif CurrStatusID EQ qResults.ResultStatusID>
                            	#getToken(CurrentResultStatus, 2, "|")#
                            </cfif>
						</cfloop>
					</td>
                    <td><cfif qResults.ResultStatusID EQ 1><cfif qResults.Score NEQ "">#qResults.Score#%<cfelse>N/A</cfif></cfif></td>
                    <td><cfif qResults.ResultStatusID EQ 1><cfif qAssessments.PassingScore LTE qResults.Score>Pass<cfelse>Fail</cfif></cfif></td>
                    <td><a href="javascript://" class="assess-try-link" id="assess-try-#qAssessments.AssessmentID#-#qResults.ResultID#">Open Record</a></td>
                    <td id="ReportDownload#qResults.ResultID#"><a href="javascript://" id="Report#qResults.ResultID#" class="Report"><img src="#Application.Settings.RootPath#/_images/file_icons/xls.png" title="Export to excel" /></a></td>
                </tr>
            </cfloop>
        </table>
    </div>
    
    <!--- RESET ARRAYCOUNT --->
    </cfloop>
</div>
<div id="assessment-container" class="ce-dialog" style="display: none; height: 527px; left: 50%; margin-left: -350px; position: absolute; top: -45px; width: 705px; z-index: 9999;"></div>
</cfoutput>