<cfset Request.NavItem = "2" />
<cfif isDefined('Attributes.ActivityID')>
  <cfset Request.MultiFormEditLabel = "Edit this activity" />
  <cfinvoke component="myFusebox" 
      method="do" fuseaction="mActivity.getActivity" />
  <cfinvoke component="myFusebox" 
      method="do" fuseaction="mActivity.getSubActivities" />
  <cfinvoke component="myFusebox" 
      method="do" fuseaction="mActivity.getLiveGroupings" />
  <cfinvoke component="myFusebox" 
      method="do" fuseaction="mActivity.getActivityTypes" />
  <cfinvoke component="myFusebox" 
      method="do" fuseaction="mActivity.TabControl" />
  <cfset Request.ActionsLimit = "4" />
  <cfset Request.Page.Title = "#ActivityBean.getTitle()#" />
  <cfset request.page.action = "#listLast(attributes.fuseaction,'.')#" />
  <cfset ActivityTitleShort = "#midLimit(Attributes.ActivityTitle,50)# // #DateFormat(ActivityBean.getStartDate(),'mm/dd/yyyy')#" />
  <cfinvoke component="myFusebox" 
      method="do" fuseaction="mActivity.getActions" />
  <cfset Request.editlink = "#myself#Activity.Detail?ActivityID=#Attributes.ActivityID#" />
</cfif>