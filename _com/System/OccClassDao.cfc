<cfcomponent displayname="OccClassDAO" hint="table ID column = OccClassID">

	<cffunction name="init" access="public" output="false" returntype="_com.System.OccClassDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="OccClass" type="_com.System.OccClass" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO ce_Sys_OccClass
					(
					Name,
					Description
					)
				VALUES
					(
					<cfqueryparam value="#arguments.OccClass.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.OccClass.getName())#" />,
					<cfqueryparam value="#arguments.OccClass.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.OccClass.getDescription())#" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.System.OccClass">
		<cfargument name="OccClass" type="_com.System.OccClass" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					OccClassID,
					Name,
					Description,
					Created
				FROM	ce_Sys_OccClass
				WHERE	OccClassID = <cfqueryparam value="#arguments.OccClass.getOccClassID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset OccClassBean = arguments.OccClass.init(argumentCollection=strReturn)>
			<cfreturn OccClassBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="OccClass" type="_com.System.OccClass" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	ce_Sys_OccClass
				SET
					Name = <cfqueryparam value="#arguments.OccClass.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.OccClass.getName())#" />,
					Description = <cfqueryparam value="#arguments.OccClass.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.OccClass.getDescription())#" />,
					Created = <cfqueryparam value="#arguments.OccClass.getCreated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.OccClass.getCreated())#" />
				WHERE	OccClassID = <cfqueryparam value="#arguments.OccClass.getOccClassID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="OccClass" type="_com.System.OccClass" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	ce_Sys_OccClass 
				WHERE	OccClassID = <cfqueryparam value="#arguments.OccClass.getOccClassID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="OccClass" type="_com.System.OccClass" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	ce_Sys_OccClass
			WHERE	OccClassID = <cfqueryparam value="#arguments.OccClass.getOccClassID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="OccClass" type="_com.System.OccClass" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.OccClass)>
			<cfset success = update(arguments.OccClass) />
		<cfelse>
			<cfset success = create(arguments.OccClass) />
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
