<cfcomponent displayname="typeahead ajax" hint="This component returns JSON responses formatted for all typeahead elements in the user interface based on full-text search." output="no">
	<!--- TODO: needs application scope AJAX caching and search queries should be in a service object instead of here. --->
	<cfset variables.allowedTypes = "activity,all,city,country,credits,degrees,entities,folders,occupation,person,specialties,state" />
	<cfset variables.returnVar = createObject("component","_com.returnData.buildStruct").init(status=false,statusMsg="Unable to access Type Ahead functionality.") />

    <cffunction name="resetReturnVar" hint="Resets values for the return data struct." access="private" output="false" returntype="void">
    	<cfset variables.returnVar.setStatus(false) />
        <cfset variables.returnVar.setStatusMsg("Unable to access search functionality.") />
        <cfset variables.returnVar.setPayload("[]") />
    </cffunction>
	
	<cffunction name="search" access="remote" hint="general full-text search across multiple data objects for search" output="false" returnformat="plain">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="0" />
		<cfargument name="type" type="string" required="no" default="all" />
		
		<cfset var results = "" />
		<cfset var payload = structNew() />
		
		<cfif NOT listFindNoCase(variables.allowedTypes,arguments.type,",")>
			<cfset variables.returnVar.setStatusMsg("INVALID TYPE: #arguments.type# (allowed types: #variables.allowedTypes#") />
			
			<cfreturn variables.returnVar.getJSON() />
			<cfabort>
		</cfif>
		
		<cfset results = evaluate("application.search.#arguments.type#(arguments.q,arguments.max)") />
		
		<cfset payload.dataset = application.udf.querytostruct(results) />
		<cfset variables.returnVar.setStatus(true) />
		<cfset variables.returnVar.setStatusMsg("Success") />
		<cfset variables.returnVar.setPayload(payload) />
		
		<cfcontent type="text/javascript">
		
		<cfreturn variables.returnVar.getJSON() />
        
        <cfset this.resetReturnVar() />
	</cffunction>
</cfcomponent>