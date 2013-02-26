
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
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_SectSubTitle">Transcript Options</div>
<div class="MultiFormRight_LinkList">
	<table>
    	<tr>
        	<td><input type="text" id="date1" name="StartDate" style="width:80px;" /></td>
        </tr>
    	<tr>
        	<td><input type="text" id="date2" name="EndDate" style="width:80px;" /></td>
        </tr>
    </table>
	<a href="javascript://" id="GetTranscript" title="This link provides a copy of the person's transcript."><img src="#Application.Settings.RootPath#/_images/icons/page.png" border="0" align="absmiddle" /> Print Transcript</a>
</div>
<div class="MultiFormRight_SectSubTitle">Activity Options</div>
<div class="MultiFormRight_LinkList">
	<table>
    	<tr>
        	<td><cf_cePersonFinder Instance="MoveActivities" DefaultName="Move Activities" DefaultID="" AddPersonFunc="moveActivities();"></td>
        </tr>
    </table>
</div>
</cfoutput>