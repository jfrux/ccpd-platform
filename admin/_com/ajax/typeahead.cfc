<cfcomponent displayname="typeahead ajax" hint="This component returns JSON responses formatted for all typeahead elements in the user interface based on full-text search." output="no">
	<!--- TODO: needs application scope AJAX caching and search queries should be in a service object instead of here. --->
	
		<cfprocessingdirective pageencoding="UTF-8">
		<cfset variables.allowedTypes = "activity,all,city,country,credits,degrees,entities,folders,occupation,person,specialties,state" />
	<cfset variables.returnVar = createObject("component","_com.returnData.buildStruct").init(status=false,statusMsg="Unable to access Type Ahead functionality.") />
    
    <cffunction name="add" access="remote" hint="general add function for typehead objects." output="false" returnFormat="plain">
    	<cfargument name="name" type="string" required="no" default="" />
        <cfargument name="type" type="string" required="no" default="" />
        
        <cfif len(trim(arguments.name)) EQ 0>
        	<cfset variables.returnVar.addError("Name","You must provide the Value you would like to add.")>
        </cfif>
        
        <cfif len(trim(arguments.type)) EQ 0>
        	<cfset variables.returnVar.addError("Type","You must provide the Type of the value you would like to add.")>
        </cfif>
        
        <cfif arrayLen(variables.returnVar.getErrors()) EQ 0>
			<cfset variables.returnVar.setPayload(evaluate("application.add.#arguments.type#(arguments.name)")) />
            <cfset variables.returnVar.setStatus(true) />
            <cfset variables.returnVar.setStatusMsg("Value exists.") />
        <cfelse>
        	<cfset variables.returnVar.setStatusMsg("Please correct errors before continuing.")>
        </cfif>
        
        <cfreturn variables.returnVar.getJSON() />
        
        <cfset this.resetReturnVar() />
    </cffunction>
    
    <cffunction name="resetReturnVar" hint="Resets values for the return data struct." access="private" output="false" returntype="void">
    	<cfset variables.returnVar.setStatus(false) />
        <cfset variables.returnVar.setStatusMsg("Unable to access Type Ahead functionality.") />
        <cfset variables.returnVar.setPayload("[]") />
    </cffunction>
	
	<cffunction name="search" access="remote" hint="general full-text search across multiple data objects for typeahead" output="false" returnformat="plain">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		<cfargument name="type" type="string" required="no" default="all" />
		
		<cfset var results = "" />
		<cfset var payload = structNew() />
		
		
		<cfif arguments.max EQ 0>
			<cfset arguments.max = 1000 />
		</cfif>
		
		<cfif NOT listFindNoCase(variables.allowedTypes,arguments.type,",")>
			<cfset variables.returnVar.setStatusMsg("INVALID TYPE: #arguments.type# (allowed types: #variables.allowedTypes#") />
			
			<cfreturn variables.returnVar.getJSON() />
			<cfabort>
		</cfif>
		<cfset results = evaluate("application.search.#arguments.type#(arguments.q,arguments.max)") />
		
		<cfif isQuery(results)>
			<cfset payload.dataset = application.udf.querytostruct(results) />
			<cfset variables.returnVar.setStatus(true) />
			<cfset variables.returnVar.setStatusMsg("Success") />
			<cfset variables.returnVar.setPayload(payload) />
		<cfelse>
			<cfset payload.dataset = #arrayNew(1)# />
			<cfset variables.returnVar.setStatus(true) />
			<cfset variables.returnVar.setStatusMsg("success, but no results returned") />
			<cfset variables.returnVar.setPayload(payload) />
		</cfif>
		<cfheader name="charset" value="UTF-8">
		<cfcontent type="text/javascript">
		
		<cfreturn variables.returnVar.getJSON() />
        
        <cfset trim(this.resetReturnVar()) />
	</cffunction>
	
	<!---<cffunction name="folders" hint="returns folders list for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		<!---<cfset var results = "" />
		<cfset var payload = structNew() />
		<cfset var variables.returnVar = createObject("component","_com.returnData.buildStruct").init() />
		
		<cfif NOT listFindNoCase(variables.allowedTypes,arguments.type,",")>
			<cfset variables.returnVar.setStatus(false) />
			<cfset variables.returnVar.setStatusMsg("INVALID TYPE: #arguments.type# (allowed types: #variables.allowedTypes#") />
			
			<cfreturn variables.returnVar.getJSON() />
			<cfabort>
		</cfif>
		
		<cfset results = evaluate("application.search.#arguments.type#(arguments.q,arguments.max)") />--->
	</cffunction>
	
	<cffunction name="city" hint="returns folders list for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		<cfreturn application.search.city(arguments.q,arguments.max).getJSON() />
	</cffunction>
	
	<cffunction name="wikipedia" hint="returns wikipedia list for typeahead" access="remote" output="no" returnformat="plain">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		
		<cfreturn application.search.wikipedia(arguments.q,arguments.max).getJSON() />
	</cffunction>
	
	<cffunction name="occupation" hint="returns occupation list for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		
		<cfreturn application.search.occupation(arguments.q,arguments.max).getJSON() />
	</cffunction>
	
	<cffunction name="activity" hint="returns activity list for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		<cfreturn application.search.activity(arguments.q,arguments.max) />
	</cffunction>
	
	<cffunction name="person" hint="returns person list for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		
		<cfreturn application.search.person(arguments.q,arguments.max).getJSON() />
	</cffunction>
	
	<cffunction name="state" hint="returns state list for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		<cfreturn application.search.state(arguments.q,arguments.max).getJSON() />
	</cffunction>
	
	<cffunction name="country" hint="returns country list for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		
		<cfreturn application.search.country(arguments.q,arguments.max).getJSON() />
	</cffunction>
	
	<cffunction name="specialties" hint="returns specialties for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		
		<cfreturn application.search.specialties(arguments.q,arguments.max).getJSON() />
	</cffunction>
	
	<cffunction name="degrees" hint="returns degree types for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		
		<cfreturn application.search.degrees(arguments.q,arguments.max).getJSON() />
	</cffunction>
	
	<cffunction name="entities" hint="returns entities for typeahead" access="remote" returnformat="plain" output="no">
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="max" type="numeric" required="no" default="10" />
		
		
		<cfreturn application.search.entities(arguments.q,arguments.max).getJSON() />
	</cffunction>--->
</cfcomponent>