<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.MultiFormContent" default="">
<cfparam name="Request.MultiFormRight" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">

<cfoutput>
<script>


function continueCopy() {
	$.post("/lms/_com/Activity/ActivityAjax.cfc", 
		{ method: "CopyPaste", Mode: $(".CopyChoice:checked").val(), ActivityID:#Attributes.ActivityID#, ReturnFormat:"plain" },
		function(returnData) {
			cleanData = $.trim(returnData);
			status = $.ListGetAt(cleanData,1,"|");
			statusMsg = $.ListGetAt(cleanData,2,"|");
			if(status == 'Fail') {
				addError(statusMsg,250,6000,4000);
			} else {
				//window.location='#myself#Activity.Detail?ActivityID=' + statusMsg + '&Message=Copy and Paste Successful!';
			}
	});
}

function cancelCopy() {

}

function updateAll() {
	updateStats();
	updateActions();
	updateContainers();
}

function updateStats() {
	$.post("#myself#Activity.Stats?ActivityID=#Attributes.ActivityID#", function(data) {
		$("##ActivityStats").html(data);
	});
}

function updateActions() {
	$.post("#myself#Activity.ActionsShort?ActivityID=#Attributes.ActivityID#", function(data) {
		$("##LatestActions").html(data);
	});
}

function updateContainers() {
	$.post("#myself#Activity.Container?ActivityID=#Attributes.ActivityID#", function(data) {
		$("##Containers").html(data);
	});
}

/* ON DOM LOAD EVENTS */
$(document).ready(function() {
	updateActions();
	updateContainers();
	updateStats();
	
	/* STATUS CHANGER */
	$("##StatusChanger").change(function() {
		$.post("/lms/_com/Activity/ActivityAjax.cfc", { method: "setStatus", ActivityID: #Attributes.ActivityID#, StatusID:$(this).val(), returnFormat:"plain" },
		  function(data){
			var cleanData = $.trim(data);
			addMessage("Activity status changed successfully!",250,6000,4000);
		  });
		$("##StatusIcon").attr("src","/lms/_images/icons/Status" + $(this).val() + ".png");
	});
	/* // END STATUS CHANGER */
	
	/* DIALOG WINDOWS */
	/* ACTIVITY DIALOG */
	$("##ActivityList").dialog({ 
		title:"Activity List",
		modal: false, 
		autoOpen: #Cookie.Settings.ActListOpen#,
		height:#GetToken(Cookie.Settings.ActListSize,2,",")#,
		width:#GetToken(Cookie.Settings.ActListSize,1,",")#,
		position:[#Cookie.Settings.ActListPos#],
		resizable: true,
		dragStop: function(ev,ui) {
			$.post("/lms/_com/UserSettings.cfc", { method:'setActListPos', position: ui.position.left + "," + ui.position.top });
		},
		open:function() {
			$("##ActivityList").show();
			$.post("/lms/_com/UserSettings.cfc", { method:'setActListOpen', IsOpen: 'true' });
			$("##ActivityDialogLink").fadeOut();
			$("##ActivityList").attr({ scrollTop: $(".CurrentActivityRow").position().top-30 });
		},
		close:function() {
			$("##ActivityDialogLink").fadeIn();
			$.post("/lms/_com/UserSettings.cfc", { method:'setActListOpen', IsOpen: 'false' });
		},
		resizeStop:function(ev,ui) {
			$.post("/lms/_com/UserSettings.cfc", { method:'setActListSize', Size: ui.size.width + ',' + ui.size.height });
		}
	});
	
	$("##ActivityDialogLink").click(function() {
		$("##ActivityList").dialog("open");
	});
	
	$(".ActivityRow").click(function() {
		var nActivityID = $.Replace(this.id,"Activity","","ALL");
		window.location='#myself##Attributes.Fuseaction#?ActivityID=' + nActivityID;
	});
	
	$(".ActivityRow").mouseover(function() {
		$(this).removeClass('ActivityRow');
		$(this).addClass('CurrentActivityRow');
	});
	
	$(".ActivityRow").mouseout(function() {
		$(this).removeClass('CurrentActivityRow');
		$(this).addClass('ActivityRow');
	});
	/* // END ACTIVITY DIALOG */
	
	/* COPY AND PASTE DIALOG */
	$("##CopyDialog").dialog({ 
		title:"Copy &amp; Paste Activity",
		modal: true, 
		autoOpen: false,
		overlay: { 
			opacity: 0.5, 
			background: "black" 
		} ,
		buttons: { 
			Continue:function() {
				continueCopy()
			}, 
			Cancel:function() {
				cancelCopy();
				$("##CopyDialog").dialog("close");
			}
		},
		height:125,
		width:400,
		resizable: false,
		draggable: true,
		open:function() {
			$("##CopyDialog").show();
		},
		close:function() {
			cancelCopy()
		}
	});
	
	$("##CopyLink").click(function() {
		$("##CopyDialog").dialog("open");
	});
	/* // END COPY AND PASTE DIALOG */
	
	/* NOTES DIALOG */
	$("##NotesList").dialog({ 
		title:"Notes",
		modal: false, 
		autoOpen: #Cookie.Settings.ActNotesOpen#,
		height:420,
		width:370,
		position:[#Cookie.Settings.ActNotesPos#],
		resizable: false,
		dragStop: function(ev,ui) {
			$.post("/lms/_com/UserSettings.cfc", { method:'setActNotesPos', position: ui.position.left + "," + ui.position.top });
		},
		open:function() {
			$("##NotesList").show();
			$("##frmNotes").attr("src","#myself#Activity.Notes?ActivityID=#Attributes.ActivityID#");
			$.post("/lms/_com/UserSettings.cfc", { method:'setActNotesOpen', IsOpen: 'true' });
			$("##NotesDialogLink").fadeOut();
		},
		close:function() {
			$("##NotesDialogLink").fadeIn();
			$("##frmNotes").attr("src","javascript://");
			$.post("/lms/_com/UserSettings.cfc", { method:'setActNotesOpen', IsOpen: 'false' });
		}
	});

	$("##NotesDialogLink").click(function() {
		$("##NotesList").dialog("open");
	});
	/* // END NOTES DIALOG */
	
	/* OVERVIEW DIALOG */
	$("##OverviewList").dialog({ 
		title:"Activity Overview",
		modal: false, 
		autoOpen: false,
		height:550,
		width:740,
		resizable: true,
		open:function() {
			$("##frmOverview").attr("src","#myself#Activity.Overview?ActivityID=#Attributes.ActivityID#");
			$("##OverviewList").show();
			$("##OverviewDialogLink").fadeOut();
		},
		close:function() {
			$("##OverviewDialogLink").fadeIn();
			$("##frmOverview").attr("src","javascript://");
		},
		buttons: { 
			Print:function() {
				frmOverview.print();
			}, 
			Close:function() {
				$("##OverviewList").dialog("close");
			}
		}
	});

	$("##OverviewDialogLink").click(function() {
		$("##OverviewList").dialog("open");
	});
	/* // END OVERVIEW DIALOG */
	
	
	
	/* PROCESS QUEUES DIALOG */
	$("##ProcessQueueDialog").dialog({ 
		title:"Process Queues",
		modal: true, 
		autoOpen: false,
		overlay: { 
			opacity: 0.5, 
			background: "black" 
		},
		buttons: { 
			Continue:function() {
				frmProcessQueue.addToQueue();
			}, 
			Cancel:function() {
				$("##ProcessSelect").val("");
				$(this).dialog("close");
			}
		},
		height:400,
		width:560,
		resizable: false,
		open:function() {
			$("##ProcessQueueDialog").show();
		}
	});
	
	$("##ProcessSelect").change(function() {
		$("##frmProcessQueue").attr("src","#myself#Process.AddToQueue?ActivityID=#Attributes.ActivityID#&ProcessID=" + $(this).val());
		$("##ProcessQueueDialog").dialog("open");
	});
	
	$("##ProcessSelect").val("");
	/* // END PROCESS QUEUES DIALOG */
	/* // END DIALOG WINDOWS */
	
	/* UNSAVED CHANGES SCRIPTS */
	var Unsaved = false;
	var question232 = $("##question232");
	var TheLink = '';
	$(".PageStandard").hide();
	
	$("form input,form textarea").bind("keyup", function(){
		if (Unsaved==false) {
			Unsaved = true;
			$("##StatusBar").show();
			$(".PageStandard").fadeIn("slow").html("Unsaved Changes...");;
		}
	});
	
	$("form select").bind("change", function(){
		$("##StatusBar").show();
		$(".PageStandard").fadeIn("slow").html("Unsaved Changes...");;
		Unsaved = true;
	});
	
	$("a").bind("click", this, function(){
			TheLink = this.href;
			if (Unsaved) {
				$("##StatusBar").hide().fadeIn("fast").addClass("StatusError").fadeOut("fast").fadeIn("fast").fadeOut("fast").fadeIn("fast").html("Unsaved Changes...");
				$.extend($.blockUI.defaults.overlayCSS, { backgroundColor: '##000' });
				$.blockUI({message: question232, width: '275px' });
				
				return false;
			}
		});
	
	$('##yes').click(function() { 
		$.unblockUI();
		window.location=TheLink;
	}); 
	
	$('##no').click($.unblockUI);
	
	$('a.button').unbind("click");
	/*END UNSAVED CHANGES CRAP */
	
	
});
</script>
<link href="/_styles/Activity.css" rel="stylesheet" type="text/css" />
	<div class="ContentTitle">
		<cfif Len(ActivityBean.getTitle()) GT 75>#left(ActivityBean.getTitle(),75) & "..."#<cfelse>#ActivityBean.getTitle()#</cfif> // #DateFormat(ActivityBean.getReleaseDate(),'mm/dd/yyyy')#</div>
	<div style="font-size:16px; font-weight:normal; text-transform:uppercase; color:##555;"><cfif ActivityBean.getParentActivityID() NEQ "">#ParentBean.getTitle()# <cfelse>Parent Activity</cfif> // <cfif ParentBean.getSessionType() EQ "M">Multi-Session<cfelse>Single-Session</cfif></div>
	<cfif ActivityBean.getDeletedFlag() EQ "Y">
	<div style="font-size:18px;color:##FF0000;">THIS ACTIVITY HAS BEEN DELETED.</div>
	<cfelse>
	<div class="clear-fix"><cf_ceTabControl Instance="MultiForm" Labels="#Request.MultiFormLabels#" Fuseactions="#Request.MultiFormFuseactions#" QueryString="#Request.MultiFormQS#" Current="#Attributes.Fuseaction#"></div>
	<table width="979" cellspacing="0" border="0" cellpadding="0" class="MultiForm">
		<tbody>
			<tr>
				<td class="MultiFormContent">#Request.MultiFormContent#</td>
				<td class="MultiFormRight" valign="top">
					
					
					#Request.MultiFormRight#
					
					<div class="MultiFormRight_SectSubTitle">Global Options</div>
					<div class="MultiFormRight_LinkList">
						<a href="javascript:void(0);" id="CopyLink">Copy This Activity</a>
					</div>
				</td>
				<td class="InfoBar" valign="top">
					<cfset qStatuses = Application.Com.StatusGateway.getByAttributes(OrderBy="Name")>
					<div id="Status">
						<h3>Activity Status</h3>
						<table width="100%" cellspacing="1" border="0" cellpadding="2">
							<tr>
								<td>Status</td><td><img src="/lms/_images/icons/Status#ActivityBean.getStatusID()#.png" id="StatusIcon" /></td>
								<td>
									<select name="StatusChanger" id="StatusChanger">
										<option value="">No Status</option>
										<cfloop query="qStatuses">
										<option value="#qStatuses.StatusID#"<cfif ActivityBean.getStatusID() EQ qStatuses.StatusID> selected</cfif>>#qStatuses.Name#</option>
										</cfloop>
									</select>
								</td>
							</tr>
						</table>
					</div>
					
					<div id="Containers">
						
					</div>
					<div id="LatestActions">
						
					</div>
					<div id="ActivityStats">
						
					</div>
					<div id="ProcessQueue">
						<h3>Process Queue</h3>
						<p>
						<cfset qProcesses = Application.Com.ProcessGateway.getByAttributes(DeletedFlag="N",OrderBy="Title")>
						<select name="ProcessSelect" id="ProcessSelect">
							<option value="">-- Select --</option>
							<cfloop query="qProcesses">
							<option value="#qProcesses.ProcessID#">#qProcesses.Title#</option>
							</cfloop>
						</select>
						<br />This will place the Activity into a "Task" queue so that managers of this process will be notified and can track the life of the Activity.
						</p>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<cfif ParentBean.getSessionType() EQ "M">
	<div id="ActivityList" style="display:none;">
	<div class="ActivityLinks">
		<table width="<cfif BrowserDetect() CONTAINS "MSIE">95%<cfelse>100%</cfif>" cellspacing="0" cellpadding="0" border="0" class="ActivityRows">
			<tr id="Activity#Attributes.ParentActivityID#" <cfif Attributes.ParentActivityID EQ Attributes.ActivityID>class="CurrentActivityRow"<cfelse>class="ActivityRow"</cfif>>
				<td width="16" style="text-align:center;"><img src="/lms/_images/icons/book_open.png" border="0" align="absmiddle" /></td>
				<td width="16" style="text-align:center;"><img src="/lms/_images/icons/Status#ParentBean.getStatusID()#.png" border="0" align="absmiddle" /></td>
				<td width="70" style="text-align:center;">#DateFormat(ParentBean.getReleaseDate(),"mm/dd/yyyy")#</td>
				<td>#ParentBean.getTitle()#</td>
			</tr>
		<cfloop query="qSubActivities">
			<tr id="Activity#qSubActivities.ActivityID#" <cfif qSubActivities.ActivityID EQ Attributes.ActivityID>class="CurrentActivityRow"<cfelse>class="ActivityRow"</cfif>>
				<td width="16" style="text-align:center;"><img src="/lms/_images/icons/calendar_view_day.png" border="0" align="absmiddle" /></td>
				<td width="16" style="text-align:center;"><img src="/lms/_images/icons/Status#qSubActivities.StatusID#.png" border="0" align="absmiddle" /></td>
				<td width="70" style="text-align:center;">#DateFormat(qSubActivities.ReleaseDate,"mm/dd/yyyy")#</td>
				<td>#qSubActivities.Title#</td>
			</tr>
		</cfloop>
		</table>
	</div>
	</div>
	</cfif>
	<div id="ActivityDialogs">
		<cfif ParentBean.getSessionType() EQ "M"><a href="javascript:void(0);" id="ActivityDialogLink" style="text-decoration:none;<cfif Cookie.Settings.ActListOpen>display:none;</cfif>"><img src="/lms/_images/layers.gif" border="0" align="absmiddle" /> Open Activities</a></cfif><a href="javascript:void(0);" id="OverviewDialogLink" style="text-decoration:none;"><img src="/lms/_images/page.gif" border="0" align="absmiddle" /> Activity Overview</a><a href="javascript:void(0);" id="NotesDialogLink" style="text-decoration:none;<cfif Cookie.Settings.ActNotesOpen>display:none;</cfif>"><img src="/lms/_images/note.gif" border="0" align="absmiddle" /> Open Notes</a>
	</div>
	<div id="NotesList" style="display:none;">
		<iframe width="365" height="380" src="" id="frmNotes" frameborder="0" name="frmNotes" scrolling="auto"></iframe>
	</div>
	<div id="OverviewList" style="display:none;">
		<iframe width="733" height="500" src="" id="frmOverview" frameborder="0" name="frmOverview"></iframe>
	</div>
	<div id="CopyDialog" style="display:none;">
		<div style="padding:4px;">
		<input type="radio" name="CopyChoice" id="CopyChoice1" class="CopyChoice" value="1" checked="checked" /><label for="CopyChoice1"> Paste as new parent activity.</label><br />
		<input type="radio" name="CopyChoice" id="CopyChoice2" class="CopyChoice"  value="2" /><label for="CopyChoice2"> Paste as new session within this activity.</label>
		</div>
	</div>
	<div id="PhotoUpload" style="display:none;">
		<iframe width="440" height="110" scrolling="no" src="" frameborder="0" id="frmUpload"></iframe>
	</div>
	<div id="ProcessQueueDialog" style="display:none;overflow:auto;">
		<iframe width="550" height="350" scrolling="no" src="" frameborder="0" name="frmProcessQueue" id="frmProcessQueue"></iframe>
	</div>
	</cfif>
<div id="DisableActivity">
&nbsp;
</div>
</cfoutput>
