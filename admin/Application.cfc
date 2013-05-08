<cfcomponent extends="admin._core.fusebox5.Application" output="false">
  <cfsilent>
  <!---
    sample Application.cfc for ColdFusion MX 7 and later compatible systems
  --->
    
  <!--- set application name based on the directory path --->
  <cfset namekey = "6+3f254f62" />
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
  <cfset this.clientStorage = "ccpd_clone">
  <cfset this.loginStorage = "session">
  <cfset this.sessionManagement = true>
  <cfset this.sessionStorage = "ccpd_clone">
  <cfset this.sessionTimeout = createTimeSpan(0,0,180,0)>
  <cfset this.setClientCookies = true>
  
  <!--- enable debugging --->
  <cfset FUSEBOX_PARAMETERS.debug = false />
  
  
  <!--- force the directory in which we start to ensure CFC initialization works: --->
  <cfset FUSEBOX_CALLER_PATH = getDirectoryFromPath(getCurrentTemplatePath()) & "_core\" />

  <cffunction name="onCFCRequest" access="public" returntype="void" output="true" hint="I process the user's CFC request.">
    <cfargument name="component" type="string" required="true" hint="I am the component requested by the user."/>
    <cfargument name="methodName" type="string" required="true" hint="I am the method requested by the user." /> 
    <cfargument name="methodArguments" type="struct" required="true" hint="I am the argument collection sent by the user." />

    <cfif !structKeyExists(application.apiCache, arguments.component)>
      <cfset application.apiCache[arguments.component] = createObject("component",arguments.component).init()/>
    </cfif>

    <cfset local.cfc = application.apiCache[arguments.component] />
    
    <cfinclude template="/lib/fusebox-addons/helpers.cfm" />
    <cfset params = $paramParser() />
    
    <cfinvoke returnvariable="local.result" component="#local.cfc#" method="#arguments.methodName#" argumentcollection="#params#" />
    
    <cfset local.responseData = "" />
    <cfset local.responseMimeType = "text/plain" />

    <cfif structKeyExists( local, "result" )>
      <cfif structKeyExists( local.cfc, arguments.methodName )>
        <!--- Get target method return format. --->
        <cfparam name="params.returnFormat" type="string" default="#getMetaData( local.cfc[ arguments.methodName ] ).returnFormat#" />
      <cfelseif structKeyExists( local.cfc, "onMissingMethod" )>
        <!--- Get on missing method return format. --->
        <cfparam name="params.returnFormat" type="string" default="#getMetaData( local.cfc[ 'onMissingMethod' ] ).returnFormat#" />
      </cfif>

      <cfif (params.returnFormat eq "json")>
        <cfset local.responseData = serializeJSON( local.result ) />
        <cfset local.responseMimeType = "text/x-json" />
         
      <cfelseif (params.returnFormat eq "wddx")>
        <cfwddx
        action="cfml2wddx"
        input="#local.result#"
        output="local.responseData"
        />
        <cfset local.responseMimeType = "text/xml" />
       
      <cfelse>
        <cfset local.responseData = local.result />
         
        <cfset local.responseMimeType = "text/plain" />
         
      </cfif>
    </cfif>
    <cfset local.binaryResponse = toBinary(
      toBase64( local.responseData )
    ) />
     
    <cfheader
      name="content-length"
      value="#arrayLen( local.binaryResponse )#"
    />
    <cfcontent
      type="#local.responseMimeType#"
      variable="#local.binaryResponse#"
    />

    <cfreturn />
  </cffunction>
  <!---
    if you define any onXxxYyy() handler methods, remember to start by calling
      super.onXxxYyy(argumentCollection=arguments)
    so that Fusebox's own methods are executed before yours
  --->
  </cfsilent>
</cfcomponent>