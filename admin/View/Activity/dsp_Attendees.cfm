<cfparam name="Attributes.Page" type="numeric" default="1" />
<cf_cePersonFinder Instance="Attendee" DefaultName="Add Registrant" DefaultID="" AddPersonFunc="saveAttendee();" ActivityID="#Attributes.ActivityID#">

<script>
  <cfoutput>
  var nId = #Attributes.Page#;
  var nStatus = #attributes.status#;
  var SelectedMembers = '';
  var SelectedAttendees = '';
  var SelectedCount = 0;
  var CookieAttendeePageActivity = #GetToken(Cookie.USER_AttendeePage,1,"|")#;
  var CookieAttendeePage = #getToken(Cookie.USER_AttendeePage,2,"|")#;
  var CookieAttendeeStatusActivity = #getToken(cookie.user_attendeeStatus, 1, "|")#;
  var CookieAttendeeStatus = #getToken(cookie.user_attendeeStatus, 2, "|")#;

  var TotalAttendeeCount = #qAttendees.RecordCount#;
  var TotalAttendeeList = '#TotalAttendeeList#';
  </cfoutput>
  
  App.Activity.Participants.start();
</script>

<div class="ViewSection">
  <div id="RegistrantsContainer"></div>
  <div id="RegistrantsLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
  <div>Please Wait</div></div>
</div>
<cfoutput>
<div class="importDialog">
  <iframe src="" frameborder="0" style="width: 400px; height: 100px;"></iframe>
</div>

<div class="newImportDialog">
  <iframe src="" frameborder="0" style="width: 640px; height: 545px;"></iframe>
</div>
</cfoutput>
