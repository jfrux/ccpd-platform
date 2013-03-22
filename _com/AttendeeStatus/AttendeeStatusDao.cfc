
<cfcomponent displayname="AttendeeStatusDAO" hint="table ID column = AttendeeStatusID">

	<cffunction name="init" access="public" output="false" returntype="_com.AttendeeStatus.AttendeeStatusDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="AttendeeStatus" type="_com.AttendeeStatus.AttendeeStatus" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO sys_attendeestatuses
					(
					Name,
					Description,
					Code
					)
				VALUES
					(
					<cfqueryparam value="#arguments.AttendeeStatus.getName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.AttendeeStatus.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttendeeStatus.getDescription())#" />,
					<cfqueryparam value="#arguments.AttendeeStatus.getCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttendeeStatus.getCode())#" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.AttendeeStatus.AttendeeStatus">
		<cfargument name="AttendeeStatus" type="_com.AttendeeStatus.AttendeeStatus" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					AttendeeStatusID,
					Name,
					Description,
					Code
				FROM	sys_attendeestatuses
				WHERE	AttendeeStatusID = <cfqueryparam value="#arguments.AttendeeStatus.getAttendeeStatusID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset AttendeeStatusBean = arguments.AttendeeStatus.init(argumentCollection=strReturn)>
			<cfreturn AttendeeStatusBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="AttendeeStatus" type="_com.AttendeeStatus.AttendeeStatus" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	sys_attendeestatuses
				SET
					Name = <cfqueryparam value="#arguments.AttendeeStatus.getName()#" CFSQLType="cf_sql_varchar" />,
					Description = <cfqueryparam value="#arguments.AttendeeStatus.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttendeeStatus.getDescription())#" />,
					Code = <cfqueryparam value="#arguments.AttendeeStatus.getCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttendeeStatus.getCode())#" />
				WHERE	AttendeeStatusID = <cfqueryparam value="#arguments.AttendeeStatus.getAttendeeStatusID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="AttendeeStatus" type="_com.AttendeeStatus.AttendeeStatus" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	sys_attendeestatuses 
				WHERE	AttendeeStatusID = <cfqueryparam value="#arguments.AttendeeStatus.getAttendeeStatusID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="AttendeeStatus" type="_com.AttendeeStatus.AttendeeStatus" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	sys_attendeestatuses
			WHERE	AttendeeStatusID = <cfqueryparam value="#arguments.AttendeeStatus.getAttendeeStatusID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="AttendeeStatus" type="_com.AttendeeStatus.AttendeeStatus" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.AttendeeStatus)>
			<cfset success = update(arguments.AttendeeStatus) />
		<cfelse>
			<cfset success = create(arguments.AttendeeStatus) />
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
