<cfparam name="attributes.tabs" default="" />
<cfparam name="attributes.tabOrder" default="" />
<cfparam name="attributes.current" default="" />

<cfoutput>
<div class="TabControl linkbar" id="Tabs">
  <div class="linkbar-inner">
  <ul class="nav">
    <cfloop from="1" to="#LabelCount#" index="i">
    <li class="<cfif ListFindNoCase(GetToken(Attributes.Fuseactions,i,","),Attributes.Current,"|")>active </cfif>#replace(lcase(GetToken(GetToken(Attributes.Fuseactions,i,","),1,"|")),'.','_')#"><a href="#request.myself##GetToken(GetToken(Attributes.Fuseactions,i,","),1,"|")##Attributes.QueryString#<cfif url.Mini NEQ ''>&Mini=1</cfif>">#GetToken(Attributes.Labels,i,',')#</a></li>
    </cfloop>
  </ul>
  </div>
</div>
</cfoutput>