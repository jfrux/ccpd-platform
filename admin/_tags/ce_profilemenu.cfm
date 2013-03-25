<cfparam name="attributes.settings" default="" />
<cfparam name="attributes.current" default="" />
<cfparam name="attributes.type" default="" />
<cfparam name="attributes.typeid" default="" />

<cfoutput>
<div class="TabControl linkbar" id="Tabs">
  <div class="linkbar-inner">
  <ul class="nav">
    <cfloop from="1" to="#arrayLen(attributes.settings.tabsSort)#" index="i">
      <cfset key = attributes.settings.tabsSort[i] />
      <cfset tab = attributes.settings.tabs[key] />
    <li class=""><a href="/admin/event/#tab.event#?#attributes.type#id=#attributes.typeid#"><i class="fg-#tab.icon#"></i> <span>#tab.label#</span></a></li>
    </cfloop>
  </ul>
  </div>
</div>
</cfoutput>