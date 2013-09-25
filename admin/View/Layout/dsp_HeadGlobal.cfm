<cfparam name="request.page.responsive" default="false" />

<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<cfoutput>
#styleSheetLinkTag(sources="vendors",debug=false)#
#styleSheetLinkTag(sources="application",debug=false)#
#styleSheetLinkTag(sources="responsive",debug=false)#
<!--- <cfif request.page.responsive>
	#styleSheetLinkTag(sources="responsive",debug=false)#
</cfif> --->
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
#javascriptIncludeTag(source="ckeditor/ckeditor",debug=false)#
#javascriptIncludeTag(source="vendors",debug=false)#
#javascriptIncludeTag(source="application",debug=false)#


</cfoutput>
<cfinclude template="js_global.cfm" />


