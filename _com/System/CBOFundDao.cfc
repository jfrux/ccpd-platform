<cfcomponent displayname="CBOFundDAO" hint="table ID column = CBOFundID">

	<cffunction name="init" access="public" output="false" returntype="_com.System.CBOFundDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="CBOFund" type="_com.System.CBOFund" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO ce_Sys_CBOFund
					(
					Name,
					Description
					)
				VALUES
					(
					<cfqueryparam value="#arguments.CBOFund.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CBOFund.getName())#" />,
					<cfqueryparam value="#arguments.CBOFund.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CBOFund.getDescription())#" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.System.CBOFund">
		<cfargument name="CBOFund" type="_com.System.CBOFund" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					CBOFundID,
					Name,
					Description,
					Created
				FROM	ce_Sys_CBOFund
				WHERE	CBOFundID = <cfqueryparam value="#arguments.CBOFund.getCBOFundID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset CBOFundBean = arguments.CBOFund.init(argumentCollection=strReturn)>
			<cfreturn CBOFundBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="CBOFund" type="_com.System.CBOFund" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	ce_Sys_CBOFund
				SET
					Name = <cfqueryparam value="#arguments.CBOFund.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CBOFund.getName())#" />,
					Description = <cfqueryparam value="#arguments.CBOFund.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CBOFund.getDescription())#" />,
					Created = <cfqueryparam value="#arguments.CBOFund.getCreated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CBOFund.getCreated())#" />
				WHERE	CBOFundID = <cfqueryparam value="#arguments.CBOFund.getCBOFundID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="CBOFund" type="_com.System.CBOFund" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	ce_Sys_CBOFund 
				WHERE	CBOFundID = <cfqueryparam value="#arguments.CBOFund.getCBOFundID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="CBOFund" type="_com.System.CBOFund" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	ce_Sys_CBOFund
			WHERE	CBOFundID = <cfqueryparam value="#arguments.CBOFund.getCBOFundID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="CBOFund" type="_com.System.CBOFund" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.CBOFund)>
			<cfset success = update(arguments.CBOFund) />
		<cfelse>
			<cfset success = create(arguments.CBOFund) />
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
