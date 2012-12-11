<cfparam name="Attributes.Title" default="">
<cfparam name="Attributes.ActivityID" default="0">
<cfparam name="Attributes.ActivityType" default="1">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.StartTime" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.EndTime" default="">
<cfparam name="Attributes.groupingid" default="">
<cfparam name="Attributes.Description" default="">
<cfparam name="Attributes.Location" default="">
<cfparam name="Attributes.Street" default="">
<cfparam name="Attributes.City" default="">
<cfparam name="Attributes.Province" default="">
<cfparam name="Attributes.Country" default="230">
<cfparam name="Attributes.StateID" default="">
<cfparam name="Attributes.PostalCode" default="">
<cfparam name="Attributes.Sessions" default="1">
<cfparam name="Attributes.SessionType" default="S">
<cfparam name="Attributes.ExternalID" default="">
<cfparam name="Attributes.ReleaseDate" default="#DateFormat(Now(),"MM/DD/YYYY")#">
<div class="ViewSection">
<h3>General Information</h3>
<script>
<cfoutput>
var sSessionType = "#Attributes.SessionType#";
var nActivityType = #Attributes.ActivityType#;
var LiveOptions = <cfloop query="qLiveGroupings">"<option value=\"#qLiveGroupings.GroupingID#\">#qLiveGroupings.Name#</option>"<cfif qLiveGroupings.RecordCount NEQ qLiveGroupings.CurrentRow> + </cfif></cfloop>;
var EMOptions = <cfloop query="qEMGroupings">"<option value=\"#qEMGroupings.GroupingID#\">#qEMGroupings.Name#</option>"<cfif qEMGroupings.RecordCount NEQ qEMGroupings.CurrentRow> + </cfif></cfloop>;
</cfoutput>
function updateStateProvince(countryId) {
	if(countryId  == 184) {
		$(".stateField").show();
		$(".provinceField").hide();
	} else {
		$(".stateField").hide().css({ display:'none' });
		$(".provinceField").show();
	}
}

function setSessionType(sSessionType) {
	if(sSessionType == "M") {
			$(".Sessions").show();
			$(".SingleSession").hide();
		} else {
			$(".Sessions").hide();
			$(".SingleSession").show();
		}
}

