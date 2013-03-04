
<cfcomponent displayname="PersonStatusDAO" hint="table ID column = PersonStatusID">

	<cffunction name="init" access="public" output="false" returntype="_com.System.PersonStatusDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="PersonStatus" type="_com.System.PersonStatus" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO ce_Sys_PersonStatus
					(
					Name,
					Description,
					Code
					)
				VALUES
					(
					<cfqueryparam value="#arguments.PersonStatus.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.PersonStatus.getName())#" />,
					<cfqueryparam value="#arguments.PersonStatus.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.PersonStatus.getDescription())#" />,
					<cfqueryparam value="#arguments.PersonStatus.getCode()#" CFSQLType="cf_sql_char" null="#not len(arguments.PersonStatus.getCode())#" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.System.PersonStatus">
		<cfargument name="PersonStatus" type="_com.System.PersonStatus" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					PersonStatusID,
					Name,
					Description,
					Code
				FROM	ce_Sys_PersonStatus
				WHERE	PersonStatusID = <cfqueryparam value="#arguments.PersonStatus.getPersonStatusID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset PersonStatusBean = arguments.PersonStatus.init(argumentCollection=strReturn)>
			<cfreturn PersonStatusBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="PersonStatus" type="_com.System.PersonStatus" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	ce_Sys_PersonStatus
				SET
					Name = <cfqueryparam value="#arguments.PersonStatus.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.PersonStatus.getName())#" />,
					Description = <cfqueryparam value="#arguments.PersonStatus.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.PersonStatus.getDescription())#" />,
					Code = <cfqueryparam value="#arguments.PersonStatus.getCode()#" CFSQLType="cf_sql_char" null="#not len(arguments.PersonStatus.getCode())#" />
				WHERE	PersonStatusID = <cfqueryparam value="#arguments.PersonStatus.getPersonStatusID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="PersonStatus" type="_com.System.PersonStatus" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	ce_Sys_PersonStatus 
				WHERE	PersonStatusID = <cfqueryparam value="#arguments.PersonStatus.getPersonStatusID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="PersonStatus" type="_com.System.PersonStatus" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	ce_Sys_PersonStatus
			WHERE	PersonStatusID = <cfqueryparam value="#arguments.PersonStatus.getPersonStatusID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="PersonStatus" type="_com.System.PersonStatus" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.PersonStatus)>
			<cfset success = update(arguments.PersonStatus) />
		<cfelse>
			<cfset success = create(arguments.PersonStatus) />
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
