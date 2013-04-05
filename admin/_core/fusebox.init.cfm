<!---
	fusebox.init.cfm is included by the framework at the start of every request.
	It is included within a cfsilent tag so it cannot generate output. It is
	intended to be for per-request initialization and manipulation of the
	Fusebox fuseaction variables.
	
	You can set attributes.fuseaction, for example, to override the default
	fuseaction.
	
	A typical usage is to set "self" and "myself" variables, as shown below,
	for use inside display fuses when creating links.

	Fusebox 5 and earlier - set variables explicitly:
	<cfset self = "index.cfm" />
	<cfset myself = "#self#?#myFusebox.getApplication().fuseactionVariable#=" />
	
	Fusebox 5.1 and later - set variables implicitly from the Fusebox itself.
	
	Could also modify the self location here:
	<cfset myFusebox.setSelf("/myapp/start.cfm") />
--->
<cfset self = myFusebox.getSelf() />
<cfset myself = "/admin/event/" />

<cfset request.self = myFusebox.getSelf() />
<cfset request.myself = myself />
<cfset request.isException = false />

<cfset scriptExceptions = [
	"statFixer.cfc",
	"dailyStatusUpdater.cfc",
	"upload.cfc"
]>
<cfsetting showdebugoutput="no" />
<cfloop from="1" to="#arrayLen(scriptExceptions)#" index="i">
	<cfset script = scriptExceptions[i]>
	
	<cfif CGI.SCRIPT_NAME CONTAINS script>
		<cfset request.isException  = true />
	</cfif>
</cfloop>

<cffunction name="isAjax">
	<cfset headers = GetHttpRequestData().headers>
	<cfif structKeyExists( headers, "X-Requested-With" ) AND headers[ "X-Requested-With" ] EQ "XMLHttpRequest">
		<cfreturn true />
	<cfelse>
		<cfreturn false />
	</cfif>
</cffunction>

<cffunction name="isPjax">
	<cfset headers = GetHttpRequestData().headers>
	<cfif structKeyExists(headers, "X-PJAX")>
		<cfreturn true />
	<cfelse>
		<cfreturn false />
	</cfif>
</cffunction>
<!---
<cfparam name="Request.Status.Errors" default="" />
WE ARE PREPARING FOR A MIGRATION.<br />
The service should be back up shortly.<br />
<cfabort>--->
<cfinclude template="/admin/Model/Page/act_Access.cfm" />