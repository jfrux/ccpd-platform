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

  <div id="PersonDetail">
    <iframe src="" width="840" height="500" frameborder="0" scrolling="auto" name="frameDetail" id="frameDetail"></iframe>
  </div>

  <div id="PhotoUpload" style="display:none;">
    <iframe width="440" height="110" scrolling="no" src="" frameborder="0" id="frmUpload"></iframe>
  </div>
  
  <div id="DisableActivity">
  &nbsp;
  </div>