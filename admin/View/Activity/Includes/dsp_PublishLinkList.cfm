<script>
<cfoutput>
var isPublishArea = true; // USED TO DETERMINE IF PUBLISH BAR IS UPDATED
</cfoutput>
function updatePublishState() {
  $.ajax({
    url:sMyself + "Activity.PublishBar", 
    type:'get',
    data: { 
      ActivityID: nActivity 
    }, 
    success: function(data) {
      $("#PublishState").html(data);
    }
  });
}

$(document).ready(function() {
  updatePublishState();

  <cfif Attributes.Fuseaction EQ "Activity.PubCategory">
  $("#btnNewCategory").bind("click", this, function() {
    if($("#NewCategory").val() != "") {
      $.post(sRootPath + "/_com/AJAX_System.cfc", { method: "saveCategoryLMS", CategoryName: $("#NewCategory").val(), returnFormat: "plain" },
        function(data){
          var cleanData = $.trim($.ListGetAt(data,1,"<"));
          var status = $.ListGetAt(cleanData, 1, "|");
          var statusMsg = $.ListGetAt(cleanData, 2, "|");
          
          if(status == 'Success') {
            updateCategories();
            updatePublishState();
            addMessage(statusMsg,250,6000,4000);
            $("#NewCategory").val("");
          } else {
            addError(statusMsg,250,6000,4000);
          }
      });
    }   
  });
  </cfif>

  <cfif Attributes.Fuseaction EQ "Activity.PubSpecialty">
  $("#btnNewSpecialty").bind("click", this, function() {
      if($("#NewSpecialty").val() != "") {
         $.post(sRootPath + "/_com/AJAX_System.cfc", { method: "saveSpecialty", SpecialtyName: $("#NewSpecialty").val(), returnFormat: "plain" },
    function(data){
      var cleanData = $.trim($.ListGetAt(data,1,"<"));
      var status = $.ListGetAt(cleanData, 1, "|");
      var statusMsg = $.ListGetAt(cleanData, 2, "|");
      
      if(status == 'Success') {
        updateSpecialties();
        addMessage(statusMsg,250,6000,4000);
        $("#NewSpecialty").val("");
      } else {
        addError(statusMsg,250,6000,4000);
      }
  });
      }
  });
  </cfif>
});
</script>

<cfoutput>
<div id="PublishState">

</div>
<!---
<!--- ADD NEW CATEGORY --->
<cfif Attributes.Fuseaction EQ "Activity.PubCategory">
<div style="clear:both;">
<div class="MultiFormRight_SectSubTitle">Category Options</div>
<div class="MultiFormRight_SectBody"><label for="NewCategory"><strong>Add New Category</strong></label>
<input type="text" name="NewCategory" id="NewCategory" /><a href="javascript:void(0);" id="btnNewCategory"><img src="#Application.Settings.RootPath#/_images/icons/asterisk_orange.png" border="0" /></a><br />
OR <a href="#Myself#Admin.Categories">Manage Categories</a>
</div>
</div>
</cfif>

<!--- ADD NEW SPECIALTY --->
<cfif Attributes.Fuseaction EQ "Activity.PubSpecialty">
<div style="clear:both;">
<div class="MultiFormRight_SectSubTitle">Specialty Options</div>
<div class="MultiFormRight_SectBody"><label for="NewSpecialty"><strong>Add New Specialty</strong></label>
<input type="text" name="NewSpecialty" id="NewSpecialty" /><a href="javascript:void(0);" id="btnNewSpecialty"><img src="#Application.Settings.RootPath#/_images/icons/asterisk_orange.png" border="0" /></a><br />
OR <a href="#Myself#Admin.Specialties">Manage Specialties</a>
</div>
</div>

</cfif>
--->
</cfoutput>