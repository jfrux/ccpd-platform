<cfparam name="attributes.settings" default="" />
<cfparam name="attributes.current" default="" />
<cfparam name="attributes.type" default="" />
<cfparam name="attributes.typeid" default="" />

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

      <li class="<cfif isActive(attributes.current,tab)>active</cfif>">
        <a href="/admin/event/#tab.event#?#attributes.type#id=#attributes.typeid#" title="#tab.tooltip#">
          <i class="fg-#tab.icon#"></i> <span>#tab.label#</span>
          <cfif structkeyExists(tab,'count')>
            <span class="navItemCount pull-right">#tab.count#</span>
          </cfif>
        </a>
      </li>
      <cfif arrayLen(tab.subEvents) GT 0>
        <ul class="nav subnav<cfif !isActive(attributes.current,tab)> hide</cfif>">
          <cfloop from="1" to="#arrayLen(tab.subEvents)#" index="e">
            <cfset subkey = tab.subEvents[e] />
            <cfset subtab = attributes.settings.tabs[subkey] />
            <li class="<cfif isActive(attributes.current,subtab)>active</cfif>">
              <a href="/admin/event/#subtab.event#?#attributes.type#id=#attributes.typeid#" title="#subtab.tooltip#">
                <i class="fg-#subtab.icon#"></i> <span>#subtab.label#</span>
                <cfif structkeyExists(subtab,'count')>
                  <span class="navItemCount pull-right">#subtab.count#</span>
                </cfif>
              </a>
            </li>
          </cfloop>
        </ul>
      </cfif>
    </cfloop>
  </ul>
  </div>
</div>
</cfoutput>