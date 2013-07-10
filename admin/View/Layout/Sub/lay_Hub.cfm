<cfparam name="hub_classes" default="" />
<cfparam name="params.id" default="0" />
<cfparam name="params.controller" default="" />
<cfinclude template="includes/#params.controller#/pre.cfm" />
<cfoutput>
<div class="hub profile #lcase(params.controller)# #hub_classes#">
  <div class="hub-bg profile-bg">
    <div class="hub-bg-inner profile-bg-inner"></div>
  </div>
  <div class="hub-bar projectbar js-projectbar">
    <div class="box">
      <div class="profile-picture" style="background-image:url(#imageUrl('default_photo/activity_p.png')#);">

      </div>
    </div>
    <div class="box js-profile-menu">
      #profileMenu(
        type=params.controller
       ,typeid=params.id
       ,settings="#request.tabSettings#"
       ,current="#Attributes.Fuseaction#"
      )#
    </div>
  </div>
  <div class="hub-body project-body">
    <div class="titlebar">
      <div class="title-text">
        <div class="ContentTitle">
          <span title="#HTMLSafe(ActivityBean.getTitle())#">#midLimit(ActivityBean.getTitle(),50)#</span>
        </div>
      </div>
      <div class="title-actions">
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
    <div class="content js-profile-content">
      <div class="hub-content content-inner js-content-toggle">
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
      <div class="hub-infobar js-infobar-outer">
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
  </div>
 
  <cfinclude template="includes/#params.controller#/dialogs.cfm" />
</div>
</cfoutput>
