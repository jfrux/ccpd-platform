<cffunction name="$isTabActive" returntype="boolean">
  <cfargument name="current" type="string">
  <cfargument name="tab" type="struct">
  <cfif (arguments.tab.event EQ arguments.current) OR (arrayFindNoCase(arguments.tab.subEvents,arguments.current))>
    <cfreturn true />
  <cfelse>
    <cfreturn false />
  </cfif>
</cffunction>

<cffunction name="$profileMenu_renderItem" output="false">
  <cfargument name="tab" type="struct" required="true" />
  <cfargument name="settings" default="" />
  <cfargument name="current" default="" />
  <cfargument name="type" default="" />
  <cfargument name="typeid" default="" />
  <cfargument name="includekey" default="true" />
  <cfargument name="tabs" default="true" />
  
  <cfset var loc = {} />
  <cfset loc['tab'] = arguments.tab />
  <cfset loc['current'] = arguments.current />
  <cfset loc['options'] = arguments />
  <cfset loc.options.tabs = arguments.tabs />
  <cfsavecontent variable="itemOutput">
  <cfoutput>
    <li class="<cfif $isTabActive(arguments.current,loc.tab)>active</cfif>">
    <cfsavecontent variable="loc.tabLinkText">
      <i class="#loc.tab.icon#"></i> <div class="text">#loc.tab.label#</div>
      <cfif structkeyExists(loc.tab,'count')>
        <span class="navItemCount pull-right">#loc.tab.count#</span>
      </cfif>
      <span class="menuLoader icon-spin2 icon-spin"></span>
      <span class="menuArrow"></span>
    </cfsavecontent>

    <cfset loc.tabLinkData = {
      'js-namespace':"js-#replace(loc.tab.event,'.','-')#",
      'pjax-container':"##js-#replace(loc.tab.event,'.','-')#",
      'pjax-title':"#loc.tab.title#" ,
      'tooltip-title':"#loc.tab.tooltip#",
      'data-icon':"#loc.tab.icon#"
    } />

    #linkTo(href="#loc.tab.link#",data=loc.tabLinkData,text=loc.tabLinkText)#

    <cfif arrayLen(tab.subEvents) GT 0>
      <ul class="nav subnav">
        <cfloop from="1" to="#arrayLen(loc.tab.subEvents)#" index="e">
          <cfset subkey = loc.tab.subEvents[e] />
          <cfset loc.options.tab = arguments.tabs[subkey] />
          <cfset loc.options.tab.link = "/admin/event/#loc.options.tab.event#" />
          <cfif arguments.includekey>
            <cfset loc.options.tab.link &= "?#arguments.type#id=#arguments.typeid#" />
          </cfif>
          #$profileMenu_renderItem(argumentCollection=loc.options)#
        </cfloop>
      </ul>
    </cfif>
  </li></cfoutput>
  </cfsavecontent>

  <cfreturn itemOutput />
</cffunction>

<cffunction name="profileMenu" output="false">
  <cfargument name="settings" default="" />
  <cfargument name="current" default="" />
  <cfargument name="type" default="" />
  <cfargument name="typeid" default="" />
  <cfargument name="includekey" default="true" />

  <cfset var tabControl = "" />
  <cfset var options = arguments />
  <cfset options['tabs'] = arguments.settings.tabs />
  <cfsavecontent variable="tabControl">
  <cfoutput>
  <div class="TabControl linkbar" id="Tabs">
    <div class="linkbar-inner">
    <ul class="nav">
      <cfloop from="1" to="#arrayLen(arguments.settings.tabsSort)#" index="i">
        <cfset key = arguments.settings.tabsSort[i] />
        <cfset options['tab'] = arguments.settings.tabs[key] />
        <cfset options.tab['link'] = "/admin/event/#options.tab.event#" />
        <cfif arguments.includekey>
          <cfset options.tab.link &= "?#arguments.type#id=#arguments.typeid#" />
        </cfif>
        #$profileMenu_renderItem(argumentCollection=options)#
      </cfloop>
    </ul>
    </div>
  </div>
  </cfoutput>
  </cfsavecontent>

  <cfreturn tabControl />
</cffunction>