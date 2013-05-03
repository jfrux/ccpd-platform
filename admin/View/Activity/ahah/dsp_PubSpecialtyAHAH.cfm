<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveJS.cfm" />

<script>
App.Activity.Publish.Specialties.start()
<cfoutput>
// CREATE Specialty ARRAYS
aActivitySpecialtyList = $.ListToArray("#ActivitySpecialtyList#","|");
aSpecialtyList = $.ListToArray("#SpecialtyList#","|");
</cfoutput>

$(document).ready(function() {
  // PAGE WIDE EDITING VARS
  nCurrEditID = 0;
  sCurrEditName = "";
  
  // Specialties STYLE CHANGES
  $(".FieldInput").on("click", function() {
    $this = $(this);
    $itemRow = $this.parents('.grid-list-item');
    if($this.attr('checked')) {
      $itemRow.addClass('is-checked');
    } else {
      $itemRow.removeClass('is-checked');
    }
  });
});
</script>

<cfoutput>
<!--- CREATE TABLE CELL COUNTER --->
<cfset CellCount = 0>
<form name="frmSpecialties" class="formstate js-formstate form-horizontal" method="post" action="#Application.Settings.RootPath#/_com/AJAX_Activity.cfc">
  <input type="hidden" value="saveSpecialtiesLMS" name="method" id="method" />
  <input type="hidden" value="plain" name="returnformat" />
  <input type="hidden" value="#attributes.activityid#" name="ActivityID" />
  
  <cfloop query="qSpecialties">
    <cfset rowClass = '' />
    <cfset checkAttr = '' />
    <cfif ListFind(ActivitySpecialtyList, qSpecialties.SpecialtyID, "|")>
      <cfset rowClass = ' is-checked' />
      <cfset checkAttr = ' checked="checked"' />
    </cfif>
  <div class="grid-list-item#rowClass#" id="Specialty_#qSpecialties.SpecialtyID#Container">
    <span id="SpecialtyContainer#qSpecialties.SpecialtyID#">
    <label for="Specialty_#qSpecialties.SpecialtyID#" class="checkbox">
      <input type="checkbox" name="specialties" id="specialty_#qSpecialties.SpecialtyID#" value="#qSpecialties.SpecialtyID#" class="FieldInput"#checkAttr#/>
      #qSpecialties.Name#
    </label>
    </span>
  </div>
  </cfloop>
</form>
</cfoutput>