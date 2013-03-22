<cfcomponent displayname="PersonInterestExceptDAO" hint="table ID column = PersonIntExceptID">

	<cffunction name="init" access="public" output="false" returntype="_com.PersonInterestExcept.PersonInterestExceptDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="PersonInterestExcept" type="_com.PersonInterestExcept.PersonInterestExcept" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO Users_Interest_Except
					(
					PersonID,
					ActivityID
					)
				VALUES
					(
					<cfqueryparam value="#arguments.PersonInterestExcept.getPersonID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.PersonInterestExcept.getActivityID()#" CFSQLType="cf_sql_integer" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.PersonInterestExcept.PersonInterestExcept">
		<cfargument name="PersonInterestExcept" type="_com.PersonInterestExcept.PersonInterestExcept" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					PersonIntExceptID,
					PersonID,
					ActivityID,
					Created
				FROM	Users_Interest_Except
				WHERE	PersonID = <cfqueryparam value="#arguments.PersonInterestExcept.getPersonID()#" CFSQLType="cf_sql_integer" /> AND ActivityID = <cfqueryparam value="#arguments.PersonInterestExcept.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset PersonInterestExceptBean = arguments.PersonInterestExcept.init(argumentCollection=strReturn)>
			<cfreturn PersonInterestExceptBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="PersonInterestExcept" type="_com.PersonInterestExcept.PersonInterestExcept" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	Users_Interest_Except
				SET
					PersonID = <cfqueryparam value="#arguments.PersonInterestExcept.getPersonID()#" CFSQLType="cf_sql_integer" />,
					ActivityID = <cfqueryparam value="#arguments.PersonInterestExcept.getActivityID()#" CFSQLType="cf_sql_integer" />,
					Created = <cfqueryparam value="#arguments.PersonInterestExcept.getCreated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.PersonInterestExcept.getCreated())#" />
				WHERE	PersonID = <cfqueryparam value="#arguments.PersonInterestExcept.getPersonID()#" CFSQLType="cf_sql_integer" /> AND ActivityID = <cfqueryparam value="#arguments.PersonInterestExcept.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="PersonInterestExcept" type="_com.PersonInterestExcept.PersonInterestExcept" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	Users_Interest_Except 
				WHERE	PersonID = <cfqueryparam value="#arguments.PersonInterestExcept.getPersonID()#" CFSQLType="cf_sql_integer" /> AND ActivityID = <cfqueryparam value="#arguments.PersonInterestExcept.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="PersonInterestExcept" type="_com.PersonInterestExcept.PersonInterestExcept" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	Users_Interest_Except
			WHERE	PersonID = <cfqueryparam value="#arguments.PersonInterestExcept.getPersonID()#" CFSQLType="cf_sql_integer" /> AND ActivityID = <cfqueryparam value="#arguments.PersonInterestExcept.getActivityID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="PersonInterestExcept" type="_com.PersonInterestExcept.PersonInterestExcept" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.PersonInterestExcept)>
			<cfset success = update(arguments.PersonInterestExcept) />
		<cfelse>
			<cfset success = create(arguments.PersonInterestExcept) />
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
