<cfparam name="Attributes.Attendance" default="">
<cfoutput>
<script>
	$(document).ready(function() {
		$(".CheckIn").bind("click",this,function() {
			var nPersonID = $.Replace(this.id,'CheckInFlag','','ALL');
			var sName = $('##' + nPersonID + 'Name').html();
			
			if($(this).attr("checked")) {
				$.post("#Application.Settings.RootPath#/_com/PersonAttendance/PersonAttendanceAjax.cfc", 
					{ method: "AddCheck", PersonID: nPersonID, AttendanceID: #Attributes.AttendanceID#, Type: 'In', returnFormat: "plain" },
					function(returnData) {
						var cleanData = $.trim(returnData);
						var status = $.ListGetAt(cleanData,1,"|");
						var statusMsg = $.ListGetAt(cleanData,2,"|");
						var dateChecked = $.ListGetAt(cleanData,3,"|");
						
						if(status == 'success') {
							$("##" + nPersonID + "CheckInDate").html(dateChecked);
							$("##CheckOutFlag" + nPersonID).removeAttr('disabled');
							addMessage(sName + ' Check-In successful!',250,2500,2500);
						} else if(status == 'fail') {
							$(this).checked = false;
							addError(sName + ' Check-In failed!',250,2500,2500);
						}
					});
			} else {
				$.post("#Application.Settings.RootPath#/_com/PersonAttendance/PersonAttendanceAjax.cfc", 
					{ method: "RemoveCheck", PersonID: nPersonID, AttendanceID: #Attributes.AttendanceID#, Type: 'In', returnFormat: "plain" },
					function(returnData) {
						var cleanData = $.trim(returnData);
						var status = $.ListGetAt(cleanData,1,"|");
						var statusMsg = $.ListGetAt(cleanData,2,"|");
						var dateChecked = $.ListGetAt(cleanData,3,"|");
						
						if(status == 'success') {
							$("##" + nPersonID + "CheckInDate").html(dateChecked);
							$("##CheckOutFlag" + nPersonID).attr('disabled',true);
							addMessage(sName + ' Check-In REMOVAL successful!',250,2500,2500);
						} else if(status == 'fail') {
							$(this).checked = true;
							$("##CheckOutFlag" + nPersonID).removeAttr('disabled');
							addError(sName + ' Check-In REMOVAL failed!',250,2500,2500);
						}
					});
			}
		});
		
		$(".CheckOut").bind("click",this,function() {
			var nPersonID = $.Replace(this.id,'CheckOutFlag','','ALL');
			var sName = $('##' + nPersonID + 'Name').html();
			
			if($(this).attr("checked")) {
				$.post("#Application.Settings.RootPath#/_com/PersonAttendance/PersonAttendanceAjax.cfc", 
					{ method: "AddCheck", PersonID: nPersonID, AttendanceID: #Attributes.AttendanceID#, Type: 'Out', returnFormat: "plain" },
					function(returnData) {
						var cleanData = $.trim(returnData);
						var status = $.ListGetAt(cleanData,1,"|");
						var statusMsg = $.ListGetAt(cleanData,2,"|");
						var dateChecked = $.ListGetAt(cleanData,3,"|");
						
						if(status == 'success') {
							$("##" + nPersonID + "CheckOutDate").html(dateChecked);
							addMessage(sName + ' Check-Out successful!',250,2500,2500);
							$("##CheckInFlag" + nPersonID).attr('disabled',true);
						} else if(status == 'fail') {
							$(this).checked = false;
							$("##CheckInFlag" + nPersonID).removeAttr('disabled');
							addError(sName + ' Check-Out failed!',250,2500,2500);
						}
					});
			} else {
				$.post("#Application.Settings.RootPath#/_com/PersonAttendance/PersonAttendanceAjax.cfc", 
					{ method: "RemoveCheck", PersonID: nPersonID, AttendanceID: #Attributes.AttendanceID#, Type: 'Out', returnFormat: "plain" },
					function(returnData) {
						var cleanData = $.trim(returnData);
						var status = $.ListGetAt(cleanData,1,"|");
						var statusMsg = $.ListGetAt(cleanData,2,"|");
						var dateChecked = $.ListGetAt(cleanData,3,"|");
						
						if(status == 'success') {
							$("##" + nPersonID + "CheckOutDate").html(dateChecked);
							$("##CheckInFlag" + nPersonID).removeAttr('disabled');
							addMessage(sName + ' Check-Out REMOVAL successful!',250,2500,2500);
						} else if(status == 'fail') {
							$(this).checked = true;
							$("##CheckInFlag" + nPersonID).attr('disabled',true);
							addError(sName + ' Check-Out REMOVAL failed!',250,2500,2500);
						}
					});
			}
		});
		
	});
	
</script>
<form name="frmAttendanceAdd" method="post" action="#Myself#Activity.RecordAttendance&ActivityID=#Attributes.ActivityID#&AttendanceID=#Attributes.AttendanceID#&FormSubmit=1">
<div class="FormSection" id="Sect2">
		<h3>#Attributes.EventName# - #DateFormat(Attributes.EventDate,"mm/dd/yyyy")# #TimeFormat(Attributes.EventTime,"hh:mm:ss TT")# - Live Attendance Management</h3>
		<!---<cfif qPeople.RecordCount GT 0>#PeoplePager.getRenderedHTML()#</cfif>
	<table width="100%" cellpadding="0" cellspacing="0" class="DataGrid">
		<thead>
			<tr>	
				<th nowrap="nowrap"><a href="javascript:void(0);">Name</a></th>
				<th width="170" nowrap="nowrap"><a href="javascript:void(0);">Check In</a></th>
				<th width="170" nowrap="nowrap"><a href="javascript:void(0);">Check Out</a></th>
			</tr>
		</thead>
		<tbody>
		<cfloop query="qCurrentAttendance">
			<tr id="PersonRow#PersonID#">
				<td id="#PersonID#Name">#FirstName# #LastName#</td>
				<td width="170"><input type="checkbox" name="CheckIn" class="CheckIn" id="CheckInFlag#PersonID#"<cfif qCurrentAttendance.CheckOutFlag EQ "Y"> disabled</cfif> value="Y"<cfif qCurrentAttendance.CheckInFlag EQ "Y"> checked</cfif>> <span id="#PersonID#CheckInDate">#DateFormat(qCurrentAttendance.CheckedIn,"mm/dd/yyyy")# #TimeFormat(qCurrentAttendance.CheckedIn,"hh:mm:ss TT")#</span></td>
				<td width="170"><input type="checkbox" name="CheckOut" class="CheckOut" id="CheckOutFlag#PersonID#"<cfif qCurrentAttendance.CheckInFlag EQ "N" OR qCurrentAttendance.CheckInFlag EQ ""> disabled</cfif> value="Y"<cfif qCurrentAttendance.CheckOutFlag EQ "Y"> checked</cfif>> <span id="#PersonID#CheckOutDate">#DateFormat(qCurrentAttendance.CheckedOut,"mm/dd/yyyy")# #TimeFormat(qCurrentAttendance.CheckedOut,"hh:mm:ss TT")#</span></td>
			</tr>
		</cfloop>
		</tbody>
	</table>
	<cfif qPeople.RecordCount GT 0>#PeoplePager.getRenderedHTML()#</cfif>--->
</div>
</form>
</cfoutput>