<cfparam name="hub_classes" default="" />
<cfparam name="params.id" default="0" />
<cfparam name="params.title" default="" />
<cfparam name="params.controller" default="" />
<cfparam name="params.profile_picture" default="" />
<cfparam name="params.has_infobar" type="boolean" default=true />
<cfinclude template="includes/#params.controller#/pre.cfm" />
<cfoutput>
<div class="hub profile #lcase(params.controller)# #hub_classes#<cfif params.has_infobar> infobar-active</cfif>">
  <div class="hub-bar projectbar js-projectbar">
    <div class="box">
      <cfif params.controller NEQ "main">
        <cfif len(trim(params.profile_picture)) GT 0>
          <cfset profile_picture_url = pictureUrl(params.profile_picture,"p") />
        <cfelse>
          <cfset profile_picture_url = imageUrl('default_photo/#lcase(params.controller)#_p.png') />
        </cfif>
      <div class="profile-picture" style="background-image:url(#profile_picture_url#);"></div>
      </cfif>
      <div class="user-profile-area">
        <div class="user-picture" style="background-image:url(#pictureUrl(session.person.getprimary_photo(),"i")#);"></div>
        <div class="user-links">
          #linkTo(controller="person",action="detail",params="personid=#session.person.getPersonId()#",text='#session.person.getCertName()#')#
          <br />
          #linkTo(controller="person",action="detail",params="personid=#session.person.getPersonId()#",text='Edit Profile')#
        </div>
      </div>
    </div>
    <div class="box js-profile-menu js-hub-menu">
      <div id="Tabs" class="TabControl linkbar">
        <div class="linkbar-inner">
          <ul class="nav">

          </ul>
         </div>
      </div>
      <!--- #profileMenu(
        type=params.controller
       ,typeid=params.id
       ,includekey=#params.includekey#
       ,settings="#request.tabSettings#"
       ,current="#Attributes.Fuseaction#"
      )# --->
    </div>
  </div>
  <div class="hub-body project-body">
    <div class="titlebar">
      <div class="title-text">
          #params.title#
      </div>
      <div class="title-actions">
        <div class="action-buttons">
          <cfinclude template="includes/#lcase(params.controller)#/action_buttons.cfm" />
        </div>
      </div>
    </div>
    <div class="content js-profile-content">
      <div class="hub-content js-content-toggle">
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
      <cfif params.has_infobar>
        <div class="hub-infobar js-infobar-outer">
          <div class="infobar-point"></div>
          <div class="InfoBar infobar js-infobar">
            <cfinclude template="includes/#params.controller#/infobar.cfm" />
          </div>
        </div>
      </cfif>
    </div>
  </div>
 
  <cfinclude template="includes/#params.controller#/dialogs.cfm" />
</div>
</cfoutput>
