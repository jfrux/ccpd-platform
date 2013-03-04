<cfcomponent displayname="AddressTypeDAO" hint="table ID column = AddressTypeID">

	<cffunction name="init" access="public" output="false" returntype="_com.AddressType.AddressTypeDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="AddressType" type="_com.AddressType.AddressType" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO ce_Sys_AddressType
					(
					Name,
					Description,
					Code
					)
				VALUES
					(
					<cfqueryparam value="#arguments.AddressType.getName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.AddressType.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AddressType.getDescription())#" />,
					<cfqueryparam value="#arguments.AddressType.getCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AddressType.getCode())#" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.AddressType.AddressType">
		<cfargument name="AddressType" type="_com.AddressType.AddressType" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					AddressTypeID,
					Name,
					Description,
					Code
				FROM	ce_Sys_AddressType
				WHERE	AddressTypeID = <cfqueryparam value="#arguments.AddressType.getAddressTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset AddressTypeBean = arguments.AddressType.init(argumentCollection=strReturn)>
			<cfreturn AddressTypeBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="AddressType" type="_com.AddressType.AddressType" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	ce_Sys_AddressType
				SET
					Name = <cfqueryparam value="#arguments.AddressType.getName()#" CFSQLType="cf_sql_varchar" />,
					Description = <cfqueryparam value="#arguments.AddressType.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AddressType.getDescription())#" />,
					Code = <cfqueryparam value="#arguments.AddressType.getCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AddressType.getCode())#" />
				WHERE	AddressTypeID = <cfqueryparam value="#arguments.AddressType.getAddressTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="AddressType" type="_com.AddressType.AddressType" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	ce_Sys_AddressType 
				WHERE	AddressTypeID = <cfqueryparam value="#arguments.AddressType.getAddressTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="AddressType" type="_com.AddressType.AddressType" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	ce_Sys_AddressType
			WHERE	AddressTypeID = <cfqueryparam value="#arguments.AddressType.getAddressTypeID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="AddressType" type="_com.AddressType.AddressType" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.AddressType)>
			<cfset success = update(arguments.AddressType) />
		<cfelse>
			<cfset success = create(arguments.AddressType) />
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
