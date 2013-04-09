<script>
  var CurrPersonID = 0;

  App.Activity.Faculty.start();
</script>
<cfoutput>
  <cf_cePersonFinder 
  Instance="Faculty" 
  DefaultName="Add Faculty / Speaker" 
  DefaultID="" 
  AddPersonFunc="App.Activity.Faculty.save();" 
  ActivityID="#Attributes.ActivityID#">
 
<div class="ViewSection">
  <div id="FacultyContainer"></div>
  <div id="FacultyLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
  <div>Please Wait</div></div>
</div>
<div id="FileUploader">
</div>
</cfoutput>