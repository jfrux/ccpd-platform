<cfcomponent displayname="listing ajax" output="no">

	<cffunction name="occupation" access="remote" returnformat="plain" output="no">
		
	</cffunction>
	
	<cffunction name="specialty" access="remote" returnformat="plain" output="no">
		
	</cffunction>
	
	<cffunction name="degree" access="remote" returnformat="plain" output="no">
		
	</cffunction>
	
	<cffunction name="folder" access="remote" returnformat="plain" output="no">
		<cfset var returnVar = structNew() />
		<cfset returnVar = {
			text = arguments.name,
			item_id = '9999999999',
			image = '/static/images/no-photo/none_i.png'
		} />
		
		<cfcontent type="text/javascript">
		
		<cfreturn serializeJSON(returnVar) />
	</cffunction>
	
	<cffunction name="entity" access="remote" returnformat="plain" output="no">
		<cfset var returnVar = structNew() />
		<cfset returnVar = {
			text = arguments.name,
			item_id = '9999999999',
			image = '/static/images/no-photo/entity_i.png'
		} />
		
		<cfcontent type="text/javascript">
		
		<cfreturn serializeJSON(returnVar) />
	</cffunction>
	
	<cffunction name="supporter" access="remote" returnformat="plain" output="no">
		<cfset var returnVar = structNew() />
        
		<cfset returnVar = {
			text = arguments.name,
			item_id = '9999999999',
			image = '/static/images/no-photo/none_i.png'
		} />
		
		<cfcontent type="text/javascript">
		
		<cfreturn serializeJSON(returnVar) />
	</cffunction>
</cfcomponent>