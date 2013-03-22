<cfcomponent extends="lms._core.fusebox5.Application" output="false">
	<!---
		sample Application.cfc for ColdFusion MX 7 and later compatible systems
	--->
		<cfset namekey = "f32f23f" />
	<!--- set application name based on the directory path --->
	<cfswitch expression="#CGI.SERVER_NAME#">
		<!--- PRODUCTION --->
		<cfcase value="ccpd.uc.edu">
			<cfset this.name = "CCPD_LMS_PRODUCTION_#namekey#" />
	
			<cfset THIS.CustomTagPaths = expandPath("/lms/_tags") />
			<!--- <cferror template="/lms/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/lms/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu"> --->
		</cfcase>
		
		<cfcase value="www.ccpd.uc.edu">
			<cflocation url="http://ccpd.uc.edu/lms/" addtoken="no" />
		</cfcase>
		
		<cfcase value="test.ccpd.uc.edu">
			<cfset this.name = "CCPD_LMS_TEST_#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "production" />
			
			<cfset THIS.CustomTagPaths = expandPath("/lms/_tags") />
			<cferror template="/lms/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/lms/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">
		</cfcase>

		<cfcase value="localhost">
			<cfset this.name = "CCPD_LMS_TEST_#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "production" />
			
			<cfset THIS.CustomTagPaths = expandPath("/lms/_tags") />
			<cferror template="/lms/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/lms/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">
		</cfcase>

		<cfcase value="v2.ccpd.uc.edu">
			<cfset this.name = "CCPD_LMS_TEST_#namekey#" />
			<cfset FUSEBOX_PARAMETERS.mode = "production" />
			
			<cfset THIS.CustomTagPaths = expandPath("/lms/_tags") />
		</cfcase>
	</cfswitch>
    
    
	<cfset this.clientManagement = true>
	<cfset this.clientStorage = "registry">
	<cfset this.loginStorage = "session">
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,60,0)>
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

</cfcomponent>