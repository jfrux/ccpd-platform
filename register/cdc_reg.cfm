<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--- GET NEW DB REGISTRATIONS --->
<cfset qRegisteredActivities = Application.Com.AttendeeCDCGateway.getByCDCAttributes(PersonID=Session.PersonID,DeletedFlag="N",OrderBy="act.StartDate,att.RegisterDate")>
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Welcome Center</title>
<link href="styles/inc_styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
<cfinclude template="includes/inc_header.cfm">
<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<td class="content_cell" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="content_title">My Registrations &amp; Documents </td>
				</tr>
				<tr>
					<td class="content_body">
						<cfoutput>
						<div style="height:4px;"></div>
						<div id="info_box_blue">
						This page contains all the courses you've registered for and the options you have available for these courses such as Printing Certificates, and Completing Evaluations<br />
						</div>
						<div style="height:5px;"></div>
                        <div>
                        <table width="100%" cellspacing="1" cellpadding="3" border="0" class="table_main">
                            <tr>
                                <td class="table_cell_title" nowrap="nowrap">Current Registrations</td>
                            </tr>
                            <!--- SET CURRENT DATETIME --->
							<cfset Attributes.CurrDateTime = DateFormat(Now(), "MM/DD/YYYY") & " " & TimeFormat(Now(), "hh:mm:ssTT")>
                            
                        	<cfloop query="qRegisteredActivities">
                            <tr>
                            	<td class="table_cell_content" valign="top">
                                	#qRegisteredActivities.Title#
                                    <div id="table_cell_infotext">
                                    	<strong>Start Date:</strong> #DateFormat(qRegisteredActivities.ReleaseDate, "M/DD/YYYY")# #TimeFormat(qRegisteredActivities.ReleaseDate, "h:mmTT")# <strong>Registration Date:</strong> <cfif qRegisteredActivities.CheckIn NEQ "">#DateFormat(qRegisteredActivities.CheckIn, "M/DD/YYYY")#<cfelse>#DateFormat(qRegisteredActivities.AttendeeCreated, "M/DD/YYYY")#</cfif>
                                    </div>
                            		<a href="activity_documents.cfm?aid=#qRegisteredActivities.ActivityID#" style="text-decoration:none;"><img src="images/file_icon_documents.gif" align="absmiddle" border="0"> Download Documents</a>&nbsp;&nbsp;
									<!--- SET ACTIVITYDATETIME VAR --->
									<cfset Attributes.ActivityDateTime = DateFormat(qRegisteredActivities.ActivityEventDate, "MM/DD/YYYY") & " " & TimeFormat(qRegisteredActivities.ActivityEndTime, "hh:mm:ssTT")>
									
                                    <cfif Attributes.ActivityDateTime LTE Attributes.CurrDateTime>
										<!--- SET ATTRIBUTES.ASSESSMENTID --->
                                        <cfif qRegisteredActivities.AssessmentID NEQ "">
                                            <cfset Attributes.AssessmentID = qRegisteredActivities.AssessmentID>
                                        <cfelseif qRegisteredActivities.ParentAssessmentID NEQ "">
                                            <cfset Attributes.AssessmentID = qRegisteredActivities.ParentAssessmentID>
                                        <cfelse>
                                            <cfset Attributes.AssessmentID = 0>
                                        </cfif>
                                        
                                        <!--- PULL RESULTSTATUSID --->
                                        <cfif Attributes.AssessmentID GT 0>
                                            <cfquery name="qGetResultStatusID" datasource="#Application.Settings.DSN#">
                                                SELECT ResultStatusID
                                                FROM ce_AssessResult
                                                WHERE AssessmentID = <cfqueryparam value="#Attributes.AssessmentID#" cfsqltype="cf_sql_integer" /> AND PersonID = <cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" />
                                            </cfquery>
                                            
                                            <!--- CHECK RESULTSTATUSID --->
                                            <cfif qGetResultStatusID.RecordCount NEQ 0>
                                                <cfif qGetResultStatusID.ResultStatusID EQ 2>
                                                    <a href="Evaluation.cfm?aid=#qRegisteredActivities.ActivityID#&assessmentid=#Attributes.AssessmentID#" style="text-decoration:none;"><img src="images/file_icon_evaluation.gif" align="absmiddle" border="0"> Continue Evaluation</a>
                                                <cfelseif qGetResultStatusID.ResultStatusID EQ 1>
                                                <a href="http://ccpd.uc.edu/admin/index.cfm/event/Public.Cert?ActivityID=#qRegisteredActivities.ActivityID#&ReportID=5&PersonID=#Session.PersonID#" target="_blank" style="text-decoration:none;"><img src="images/file_icon_certificate.gif" align="absmiddle" border="0"> Certificate</a>
                                                </cfif>
                                            <cfelse>
                                                <a href="Evaluation.cfm?aid=#qRegisteredActivities.ActivityID#&assessmentid=#Attributes.AssessmentID#" style="text-decoration:none;"><img src="images/file_icon_evaluation.gif" align="absmiddle" border="0"> Evaluation</a>
                                            </cfif>
                                        </cfif>
                                    </cfif>
                                </td>
                            </tr>
                            </cfloop>
                        </table>
                        <br />
                        </div>
						<!--- AIT&L LEGACY SYSTEM REGISTERED ACTIVITY OUTPUT VARIABLE // REMOVED 02-25-2009
						#sRegOut#
						--->
						<div style="height:5px;"></div>
						<div id="info_box_red">
						<strong>Need Assistance? Having trouble finding what you are looking for?</strong>
						<div style="height:5px;"></div>
						<input type="button" name="fldContact" value="Contact Technical Support" style="width:220px;" onClick="window.location='cdc_contact.cfm?type=1';" />
						</div>
						</cfoutput>
						</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
