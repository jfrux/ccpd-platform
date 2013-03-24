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
<cfinclude template="/_com/_UDF/isActivityEditable.cfm" />
<script src="#Application.Settings.RootPath#/_scripts/action_menu.js" language="javascript" type="text/javascript"></script>
</cfoutput>
<script>
<cfoutput>
sLocation = sMyself + '#Attributes.Fuseaction#';
nActivity = #Attributes.ActivityID#;
sActivityTitle = "#jsStringFormat(attributes.activityTitle)#";
nActivityType = #Attributes.ActivityTypeID#;
<cfif isDefined("attributes.groupingId") AND Attributes.GroupingID NEQ "">
  nGrouping = #Attributes.GroupingID#;
<cfelse>
  nGrouping = 0;
</cfif>
cActNotesPosX = #getToken(Cookie.USER_ActNotesPos,1,",")#;
cActNotesPosY = #getToken(Cookie.USER_ActNotesPos,2,",")#;
cActNotesOpen = #Cookie.USER_ActNotesOpen#;
cActListPosX = #getToken(Cookie.USER_ActListPos,1,",")#;
cActListPosY = #getToken(Cookie.USER_ActListPos,2,",")#;
cActListOpen = #Cookie.USER_ActListOpen#;
cActListHeight = #GetToken(Cookie.USER_ActListSize,2,",")#;
cActListWidth = #GetToken(Cookie.USER_ActListSize,1,",")#;
</cfoutput>
function continueCopy() {
  var sNewActivityTitle = $("#NewActivityTitle").val();
  var nNewActivityType = $("#NewActivityType").val();
  var nNewGrouping = $("#NewGrouping").val();
  var nCopyChoice = $(".CopyChoice:checked").val();
  var nError = 0;
  
  if(nNewActivityType == "" && nCopyChoice == 1) {
    addError("Please select an activity type.",250,6000,4000);
    nError = nError + 1;
  }
  
  if(sNewActivityTitle == "") {
    addError("Please enter an activity title.",250,6000,4000);
    nError = nError + 1;
  }
  
  if(nError > 0) {
    return false;
  }
  
  if(nNewGrouping == "") {
    nNewGrouping = 0;
  }
  
  $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", 
    { method: "CopyPaste", Mode: nCopyChoice, NewActivityTitle: sNewActivityTitle, NewActivityTypeID: nNewActivityType, NewGroupingID: nNewGrouping, ActivityID: nActivity, ReturnFormat:"plain" },
    function(data) {
      if(data.STATUS) {
        window.location = sMyself + 'Activity.Detail?ActivityID=' + data.DATASET[0].activityid + '&Message=' + data.STATUSMSG;
      } else {
        addError(data.STATUSMSG,250,6000,4000);
      }
  });
}

function cancelCopy() {

}

function setCurrActivityType(nID) {
  $("#NewActivityType").val(nID);
  getGroupingList(nID);
}

function getGroupingList(nID) {
  $("#NewGrouping").removeOption("");
  $("#NewGrouping").removeOption(/./);
  
  $("#NewGrouping").ajaxAddOption(sRootPath + "/_com/AJAX_Activity.cfc", { method: "getGroupings", ATID: nID, returnFormat: "plain" }, false,
    function(data) {
    
    if($("#NewGrouping").val() != "") {
      $("#NewGrouping").val(nGrouping);
      $("#NewGroupingSelect").show();
    } else {
      $("#NewGrouping").val(0);
      $("#NewGroupingSelect").hide();
    }
  });
}

function updateAll() {
  updateStats();
  //updateActions();
  updateContainers();
  updateActivityList();
}

function updateStats() {
  $.post(sMyself + "Activity.Stats", { ActivityID: nActivity }, 
    function(data) {
      $("#ActivityStats").html(data);
  });
}

function updateActions() {
  /*$.post(sMyself + "Activity.ActionsShort", { ActivityID: nActivity }, 
    function(data) {
      $("#LatestActions").html(data);
  });*/
}

function updateContainers() {
  $.post(sMyself + "Activity.Container", { ActivityID: nActivity }, 
    function(data) {
      $("#Containers").html(data);
  });
}

