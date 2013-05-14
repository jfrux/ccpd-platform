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
<form action="#myself#activity.create" method="post" name="frmCreate">
  <input type="hidden" name="submitted" value="1" />
  <div class="control-group">
    <label class="control-label">Title</label>
    <div class="controls">
      <textarea name="Title" rows="2" id="Title">#HTMLSafe(Attributes.Title)#</textarea></td>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">Activity Type</label>
    <div class="controls">
      <select name="ActivityType" id="ActivityType">
        <cfloop query="qActivityTypeList">
        <option value="#qActivityTypeList.ActivityTypeID#">#qActivityTypeList.Name#</option>
        </cfloop>
      </select>
    </div>
  </div>
  <div class="control-group" id="Groupings" style="display:none;">
    <label class="control-label">Grouping</label>
    <div class="controls">
      <select name="Grouping" id="Grouping"></select>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">Session Info</label>
    <div class="controls">
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
    </div>
  </div>
  <div class="control-group" style="display: none;">
    <label class="control-label">Release Date</label>
    <div class="controls">
      <input type="text" name="ReleaseDate" id="date1" value="#Attributes.ReleaseDate#"/>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">Start Date</label>
    <div class="controls">
      <input type="text" name="StartDate" id="date2" value="#Attributes.StartDate#"/>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">End Date</label>
    <div class="controls">
      <input type="text" name="EndDate" id="date3" value="#Attributes.EndDate#"/>
    </div>
  </div>
  <div class="control-group" class="Location">
    <label class="control-label" for="Location">Location</label>
    <div class="controls">
      <input type="text" name="Location" id="Location" value="#Attributes.Location#" />
    </div>
  </div>
  <div class="control-group" class="Location">
    <label class="control-label" for="Address1">Address 1</label>
    <div class="controls">
      <input type="text" name="Address1" id="Address1" value="#Attributes.Address1#" />
    </div>
  </div>
  <div class="control-group" class="Location">
    <label class="control-label" for="Address2">Address 2</label>
    <div class="controls">
      <input type="text" name="Address2" id="Address2" value="#Attributes.Address2#" />
    </div>
  </div>
  <div class="control-group" class="Location">
    <label class="control-label" for="City">City</label>
    <div class="controls">
      <input type="text" name="City" id="City" value="#Attributes.City#" />
    </div>
  </div>
  <div class="control-group" class="Location stateField">
    <label class="control-label" for="State">State</label>
    <div class="controls">
      <select id="State" name="State">
        <option value="0">Select one...</option>
        <cfloop query="Application.List.States">
          <option value="#trim(Application.List.States.StateId)#"<cfif Attributes.State EQ trim(Application.List.States.StateId)> Selected</cfif>>#Name#</option>
        </cfloop>
      </select>
    </div>
  </div>
  <div class="Location control-group provinceField">
    <label class="control-label" for="Province">State / Province</label>
    <div class="controls">
      <input type="text" name="Province" id="Province" value="#Attributes.Province#" />
    </div>
  </div>
  <div class="Location control-group">
    <label class="control-label" for="Country">Country</label>
    <div class="controls">
      <select id="Country" name="Country">
        <option value="0">Select one...</option>
        <cfloop query="Application.List.Countries">
        <option value="#trim(Application.List.Countries.CountryID)#"<cfif Attributes.Country EQ trim(Application.List.Countries.CountryID) OR Attributes.Country EQ "" AND trim(Application.List.Countries.Name) EQ "United States of America"> Selected</cfif>>#Name#</option>
        </cfloop>
      </select>
    </div>
  </div>
  <div class="control-group" class="Location">
    <label class="control-label" for="PostalCode">Postal Code</label>
    <div class="controls">
      <input type="text" name="PostalCode" id="PostalCode" value="#Attributes.PostalCode#" />
    </div>
  </div>
  <div class="control-group hide">
    <label class="control-label">External ID</label>
    <div class="controls">
      <input type="text" name="ExternalID" id="ExternalID" value="#Attributes.ExternalID#"/>
    </div>
  </div>
</form>
</cfoutput>