<cfcomponent displayname="MarketDAO" hint="table ID column = MarketID">

	<cffunction name="init" access="public" output="false" returntype="_com.System.MarketDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="Market" type="_com.System.Market" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO sys_markets
					(
					Name,
					Description
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Market.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Market.getName())#" />,
					<cfqueryparam value="#arguments.Market.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Market.getDescription())#" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.System.Market">
		<cfargument name="Market" type="_com.System.Market" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					MarketID,
					Name,
					Description,
					Created
				FROM	sys_markets
				WHERE	MarketID = <cfqueryparam value="#arguments.Market.getMarketID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset MarketBean = arguments.Market.init(argumentCollection=strReturn)>
			<cfreturn MarketBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="Market" type="_com.System.Market" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	sys_markets
				SET
					Name = <cfqueryparam value="#arguments.Market.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Market.getName())#" />,
					Description = <cfqueryparam value="#arguments.Market.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Market.getDescription())#" />,
					Created = <cfqueryparam value="#arguments.Market.getCreated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Market.getCreated())#" />
				WHERE	MarketID = <cfqueryparam value="#arguments.Market.getMarketID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Market" type="_com.System.Market" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	sys_markets 
				WHERE	MarketID = <cfqueryparam value="#arguments.Market.getMarketID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Market" type="_com.System.Market" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	sys_markets
			WHERE	MarketID = <cfqueryparam value="#arguments.Market.getMarketID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Market" type="_com.System.Market" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Market)>
			<cfset success = update(arguments.Market) />
		<cfelse>
			<cfset success = create(arguments.Market) />
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
