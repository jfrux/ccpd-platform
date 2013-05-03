<cfif ParentBean.getSessionType() EQ "M">
  <div id="ActivityList" class="dialog">
    
  </div>
  </cfif>
  
  <div id="OverviewList" class="dialog">
  </div>
  <div id="MoveDialog" class="dialog">
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
  <div id="PersonDetail" class="dialog">
    <iframe src="" width="840" height="500" frameborder="0" scrolling="auto" name="frameDetail" id="frameDetail"></iframe>
  </div>
  <div id="CopyDialog" class="dialog">
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
  <div id="CreditsDialog" class="dialog"></div>
  <div id="email-cert-dialog" class="dialog"></div>

  

  <div id="PhotoUpload" class="dialog">
    <iframe width="440" height="110" scrolling="no" src="" frameborder="0" id="frmUpload"></iframe>
  </div>
  
  <div id="DisableActivity" class="dialog">
  &nbsp;
  </div>