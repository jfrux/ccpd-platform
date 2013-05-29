<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.content" default="">
<cfparam name="Request.right" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">

<cfinclude template="/_com/_UDF/isActivityEditable.cfm" />
<cfset qActCats = Application.Com.ActivityCategoryGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,DeletedFlag='N')>
<cfset qCats = Application.Com.CategoryGateway.getByAttributes(OrderBy="Name")>
<cfset qPersonalCats = Application.Com.CategoryGateway.getByCookie(TheList=Cookie.USER_Containers,OrderBy="Name")>
<cfset defaultValues = [] />
<cfloop query="qActCats">
  <cfset cat = {
    name: qActCats.Name,
    label: qActCats.Name,
    value:qActCats.categoryid
  } />

  <cfset defaultValues.add(cat) />
</cfloop>
<script>
var defaultFolders = <cfoutput>#serializeJson(defaultValues)#</cfoutput>;
//App.module("Activity.Folders").start(defaultValues);
</script>
<cfoutput>
  <script>
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
var cActShowInfobar = $.cookie("USER_ACTSHOWINFOBAR");

App.module('Activity').start({
  'id':nActivity,
  'folders':defaultFolders,
  'model':{
    id:nActivity,
    title:sActivityTitle,
    type:nActivityType,
    grouping:nGrouping
  }
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
  <div class="profile-bg">
    <div class="profile-bg-inner"></div>
  </div>
  <div class="row">
    <div class="span5">
      <cfoutput>
      <div class="projectbar js-projectbar">
        <div class="box">
          <div class="profile-picture" style="background-image:url(#imageUrl('default_photo/activity_p.png')#);">

          </div>
        </div>
        <div class="box js-profile-menu">
          #profileMenu(
            type="activity"
           ,typeid="#attributes.activityid#"
           ,settings="#request.tabSettings#"
           ,current="#Attributes.Fuseaction#"
          )#
        </div>
      </div>
      </cfoutput>
    </div>
    <div class="span19">
      <div class="titlebar">
        <div class="row-fluid">
          <div class="span16">
            <div class="ContentTitle">
              <span title="#HTMLSafe(ActivityBean.getTitle())#">#midLimit(ActivityBean.getTitle(),50)#</span></div>
              <!--- <cfif ActivityBean.getParentActivityID() NEQ ""><cfif Len(ParentBean.getTitle()) GT 75><span title="#ParentBean.getTitle()#">#left(ParentBean.getTitle(),50) & "..."#</span><cfelse>#ParentBean.getTitle()#</cfif> <cfelse>Parent Activity</cfif> // <cfif ParentBean.getSessionType() EQ "M">Multi-Session<cfelse>Single-Session</cfif> --->
            </div>
          <div class="span8">
            <div class="action-buttons pull-right">
              <div class="btn-group">
                <a href="javascript:void(0);" class="btn" title="Move Activity" id="MoveLink"><i class="icon-road"></i></a>
                <a href="javascript:void(0);" class="btn" title="Copy Activity" id="CopyLink"><i class="icon-doc"></i></a>
                <a href="javascript:void(0);" class="btn" title="Delete Activity" id="DeleteActivityLink"><i class="icon-trash"></i></a>
              </div>
              <div class="btn-group">
                <a class="btn js-toggle-infobar" title="Toggle Infobar"><i class="icon-info"></i></a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="span19">
      <div class="content js-profile-content">
        <cfoutput>
        <div class="row-fluid">
          <div class="span18 js-content-toggle">
            <div class="row-fluid">
              <div class="content-title">
                <h3>#request.tabSettings.tabs[lcase(attributes.fuseaction)].title#</h3>
              </div>
            </div>
            <div class="MultiFormContent content-inner">
              <div id="js-#replace(request.tabSettings.tabs[lcase(attributes.fuseaction)].event,'.','-')#">
              <cfif structKeyExists(variables,'multiformright')>
                <div class="toolbar">
                  #multiformright#
                </div>
              </cfif>
              <cfif structKeyExists(variables,'multiformcontent')>
                #multiformcontent#
              </cfif>
              </div>
            </div>
          </div>
          <div class="span6 js-infobar-outer">
            <div class="InfoBar infobar js-infobar">
              <cfset qStatuses = Application.Com.StatusGateway.getByAttributes(OrderBy="Name")>
              
              <div id="Status">
                <h3><i class="fg fg-fruit"></i> Activity Health</h3>
                <div class="box">
                  <div class="project-status activity-status js-activity-status">
                    <select name="StatusChanger" id="StatusChanger" class="span24">
                      <option value="">No Status</option>
                      <cfloop query="qStatuses">
                      <option value="#qStatuses.StatusID#"<cfif ActivityBean.getStatusID() EQ qStatuses.StatusID> selected</cfif>>#qStatuses.Name#</option>
                      </cfloop>
                    </select>
                  </div>


                  <div class="overview-buttons">
                    <div class="row-fluid">
                      <div class="btn-group span24">
                        <a href="javascript:void(0);" id="OverviewDialogLink" class="btn span12">Overview</a>
                        <a href="javascript:void(0);" id="ActivityDialogLink" class="btn span12<cfif ParentBean.getSessionType() NEQ "M"> disabled</cfif>">Related</a>
                      </div>
                    </div>
                  </div>
                  <div id="ActivityStats">
                    
                  </div>
                </div>
                
                
              </div>
                
              <div id="Containers">
                
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
</cfoutput>
