<cfcomponent extends="admin._core.fusebox5.Application" output="false">
	<cfsilent>
	<!---
		sample Application.cfc for ColdFusion MX 7 and later compatible systems
	--->
		
	<!--- set application name based on the directory path --->
	
	<cfset namekey = "f32f23f23f" />
	<cfswitch expression="#CGI.SERVER_NAME#">
		<!--- PRODUCTION --->
		<cfcase value="ccpd.uc.edu">
			<cfset this.name = "ADMIN-LIVE-#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "production" />
			
			<!---<cferror template="/admin/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/admin/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">--->
		</cfcase>


		<!--- PRODUCTION --->
		<cfcase value="localhost">
			<cfset this.name = "ADMIN-LIVE-#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "production" />
			
			<!---<cferror template="/admin/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/admin/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">--->
		</cfcase>

		<!--- TEST --->
		<cfcase value="test.ccpd.uc.edu">
			<cfset this.name = "ADMIN-TEST-#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "production" />
			
			<cferror template="/admin/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/admin/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">
		</cfcase>

		<cfcase value="dev1.ccpd.uc.edu">
			<cfset this.name = "ADMIN-DEV1-#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "development-circuit-load" />
			
			<!---<cferror template="/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">--->
		</cfcase>
		
		<cfcase value="dev2.ccpd.uc.edu">
			<cfset this.name = "ADMIN-DEV2-#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "development-circuit-load" />
			
			<!---<cferror template="/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">--->
		</cfcase>

		<cfcase value="10.97.106.160">
			<cfset this.name = "ADMIN-MOVE-#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "development-circuit-load" />
			
			<!---<cferror template="/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">--->
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