<cfcomponent displayname="FunRCGateway" output="false">
	<cffunction name="init" access="public" output="false" returntype="_com.System.FunRCGateway">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.dsn = arguments.dsn />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributes" access="public" output="false" returntype="query">
		<cfargument name="FunRCID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Created" type="date" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#">
			SELECT
				FunRCID,
				Name,
				Description,
				Created
			FROM	ce_Sys_FunRC
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"FunRCID") and len(arguments.FunRCID)>
			AND	FunRCID = <cfqueryparam value="#arguments.FunRCID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			AND	Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Description") and len(arguments.Description)>
			AND	Description = <cfqueryparam value="#arguments.Description#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Created") and len(arguments.Created)>
			AND	Created = <cfqueryparam value="#arguments.Created#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

</cfcomponent>