function updateActivityList() {
  $.post(sMyself + "Activity.ActivityList", { ActivityID: nActivity },
      function(data){
      $("#ActivityList").html(data);
    });
}

function updateNoteCount() {
  $.post(sRootPath + "/_com/AJAX_Activity.cfc", { method: "getNoteCount", ActivityID: nActivity, returnFormat: "plain" }, 
    function(data){
      var nNoteCount =  $.ListGetAt($.Trim(data), 1, ".");
      
      $("#NoteCount").html("(" + nNoteCount + ")");
  });
}

/* ON DOM LOAD EVENTS */
$(document).ready(function() {
  //updateActions();
  updateContainers();
  updateStats();
  updateNoteCount()
  
  /* STATUS CHANGER */
  $("#StatusChanger").change(function() {
    var nStatus = $(this).val();
    
    if(nStatus == "") {
      addError("You must select a status.",250,6000,4000);
      return false;
    }
    
    $.post(sRootPath + "/_com/AJAX_Activity.cfc", { method: "updateActivityStatus", ActivityID: nActivity, StatusID: nStatus, returnFormat:"plain" },
      function(data){
      var cleanData = $.trim(data);
      updateActions();
      <cfif ListFind("Activity.Publish,Activity.PubGeneral,Activity.PubSites,Activity.PubBuilder,Activity.PubCategory,Activity.PubSpecialty",Attributes.Fuseaction,",")>
      updatePublishState();
      </cfif>
      addMessage("Activity status changed successfully!",250,6000,4000);
      });
    $("#StatusIcon").attr("src",sRootPath + "/admin/_images/icons/Status" + $(this).val() + ".png");
  });
  /* // END STATUS CHANGER */
  
  /* DIALOG WINDOWS */
  /* ACTIVITY DIALOG */
  $("#ActivityList").dialog({ 
    title:"Activity List",
    modal: false, 
    autoOpen: cActListOpen,
    height:cActListHeight,
    width:cActListWidth,
    position:[cActListPosX,cActListPosY],
    resizable: true,
    dragStop: function(ev,ui) {
      $.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActListPos', position: ui.position.left + "," + ui.position.top });
    },
    open:function() {
      updateActivityList();
      $("#ActivityList").show();
      $.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActListOpen', IsOpen: 'true' });
      $("#ActivityDialogLink").fadeOut();
      
    },
    close:function() {
      $("#ActivityList").html("");
      $("#ActivityDialogLink").fadeIn();
      $.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActListOpen', IsOpen: 'false' });
    },
    resizeStop:function(ev,ui) {
      $.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActListSize', Size: ui.size.width + ',' + ui.size.height });
    }
  });
  
  
  
  $("#ActivityDialogLink").click(function() {
    $("#ActivityList").dialog("open");
  });
  
  
  /* // END ACTIVITY DIALOG */
  
  /* MOVE DIALOG */
  $("#MoveDialog").dialog({ 
    title:"Move Activity",
    modal: true, 
    autoOpen: false,
    position:[150,150],
    buttons: { 
      Continue:function() {
        $.post(sRootPath + "/_com/AJAX_Activity.cfc", { method:'Move', FromActivityID: nActivity, ToActivityID: $("#ToActivity").val() }, function(data) {
          window.location=sMyself + 'Activity.Detail?ActivityID=' + nActivity + '&Message=Activity successfully moved.';
        });
        
      }, 
      Cancel:function() {
        $("#MoveDialog").dialog("close");
      }
    },
    height:200,
    width:450,
    resizable: false,
    draggable: true,
    open:function() {
      $("#MoveDialog").show();
    },
    close:function() {
      
    }
  });
  
  $("#MoveLink").click(function() {
    $("#MoveDialog").dialog("open");
  });
  /* // END MOVE DIALOG */
  
  /* COPY AND PASTE DIALOG */
  $("#CopyDialog").dialog({ 
    title:"Copy &amp; Paste Activity",
    modal: true, 
    autoOpen: false,
    position:[200,200],
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
        $("#CopyDialog").dialog("close");
      }
    },
    height:230,
    width:400,
    resizable: false,
    draggable: true,
    open:function() {
      $("#CopyDialog").show();
    },
    close:function() {
      cancelCopy()
    }
  });
  
  $("#CopyLink").click(function() {
    setCurrActivityType(nActivityType);
    $("#CopyDialog").dialog("open");
    $("#NewActivityTitle").val("Copy of " + sActivityTitle);
    $("#NewActivityTitle").focus();
    $("#NewActivityTitle").select();
  });
  
  $(".CopyChoice").change(function() {
    var sID = $.Replace(this.id, "CopyChoice", "");
    
    if(sID == 2) {
      $("#ParentActivityOptions").hide();
    } else {
      $("#ParentActivityOptions").show();
    }
  });
  
  $("#NewActivityType").bind("change", this, function() {
    var nID = $(this).val();
    
    if(nID != "") {
      getGroupingList(nID);
    } else {
      $("#NewGroupingSelect").hide();
      $("#NewGrouping").val("");
    }
  });
  /* // END COPY AND PASTE DIALOG */
  
  /* NOTES DIALOG */
  $("#NotesList").dialog({ 
    title:"Notes",
    modal: false, 
    autoOpen: cActNotesOpen,
    height:430,
    width:390,
    position:[cActNotesPosX,cActNotesPosY],
    resizable: false,
    dragStop: function(ev,ui) {
      $.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActNotesPos', position: ui.position.left + "," + ui.position.top });
    },
    open:function() {
      $("#NotesList").show();
      $("#frmNotes").attr("src",sMyself + "Activity.Notes?ActivityID=" + nActivity);
      $.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActNotesOpen', IsOpen: 'true' });
      $("#NotesDialogLink").fadeOut();
    },
    close:function() {
      updateNoteCount();
      
      $("#NotesDialogLink").fadeIn();
      $("#frmNotes").attr("src","javascript://");
      $.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActNotesOpen', IsOpen: 'false' });
    }
  });

  $("#NotesDialogLink").click(function() {
    $("#NotesList").dialog("open");
  });
  /* // END NOTES DIALOG */
  
  /* OVERVIEW DIALOG */
  $("#OverviewList").dialog({ 
    title:"Activity Overview",
    modal: false, 
    autoOpen: false,
    height:550,
    width:740,
    position: [100,100],
    resizable: true,
    open:function() {
      $.post(sMyself + "Activity.Overview", { ActivityID: nActivity },
        function(data) {
          $("#OverviewList").html(data);
      });
    },
    close:function() {
      $("#OverviewDialogLink").fadeIn();
      $("#OverviewList").html("");
    },
    buttons: { 
      Print:function() {
        $("#OverviewList").printArea();
      }, 
      Close:function() {
        $("#OverviewList").dialog("close");
      }
    }
  });

  $("#OverviewDialogLink").click(function() {
    $("#OverviewList").dialog("open");
  });
  /* // END OVERVIEW DIALOG */
  
  /* START DELETE ACTIVITY */
  $("#DeleteActivityLink").bind("click", this, function() {
    var sReason = prompt("Do you really want to delete '" + sActivityTitle + "'?  What is the reason?","");
    
    if(sReason != null && sReason != "") {
      $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", { method: "deleteActivity", ActivityID: nActivity, Reason: sReason, returnFormat: "plain" },
        function(data) {
          if(data.STATUS) {
            window.location = sMyself + "Activity.Home?Message=" + data.STATUSMSG;
          } else {
            addError(data.STATUSMSG,250,6000,4000);
          }
      });
    } else {
      addError('Please provide a reason.',250,6000,4000);
    } 
  });
  /* END DELETE ACTIVITY */
    
  /* PROCESS QUEUES DIALOG */
  $("#ProcessQueueDialog").dialog({ 
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
        $("#ProcessSelect").val("");
        $(this).dialog("close");
      }
    },
    height:400,
    width:560,
    resizable: false,
    open:function() {
      $("#ProcessQueueDialog").show();
    }
  });
  
  $("#ProcessSelect").change(function() {
    $("#frmProcessQueue").attr("src",sMyself + "Process.AddToQueue?ActivityID=" + nActivity + "&ProcessID=" + $(this).val());
    $("#ProcessQueueDialog").dialog("open");
  });
  
  $("#ProcessSelect").val("");
  /* // END PROCESS QUEUES DIALOG */
  /* // END DIALOG WINDOWS */
});
</script>