function setActivityType(nActivityType) {
	
	if(nActivityType == 1) {
		$("#Grouping").html(LiveOptions);
		$("#Groupings").show();
		updateStateProvince($("#Country").val());
		$(".Location").show();
	} else if(nActivityType == 2) {
		$("#Groupings").show();
		$("#Grouping").html(EMOptions);
		updateStateProvince($("#Country").val());
		$(".Location").hide();
	} else {
		$("#Groupings").hide();
		$("#Grouping").html("");
		updateStateProvince($("#Country").val());
		$(".Location").hide();
	}
	
}
$(document).ready(function(){
	updateStateProvince($("#Country").val());
	
	$("#Country").bind("change", this, function() {
		updateStateProvince($(this).val());
	});
	
	$(".DatePicker").datepicker({ 
		showOn: "button", 
		buttonImage: "/admin/_images/icons/calendar.png", 
		buttonImageOnly: true,
		showButtonPanel: true,
		changeMonth: true,
		changeYear: true,
		onSelect: function() {
			Unsaved();
			AddChange($("label[for='" + this.id + "']").html(),$(this).val());
		}

	});
	
	$("#Title").autocomplete(sRootPath + '/_com/AJAX_Activity.cfc?method=AutoComplete&returnformat=plain');
	$("#Sponsor").autocomplete(sRootPath + '/_com/AJAX_Activity.cfc?method=JointlyAutoComplete&returnformat=plain');
	
	$("#ActivityType").bind("change", this, function() {
		setActivityType($(this).val());
	});
	
	$("#SessionType").change(function() {
		setSessionType($(this).val());
	});
	
	<cfif Attributes.ActivityType NEQ "">
	$("#ActivityType").val(nActivityType);
	setActivityType($("#ActivityType").val());
		<cfif Attributes.GroupingID NEQ "">
	$("#Grouping").val(nGrouping);
		</cfif>
	</cfif>
	
	<cfif Attributes.SessionType NEQ "">
		$("#SessionType").val(sSessionType);
		setSessionType($("#SessionType").val());
	</cfif>
	
	/* CHECK IF SPONSORSHIP IS JOINTLY OR DIRECTLY START */
	if($("#SponsorshipJ").attr("checked")) {
		$("#JointlyTextFld").css("display","");
	}
	
	$(".Sponsorship").bind("click", function() {
		if($("#SponsorshipJ").attr("checked")) {
			$("#JointlyTextFld").css("display","");
		} else if($("#SponsorshipD").attr("checked")) {
			$("#JointlyTextFld").css("display","none");
		}
	});
	/* CHECK IF SPONSORSHIP IS JOINTLY OR DIRECTLY END */
});
</script>
<cfoutput>
<div class="ContentBody">
	<form action="#myself#Activity.Create&Submitted=1" method="post" name="frmCreate">
	<fieldset class="common-form">
		<table cellspacing="2" cellpadding="3" border="0">
			<tr>
				<td valign="top" width="100">Title</td>
				<td><textarea name="Title" rows="2" id="Title" style="width:495px; height:60px;">#HTMLSafe(Attributes.Title)#</textarea></td>
			</tr>
			<tr>
				<td valign="top">Activity Type</td>
				<td valign="top">
					<select name="ActivityType" id="ActivityType">
					<cfloop query="qActivityTypeList">
					<option value="#qActivityTypeList.ActivityTypeID#">#qActivityTypeList.Name#</option>
					</cfloop>
					</select>
				</td>
			</tr>
			<tr id="Groupings" style="display:none;">
				<td>Grouping</td>
				<td><select name="Grouping" id="Grouping"></select></td>
			</tr>
			<tr>
				<td>Session Info</td>
				<td>
					<select name="SessionType" id="SessionType">
						<option value="S">Stand-alone</option>
						<option value="M">Multi-session</option>
					</select>
					<span class="Sessions" style="display:none;">
					<select name="Sessions" id="Sessions">
						<cfloop from="1" to="400" index="i">
						<option value="#i#">#i#</option>
						</cfloop>
					</select> sessions
					</span>
				</td>
			</tr>
			<tr style="display: none;">
				<td>Release Date</td>
				<td><input type="text" name="ReleaseDate" id="date1" value="#Attributes.ReleaseDate#"/></td>
			</tr>
			<tr>
				<td>Start Date</td>
				<td><input type="text" name="StartDate" id="date2" value="#Attributes.StartDate#"/></td>
			</tr>
			<tr>
				<td>End Date</td>
				<td><input type="text" name="EndDate" id="date3" value="#Attributes.EndDate#"/></td>
			</tr>
			<tr class="Location">
				<td><label for="Location">Location</label></td>
				<td><input type="text" name="Location" id="Location" value="#Attributes.Location#" /></td>
			</tr>
			<tr class="Location">
				<td><label for="Address1">Address 1</label></td>
				<td><input type="text" name="Address1" id="Address1" value="#Attributes.Address1#" /></td>
			</tr>
			<tr class="Location">
				<td><label for="Address2">Address 2</label></td>
				<td><input type="text" name="Address2" id="Address2" value="#Attributes.Address2#" /></td>
			</tr>
			<tr class="Location">
				<td><label for="City">City</label></td>
				<td><input type="text" name="City" id="City" value="#Attributes.City#" /></td>
			</tr>
			<tr class="Location stateField">
				<td><label for="State">State</label></td>
				<td>
					<select id="State" name="State">
						<option value="0">Select one...</option>
						<cfloop query="Application.List.States">
							<option value="#trim(Application.List.States.StateId)#"<cfif Attributes.State EQ trim(Application.List.States.StateId)> Selected</cfif>>#Name#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			<tr class="Location provinceField">
				<td><label for="Province">State / Province</label></td>
				<td><input type="text" name="Province" id="Province" value="#Attributes.Province#" /></td>
			</tr>
            <tr class="Location">
            	<td><label for="Country">Country</label></td>
                <td>
					<select id="Country" name="Country">
						<option value="0">Select one...</option>
						<cfloop query="Application.List.Countries">
							<option value="#trim(Application.List.Countries.CountryID)#"<cfif Attributes.Country EQ trim(Application.List.Countries.CountryID) OR Attributes.Country EQ "" AND trim(Application.List.Countries.Name) EQ "United States of America"> Selected</cfif>>#Name#</option>
						</cfloop>
					</select>
                </td>
            </tr>
			<tr class="Location">
				<td><label for="PostalCode">Postal Code</label></td>
				<td><input type="text" name="PostalCode" id="PostalCode" value="#Attributes.PostalCode#" /></td>
			</tr>
			<tr>
				<td>External ID</td>
				<td><input type="text" name="ExternalID" id="ExternalID" value="#Attributes.ExternalID#"/></td>
			</tr>
		</table>
		</fieldset>
  	</form>
</div>
</div>
</cfoutput>