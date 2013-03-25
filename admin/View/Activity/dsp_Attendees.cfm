<cfparam name="Attributes.Page" type="numeric" default="1" />
<cf_cePersonFinder Instance="Attendee" DefaultName="Add Registrant" DefaultID="" AddPersonFunc="saveAttendee();" ActivityID="#Attributes.ActivityID#">
    
<script>
	<cfoutput>
	var nId = #Attributes.Page#;
	var nStatus = #attributes.status#;
	var SelectedMembers = '';
	var SelectedAttendees = '';
	var SelectedCount = 0;
	var TotalAttendeeCount = #qAttendees.RecordCount#;
	var TotalAttendeeList = '#TotalAttendeeList#';
	</cfoutput>
	
	function updateRegistrants(nPage, nStatus) {
		$("#RegistrantsLoading").show();
		$.get(sMyself + "Activity.AttendeesAHAH", { ActivityID: nActivity, status: nStatus, page: nPage }, 
			function(data) {
				$("#RegistrantsContainer").html(data);
				$("#RegistrantsLoading").hide();
				
				$(".AllAttendees").unbind();
				$(".AllAttendees").isPerson();
				
				// CHECK IF ATTENDEE HAS BEEN MARKED AS SELECTED	
				$(".AllAttendees").each(function() {
					$row = $(this);
					var $checkBox = $row.find('.MemberCheckbox');
					var nPerson = $row.find('.personId').val();
					var nAttendee = $row.find('.attendeeId').val();
			
					$checkBox.click(function() {
						if($(this).attr("checked")) {
							$("#attendeeRow-" + nAttendee).css("background-color","#FFD");
							
							// ADD CURRENT MEMBER TO SELECTEDMEMBERS LIST
							addSelectedAttendee({
								person:nPerson,
								attendee:nAttendee
							});
						} else {
							$("#attendeeRow-" + nAttendee).css("background-color","#FFF");
							
							// REMOVE CURRENT MEMBER FROM SELECTEDMEMBERS LIST
							removeSelectedPerson({
								person:nPerson,
								attendee:nAttendee
							});
						}
					});
					/*checkmarkMember({
						person:nPerson,
						attendee:nAttendee
					});*/
				});
		});
	}
	
	function clearSelectedMembers() {
		SelectedAttendees = '';
		SelectedMembers = '';
		SelectedCount = 0;
		$("#CheckedCount").html("(0)");
	}
	
	function updateSelectedCount(nAmount) {
		SelectedCount = SelectedCount + nAmount;
		$("#CheckedCount,.js-attendee-status-selected-count").html("" + SelectedCount + "");

		if(SelectedCount > 0) {
			$(".js-partic-actions").find('.btn').removeClass('disabled');
		} else {
			$(".js-partic-actions").find('.btn').addClass('disabled');
		}
	}
	
	function addSelectedAttendee(params) {
		var settings = $.extend({},params);
		
		if(settings.person && settings.person > 0) {
			if(!$.ListFind(SelectedMembers,settings.person,",")) {
			SelectedMembers = $.ListAppend(SelectedMembers, settings.person, ",");
			}
		}
		
		if(settings.attendee && settings.attendee > 0) {
			if(!$.ListFind(SelectedAttendees,settings.attendee,",")) {
			SelectedAttendees = $.ListAppend(SelectedAttendees, settings.attendee, ",");
			}
		}
		
		updateSelectedCount(1);
	}
	
	function removeSelectedPerson(params) {
		var settings = $.extend({},params);
		
		if(settings.person && settings.person > 0) {
			SelectedMembers = $.ListDeleteAt(SelectedMembers, $.ListFind(SelectedMembers, settings.person));
		}
		
		if(settings.attendee && settings.attendee > 0) {
			SelectedAttendees = $.ListDeleteAt(SelectedAttendees, $.ListFind(SelectedAttendees, settings.attendee));
		}
		
		
		updateSelectedCount(-1);
	}
	
	function saveAttendee() {
		$.blockUI({ message: '<h1>Adding Attendee...</h1>'});
		
		$.post(sRootPath + "/_com/AJAX_Activity.cfc", { method: "saveAttendee", PersonID: $("#AttendeeID").val(), ActivityID: nActivity, returnFormat: "plain" },
			function(returnData) {
				cleanData = $.trim(returnData);
				status = $.ListGetAt(cleanData,1,"|");
				statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(status == 'Success') {
					updateRegistrants(nId, nStatus);
					addMessage(statusMsg,250,6000,4000);
					$.unblockUI();
				} else if(status == 'Fail') {
					addError(statusMsg,250,6000,4000);
					$.unblockUI();
					$("#AttendeeName").val("Click To Add Attendee");
				}
			});
		
		$("#AttendeeID").val('');
		$("#AttendeeName").val('Click To Add Attendee');
	}
	
	$(document).ready(function() {
		<cfif GetToken(Cookie.USER_AttendeePage,1,"|") EQ Attributes.ActivityID>
			<cfif getToken(cookie.user_attendeeStatus, 1, "|") EQ Attributes.ActivityId>
				updateRegistrants(<cfoutput>#getToken(Cookie.USER_AttendeePage,2,"|")#, #getToken(Cookie.USER_AttendeeStatus,2,"|")#</cfoutput>);
			<cfelse>
				updateRegistrants(<cfoutput>#getToken(Cookie.USER_AttendeePage,2,"|")#</cfoutput>, nStatus);
			</cfif>
		<cfelse>
			updateRegistrants(nId, nStatus);
		</cfif>
		var MaxRegistrants = $("#MaxRegistrants").val();
		var AddlAttendees = $("#AddlAttendees").val();
		var NoChange = 0;
		
		$("a.page,a.first,a.last,a.next,a.previous").live("click",function() {
			nPageNo = $.Mid(this.href,$.Find('page=',this.href)+5,$.Len(this.href)-$.Find('page=',this.href)+4);
			$.post(sRootPath + "/_com/UserSettings.cfc", { method: "setAttendeePage", ActivityID: nActivity, Page: nPageNo });
			updateRegistrants(nPageNo, nStatus);
			return false;
		});
		
		$(".attendees-filter li").live("click",function() {
			$this = $(this);
			$this.parents('.btn-group').find('.btn span:first').text($this.text());
			nStatus = $.ListGetAt(this.id, 2, "-");
			$("#RegistrantsContainer").html("");
			$("#RegistrantsLoading").show();
			$.post(sRootPath + "/_com/UserSettings.cfc", { method: "setAttendeeStatus", ActivityID: nActivity, status: nStatus },
				function(data) {
					updateRegistrants(1, nStatus);
			});
			//return false;
		});
		
		/* CHANGE ATTENDEE STATAUS START */
		$("#btnStatusSubmit").bind("click",function() {
			setCheckedStatuses($("#StatusID").val());
		});

		function setCheckedStatuses(nStatus) {
			$.blockUI({ message: "<h1>Updating information...</h1>" });
			var result = "";
			var cleanData = "";
			
			var nActivityRole = $("#ActivityRoles").val();
			$(".MemberCheckbox:checked").each(function () {
				result = $.ListAppend(result,$(this).val(),",");
			});
			
			$.ajax({
				url: sRootPath + "/_com/AJAX_Activity.cfc",
				type: 'post',
				data: { method: "updateAttendeeStatuses", AttendeeList: result, ActivityID: nActivity, StatusID:nStatus, returnFormat: "plain" },
				dataType: 'json',
				success: function(returnData)  {
					status = returnData.STATUS;
					statusMsg = returnData.STATUSMSG;
					
					if(status) {
						addMessage(statusMsg,250,6000,4000);
						$.unblockUI();
						updateActions();
						updateStats();
						clearSelectedMembers();
						updateRegistrants(nId, nStatus);
					} else {
						addError(statusMsg,250,6000,4000);
						$.unblockUI();
					}
				}
			});
		}
		/* CHANGE ATTENDEE STATAUS END */
		
		/* REGISTRANTS AND ATTENDEE TEXTBOX START */
		$("#MaxRegistrants,#AddlAttendees").bind("blur", function() {
			if(MaxRegistrants != $("#MaxRegistrants").val()) {		// CHECK IF THE VALUE OF MAXREGISTRANTS CHANGED
				$.post(sRootPath + "/_com/AJAX_Activity.cfc",	{ method: "updateMaxRegistrants", ActivityID: nActivity, MaxRegistrants: $("#MaxRegistrants").val(), returnFormat: "plain" },
					function(returnData) {
						cleanData = $.trim(returnData);
						status = $.ListGetAt(cleanData,1,"|");
						statusMsg = $.ListGetAt(cleanData,2,"|");
						
						if(status == 'Success') {
							addMessage(statusMsg,250,6000,4000);
						} else {
							addError(statusMsg,250,6000,4000);
						}
					});
				
				MaxRegistrants = $("#MaxRegistrants").val();	// UPDATE MAXREGISTRANTS VALUE
			} else {
				NoChange = NoChange + 1;
			};
			
			if(AddlAttendees != $("#AddlAttendees").val()) {		// CHECK IF THE VALUE OF ADDLATTENDEES CHANGED
				$.post(sRootPath + "/_com/AJAX_Activity.cfc", { method: "updateAddlAttendees", ActivityID: nActivity, AddlAttendees: $("#AddlAttendees").val(), returnFormat: "plain" },
					function(returnData) {
						cleanData = $.trim(returnData);
						status = $.ListGetAt(cleanData,1,"|");
						statusMsg = $.ListGetAt(cleanData,2,"|");
						
						if(status == 'Success') {
							addMessage(statusMsg,250,6000,4000);
						} else {
							addError(statusMsg,250,6000,4000);
						}
					});
				
				AddlAttendees = $("#AddlAttendees").val();	// UPDATE ADDLATTENDEES VALUE
			} else {
				NoChange = NoChange + 1;
			};
			
			if(NoChange == 2) {
				addError("Please adjust the value you want to update and try again.",250,6000,4000);
				NoChange = 0;
			} else if(NoChange > 0) {
				NoChange = 0;
			};
				
		});
		/* REGISTRANTS AND ATTENDEE TEXTBOX START */
		
		/* REMOVE ONLY CHECKED */
		$("#RemoveChecked").bind("click",function() {
			if(confirm("Are you sure you want to remove the checked attendees from this activity?")) {
				var cleanData = "";			
				
				$.blockUI({ message: '<h1>Removing Selected Attendees...</h1>'});
				$.ajax({
					url: sRootPath + "/_com/AJAX_Activity.cfc", 
					type: 'post',
					data: { method: "removeCheckedAttendees", PersonList: SelectedMembers,AttendeeList: SelectedAttendees, ActivityID: nActivity, returnFormat: "plain" },
					dataType: 'json',
					success: function(data) {
						if(data.STATUS) {
							addMessage(data.STATUSMSG,250,6000,4000);
							clearSelectedMembers();
						} else {
							addError(data.STATUSMSG,250,6000,4000);
						}
						
						updateActions();
						updateStats();
						$.unblockUI();
						updateRegistrants(nId, nStatus);
					}
				});
			}
		});
		
		/* REMOVE ALL PEOPLE FROM Activity */
		$("#RemoveAll").bind("click",function() {
			if(confirm("WARNING!\nYou are about to remove ALL attendees from this Activity!\nAre you sure you wish to continue?")) {
				var cleanData = "";

				$.blockUI({ message: '<h1>Removing All Attendees...</h1>'});
				$.ajax({
					url: sRootPath + '/_com/AJAX_Activity.cfc',
					type: 'post',
					data: { method: 'removeAllAttendees', ActivityID: nActivity, returnFormat: 'plain' },
					dataType: 'json',
					success: function(data) {
						if(data.STATUS) {
							addMessage(data.STATUSMSG,250,6000,4000);
							updateActions();
							updateStats();
							$.unblockUI();
							clearSelectedMembers();
							updateRegistrants(nId, nStatus);
						} else {
							addError(data.STATUSMSG,250,6000,4000);
							updateActions();
							updateStats();
							$.unblockUI();
							updateRegistrants();
						}
					}
					
				});
			}
		});
		
		/* PRINT SELECTED ONLY START */
		$("#PrintCMECert").bind("click", this, function() {	//CME CERTS
			if($("#PrintSelected").attr("checked") == 'checked') {				
				window.open("http://www.getmycme.com/activities/" + nActivity + "/certificates?attendees=" + SelectedAttendees);
			} else {
				window.open(sMyself + "Report.CMECert?ActivityID=" + nActivity + "&ReportID=5");
			};
		});
		
		$("#PrintCNECert").bind("click", this, function() {	//CNE CERTS
			if($("#PrintSelected").attr("checked") == 'checked') {						//CHECK IF PRINTSELECTED IS CHECKED
				if(SelectedAttendees != "") {
					window.open(sMyself + "Report.CNECert?ActivityID=' nActivity + '&ReportID=6&SelectedAttendees=" + SelectedAttendees);
				} else {
					addError("You must select registrants",250,6000,4000);
				};
			} else {
				window.open(sMyself + "Report.CNECert?ActivityID=" + nActivity + "&ReportID=6");
			};
		});
		
		$(".PrintSigninSheet").bind("click", this, function() {	//CME CERTS
			if($("#PrintSelected").attr("checked") == 'checked') {						//CHECK IF PRINTSELECTED IS CHECKED
				if(SelectedAttendees != "") {
					if($.ListGetAt(this.id,2,"|") == "Y") {
						window.open(sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=1&ReportID=12&SelectedAttendees=" + SelectedAttendees);
					} else {
						window.open(sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=0&ReportID=12&SelectedAttendees=" + SelectedAttendees);
					}
				} else {
					addError("You must select registrants",250,6000,4000);
				};
			} else {
				if($.ListGetAt(this.id,2,"|") == "Y") {
					window.open(sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=1&ReportID=12");
				} else {
					window.open(sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=0&ReportID=12");
				}
			};
		});
		
		$("#PrintMailingLabels").bind("click", this, function() {	//MAILING LABELS
			if($("#PrintSelected").attr("checked") == 'checked') {						//CHECK IF PRINTSELECTED IS CHECKED
				if(SelectedMembers != "") {
					window.open(sMyself + "Report.MailingLabels?ActivityID=" + nActivity + "&ReportID=3&Print=1&SelectedAttendees=" + SelectedAttendees);
				} else {
					addError("You must select registrants",250,6000,4000);
				};
			} else {
				window.open(sMyself + "Report.MailingLabels?ActivityID=" + nActivity + "&ReportID=3&Print=1");
			};
		});
		
		$("#PrintNameBadges").bind("click", this, function() {	//NAME BADGES
			if($("#PrintSelected").attr("checked") == 'checked') {						//CHECK IF PRINTSELECTED IS CHECKED
				if(SelectedMembers != "") {
				
					window.open(sMyself + "Report.NameBadges?ActivityID=" + nActivity + "&SelectedMembers=" + SelectedMembers);
				} else {
					addError("You must select registrants",250,6000,4000);
				};
			} else {
				window.open(sMyself + "Report.NameBadges?ActivityID=" + nActivity + "");
			};
		});
		/* PRINT SELECTED ONLY END */
});
$(document).ready(function() {
  $(".importDialog").dialog({
  	title:"Batch Attendee Import",
  	modal: false, 
  	autoOpen: false,
  	height:200,
  	width:500,
  	buttons: { 
  			Done:function() {
  				updateRegistrants();
  				$(".importDialog").find('iframe').attr('src',sMyself + 'activity.import?activityid=' + nActivity);
  				$(".importDialog").dialog("close");
  			}
  		}
  });

  $(".newImportDialog").dialog({
    title:"Batch Attendee Import",
    modal: false, 
    autoOpen: false,
    height:550,
    width:670,
    buttons: { 
        Done:function() {
          updateRegistrants();
          $(".newImportDialog").find('iframe').attr('src','<cfoutput>#Application.Settings.apiUrl#</cfoutput>/imports?importable_id=' + nActivity);
          $(".newImportDialog").dialog("close");
        }
      }
  });

	$(".batchLink").click(function() {
		$(".newImportDialog").dialog("open");
	});
});
</script>
<div class="ViewSection">
	<div id="RegistrantsContainer"></div>
	<div id="RegistrantsLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
	<div>Please Wait</div></div>
</div>
<cfoutput>
<div class="importDialog">
	<iframe src="#myself#activity.import?activityid=#attributes.activityid#" frameborder="0" style="width: 400px; height: 100px;"></iframe>
</div>

<div class="newImportDialog">
  <iframe src="#Application.Settings.apiUrl#/imports?importable_id=#attributes.activityid#" frameborder="0" style="width: 640px; height: 545px;"></iframe>
</div>
</cfoutput>