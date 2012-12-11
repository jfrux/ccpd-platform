<cfoutput>
<script>
	//ADD TO QUEUE
	function addToQueue() {
		var sSteps = "";
		var sNotes = "";
		var sAssigned = "";
		
		var cleanData = "";
		
		$(".StepChecks:checked").each(function () {
			sSteps = $.ListAppend(sSteps,$(this).val(),",");
			sNotes = $.ListAppend(sNotes,$('##Note' + $(this).val()).val(),"^");
			sAssigned = $.ListAppend(sAssigned,$('##AssignedTo' + $(this).val()).val(),",");
		});
		
		$.post("#Application.Settings.RootPath#/_com/ProcessStep/ActivityAjax.cfc", 
		{ method: "AddToQueues", ActivityID:#Attributes.ActivityID#,Steps:sSteps, Notes:sNotes, Assigned:sAssigned, returnFormat: "plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			
			if(cleanData == 'success') {
				parent.addMessage("Activity added to queues successfully!",250,6000,4000);
				parent.$("##ProcessQueueDialog").dialog("close");
			} else {
				addError("Process Queue failed for unknown reason.",250,6000,4000);
			}
		});
	}
	$(document).ready(function() {  
		//jQuery.blockUI({ message: $('##AddToQueue'), css: { cursor:'default',left:'50px',top:'50px',width:'650px'} });
		
		$("##CheckAll").click(function() {
			if($("##CheckAll").attr("checked")) {
				$(".StepChecks").each(function() {
					$(this).attr("checked",true);
				});
			} else {
				$(".StepChecks").each(function() {
					$(this).attr("checked",false);
				});
			}
		}); 
	});
</script>
<cfset sManagers = "">
<cfloop query="qManagers">
	<cfset sManagers = ListAppend(sManagers,"#qManagers.PersonID#|#qManagers.FullName#","$")>
</cfloop>
<strong>Check the queues you would like to add this Activity to.</strong>
	<table width="100%" cellspacing="0" cellpadding="0" border="0" class="ViewSectionGrid" align="center">
		<thead>
			<tr>
				<th><input type="checkbox" name="CheckAll" id="CheckAll" /></th>
				<th>Queue Name</th>
				<th>Assign To</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="qStepList">
			<tr id="StepItem#qStepList.StepID#">
				<td valign="top"><input type="checkbox" name="StepChecks" class="StepChecks" id="Check#qStepList.StepID#" value="#qStepList.StepID#" /></td>
				<td valign="top" width="60%">#qStepList.Name#</td>
				<td valign="top">
					<select name="AssignedTo#qStepList.StepID#" id="AssignedTo#qStepList.StepID#">
						<option value="0" selected>Leave Unassigned</option>
						<cfloop list="#sManagers#" delimiters="$" index="i">
							<cfset sValue = GetToken(i,1,"|")>
							<cfset sText = GetToken(i,2,"|")>
							<option value="#sValue#">#sText#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>