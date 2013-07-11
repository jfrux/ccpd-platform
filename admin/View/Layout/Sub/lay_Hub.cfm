<cfparam name="hub_classes" default="" />
<cfparam name="params.id" default="0" />
<cfparam name="params.controller" default="" />
<cfinclude template="includes/#params.controller#/pre.cfm" />
<cfoutput>
<div class="hub profile #lcase(params.controller)# #hub_classes#">
  <!--- <div class="hub-bg profile-bg">
    <div class="hub-bg-inner profile-bg-inner"></div>
  </div> --->
  <div class="hub-bar projectbar js-projectbar">
    <div class="box">
      <div class="profile-picture" style="background-image:url(#imageUrl('default_photo/activity_p.png')#);"></div>
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
        <div class="action-buttons">
          <cfinclude template="includes/#params.controller#/action_buttons.cfm" />
        </div>
      </div>
    </div>
    <div class="content js-profile-content">
      <div class="hub-content content-inner js-content-toggle">
        <div class="content-title">
          <h3>#request.tabSettings.tabs[lcase(attributes.fuseaction)].title#</h3>
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
        <div class="infobar-point"></div>
        <div class="InfoBar infobar js-infobar">
          <cfinclude template="includes/#params.controller#/infobar.cfm" />
        </div>
      </div>
    </div>
  </div>
 
  <cfinclude template="includes/#params.controller#/dialogs.cfm" />
</div>
</cfoutput>
