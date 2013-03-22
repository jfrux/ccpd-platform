
<cfcomponent displayname="PersonNoteDAO" hint="table ID column = NoteID">

	<cffunction name="init" access="public" output="false" returntype="_com.PersonNote.PersonNoteDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="PersonNote" type="_com.PersonNote.PersonNote" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO Users_Note
					(
					PersonID,
					Body,
					CreatedBy
					)
				VALUES
					(
					<cfqueryparam value="#arguments.PersonNote.getPersonID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.PersonNote.getBody()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.PersonNote.getCreatedBy()#" CFSQLType="cf_sql_integer" null="#not len(arguments.PersonNote.getCreatedBy())#" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.PersonNote.PersonNote">
		<cfargument name="PersonNote" type="_com.PersonNote.PersonNote" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					NoteID,
					PersonID,
					Body,
					Created,
					CreatedBy,
					Updated,
					UpdatedBy,
					Deleted,
					DeletedFlag
				FROM	Users_Note
				WHERE	NoteID = <cfqueryparam value="#arguments.PersonNote.getNoteID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset PersonNoteBean = arguments.PersonNote.init(argumentCollection=strReturn)>
			<cfreturn PersonNoteBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="PersonNote" type="_com.PersonNote.PersonNote" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	Users_Note
				SET
					PersonID = <cfqueryparam value="#arguments.PersonNote.getPersonID()#" CFSQLType="cf_sql_integer" />,
					Body = <cfqueryparam value="#arguments.PersonNote.getBody()#" CFSQLType="cf_sql_varchar" />,
					Created = <cfqueryparam value="#arguments.PersonNote.getCreated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.PersonNote.getCreated())#" />,
					CreatedBy = <cfqueryparam value="#arguments.PersonNote.getCreatedBy()#" CFSQLType="cf_sql_integer" null="#not len(arguments.PersonNote.getCreatedBy())#" />,
					Updated = <cfqueryparam value="#arguments.PersonNote.getUpdated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.PersonNote.getUpdated())#" />,
					UpdatedBy = <cfqueryparam value="#arguments.PersonNote.getUpdatedBy()#" CFSQLType="cf_sql_integer" null="#not len(arguments.PersonNote.getUpdatedBy())#" />,
					Deleted = <cfqueryparam value="#arguments.PersonNote.getDeleted()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.PersonNote.getDeleted())#" />,
					DeletedFlag = <cfqueryparam value="#arguments.PersonNote.getDeletedFlag()#" CFSQLType="cf_sql_char" null="#not len(arguments.PersonNote.getDeletedFlag())#" />
				WHERE	NoteID = <cfqueryparam value="#arguments.PersonNote.getNoteID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="PersonNote" type="_com.PersonNote.PersonNote" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	Users_Note 
				WHERE	NoteID = <cfqueryparam value="#arguments.PersonNote.getNoteID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="PersonNote" type="_com.PersonNote.PersonNote" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	Users_Note
			WHERE	NoteID = <cfqueryparam value="#arguments.PersonNote.getNoteID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="PersonNote" type="_com.PersonNote.PersonNote" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.PersonNote)>
			<cfset success = update(arguments.PersonNote) />
		<cfelse>
			<cfset success = create(arguments.PersonNote) />
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
