
<cfoutput>
<script>
$(document).ready(function() {
	$("##StepStatusChanger").change(function() {
		var nStatus = 0;
		
		nStatus = $(this).val();
		$.post("#Application.Settings.RootPath#/_com/ProcessStep/StepAjax.cfc", 
		{ method: "SetStatus", StepID: #Attributes.StepID#, ActivityID: #Attributes.ActivityID#, StepStatusID: nStatus, returnFormat: "plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			
			if(cleanData == 'success') {
				addMessage("Status changed successfully!",250,6000,4000);
			} else {
				addError("Status changed FAILED!",250,6000,4000);
			}
		});
	});
	
	$("##DueDateSetLink").click(function() {
		$.post("#Application.Settings.RootPath#/_com/ProcessStep/StepAjax.cfc", 
		{ method: "SetDueDate", StepID: #Attributes.StepID#, ActivityID: #Attributes.ActivityID#, DueDate: $("##date1").val(), returnFormat: "plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			
			if(cleanData == 'success') {
				addMessage("Due Date changed successfully!",250,6000,4000);
			} else {
				addError("Due Date change FAILED!",250,6000,4000);
			}
		});
	});
	
	$("##UnacceptLink").click(function() {
		$.post("#Application.Settings.RootPath#/_com/ProcessStep/StepAjax.cfc", 
		{ method: "SetAssign", StepID: #Attributes.StepID#, ActivityID: #Attributes.ActivityID#, AssignedToID: 0, returnFormat: "plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			
			if(cleanData == 'success') {
				window.location="#myself#Process.StepActivity?StepID=#Attributes.StepID#&ActivityID=#Attributes.ActivityID#&Message=You are no longer accepting this assignment!";
			} else {
				addError("Set Assignment FAILED!",250,6000,4000);
			}
		});
	});
	
	$("##TakeLink").click(function() {
		$.post("#Application.Settings.RootPath#/_com/ProcessStep/StepAjax.cfc", 
		{ method: "SetAssign", StepID: #Attributes.StepID#, ActivityID: #Attributes.ActivityID#, AssignedToID: #Session.Person.getPersonID()#, returnFormat: "plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			
			if(cleanData == 'success') {
				window.location="#myself#Process.StepActivity?StepID=#Attributes.StepID#&ActivityID=#Attributes.ActivityID#&Message=You have successfully taken this assignment!";
			} else {
				addError("Set Assignment FAILED!",250,6000,4000);
			}
		});
	});
	
	$("##ReassignLink").click(function() {
		$("##ReassignDiv").show();
	});
	
	$("##ReassignChanger").change(function() {
		var nAssignedTo = 0;
		
		nAssignedTo = $(this).val();
		$.post("#Application.Settings.RootPath#/_com/ProcessStep/StepAjax.cfc", 
		{ method: "SetAssign", StepID: #Attributes.StepID#, ActivityID: #Attributes.ActivityID#, AssignedToID: nAssignedTo, returnFormat: "plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			
			if(cleanData == 'success') {
				window.location="#myself#Process.StepActivity?StepID=#Attributes.StepID#&ActivityID=#Attributes.ActivityID#&Message=This queue has been reassigned successfully.";
			} else {
				addError("Set Assignment FAILED!",250,6000,4000);
			}
		});
	});
});
</script>
<div class="MultiFormRight_SectSubTitle">Assigned To</div>
<div style="padding:4px;">
	
	<div style="font-size:14px; font-weight:bold;"><a href="#myself#Person.Detail?PersonID=#qStepActivityDetail.AssignedToID#">#qStepActivityDetail.AssignedToName#</a></div>
	<div style="padding:2px;"><cfif qStepActivityDetail.AssignedToID EQ Session.Person.getPersonID()><a href="javascript:void(0);" id="UnacceptLink">Un-accept</a><cfelse><a href="javascript:void(0);" id="TakeLink">Take</a></cfif> | <a href="javascript:void(0);" id="ReassignLink">Reassign</a></div>
</div>
<div id="ReassignDiv" style="display:none;">
<div class="MultiFormRight_SectSubTitle">Reassign To</div>
<div style="padding:4px;">
	<select name="ReassignChanger" id="ReassignChanger">
		<cfloop query="qManagers">
		<option value="#qManagers.PersonID#"<cfif qManagers.PersonID EQ qStepActivityDetail.AssignedToID> selected</cfif>>#qManagers.LastName#, #qManagers.FirstName#</option>
		</cfloop>
	</select>
</div>
</div>
<cfif qStepActivityDetail.StepInstr NEQ "">
<div class="MultiFormRight_SectSubTitle">Queue Instructions</div>
<div style="padding:4px;">
	#qStepActivityDetail.StepInstr#
</div>
</cfif>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_SectSubTitle">Change Status</div>
<div style="padding:4px;">
	<cfset Status = Application.List.StepStatus>
	<select name="StepStatusChanger" id="StepStatusChanger">
		<cfloop query="Status">
		<option value="#Status.StepStatusID#"<cfif Status.StepStatusID EQ qStepActivityDetail.StepStatusID> selected</cfif>>#Status.Name#</option>
		</cfloop>
	</select>
</div>
<div class="MultiFormRight_SectSubTitle">Change Due Date</div>
<div style="padding:4px;">
	<input type="text" id="date1" name="DueDateChanger" style="width:70px;" value="#DateFormat(qStepActivityDetail.DueDate,'mm/dd/yyyy')#" />
	<a href="javascript:void(0);" id="DueDateSetLink">Save</a>
</div>
</cfoutput>