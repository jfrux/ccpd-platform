<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveJS.cfm" />

<script>
App.Activity.Publish.Categories.start()
<cfoutput>
// CREATE Category ARRAYS
aActivityCategoryList = $.ListToArray("#ActivityCategoryList#","|");
aCategoryList = $.ListToArray("#CategoryList#","|");
</cfoutput>

$(document).ready(function() {
  // PAGE WIDE EDITING VARS
  nCurrEditID = 0;
  sCurrEditName = "";
  
  // Categories STYLE CHANGES
  $(".FieldInput").bind("change", this, function() {
    // DEFINE CONTAINERID
    ContainerID = this.id + "Container";
    
    // CREATE CHECKED STATUS
    var CheckedStatus = this.checked;
    
    // CHANGE CategoryCONTAINER'S CSS
    setCategoryStyle(CheckedStatus, ContainerID);
  });
  
  // CHECK IF THE Category NEEDS CHECKD ON LOAD
  $(".FieldInput:checked").each(function() {
    ContainerID = this.id + "Container";
    
    setCategoryStyle(true, ContainerID);
  });
});

// CHANGE CategoryCONTAINER'S CSS
function setCategoryStyle(CategoryStatus, ContainerID) {
  if(CategoryStatus) {
    $("#" + ContainerID).css({"background-color": "#4E9A30", "color": "#FFFFFF", "border": "1px solid #1B6700"});
  } else {
    $("#" + ContainerID).css({"background-color": "#FFFFFF", "color": "#000000", "border": "1px solid #FFFFFF"});
  } 
}
</script>

<cfoutput>
<!--- CREATE TABLE CELL COUNTER --->
<cfset CellCount = 0>
<form name="frmCategories" class="formstate js-formstate" method="post" action="#Application.Settings.RootPath#/_com/AJAX_Activity.cfc">
  <input type="hidden" value="saveCategoriesLMS" name="method" id="method" />
  <input type="hidden" value="plain" name="returnformat" />
  <input type="hidden" value="#Attributes.ActivityID#" name="ActivityID" />
  <cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveInfo.cfm" />
  
  <cfloop query="qCategories">
  <div class="grid-list-item" id="Site#qCategories.CategoryID#Container">
    <input type="checkbox" name="Site" id="Site#qCategories.CategoryID#" value="#qCategories.CategoryID#" class="FieldInput" <cfif ListFind(ActivityCategoryList, qCategories.CategoryID, "|")>CHECKED </cfif>/>
    <span id="CategoryContainer#qCategories.CategoryID#">
    <label for="Site#qCategories.CategoryID#"><strong>#qCategories.Name#</strong></label>
    </span>
  </div>
  </cfloop>
</form>
</cfoutput>