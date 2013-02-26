<cfoutput>
<div class="MultiFormRight_LinkList">
	<a href="#myself#Activity.Application?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.Application"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/application_view_list.png" align="absmiddle" style="padding-right:4px;" />Application</a>
	<a href="#myself#Activity.Agenda?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.Agenda"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/calendar.png" align="absmiddle" style="padding-right:4px;" />Agenda</a>
	<a href="#myself#Activity.CDCInfo?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.CDCInfo"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/bug.png" align="absmiddle" style="padding-right:4px;" />CDC Information</a>
	<a href="#myself#Activity.accme?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.accme"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/asterisk_yellow.png" align="absmiddle" style="padding-right:4px;" />ACCME Information</a>
	<!---<a href="#myself#Activity.Meals?ActivityID=#Attributes.ActivityID#"<cfif Attributes.Fuseaction EQ "Activity.Meals"> id="MultiFormRight_CurrentLink"</cfif>><img src="#Application.Settings.RootPath#/_images/icons/basket.png" align="absmiddle" style="padding-right:4px;" />Meals</a>--->
</div>
</cfoutput>