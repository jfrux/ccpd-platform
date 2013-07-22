<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.content" default="">
<cfparam name="Request.right" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">

<cfoutput>
<cfset params.id = attributes.activityid />
<cfset params.title = ActivityBean.getTitle() />
<cfset params.includekey = true />
<cfset params.profile_picture = ActivityBean.getPrimary_photo() />
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
//var cActShowInfobar = $.cookie("USER_ACTSHOWINFOBAR");

App.Activity.start({
  'id':nActivity,
  'folders':defaultFolders,
  'linkbarSettings':#serializeJson(request.tabSettings)#,
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

<cfset hub_classes = "type-#activitybean.getActivityTypeID()# grouping-#activitybean.getGroupingID()#" />
<cfif activitybean.getParentActivityId() EQ "">
  <cfset hub_classes &= " parent_activity" />
<cfelse>
  <cfset hub_classes &= " child_activity" />
</cfif>
</cfoutput>