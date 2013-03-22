<cfcomponent displayname="FileTypeDAO" hint="table ID column = FileTypeID">

	<cffunction name="init" access="public" output="false" returntype="_com.System.FileTypeDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="FileType" type="_com.System.FileType" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO sys_filetypes
					(
					Name,
					Description
					)
				VALUES
					(
					<cfqueryparam value="#arguments.FileType.getName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.FileType.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.FileType.getDescription())#" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.System.FileType">
		<cfargument name="FileType" type="_com.System.FileType" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					FileTypeID,
					Name,
					Description
				FROM	sys_filetypes
				WHERE	FileTypeID = <cfqueryparam value="#arguments.FileType.getFileTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset FileTypeBean = arguments.FileType.init(argumentCollection=strReturn)>
			<cfreturn FileTypeBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="FileType" type="_com.System.FileType" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	sys_filetypes
				SET
					Name = <cfqueryparam value="#arguments.FileType.getName()#" CFSQLType="cf_sql_varchar" />,
					Description = <cfqueryparam value="#arguments.FileType.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.FileType.getDescription())#" />
				WHERE	FileTypeID = <cfqueryparam value="#arguments.FileType.getFileTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="FileType" type="_com.System.FileType" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	sys_filetypes 
				WHERE	FileTypeID = <cfqueryparam value="#arguments.FileType.getFileTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="FileType" type="_com.System.FileType" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	sys_filetypes
			WHERE	FileTypeID = <cfqueryparam value="#arguments.FileType.getFileTypeID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="FileType" type="_com.System.FileType" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.FileType)>
			<cfset success = update(arguments.FileType) />
		<cfelse>
			<cfset success = create(arguments.FileType) />
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
