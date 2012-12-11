<cfoutput>
<link href="#Application.Settings.RootPath#/_styles/StepStatus.css" rel="stylesheet" type="text/css" />
<div class="ViewSection">
	<h3>#StepBean.getName()# - Activities</h3>
	<p>
		<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ViewSectionGrid">
			<tbody>
				<cfloop query="qStepActivities">
				<tr class="StepActivities" id="StepActivity#qStepActivities.Step_ActivityID#">
					<td width="15%"><div class="StepStatus#qStepActivities.StepStatusID#">#qStepActivities.StepStatusName#</div></td>
					<td valign="top" width="60%">
						<h4 style="margin:2px 0px; font-size:14px;"><a href="#myself#Process.StepActivity?StepID=#Attributes.StepID#&ActivityID=#qStepActivities.ActivityID#">#qStepActivities.Title#</a></h4>
						<p>
							Due Date: #DateFormat(qStepActivities.DueDate,"mm/dd/yyyy")# <cfif DateDiff("d",now(),qStepActivities.DueDate) LT -1><span style="color:##FF0000; padding:1px 4px;">#DateDiff("d",qStepActivities.DueDate,now())# day(s) late</span><cfelseif DateDiff("d",now(),qStepActivities.DueDate) EQ -1><span style="color:##FF0000; padding:1px 4px;">Due yesterday</span><cfelseif DateDiff("d",now(),qStepActivities.DueDate) EQ 0><span style="color:##CC6600; padding:1px 4px;">Due Today</span></cfif><br />
							Assigned To: <cfif qStepActivities.AssignedToID GT 0>#qStepActivities.AssignedToName#<cfelse>Unassigned</cfif>
						</p>
					</td>
					<td width="25%">
						<div class="ViewSectionGrid_Links">
							<a href="#myself#Process.StepActivity?StepID=#Attributes.StepID#&ActivityID=#qStepActivities.ActivityID#">View</a>
							<cfif qStepActivities.AssignedToID EQ Session.Person.getPersonID()><a href="#myself#Process.StepActivity?StepID=#Attributes.StepID#&ActivityID=#qStepActivities.ActivityID#">Un-Accept</a><cfelseif qStepActivities.AssignedToID GT 0 AND qStepActivities.AssignedToID NEQ Session.Person.getPersonID()><cfelse><a href="#myself#Process.StepActivity?StepID=#Attributes.StepID#&ActivityID=#qStepActivities.ActivityID#">Accept</a></cfif>
						</div>
					</td>
				</tr>
				</cfloop>
			</tbody>
		</table>
	</p>
</div>
</cfoutput>