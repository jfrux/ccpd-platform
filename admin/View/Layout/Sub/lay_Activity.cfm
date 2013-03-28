<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.MultiFormContent" default="">
<cfparam name="Request.MultiFormRight" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">

<cfinclude template="/_com/_UDF/isActivityEditable.cfm" />

<script>
<cfoutput>
var sLocation = sMyself + '#Attributes.Fuseaction#';
var nActivity = #Attributes.ActivityID#;
var sActivityTitle = "#jsStringFormat(attributes.activityTitle)#";
var nActivityType = #Attributes.ActivityTypeID#;
<cfif isDefined("attributes.groupingId") AND Attributes.GroupingID NEQ "">
  var nGrouping = #Attributes.GroupingID#;
<cfelse>
  var nGrouping = 0;
</cfif>
var cActNotesPosX = #getToken(Cookie.USER_ActNotesPos,1,",")#;
var cActNotesPosY = #getToken(Cookie.USER_ActNotesPos,2,",")#;
var cActNotesOpen = #Cookie.USER_ActNotesOpen#;
var cActListPosX = #getToken(Cookie.USER_ActListPos,1,",")#;
var cActListPosY = #getToken(Cookie.USER_ActListPos,2,",")#;
var cActListOpen = #Cookie.USER_ActListOpen#;
var cActListHeight = #GetToken(Cookie.USER_ActListSize,2,",")#;
var cActListWidth = #GetToken(Cookie.USER_ActListSize,1,",")#;

$(document).ready(function() {
  ce.activity.init('.activity');
})
  

</cfoutput>

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
  <div class="profile-bg">
    <div class="profile-bg-inner"></div>
  </div>
  <div class="row">
    <div class="span4">
      <cfoutput>
      <div class="projectbar">
        <div class="box">
          <div class="thumbnail">
          <img src="http://placehold.it/164x100">
          </div>
        </div>
        <div class="box">
          <cf_ce_profilemenu type="activity" typeid="#attributes.activityid#" settings="#request.tabSettings#" current="#Attributes.Fuseaction#">
        </div>
      </div>
      </cfoutput>
    </div>
    <div class="span20">
      <div class="titlebar">
        <div class="row-fluid">
          <div class="span20">
            <div class="ContentTitle">
              <span title="#HTMLSafe(ActivityBean.getTitle())#">#midLimit(ActivityBean.getTitle(),60)#</span></div>
              <!--- <cfif ActivityBean.getParentActivityID() NEQ ""><cfif Len(ParentBean.getTitle()) GT 75><span title="#ParentBean.getTitle()#">#left(ParentBean.getTitle(),50) & "..."#</span><cfelse>#ParentBean.getTitle()#</cfif> <cfelse>Parent Activity</cfif> // <cfif ParentBean.getSessionType() EQ "M">Multi-Session<cfelse>Single-Session</cfif> --->
            </div>
          <div class="span4">
            <div class="action-buttons pull-right">
              <a href="/activities/#attributes.activityid#" class="btn">View Activity</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="span20">
      <div class="content">
        <cfoutput>
        <div class="row-fluid">
          <div class="span18">
            <cfif len(trim(request.multiformright)) GT 0>
               <div class="row-fluid">
                <div class="toolbar">
                  <div class="btn-toolbar">
                  #Request.MultiFormRight#
                  </div>
                </div>
              </div>
            </cfif>
           
            <div class="MultiFormContent content-inner">
              #Request.MultiFormContent#
            </div>
          </div>
          <div class="span6">
            
            <div class="InfoBar infobar">
              <cfset qStatuses = Application.Com.StatusGateway.getByAttributes(OrderBy="Name")>
              <div id="Status">
                <h3><i class="fg fg-fruit"></i> Activity Health</h3>
                <div class="box">
                  <select name="StatusChanger" id="StatusChanger" class="span24">
                    <option value="">No Status</option>
                    <cfloop query="qStatuses">
                    <option value="#qStatuses.StatusID#"<cfif ActivityBean.getStatusID() EQ qStatuses.StatusID> selected</cfif>>#qStatuses.Name#</option>
                    </cfloop>
                  </select>

                  <div id="ActivityStats">

                  </div>
                </div>
                
                
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
              
              <!--- <div id="ProcessQueue">
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
              </div> --->
              <div id="GlobalOptions">
                <h3>Global Options</h3>
                <cfif ActivityBean.getParentActivityID() EQ "" AND ActivityBean.getSessionType() EQ "M"><cfelse><div style="padding:6px 4px;"><a href="javascript:void(0);" id="MoveLink" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/book_previous.png" align="absmiddle" style="padding-right:4px;" />Move Activity</a></div></cfif>
                <div style="padding:6px 4px;"><a href="javascript:void(0);" id="CopyLink" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/page_copy.png" align="absmiddle" style="padding-right:4px;" />Copy Activity</a></div>
                <div style="padding:6px 4px;"><a href="javascript://" id="DeleteActivityLink" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/book_delete.png" align="absmiddle" style="padding-right:4px;" />Delete Activity</a></div>
              </div>
            </div>
            
          </div>
        </div>
        </cfoutput>
      </div>
    </div>
  </div>
 
  <cfinclude template="includes/activity_dialogs.cfm" />
  </cfif>
</div>
</cfoutput>
