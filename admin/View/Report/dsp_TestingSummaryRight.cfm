<cfoutput>
<script>
	$(document).ready(function() {
		$("##btnSelectActivity").bind("click", function() {
			updateReport($("##ActivityID").val());
		});
	});
</script>

<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectSubTitle">Activity Selector</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectBody">
	<table>
		<input type="hidden" name="Submitted" value="1">
		<input type="hidden" name="ReportID" value="13">
		<tr>
			<td>Activity</td>
			<td>
            	<select name="ActivityID" id="ActivityID" style="width:115px;">
            		<option value="">Select one...</option>
                    <cfloop query="qTestingActivities">
                    <option value="#qTestingActivities.ActivityID#"<cfif Attributes.ActivityID EQ qTestingActivities.ActivityID> SELECTED</cfif>>#DateFormat(qTestingActivities.StartDate, "MM/DD/YYYY")# - #qTestingActivities.Title#</option>
                    </cfloop>
                </select>
            </td>
		</tr>
        <tr>
        	<td colspan="2" align="right"><input type="button" name="btnSelectActivity" id="btnSelectActivity" value="Get Report" /></td>
        </tr>
    </table>
</div>
<cfif isDefined("qReportData")>
	<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=Attributes.ActivityID)>
    <cfset ActivityBean = Application.Com.ActivityDAO.Read(ActivityBean)>
	<div class="MultiFormRight_SectSubTitle">Attendee Selector</div>
    <div class="MultiFormRight_SectBody">
        <table>
            <tr>
                <td>Attendee</td>
                <td>
                    <select name="ResultID" id="ResultID" style="width:105px;">
                        <option value="0">Select one...</option>
                        <cfloop query="qReportData">
                        <!--- CREATE ASSESSBEAN --->
                        <cfset AssessBean = CreateObject("component","#Application.Settings.Com#Assessment.Assessment").Init(ActivityID=Attributes.ActivityID,AssessTypeID=1)>
                        <cfset AssessExists = Application.Com.AssessmentDAO.Exists(AssessBean)>
                        
                        <!--- CHECK IF ASSESSMENT RECORD EXISTS --->
                        <cfif AssessExists>
                        	<!--- GATHER ASSESSMENT INFO --->
                        	<cfset AssessBean = Application.Com.AssessmentDAO.Read(AssessBean)>
                        	
                            <!--- CREATE RESULTBEAN --->
							<cfset ResultBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(AssessmentID=AssessBean.getAssessmentID(),PersonID=qReportData.PersonID)>
                            <cfset ResultExists = Application.Com.AssessResultDAO.Exists(ResultBean)>
                            
                            <!--- CHECK IF RESULT RECORD EXISTS --->
                            <cfif ResultExists>
                            <cfset ResultBean = Application.Com.AssessResultDAO.Read(ResultBean)>
                            <option value="#ResultBean.getResultID()#"<cfif Attributes.ResultID EQ ResultBean.getResultID()> SELECTED</cfif>>#qReportData.LastName#, #qReportData.FirstName#</option>
                            </cfif>
                        <!--- CHECK IF PARENT ACTIVITY ASSESSMENT RECORD EXISTS --->
                        <cfelseif ActivityBean.getParentActivityID() NEQ "">
							<cfset ParentAssessBean = CreateObject("component","#Application.Settings.Com#Assessment.Assessment").Init(ActivityID=ActivityBean.getParentActivityID(),AssessTypeID=1)>
                            <cfset ParentAssessExists = Application.Com.AssessmentDAO.Exists(ParentAssessBean)>
                            
                            <cfif ParentAssessExists>
								<!--- GATHER ASSESSMENT INFO --->
                                <cfset ParentAssessBean = Application.Com.AssessmentDAO.Read(ParentAssessBean)>
                                
                                <!--- CREATE RESULTBEAN --->
                                <cfset ResultBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(AssessmentID=ParentAssessBean.getAssessmentID(),PersonID=qReportData.PersonID)>
                                <cfset ResultExists = Application.Com.AssessResultDAO.Exists(ResultBean)>
                                
                                <!--- CHECK IF RESULT RECORD EXISTS --->
                                <cfif ResultExists>
                                <cfset ResultBean = Application.Com.AssessResultDAO.Read(ResultBean)>
                                <option value="#ResultBean.getResultID()#"<cfif Attributes.ResultID EQ ResultBean.getResultID()> SELECTED</cfif>>#qReportData.LastName#, #qReportData.FirstName#</option>
                                </cfif>
                            </cfif>
                        </cfif>
                        </cfloop>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right"><input type="button" name="btnSelectAttendee" id="btnSelectAttendee" value="Get Report" /></td>
            </tr>
            <tr>
            	<td colspan="2">**Only users who filled an evaluation out will appear in list.</td>
            </tr>
        </table>
    </div>
</cfif>
</cfoutput>