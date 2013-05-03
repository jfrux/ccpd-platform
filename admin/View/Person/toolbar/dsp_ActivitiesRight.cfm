
<script>
<cfoutput>
var sFirstName = '#replace(Attributes.FirstName,"'","\'","ALL")#';
var sLastName = '#replace(Attributes.LastName,"'","\'","ALL")#';
var sFullName = sFirstName + ' ' + sLastName;
</cfoutput>
$(document).ready(function() {
	$("#date1, #date2").datepicker({ 
		showOn: "button", 
		buttonImage: "/admin/_images/icons/calendar.png", 
		buttonImageOnly: true,
		showButtonPanel: true,
		changeMonth: true,
		changeYear: true

	});

  $('.dropdown-menu table *, .dropdown-menu #GetTranscript').click(function(e) {
      e.stopPropagation();
  });
});

function moveActivities() {
	if($("#MoveActivitiesID").val() != "") {
		var bMove = confirm("Are you sure you want to move the activites from " + sFullName + " to" + $.ListGetAt($("#MoveActivitiesName").val(),2,",") + $.ListGetAt($("#MoveActivitiesName").val(),1,",") + "?");
		if(bMove) {
			nPersonID = $("#MoveActivitiesID").val();
			sPersonName =  $.ListGetAt($("#MoveActivitiesName").val(),2,",") + $.ListGetAt($("#MoveActivitiesName").val(),1,",");
			
			$.getJSON(sRootPath + "/_com/AJAX_Person.cfc", { method: "moveActivities", MoveToPersonID: nPersonID, MoveToName: sPersonName, MoveFromPersonID: nPerson, MoveFromName: sFullName, returnFormat: "plain"},
				  function(data){					
					window.location= sMyself + "Person.Activities?PersonID=" + nPersonID + "&Message=" + data.STATUSMSG;
				  });
		}
	}
}
</script>
<cfoutput>
<div class="toolbar btn-toolbar">
  <div class="btn-group">
    <a href="javascript://" id="addEmailAddress" class="btn btn-mini"><i class="icon-road"></i></a>
  </div>
  <div class="btn-group">
    <a class="btn btn-mini btn-transcript dropdown-toggle" data-toggle="dropdown" href="##">
      Transcript
      <span class="caret"></span>
    </a>
    <ul class="dropdown-menu">
      <li class="nav-header">
        <table>
          <tr>
            <td><input type="text" id="date1" name="StartDate" style="width:80px;" /></td>
          </tr>
          <tr>
            <td><input type="text" id="date2" name="EndDate" style="width:80px;" /></td>
          </tr>
        </table>
        <a href="javascript://" id="GetTranscript" title="This link provides a copy of the person's transcript." class="btn"><i class="icon-"></i> Generate</a>
      </li>
    </ul>
  </div>
</div>
<cf_cePersonFinder Instance="MoveActivities" DefaultName="Move Activities" DefaultID="" AddPersonFunc="moveActivities();">
</cfoutput>