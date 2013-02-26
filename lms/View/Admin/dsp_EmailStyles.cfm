<cfquery name="qStyles" datasource="#Application.Settings.DSN#">
SELECT     EmailStyleID, Subject
FROM         ce_Sys_EmailStyle
WHERE     (0 = 0)
ORDER BY Subject
</cfquery>
<cfoutput>
<h1>#Request.Page.Title#</h1>
<strong><a href="#myself#Admin.EmailStyle">Create Email Style</a></strong>
<div class="listitem">
	<cfloop query="qStyles">
	<div class="listitem-detail">
		- <a href="#myself#Admin.EmailStyle?EmailStyleID=#qStyles.EmailStyleID#">#qStyles.Subject#</a>
	</div>
	<div class="listitem-options">
		
	</div>
	</cfloop>
</div>
</cfoutput>