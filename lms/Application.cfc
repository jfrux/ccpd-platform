<cfcomponent extends="lms._core.fusebox5.Application" output="false">
	<!---
		sample Application.cfc for ColdFusion MX 7 and later compatible systems
	--->
		
	<!--- set application name based on the directory path --->
	<cfswitch expression="#CGI.SERVER_NAME#">
		<!--- PRODUCTION --->
		<cfcase value="ccpd.uc.edu">
			<cfset this.name = "CCPD_LMS_PRODUCTION" />
	
			<cferror template="/lms/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/lms/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">
		</cfcase>
		
		<cfcase value="www.ccpd.uc.edu">
			<cflocation url="http://ccpd.uc.edu/lms/" addtoken="no" />
		</cfcase>
		
		<cfcase value="test.ccpd.uc.edu">
			<cfset this.name = "CCPD_LMS_TEST" />
			<cfset FUSEBOX_PARAMETERS.mode = "production" />
			
			<cferror template="/lms/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/lms/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">
		</cfcase>
		
		<cfcase value="dev1.ccpd.uc.edu">
			<cfset this.name = "CCPD_LMS_DEV1" />
			<cfset FUSEBOX_PARAMETERS.mode = "development-circuit-load" />
			<!---
			<cferror template="/lms/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/lms/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">
			</cfif>--->
		</cfcase>
		
		<cfcase value="dev2.ccpd.uc.edu">
			<cfset this.name = "CCPD_LMS_DEV2" />
			<cfset FUSEBOX_PARAMETERS.mode = "development-circuit-load" />
			<!---
			<cferror template="/lms/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/lms/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">
			</cfif>--->
		</cfcase>

		<cfcase value="10.97.106.160">
			<cfset this.name = "CCPD_LMS_OTHER" />
			<cfset FUSEBOX_PARAMETERS.mode = "development-circuit-load" />
			<!---
			<cferror template="/lms/error.cfm" type="exception" mailto="rountrjf@ucmail.uc.edu">
			<cferror template="/lms/error.cfm" type="request" mailto="rountrjf@ucmail.uc.edu">
			</cfif>--->
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