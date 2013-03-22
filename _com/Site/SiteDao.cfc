<cfcomponent displayname="SiteDAO" hint="table ID column = SiteID">

	<cffunction name="init" access="public" output="false" returntype="_com.Site.SiteDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="Site" type="_com.Site.Site" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" result="CreateResult">
				INSERT INTO sys_sitelms
					(
					Name,
					NameShort,
					Description,
					DomainName,
					ContactName,
					ContactPhone,
					CreatedBy
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Site.getName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Site.getNameShort()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Site.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Site.getDescription())#" />,
					<cfqueryparam value="#arguments.Site.getDomainName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Site.getContactName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Site.getContactName())#" />,
					<cfqueryparam value="#arguments.Site.getContactPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Site.getContactPhone())#" />,
					<cfqueryparam value="#arguments.Site.getCreatedBy()#" CFSQLType="cf_sql_integer" />
					)
			</cfquery>
			
		<cfreturn CreateResult.IDENTITYCOL />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="_com.Site.Site">
		<cfargument name="Site" type="_com.Site.Site" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#">
				SELECT
					SiteID,
					Name,
					NameShort,
					Description,
					DomainName,
					ContactName,
					ContactPhone,
					Created,
					CreatedBy,
					Updated,
					UpdatedBy,
					Deleted,
					DeletedFlag
				FROM	sys_sitelms
				WHERE	SiteID = <cfqueryparam value="#arguments.Site.getSiteID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset SiteBean = arguments.Site.init(argumentCollection=strReturn)>
			<cfreturn SiteBean>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="Site" type="_com.Site.Site" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#">
				UPDATE	sys_sitelms
				SET
					Name = <cfqueryparam value="#arguments.Site.getName()#" CFSQLType="cf_sql_varchar" />,
					NameShort = <cfqueryparam value="#arguments.Site.getNameShort()#" CFSQLType="cf_sql_varchar" />,
					Description = <cfqueryparam value="#arguments.Site.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Site.getDescription())#" />,
					DomainName = <cfqueryparam value="#arguments.Site.getDomainName()#" CFSQLType="cf_sql_varchar" />,
					ContactName = <cfqueryparam value="#arguments.Site.getContactName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Site.getContactName())#" />,
					ContactPhone = <cfqueryparam value="#arguments.Site.getContactPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Site.getContactPhone())#" />,
					Created = <cfqueryparam value="#arguments.Site.getCreated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Site.getCreated())#" />,
					CreatedBy = <cfqueryparam value="#arguments.Site.getCreatedBy()#" CFSQLType="cf_sql_integer" />,
					Updated = <cfqueryparam value="#arguments.Site.getUpdated()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Site.getUpdated())#" />,
					UpdatedBy = <cfqueryparam value="#arguments.Site.getUpdatedBy()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Site.getUpdatedBy())#" />,
					Deleted = <cfqueryparam value="#arguments.Site.getDeleted()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Site.getDeleted())#" />,
					DeletedFlag = <cfqueryparam value="#arguments.Site.getDeletedFlag()#" CFSQLType="cf_sql_char" null="#not len(arguments.Site.getDeletedFlag())#" />
				WHERE	SiteID = <cfqueryparam value="#arguments.Site.getSiteID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Site" type="_com.Site.Site" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#">
				DELETE FROM	sys_sitelms 
				WHERE	SiteID = <cfqueryparam value="#arguments.Site.getSiteID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Site" type="_com.Site.Site" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" maxrows="1">
			SELECT count(1) as idexists
			FROM	sys_sitelms
			WHERE	SiteID = <cfqueryparam value="#arguments.Site.getSiteID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Site" type="_com.Site.Site" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Site)>
			<cfset success = update(arguments.Site) />
		<cfelse>
			<cfset success = create(arguments.Site) />
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
