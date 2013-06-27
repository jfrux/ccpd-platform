<!---
  fusebox.appinit.cfm is included by the framework when the application is
  started, i.e., on the very first request (in production mode) or whenever
  the framework is reloaded, either with development-full-load mode or when
  fusebox.load=true or fusebox.loadclean=true is specified.
  It is included within a cfsilent tag so it cannot generate output. It is
  intended to be for per-application initialization that can not easily be
  done in the appinit global fuseaction.
  It is included inside a conditional lock, ensuring that only one request
  can execute this file.
  
  For example, if you are sharing application variables between a Fusebox
  application and a non-Fusebox application, you can initialize them here
  and then cfinclude this file into your non-Fusebox application.
--->

<!--- APP SETTINGS --->
<cfset application['settings'] = StructNew() />
<cfset application['apiCache'] = {} />
<cfset application.settings['bugLogServer'] = "http://bugs.swodev.com" />
<cfset $_settings = application.settings />
<cfset request.CGI = CGI />
<cfinclude template="/lib/fusebox-addons/public.cfm" />
<cfswitch expression="#CGI.SERVER_NAME#">
  <!--- PRODUCTION --->
  <cfcase value="ccpd.uc.edu">
    <cfset set(environment = "production") />
  </cfcase>
  <cfcase value="test.ccpd.uc.edu">
    <cfset set(environment = "production") />
  </cfcase>
  <cfcase value="localhost">
    <cfset set(environment = "development") />
  </cfcase>
</cfswitch>
<cfinclude template="/lib/fusebox-addons/settings.cfm" />
<cfset set(asset_manifest = $loadAssetManifest()) />
<cfset set(asset_digests = get('asset_manifest').assets) />

<cfswitch expression="#get('environment')#">
  <cfcase value="production">
    <cfset set(showErrorInformation=true) />
    <cfset set(showDebugInformation = false) />
    <cfset set(webPath='/admin') />
    <cfset set(digest_assets=true) />
    <cfset set(compile_assets=true) />
    <cfset set(debug_assets=false) />
    <cfset set(asset_prefix='/public/assets') />
    <cfset set(assetPaths = {
      'http': CGI.SERVER_NAME & '/public/assets',
      'https': CGI.SERVER_NAME & '/public/assets'
    }) />
    <cfset set(imagePath = "") />
  </cfcase>
  <cfcase value="development">
    <cfset set(showErrorInformation=true) />
    <cfset set(showDebugInformation = false) />
    <cfset set(webPath='/admin') />
    <cfset set(digest_assets=true) />
    <cfset set(compile_assets=true) />
    <cfset set(debug_assets=true) />
    <cfset set(asset_prefix='/assets') />
    <cfset set(assetPaths = {
      'http':'localhost:8888/assets',
      'https':'localhost:8888/assets'
    }) />
    <cfset set(imagePath = "") />
  </cfcase>
</cfswitch>
<cfswitch expression="#CGI.SERVER_NAME#">
  <!--- PRODUCTION --->
  <cfcase value="ccpd.uc.edu">
    <cfset set(assetsUrl = "http://www.getmycme.com/assets")>
    <cfset set(apiUrl = "http://www.getmycme.com")>
    <cfset set(dsn = "CCPD_PROD")>
    <cfset set(appName = "CCPD")>
    <cfset set(rootPath = "/admin")>
    <cfset set(comPath = "/_com")>
    <cfset set(appPath = "/admin")>
    <cfset set(com = "_com.")>
    <cfset set(com2 = "admin._com.")>
    <cfset set(AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu")>
    <cfset set(WebURL = "https://ccpd.uc.edu/admin/")>
    <cfset set(LMSURL = "https://ccpd.uc.edu/")>
    <cfset set(CDCURL = "http://cme.uc.edu/stdptc")>
    <cfset set(javaloaderKey = "JAVALOADER-CCPD-PROD-15313")>
  </cfcase>
  
  <cfcase value="test.ccpd.uc.edu">
    <cfset set(assetsUrl = "http://localhost:3000/assets")>
    <cfset set(apiUrl = "http://localhost:3000")>
    <cfset set(dsn = "CCPD_PROD")>
    <cfset set(appName = "CCPD")>
    <cfset set(rootPath = "/admin")>
    <cfset set(comPath = "/_com")>
    <cfset set(appPath = "/admin")>
    <cfset set(Com = "_com.")>
    <cfset set(Com2 = "admin._com.")>
    <cfset set(AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu")>
    <cfset set(WebURL = "https://test.uc.edu/admin/")>
    <cfset set(LMSURL = "https://test.uc.edu/")>
    <cfset set(CDCURL = "http://cme.uc.edu/stdptc")>
    <cfset set(javaloaderKey = "JAVALOADER-CCPD-PROD-15313")>
  </cfcase>

  <cfcase value="localhost">
    <cfset set(assetsUrl = "http://localhost:9292/")>
    <cfset set(apiUrl = "http://localhost:3001")>
    <cfset set(dsn = "CCPD_CLONE")>
    <cfset set(appName = "CCPD")>
    <cfset set(rootPath = "/admin")>
    <cfset set(comPath = "/_com")>
    <cfset set(appPath = "/admin")>
    <cfset set(Com = "_com.")>
    <cfset set(Com2 = "admin._com.")>
    <cfset set(AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu")>
    <cfset set(WebURL = "https://test.uc.edu/admin/")>
    <cfset set(LMSURL = "https://test.uc.edu/")>
    <cfset set(CDCURL = "http://cme.uc.edu/stdptc")>
    <cfset set(javaloaderKey = "JAVALOADER-CCPD-PROD-15313")>
  </cfcase>

  <cfcase value="v2.ccpd.uc.edu">
    <cfset set(assetsUrl = "http://localhost:3000/assets")>
    <cfset set(apiUrl = "http://localhost:3000")>
    
    <cfset set(dsn = "CCPD_CLONE")>
    <cfset set(appName = "CCPD")>
    <cfset set(rootPath = "/admin")>
    <cfset set(comPath = "/_com")>
    <cfset set(appPath = "/admin")>
    <cfset set(Com = "_com.")>
    <cfset set(Com2 = "admin._com.")>
    <cfset set(AdminEmails = "rountrjf@ucmail.uc.edu,slamkajs@ucmail.uc.edu")>
    <cfset set(WebURL = "https://test.uc.edu/admin/")>
    <cfset set(LMSURL = "https://test.uc.edu/")>
    <cfset set(CDCURL = "http://cme.uc.edu/stdptc")>
    <cfset set(javaloaderKey = "JAVALOADER-CCPD-PROD-15313")>
  </cfcase>
</cfswitch>

<cfset request.cgi = CGI>


<!--- COMPONENTS --->
<cfinclude template="onapplicationstart.cfm" />