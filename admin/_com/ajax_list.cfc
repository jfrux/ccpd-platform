<cfcomponent extends="ajax" displayname="list ajax">
	<cffunction name="activities" access="remote" output="no" returnformat="plain" returntype="string">
		<cfargument name="sortby" type="string" required="no" default="recent" />
		<cfargument name="person" type="numeric" required="no" default="0" />
		<cfargument name="q" type="string" required="no" default="" />
		<cfargument name="startdate" type="string" required="no" default="#DateFormat(now(),'mm/dd/yyyy')#" />
		
		<cfset var qList = "">
		<cfset var aQuery = []>
		<cfcontent type="text/javascript">
		
		<cfswitch expression="#arguments.sortby#">
			<cfcase value="recent">
				<cfquery name="qList" datasource="#application.settings.dsn#">
					/* MOST RECENTLY MODIFIED ACTIVITIES */
					WITH CTE_MostRecent AS (
					SELECT H.ToActivityID,MAX(H.Created) As MaxCreated
					FROM ceschema.ce_History H
					WHERE H.FromPersonID=<cfqueryparam value="#arguments.person#" cfsqltype="cf_sql_integer" /> AND isNull(H.ToActivityID,0) <> 0
					GROUP BY H.ToActivityID
					) SELECT * FROM CTE_MostRecent M INNER JOIN ceschema.ce_Activity A  ON A.ActivityID=M.ToActivityID
					WHERE A.DeletedFlag='N'
					ORDER BY M.MaxCreated DESC
				</cfquery>
			</cfcase>
			<cfcase value="upcoming">
				<cfquery name="qList" datasource="#application.settings.dsn#">
				/* UPCOMING */	
				SELECT TOP 25 * FROM ceschema.ce_Activity 
				WHERE 
				StartDate > getDate() AND CreatedBy=<cfqueryparam value="#arguments.person#" cfsqltype="cf_sql_integer" /> AND DeletedFlag='N'
				ORDER BY StartDate
				</cfquery>
			</cfcase>
			<cfcase value="active">
				<cfquery name="qList" datasource="#application.settings.dsn#">
					/* MOST RECENTLY MODIFIED ACTIVITIES */
					WITH CTE_MostRecent AS (
					SELECT H.ToActivityID,MAX(H.Created) As MaxCreated
					FROM ceschema.ce_History H
					WHERE isNull(H.ToActivityID,0) <> 0
					GROUP BY H.ToActivityID
					) SELECT TOP 25 * FROM CTE_MostRecent M INNER JOIN ceschema.ce_Activity A  ON A.ActivityID=M.ToActivityID
					WHERE A.DeletedFlag='N'
					ORDER BY M.MaxCreated DESC
				</cfquery>
			</cfcase>
			<cfcase value="search">
				<cfset keystring = formatSearch(arguments.q)>
				<cfquery name="qList" datasource="#application.settings.dsn#">
					DECLARE @Word nvarchar(2000);
					
					SET @Word = <cfqueryparam value="#keystring#" cfsqltype="cf_sql_varchar" />;
					
					SELECT 
						A.ActivityID,A.Title,A.StartDate,
					  COALESCE(TitleResults.[KEY], SummaryResults.[KEY]) AS [KEY],
					  (ISNULL(TitleResults.Rank, 0) * 3 +
					  ISNULL(SummaryResults.Rank, 0) * 2) AS Rank
					FROM
					FREETEXTTABLE(ceschema.View_Activities, Title, @Word, LANGUAGE 'English') AS TitleResults
					  FULL OUTER JOIN 
						FREETEXTTABLE(ceschema.View_Activities, SearchAll, @Word, LANGUAGE 'English') AS SummaryResults 
						ON TitleResults.[KEY] = SummaryResults.[KEY]
						INNER JOIN 
					ceschema.ce_Activity As A ON A.ActivityID = TitleResults.[KEY]
					WHERE A.DeletedFlag='N'
					ORDER BY [Rank] DESC
				</cfquery>
			</cfcase>
		</cfswitch>
		
		<cfset aQuery = application.UDF.querytostruct(qList)>
		
		<cfreturn serializeJSON(aQuery) />
	</cffunction>
	
	<cffunction name="formatSearch" access="remote" output="no" returntype="string">
		<cfargument name="q" type="string" required="yes" />
		
		<cfset var qSearch = "">
		<cfset var sKeyword = Replace(Trim(Arguments.q),' ','|','ALL')>
		<cfset string = "">
		
		<cfset string = """#Replace(sKeyword,'|',' ','ALL')#""">
		<cfloop list="#sKeyword#" index="k" delimiters="|">
			<cfset string = string & " OR FORMSOF(INFLECTIONAL,""" & k & """)">
			<cfset string = string & " OR FORMSOF(Thesaurus,""" & k & """)">
		</cfloop>
		
		<cfif sKeyword EQ '""'>
			<cfset sKeyword = "">
		</cfif>
		
		<cfreturn string />
	</cffunction>
	
	<cffunction name="activityTypes" access="remote" output="no" returntype="string" returnformat="plain">
		<cfargument name="selected" type="numeric" required="no" default="0" />
		
		
	</cffunction>
</cfcomponent>