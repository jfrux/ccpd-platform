<cfparam name="Attributes.Instance" default="" />
<cfparam name="Attributes.Labels" default="" />
<cfparam name="Attributes.Fuseactions" default="" />
<cfparam name="Attributes.Current" default="" />
<cfparam name="url.Mini" default="" />

<cfset LabelCount = ListLen(Attributes.Labels,",")>
<cfset FuseCount = ListLen(Attributes.Fuseactions,",")>

<cfoutput>
<cfif LabelCount NEQ FuseCount>
	<cfexit>
</cfif>

<cfif Attributes.Labels EQ "">
	<cfexit>
</cfif>

<cfif Attributes.Fuseactions EQ "">
	<cfexit>
</cfif>

<div class="TabControl" id="Tabs#Attributes.Instance#">
	<ul>
<cfloop from="1" to="#LabelCount#" index="i">
		<li<cfif ListFindNoCase(GetToken(Attributes.Fuseactions,i,","),Attributes.Current,"|")> class="current"</cfif>><a href="#request.myself##GetToken(GetToken(Attributes.Fuseactions,i,","),1,"|")##Attributes.QueryString#<cfif url.Mini NEQ ''>&Mini=1</cfif>">#GetToken(Attributes.Labels,i,',')#</a></li>
</cfloop>
	</ul>
</div>
</cfoutput>