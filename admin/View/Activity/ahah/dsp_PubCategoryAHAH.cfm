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
<form name="frmCategories" class="formstate js-formstate form-horizontal" method="post" action="#Application.Settings.RootPath#/_com/AJAX_Activity.cfc">
  <input type="hidden" value="saveCategoriesLMS" name="method" id="method" />
  <input type="hidden" value="plain" name="returnformat" />
  <input type="hidden" value="#Attributes.ActivityID#" name="ActivityID" />
  
  <cfloop query="qCategories">
    <cfset rowClass = '' />
    <cfset checkAttr = '' />
    <cfif ListFind(ActivityCategoryList, qCategories.CategoryID, "|")>
      <cfset rowClass = ' is-checked' />
      <cfset checkAttr = ' checked="checked"' />
    </cfif>
  <div class="grid-list-item#rowClass#" id="category_#qCategories.CategoryID#Container">
    <span id="CategoryContainer#qCategories.CategoryID#">
    <label for="category_#qCategories.CategoryID#" class="checkbox">
      <input type="checkbox" name="category" id="category_#qCategories.CategoryID#" value="#qCategories.CategoryID#" class="FieldInput"#checkAttr#/>
      #qCategories.Name#
    </label>
    </span>
  </div>
  </cfloop>
</form>
</cfoutput>