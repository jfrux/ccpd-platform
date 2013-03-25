
<!---
	* Author: Cristian Costantini
	* E-mail: cristian@millemultimedia.it
	* Version: 1.0.0 Alpha
	* Date: 6/9/2009 14:14:40
	* FileName: Yaml.cfc 
	--->

<cfcomponent output="false">
	
	<cffunction name="init" access="public" returntype="Yaml" output="false">
		<cfargument name="jar" type="String" required="true" hint="Absolute file path" />
		<cfset var lib = arrayNew(1) />
		<cfset var loader = "" />
		
		<cfset lib.add( arguments.jar ) />
		
		<cfset loader = createObject("component", "it.millemultimedia.yaml.io.javaloader.JavaLoader").init( lib ) />
		
		<cfset setYaml( loader.create( 'org.ho.yaml.Yaml' ) ) />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="load" access="public" returntype="Any" output="false" hint="Return an Java Object">
		<cfargument name="yamlFile" type="String" required="true" hint="Absolute file path" />
		<cfset var file = createObject( 'java', 'java.io.File' ).init( arguments.yamlFile ) />

		<cfreturn getYaml().load( file ) />
	</cffunction>
	
	<cffunction name="dump" access="public" returntype="String" output="false" hint="Return a String YAML">
		<cfargument name="obj" type="Any" required="true" hint="Java object" />

		<cfreturn getYaml().dump( arguments.obj ) />
	</cffunction>
	
	<!--- Private --->
	
	<!--- Usage: Getyaml / Setyaml methods for yaml value --->
	<cffunction name="getYaml" access="private" output="false" returntype="any">
	   <cfreturn variables.instance.yaml />
	</cffunction>
	
	<cffunction name="setYaml" access="private" output="false" returntype="void">
	   <cfargument name="yaml" type="any" required="true" />
	   <cfset variables.instance.yaml = arguments.yaml />
	</cffunction>

</cfcomponent>