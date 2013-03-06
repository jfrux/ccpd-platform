<cfcomponent extends="admin._core.fusebox5.Application" output="false">
	<cfsilent>
	<!---
		sample Application.cfc for ColdFusion MX 7 and later compatible systems
	--->
		
	<!--- set application name based on the directory path --->
	
	<cfset namekey = "f32f23f" />
	<cfswitch expression="#CGI.SERVER_NAME#">
		<!--- PRODUCTION --->
		<cfcase value="ccpd.uc.edu">
			<cfset this.name = "CCPD_ADMIN_PRODUCTION_#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "production" />
			
			<cfset THIS.CustomTagPaths = expandPath("/admin/_tags") />

			<cferror template="/admin/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/admin/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">
		</cfcase>

		<!--- TEST --->
		<cfcase value="test.ccpd.uc.edu">
			<cfset this.name = "CCPD_ADMIN_TEST_#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "development-circuit-load" />
			
			<cfset THIS.CustomTagPaths = expandPath("/admin/_tags") />
		</cfcase>

		<!--- TEST --->
		<cfcase value="localhost">
			<cfset this.name = "CCPD_ADMIN_TEST_#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "development-circuit-load" />
			
			<cfset THIS.CustomTagPaths = expandPath("/admin/_tags") />
		</cfcase>

		<cfcase value="v2.ccpd.uc.edu">
			<cfset this.name = "CCPD_ADMIN_TEST_#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "development-circuit-load" />
			
			<cfset THIS.CustomTagPaths = expandPath("/admin/_tags") />
		</cfcase>
	</cfswitch>
	
	<cfset this.clientManagement = true>
	<cfset this.clientStorage = "registry">
	<cfset this.loginStorage = "session">
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,180,0)>
	<cfset this.setClientCookies = true>
	
	<!--- enable debugging --->
	<cfset FUSEBOX_PARAMETERS.debug = false />
	
	
	<!--- force the directory in which we start to ensure CFC initialization works: --->
	<cfset FUSEBOX_CALLER_PATH = getDirectoryFromPath(getCurrentTemplatePath()) & "_core\" />
	
	<!---
		if you define any onXxxYyy() handler methods, remember to start by calling
			super.onXxxYyy(argumentCollection=arguments)
		so that Fusebox's own methods are executed before yours
	--->
	</cfsilent>
</cfcomponent>