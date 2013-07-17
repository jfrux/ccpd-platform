<cfparam name="Attributes.Instance" default="">
<cfparam name="Attributes.DefaultName" default="">
<cfparam name="Attributes.DefaultID" default="">
<cfparam name="Attributes.AddPersonFunc" default="">
<cfparam name="Attributes.ActivityID" default="">
<style>

</style>
<cfoutput>
<script type="text/javascript">
function setPerson#Attributes.Instance#(sValue) {
  $("###Attributes.Instance#Name").val($.ListGetAt(sValue,2,"|"));
  $("###Attributes.Instance#ID").val($.ListGetAt(sValue,1,"|"));
  #Attributes.AddPersonFunc#
}

$(document).ready(function() {
  var $dialog = $("##PersonWindow#Attributes.Instance#")
  var $link = $(".js-add-person-link")
  var finderUrl = "#Request.myself#Person.Finder?Instance=#Attributes.Instance#&ActivityID=#Attributes.ActivityID#";
  var $frame = $dialog.find('iframe')
  $dialog.dialog({ 
    title:"Add #Attributes.Instance#",
    modal: true, 
    overlay: { 
      opacity: 0.5, 
      background: "black" 
    },
    autoOpen: false,
    height:500,
    width:650,
    dialogClass:'personFinder',
    resizable: false,
    draggable:false,
    open:function() {
      $frame.attr('src',finderUrl)
      $dialog.show();
    }
  });
  
  <cfif Attributes.DefaultID NEQ "">
  $.getJSON(sRootPath + "/_com/AJAX_Person.cfc", { method: "getNameByID", PersonID: #Attributes.DefaultID#, ReturnFormat: "plain" },
    function(data){
    setPerson#Attributes.Instance#("#Attributes.DefaultID#|" + data.DATASET.LASTNAME + ", " + data.DATASET.FIRSTNAME + " " + data.DATASET.MIDDLENAME);
    });
  </cfif>

 $link.click(function() {
    $dialog.dialog("open");
  });
});
</script>

<input type="hidden" name="#Attributes.Instance#Name" id="#Attributes.Instance#Name" class="field text" value="#Attributes.DefaultName#" readonly="readonly" style="cursor:default;" />
<input type="hidden" name="#Attributes.Instance#ID" id="#Attributes.Instance#ID" value="#Attributes.DefaultID#" />
<div id="PersonWindow#Attributes.Instance#" style="display:none;">
  <iframe src="" id="PersonFrame#Attributes.Instance#" frameborder="0" width="100%" height="425" scrolling="no"></iframe>
</div>
</cfoutput>