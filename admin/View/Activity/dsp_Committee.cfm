<script>
  var CurrPersonID = 0;

  App.Activity.Committee.start();
</script>
<cfoutput>
<cf_cePersonFinder Instance="Committee" DefaultName="Add Committee Member" DefaultID="" AddPersonFunc="App.Activity.Committee.save();" ActivityID="#Attributes.ActivityID#">
 
<div class="ViewSection">
  <div id="CommitteeContainer"></div>
  <div id="CommitteeLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
  <div>Please Wait</div></div>
</div>
 
</cfoutput>