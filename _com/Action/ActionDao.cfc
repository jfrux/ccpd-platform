<cfcomponent displayname="ActionDAO" hint="table ID column = ActionID">

	<cffunction name="init" access="public" output="false" returntype="_com.Action.ActionDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="Action" type="_com.Action.Action" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO ce_Action
					(
					ActivityID,
					PersonID,
					Code,
					ShortName,
					LongName,
					HiddenFlag,
					CreatedBy
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Action.getActivityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Action.getActivityID())#" />,
					<cfqueryparam value="#arguments.Action.getPersonID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Action.getPersonID())#" />,
					<cfqueryparam value="#arguments.Action.getCode()#" CFSQLType="cf_sql_char" null="#not len(arguments.Action.getCode())#" />,
					<cfqueryparam value="#arguments.Action.getShortName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Action.getLongName()#" CFSQLType="cf_sql_varchar" />,
					<cfif (NOT Len(arguments.Action.getHiddenFlag()))>
						<cfqueryparam value="N" CFSQLType="cf_sql_char" />,
					<cfelse>
						<cfqueryparam value="#arguments.Action.getHiddenFlag()#" CFSQLType="cf_sql_char" null="#not len(arguments.Action.getHiddenFlag())#" />,
					</cfif>
					<cfqueryparam value="#arguments.Action.getCreatedBy()#" CFSQLType="cf_sql_integer" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.Action.Action">
		<cfargument name="Action" type="_com.Action.Action" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					ActionID,
					ActivityID,
					PersonID,
					Code,
					ShortName,
					LongName,
					HiddenFlag,
					Created,
					CreatedBy
				FROM	ce_Action
				WHERE	ActionID = <cfqueryparam value="#arguments.Action.getActionID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is --->
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset ActionBean = arguments.Action.init(argumentCollection=strReturn)>
			<cfreturn ActionBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="Action" type="_com.Action.Action" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	ce_Action
				SET
					ActivityID = <cfqueryparam value="#arguments.Action.getActivityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Action.getActivityID())#" />,
					PersonID = <cfqueryparam value="#arguments.Action.getPersonID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Action.getPersonID())#" />,
					Code = <cfqueryparam value="#arguments.Action.getCode()#" CFSQLType="cf_sql_char" null="#not len(arguments.Action.getCode())#" />,
					ShortName = <cfqueryparam value="#arguments.Action.getShortName()#" CFSQLType="cf_sql_varchar" />,
					LongName = <cfqueryparam value="#arguments.Action.getLongName()#" CFSQLType="cf_sql_varchar" />,
					HiddenFlag = <cfqueryparam value="#arguments.Action.getHiddenFlag()#" CFSQLType="cf_sql_char" null="#not len(arguments.Action.getHiddenFlag())#" />,
					Created = <cfqueryparam value="#arguments.Action.getCreated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Action.getCreated())#" />,
					CreatedBy = <cfqueryparam value="#arguments.Action.getCreatedBy()#" CFSQLType="cf_sql_integer" />
				WHERE	ActionID = <cfqueryparam value="#arguments.Action.getActionID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Action" type="_com.Action.Action" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	ce_Action 
				WHERE	ActionID = <cfqueryparam value="#arguments.Action.getActionID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Action" type="_com.Action.Action" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	ce_Action
			WHERE	ActionID = <cfqueryparam value="#arguments.Action.getActionID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Action" type="_com.Action.Action" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Action)>
			<cfset success = update(arguments.Action) />
		<cfelse>
			<cfset success = create(arguments.Action) />
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
