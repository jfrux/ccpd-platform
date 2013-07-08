<cfparam name="Attributes.PersonID" type="numeric" default="0">
<cfparam name="Attributes.FirstName" type="String" default="">
<cfparam name="Attributes.MiddleName" type="String" default="">
<cfparam name="Attributes.LastName" type="String" default="">
<cfparam name="Attributes.BirthDate" type="String" default="">
<cfparam name="Attributes.Email" type="String" default="">
<cfparam name="Attributes.SSN" type="String" default="">
<cfparam name="Attributes.Degree" type="String" default="7">
<cfparam name="Attributes.QuickEntry" type="string" default="N">
<cfparam name="Attributes.ActivityID" default="0">
<cfparam name="Attributes.Instance" default="">

<script>
<cfoutput>
nActivity = #Attributes.ActivityID#;
sMyself = '#request.myself#';
sInstance = '#attributes.Instance#';
</cfoutput>
$(document).ready(function() {
  // bind to the form's submit event 
  $('.js-create-form').submit(function() { 
    $(this).ajaxSubmit({
      dataType:'json',
      success: function(data) {
        if(data.STATUS) {
          <cfif listFind("Attendee,Faculty,Committee",attributes.instance)>
            window.location = sMyself + "person.finder?instance=" + sInstance + "&activityid=" + nActivity + "&new_personid=" + data.STATUSMSG;
          <cfelse>
            window.location = sMyself + "person.detail?personid=" + data.STATUSMSG;
            //addMessage("Person has been saved.",250,6000,4000); 
          </cfif>
        } else {
          $.each(data.ERRORS, function(i,item){
            addError(item.MESSAGE,250,6000,4000);
          });
          
          $(".saving").css("display","none");
          $(".person-save").css("display","");
        }
      }
    }); 

    return false; 
  });
});
</script>
<cfoutput>
<form class="form-horizontal js-create-form" method="post" action="/admin/_com/AJAX_Person.cfc">
  <div class="control-group">
    <label class="control-label" for="FirstName">Full Name</label>
    <div class="controls">
      <input id="FirstName" name="FirstName" type="text" placeholder="First Name" class="inputText" style="width:70px;" value="#Attributes.FirstName#" />
      <input id="MiddleName" name="MiddleName" type="text" placeholder="Middle" class="inputText" style="width:70px;" value="#Attributes.MiddleName#" />
      <input id="LastName" name="LastName" type="text" placeholder="Last Name" class="inputText" style="width:70px;" value="#Attributes.LastName#" />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="date1">Birth Date</label>
    <div class="controls">
      <input id="date1" name="BirthDate" placeholder="01/01/1970" type="text" class="inputText" value="#Attributes.BirthDate#" />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="SSN">Last 4 SSN</label>
    <div class="controls">
      <input id="SSN" name="SSN" type="text" placeholder="1234" class="inputText" value="#Attributes.SSN#" />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="PersonID">Email</label>
    <div class="controls">
      <input id="Email" name="Email" type="text" placeholder="john@example.org" class="inputText" value="#Attributes.Email#" style="width:150px;" />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="">Password</label>
    <div class="controls">
      <input id="password" name="password" type="text" placeholder="Password" class="inputText" value="" />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="confirmation"></label>
    <div class="controls">
      <input id="passwordconfirmation" name="passwordconfirmation" placeholder="Re-type Password" type="text" class="inputText" value="" />
    </div>
  </div>
  <div class="control-group degrees">
    <label class="control-label">Profession</label>
    <div class="controls">
      <cfloop query="Application.List.Degrees">
      <label class="radio" for="DegreeID-#Application.List.Degrees.DegreeID#" id="degree-#Application.List.Degrees.DegreeID#">
        <input type="radio" name="DegreeID" <cfif attributes.degree EQ application.list.degrees.degreeid> checked="checked"</cfif> id="DegreeID-#Application.List.Degrees.DegreeID#" class="degreeid" value="#Application.List.Degrees.DegreeID#" />
         #Application.List.Degrees.Name#
       </label>
      </cfloop>
    </div>
  </div>
  <div class="control-group">
    <div class="controls">
      <input type="submit" value="Continue" class="btn btn-success person-save" />
      <a href="#myself#Person.Finder?instance=#attributes.instance#&activityId=#attributes.activityId#" class="btn">Cancel</a>
    </div>
  </div>
  <input type="hidden" name="returnFormat" value="plain" />
  <input type="hidden" name="personid" value="0" />
  <input type="hidden" name="method" value="createPerson" />
  <input type="hidden" name="Instance" id="Instance" value="#Attributes.Instance#" />
</form>
</cfoutput>