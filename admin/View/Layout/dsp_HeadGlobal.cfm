<cffunction name="stylesheet_link_tag">
	<cfargument name="source" type="string" required=true>
	<cfhttp method="get" url="http://localhost:3000/stylesheet_tags?file=#arguments.source#" result="css_markup">
		
	</cfhttp>

	<cfreturn css_markup.filecontent />
</cffunction>

<cffunction name="javascript_include_tag">
	<cfargument name="source" type="string" required=true>
	<cfhttp method="get" url="http://localhost:3000/javascript_tags?file=#arguments.source#" result="js_markup">
		
	</cfhttp>

	<cfreturn js_markup.filecontent />
</cffunction>
<cfoutput>
#stylesheet_link_tag("application")#
</cfoutput>
<!--- <!--[if lt IE 8]>
  <link href="/stylesheets/ie.css" media="screen, projection" rel="stylesheet" type="text/css" />
<![endif]--> --->
<link rel="SHORTCUT ICON" href="/favicon.ico" type="image/x-icon" />
<cfif application.settings.dsn NEQ "CCPD_PROD">
	<style>
	.header-bg {
	  background-color: LIME;
	  box-shadow: 0 3px 0 #000;
	}

	.data-source {
		position:absolute;
		color:#FFF;
		background-color:#FF0000;

	}
	</style>
</cfif>

<cfoutput>
#javascript_include_tag("vendors")#
#javascript_include_tag("application")#

<script src="#Application.Settings.RootPath#/_scripts/action_menu.js" language="javascript" type="text/javascript"></script>
</cfoutput>
<cfinclude template="js_global.cfm" />