<cfset isParent = false />
<cfif activitybean.getGroupingID() EQ 2>
  <cfif activitybean.getParentActivityId() EQ "">
    <cfset isParent = true />
  <cfelse>
    <cfset isParent = false />
  </cfif>
</cfif>
<cfoutput>
<!--- <link href="#Application.Settings.RootPath#/_styles/Activity.css" rel="stylesheet" type="text/css" /> --->
<div class="activity profile type-#activitybean.getActivityTypeID()# grouping-#activitybean.getGroupingID()# <cfif activitybean.getParentActivityId() EQ "">parent_activity<cfelse>child_activity</cfif>">
<cfif ActivityBean.getDeletedFlag() EQ "Y">
    <div style="font-size:18px;color:##FF0000;">THIS ACTIVITY HAS BEEN DELETED.</div>
<cfelse>
  <div class="ContentTitle">
    <span title="#HTMLSafe(ActivityBean.getTitle())#">#midLimit(ActivityBean.getTitle(),75)# // #DateFormat(ActivityBean.getStartDate(),'mm/dd/yyyy')#</span></div>
    <div><cfif ActivityBean.getParentActivityID() NEQ ""><cfif Len(ParentBean.getTitle()) GT 75><span title="#ParentBean.getTitle()#">#left(ParentBean.getTitle(),50) & "..."#</span><cfelse>#ParentBean.getTitle()#</cfif> <cfelse>Parent Activity</cfif> // <cfif ParentBean.getSessionType() EQ "M">Multi-Session<cfelse>Single-Session</cfif>
  </div>
  <div class="row">
    <div class="span4 menu"><cf_ceTabControl Instance="MultiForm" Labels="#Request.MultiFormLabels#" Fuseactions="#Request.MultiFormFuseactions#" QueryString="#Request.MultiFormQS#" Current="#Attributes.Fuseaction#"></div>
    <div class="span20 content">
      <div class="row-fluid">
        <div class="MultiFormContent span18">
          #Request.MultiFormContent#
        </div>

        <div class="InfoBar span6">
          #Request.MultiFormRight#
          <cfset qStatuses = Application.Com.StatusGateway.getByAttributes(OrderBy="Name")>
          <div id="Status">
            <h3>Activity Status</h3>
            <table width="100%" cellspacing="1" border="0" cellpadding="2">
              <tr>
                <td>Status</td><td><div style="position:relative;"><img src="#Application.Settings.RootPath#/_images/icons/Status#ActivityBean.getStatusID()#.png" id="StatusIcon" style="position: absolute; left: 2px; top: -8px;" /></div></td>
                <td>
                  <select name="StatusChanger" id="StatusChanger" style="padding-left:16px;">
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
          <cfinclude template="#Application.Settings.RootPath#/Model/Report/act_getIssues.cfm" />
          <cfif qIssues.RecordCount GT 0>
          <div id="Issues">
            <h3>Issues</h3>
            <table width="100%">
            <cfloop query="qReasons">
              <tr>
                <td valign="top"><img src="#Application.Settings.RootPath#/_images/icons/flag_red.png" align="absmiddle" style="padding-right:4px;" /></td>
                <td valign="top">#Reason#</td>
              </tr>
            </cfloop>
            </table>
          </div>
          </cfif>
          <div id="ActivityStats">
            
          </div>
          <!---<div id="ProcessQueue">
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
          </div>--->
          <div id="GlobalOptions">
            <h3>Global Options</h3>
            <cfif ActivityBean.getParentActivityID() EQ "" AND ActivityBean.getSessionType() EQ "M"><cfelse><div style="padding:6px 4px;"><a href="javascript:void(0);" id="MoveLink" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/book_previous.png" align="absmiddle" style="padding-right:4px;" />Move Activity</a></div></cfif>
            <div style="padding:6px 4px;"><a href="javascript:void(0);" id="CopyLink" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/page_copy.png" align="absmiddle" style="padding-right:4px;" />Copy Activity</a></div>
            <div style="padding:6px 4px;"><a href="javascript://" id="DeleteActivityLink" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/book_delete.png" align="absmiddle" style="padding-right:4px;" />Delete Activity</a></div>
          </div>
        </div>
      </div>
  </div>
  <cfif ParentBean.getSessionType() EQ "M">
  <div id="ActivityList" style="display:none;">
    
  </div>
  </cfif>
  <div id="ActivityDialogs">
    <cfif ParentBean.getSessionType() EQ "M"><a href="javascript:void(0);" id="ActivityDialogLink" style="text-decoration:none;<cfif Cookie.USER_ActListOpen>display:none;</cfif>"><img src="#Application.Settings.RootPath#/_images/icons/layers.png" border="0" align="absmiddle" /> Open Activities</a></cfif>
        <a href="javascript:void(0);" id="OverviewDialogLink" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/page.png" border="0" align="absmiddle" /> Activity Overview</a>
        <a href="javascript:void(0);" id="NotesDialogLink" style="text-decoration:none;<cfif Cookie.USER_ActNotesOpen>display:none;</cfif>"><img src="#Application.Settings.RootPath#/_images/icons/note.png" border="0" align="absmiddle" /><span id="NoteCount"></span> Open Notes</a>
  </div>
  <div id="NotesList" style="display:none;">
    <iframe width="365" height="380" src="" id="frmNotes" frameborder="0" name="frmNotes" scrolling="auto"></iframe>
  </div>
  <div id="OverviewList" style="display:none;">
  </div>
  <div id="MoveDialog" style="display:none;">
    <div style="padding:4px;">
      <cfquery name="qMultiSessions" datasource="#Application.Settings.DSN#">
        SELECT ActivityID,Title,ReleaseDate FROM ce_Activity WHERE SessionType='M' AND ParentActivityID IS NULL AND DeletedFlag='N'
        ORDER BY Title
      </cfquery>
      <strong>Are you sure you want to move this activity?</strong><br />
      Select from the list below which Multi-Session Parent Activity you wish to move it to.
      <div style="padding:5px;">
      <strong>From:</strong> #ActivityBean.getTitle()#
      </div>
      <div style="padding:5px;">
      <strong>To:</strong>
      <select name="ToActivity" id="ToActivity" style="width:350px;">
      <option value="">Select Activity</option>
      <cfloop query="qMultiSessions">
        <option value="#qMultiSessions.ActivityID#">#qMultiSessions.Title# [#DateFormat(qMultiSessions.ReleaseDate,"mm/dd/yyyy")#]</option>
      </cfloop>
      </select>
      </div>
    </div>
  </div>
  <div id="CopyDialog" style="display:none;">
    <div style="padding:4px;">
            <input type="radio" name="CopyChoice" id="CopyChoice1" class="CopyChoice" value="1" checked="checked" /><label for="CopyChoice1"> Paste as new parent activity.</label><br />
            <input type="radio" name="CopyChoice" id="CopyChoice2" class="CopyChoice"  value="2"<cfif ActivityBean.getSessionType() EQ "S"> disabled="disabled"</cfif> /><label for="CopyChoice2"> Paste as new session within this activity.</label><br />
            <strong>Options</strong><br />
            Title: <input type="text" name="NewActivityTitle" id="NewActivityTitle" style="width: 300px;" />
            <div id="ParentActivityOptions">
            Activity Type: 
                <select name="NewActivityType" id="NewActivityType">
                    <option value="">Select one...</option>
                    <cfloop query="qActivityTypeList">
                        <option value="#qActivityTypeList.ActivityTypeID#">#qActivityTypeList.Name#</option>
                    </cfloop>
                </select>
                <span id="NewGroupingSelect" style="display:none;">
                <br />
                Grouping: 
                <select name="NewGrouping" id="NewGrouping">
                </select>
                </span>
            </div>
    </div>
  </div>
  <div id="CreditsDialog"></div>
  <div id="email-cert-dialog"></div>
  <div id="pifDialog">
    <div id="pifForm"></div>
  </div>
  <div id="PersonDetail">
    <iframe src="" width="840" height="500" frameborder="0" scrolling="auto" name="frameDetail" id="frameDetail"></iframe>
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
</div>
</cfoutput>
