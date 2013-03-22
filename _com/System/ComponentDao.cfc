<cfcomponent displayname="ComponentDAO" hint="table ID column = ComponentID">

	<cffunction name="init" access="public" output="false" returntype="_com.System.ComponentDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="Component" type="_com.System.Component" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO sys_components
					(
					Name,
					Description,
					TypeCode,
					SortFlag,
					MaxUsage
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Component.getName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Component.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Component.getDescription())#" />,
					<cfqueryparam value="#arguments.Component.getTypeCode()#" CFSQLType="cf_sql_char" null="#not len(arguments.Component.getTypeCode())#" />,
					<cfqueryparam value="#arguments.Component.getSortFlag()#" CFSQLType="cf_sql_char" null="#not len(arguments.Component.getSortFlag())#" />,
					<cfqueryparam value="#arguments.Component.getMaxUsage()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Component.getMaxUsage())#" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.System.Component">
		<cfargument name="Component" type="_com.System.Component" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					ComponentID,
					Name,
					Description,
					TypeCode,
					SortFlag,
					MaxUsage
				FROM	sys_components
				WHERE	ComponentID = <cfqueryparam value="#arguments.Component.getComponentID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset ComponentBean = arguments.Component.init(argumentCollection=strReturn)>
			<cfreturn ComponentBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="Component" type="_com.System.Component" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	sys_components
				SET
					Name = <cfqueryparam value="#arguments.Component.getName()#" CFSQLType="cf_sql_varchar" />,
					Description = <cfqueryparam value="#arguments.Component.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Component.getDescription())#" />,
					TypeCode = <cfqueryparam value="#arguments.Component.getTypeCode()#" CFSQLType="cf_sql_char" null="#not len(arguments.Component.getTypeCode())#" />,
					SortFlag = <cfqueryparam value="#arguments.Component.getSortFlag()#" CFSQLType="cf_sql_char" null="#not len(arguments.Component.getSortFlag())#" />,
					MaxUsage = <cfqueryparam value="#arguments.Component.getMaxUsage()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Component.getMaxUsage())#" />
				WHERE	ComponentID = <cfqueryparam value="#arguments.Component.getComponentID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Component" type="_com.System.Component" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	sys_components 
				WHERE	ComponentID = <cfqueryparam value="#arguments.Component.getComponentID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Component" type="_com.System.Component" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	sys_components
			WHERE	ComponentID = <cfqueryparam value="#arguments.Component.getComponentID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Component" type="_com.System.Component" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Component)>
			<cfset success = update(arguments.Component) />
		<cfelse>
			<cfset success = create(arguments.Component) />
		</cfif>
		
		<cfreturn success />
	</cffunction>

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		
		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 * 
			 * @param query 	 The query to work with. 
			 * @param row 	 Row number to check. Defaults to row 1. 
			 * @return Returns a structure. 
			 * @author Nathan Dintenfass (nathan@changemedia.com) 
			 * @version 1, December 11, 2001 
			 */
			//by default, do this to the first row of the query
			var row = 1;
			//a var for looping
			var ii = 1;
			//the cols to loop over
			var cols = listToArray(qry.columnList);
			//the struct to return
			var stReturn = structnew();
			//if there is a second argument, use that for the row number
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			//loop over the cols and build the struct from the query row
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}		
			//return the struct
			return stReturn;
		</cfscript>
	</cffunction>

</cfcomponent>
