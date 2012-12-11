<cfparam name="Attributes.AssessTypeID" default="1" />
<cfparam name="Attributes.Name" default="" />
<cfparam name="Attributes.Description" default="" />
<cfparam name="Attributes.PassingScore" default="" />
<cfparam name="Attributes.MaxAttempts" default="" />
<cfparam name="Attributes.AssessRequiredFlag" default="Y" />
<cfparam name="Attributes.RandomFlag" default="N" />
<cfparam name="Attributes.CommentFlag" default="" />
<cfparam name="Attributes.ActivityID" default="0" />
<cfset qTypes = Application.Com.AssessmentTypeGateway.getByAttributes()>

<script>
$(document).ready(function() {
	$("#AddDetailsLink").click(function() {
		$(this).hide();
		$(".Details").fadeIn();
	});
	
	$("#AssessTypeID").change(function() {
		setType($(this).val());
	});
});

function setType(nTypeID) {
	$("#AssessTypeID").val(nTypeID);
	var nType = parseInt(nTypeID);
	switch(nType)
	{
		/* Evaluation */
		case 1: 
			$(".RequiredFlag").fadeIn();
			<cfif Attributes.Description NEQ "">
			$("#AddDetailsLink").hide();
			$(".Details").fadeIn();
			</cfif>
			$(".MaxAttempts").hide();
			$(".PassingScore").hide();
			$(".RandomFlag").hide();
		break;  
		
		/* Post Test */  
		case 2:
			$(".RequiredFlag").fadeIn();
			<cfif Attributes.Description NEQ "">
			$("#AddDetailsLink").hide();
			$(".Details").fadeIn();
			</cfif>
			$(".MaxAttempts").fadeIn();
			$(".PassingScore").fadeIn();
			$(".RandomFlag").fadeIn();
		break;
		
		/* Pre Test */  
		case 3:
			$(".RequiredFlag").fadeIn();
			<cfif Attributes.Description NEQ "">
			$("#AddDetailsLink").hide();
			$(".Details").fadeIn();
			</cfif>
			$(".MaxAttempts").fadeIn();
			$(".PassingScore").fadeIn();
			$(".RandomFlag").fadeIn();
		break;
		
		default:
			$(".RequiredFlag").hide();
			<cfif Attributes.Description NEQ "">
			$("#AddDetailsLink").hide();
			$(".Details").fadeIn();
			</cfif>
			$(".MaxAttempts").hide();
			$(".PassingScore").hide();
			$(".RandomFlag").hide();
	}
}
</script>

<cfoutput>
<form action="#myself##xfa.AssessSubmit#?ActivityID=#Attributes.ActivityID#&AssessmentID=#Attributes.AssessmentID#&Submitted=1" method="post" id="formDetail" name="formDetail">
<input type="hidden" name="Submitted" value="1" />
<table width="100%" cellspacing="1" border="0" cellpadding="2">
	<tr>
		<td class="FieldLabel2" valign="top" width="150">Assessment Name</td>
		<td class="FieldInput2">
			<input type="text" name="Name" id="Name" value="#Attributes.Name#" style="width:600px;" />
			<div><a href="javascript:void(0);" id="AddDetailsLink">Add additional details...</a></div>
		</td>
	</tr>
	<tr class="Details" style="display:none;">
		<td class="FieldLabel2" valign="top" width="150">Details</td>
		<td class="FieldInput2">
			<textarea name="Description" id="Description" style="width:600px;height:100px;">#Attributes.Description#</textarea>
		</td>
	</tr>
	<tr>
		<td class="FieldLabel2" width="150" style="width:150px;">Type</td>
		<td class="FieldInput2">
			<select name="AssessTypeID" id="AssessTypeID">
				<cfloop query="qTypes">
				<option value="#qTypes.AssessTypeID#">#qTypes.Name#</option>
				</cfloop>
			</select>
		</td>
	</tr>	
	<tr class="PassingScore" style="display:none;">
		<td class="FieldLabel2" valign="top" width="150">Passing Score</td>
		<td class="FieldInput2">
			<input type="text" name="PassingScore" id="PassingScore" value="#Attributes.PassingScore#" style="width:50px;" />
		</td>
	</tr>
	<tr class="MaxAttempts" style="display:none;">
		<td class="FieldLabel2" valign="top" width="150">Max Attempts</td>
		<td class="FieldInput2">
			<input type="text" name="MaxAttempts" id="MaxAttempts" value="#Attributes.MaxAttempts#" style="width:50px;" />
		</td>
	</tr>
	<tr class="RequiredFlag" style="display:none;">
		<td class="FieldLabel2" style="width:150px;">Require Completion?</td>
		<td class="FieldInput2">
			<input type="radio" name="RequiredFlag" id="RequiredYes" value="Y"<cfif Attributes.AssessRequiredFlag EQ "Y"> checked</cfif> /> Yes <input type="radio" name="RequiredFlag" id="RequiredNo" value="N"<cfif Attributes.AssessRequiredFlag EQ "N"> checked</cfif> /> No
		</td>
	</tr>
	<tr class="RandomFlag" style="display:none;">
		<td class="FieldLabel2" style="width:150px;">Randomize Answers?</td>
		<td class="FieldInput2">
			<input type="radio" name="RandomFlag" id="RandomYes" value="Y"<cfif Attributes.RandomFlag EQ "Y"> checked</cfif> /> Yes <input type="radio" name="RandomFlag" id="RandomNo" value="N"<cfif Attributes.RandomFlag EQ "N"> checked</cfif> /> No
		</td>
	</tr>
</table>
</form>
</cfoutput>