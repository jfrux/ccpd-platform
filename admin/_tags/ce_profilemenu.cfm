<cfparam name="attributes.settings" default="" />
<cfparam name="attributes.current" default="" />
<cfparam name="attributes.type" default="" />
<cfparam name="attributes.typeid" default="" />
<cfparam name="attributes.includekey" default="true" />

<cfoutput>
<cffunction name="isActive" returntype="boolean">
  <cfargument name="current" type="string">
  <cfargument name="tab" type="struct">
  <cfif (arguments.tab.event EQ arguments.current) OR (arrayFindNoCase(arguments.tab.subEvents,arguments.current))>
    <cfreturn true />
  <cfelse>
    <cfreturn false />
  </cfif>
</cffunction>

<div class="TabControl linkbar" id="Tabs">
  <div class="linkbar-inner">
  <ul class="nav">
    <cfloop from="1" to="#arrayLen(attributes.settings.tabsSort)#" index="i">
      <cfset key = attributes.settings.tabsSort[i] />
      <cfset tab = attributes.settings.tabs[key] />
      <cfset link = "/admin/event/#tab.event#" />
      <cfif attributes.includekey>
        <cfset link &= "?#attributes.type#id=#attributes.typeid#" />
      </cfif>
      <li class="<cfif isActive(attributes.current,tab)>active</cfif>">
        <cfsavecontent variable="tabLinkText">
          <i class="#tab.icon#"></i> <span>#tab.label#</span>
          <cfif structkeyExists(tab,'count')>
            <span class="navItemCount pull-right">#tab.count#</span>
          </cfif>
          <span class="menuArrow"></span>
        </cfsavecontent>
        <cfset tabLinkData = {
          'js-namespace':"js-#replace(tab.event,'.','-')#",
          'pjax-container':"##js-#replace(tab.event,'.','-')#",
          'pjax-title':"#tab.title#" ,
          'tooltip-title':"#tab.tooltip#",
          'data-icon':"#tab.icon#"
        } />

        #linkTo(href="#link#",data=tabLinkData,text=tabLinkText)#

        <cfif arrayLen(tab.subEvents) GT 0>
        <ul class="nav subnav">
          <cfloop from="1" to="#arrayLen(tab.subEvents)#" index="e">
            <cfset subkey = tab.subEvents[e] />
            <cfset subtab = attributes.settings.tabs[subkey] />
            <cfset sublink = "/admin/event/#subtab.event#" />
            <cfif attributes.includekey>
              <cfset sublink &= "?#attributes.type#id=#attributes.typeid#" />
            </cfif>
            <li class="<cfif isActive(attributes.current,subtab)>active</cfif>">
              <a href="#sublink#" 
                  data-pjax-title="#subtab.title#" 
                  data-tooltip-title="#subtab.tooltip#"
                  data-js-namespace="js-#replace(subtab.event,'.','-')#" 
                  data-pjax-container="##js-#replace(subtab.event,'.','-')#">
                <i class="#subtab.icon#"></i> <span>#subtab.label#</span>
                <cfif structkeyExists(subtab,'count')>
                  <span class="navItemCount pull-right">#subtab.count#</span>
                </cfif>
              </a>
            </li>
          </cfloop>
        </ul>
      </cfif>
      </li>

    </cfloop>
  </ul>
  </div>
</div>
</cfoutput>