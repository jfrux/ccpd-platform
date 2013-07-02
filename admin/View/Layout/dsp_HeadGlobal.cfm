<cfparam name="request.page.responsive" default="false" />

<cfoutput>
#styleSheetLinkTag(sources="application",debug=false)#
<cfif request.page.responsive>
	#styleSheetLinkTag(sources="responsive",debug=false)#
</cfif>
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
#javascriptIncludeTag(source="vendors",debug=false)#
#javascriptIncludeTag(source="application",debug=false)#
</cfoutput>
<cfinclude template="js_global.cfm" />


