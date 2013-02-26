<cfcomponent displayname="Search">
	<cffunction name="init" access="public" output="no" returntype="ccpdadmin._com.Search">
		<cfreturn this />
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
	
	<cffunction name="searchActivity" access="remote" output="no" returntype="string" returnformat="plain">
		<cfargument name="q" type="string" required="yes" />
		
		<cfset keystring = formatSearch(arguments.q)>
		
		<cfquery name="qSearch" datasource="#application.settings.dsn#">
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
		
		<cfset aSearch = application.UDF.querytostruct(qSearch)>
		
		<cfreturn serializeJSON(aSearch)>
	</cffunction>
	
	<cffunction name="Activities" access="public" output="no" returntype="query">
		<cfargument name="LimitTo" type="numeric" required="no" default="100" />
		<cfargument name="q" type="string" required="yes" />
		<cfargument name="activitytype" type="string" required="no" default="0" />
		<cfargument name="grouping" type="string" required="no" default="0" />
		<cfargument name="container" type="string" required="no" default="0" />
		<cfargument name="startdate" type="string" required="no" default="" />
		
		<cfset sKeyword = formatSearch(arguments.q)>
		
		<cfquery name="qSearch" datasource="#Application.Settings.DSN#">
			DECLARE @Search nvarchar(255)
			SET @Search = <cfqueryparam value="#sKeyword#" cfsqltype="cf_sql_varchar" />
			
			SELECT     
					TOP (<cfqueryparam value="#Arguments.LimitTo#" cfsqltype="cf_sql_integer" />)
				C.ActivityID, C.ParentActivityID, C.ActivityTypeID, CT.Name AS ActivityTypeName, C.GroupingID, G.Name AS GroupingName, C.Title, C.Description, 
				  C.StartDate, C.Created, C.CreatedBy, P1.firstname + ' ' + P1.lastname AS CreatedByName, C.Updated, C.UpdatedBy, 
				  P2.firstname + ' ' + P2.lastname AS UpdatedByName, C.Deleted, C.DeletedFlag, S.Name As StatusName, S.StatusID
				 <cfif Trim(sKeyword) NEQ ""> , KeyTbl.Rank</cfif>
				FROM         ce_Sys_Status AS S RIGHT OUTER JOIN
				  ce_Activity AS C ON S.StatusID = C.StatusID LEFT OUTER JOIN
				  ce_Sys_ActivityType AS CT ON C.ActivityTypeID = CT.ActivityTypeID LEFT OUTER JOIN
				  ce_Sys_Grouping AS G ON C.GroupingID = G.GroupingID LEFT OUTER JOIN
				  ce_person AS P1 ON C.CreatedBy = P1.personid LEFT OUTER JOIN
				  ce_person AS P2 ON C.UpdatedBy = P2.personid
				  <cfif Trim(sKeyword) NEQ ""> INNER JOIN
			CONTAINSTABLE(View_Activities,(Searchable), @Search) AS KeyTbl ON C.ActivityID = KeyTbl.[KEY]</cfif>
	WHERE     (0 = 0)
				<cfif structKeyExists(arguments,"ActivityType") and len(arguments.ActivityType) AND arguments.ActivityType GT 0>
					AND	C.ActivityTypeID = <cfqueryparam value="#arguments.ActivityType#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"Grouping") and len(arguments.Grouping) AND arguments.Grouping GT 0>
					AND	C.GroupingID = <cfqueryparam value="#arguments.Grouping#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"Container") and len(arguments.Container) AND arguments.Container GT 0>
					AND	(SELECT Count(AC.Activity_CategoryID) FROM ce_Activity_Category AC WHERE AC.CategoryID=<cfqueryparam value="#Arguments.Container#" cfsqltype="cf_sql_integer" /> AND AC.DeletedFlag='N' AND AC.ActivityID=C.ActivityID) > 0
				</cfif>
				<cfif structKeyExists(arguments,"StartDate") and isDate(arguments.StartDate)>
					AND	C.StartDate BETWEEN #CreateODBCDateTime("#Arguments.StartDate# 00:00:00")# AND #CreateODBCDateTime("#Arguments.StartDate# 23:59:59")#
				</cfif>
					<cfif Trim(sKeyword) NEQ ""> 
			ORDER BY KeyTbl.Rank DESC
			</cfif>
		</cfquery>
		
		<cfreturn qSearch />
	</cffunction>
	
	<cffunction name="People" access="public" output="no" returntype="query">
		<cfargument name="LimitTo" type="numeric" required="no" default="0" />
		<cfargument name="q" type="string" required="yes" />
		<cfargument name="birthdate" type="string" required="no" default="0" />
		<cfargument name="email" type="string" required="no" default="0" />
		
		<cfset sKeyword = formatSearch(arguments.q)>
		
		<cfquery name="qSearch" datasource="#Application.Settings.DSN#">
			DECLARE @NameSearch varchar;
			SET @NameSearch = <cfqueryparam value="#sNameSearch#" cfsqltype="cf_sql_varchar" />;
			SELECT 
				<cfif Arguments.LimitTo GT 0>
				TOP (#Arguments.LimitTo#)
				</cfif>   
				U.UserID, 
				U.Email, 
				U.URLName, 
				U.DisplayName, 
				U.FirstName, 
				U.LastName, 
				U.Country, 
				U.PostalCode, 
				U.State, 
				U.City, 
                (SELECT Count(UserStarID) AS StarCount
                 FROM ur_UserStar
                 WHERE UserID = <cfqueryparam value="#Session.UserID#" cfsqltype="cf_sql_integer" /> AND GarageID = U.UserID) StarCount,
				U.PrimaryPhotoID AS UserPhotoID, 
				P.FileExt AS UserPhotoExt, 
				KeyTbl.[KEY], KeyTbl.RANK
			FROM
				ur_User AS U 
			INNER JOIN
			  CONTAINSTABLE(View_Users, (FullName, FirstName, LastName, DisplayName, URLName), '#sNameSearch#') AS KeyTbl ON 
			  U.UserID = KeyTbl.[KEY] 
			LEFT OUTER JOIN
			  ur_Photo AS P ON U.PrimaryPhotoID = P.PhotoID
		</cfquery>
		
		<cfreturn qSearch />
	</cffunction>
	
	<cfscript>
	function removeSQLStops(TheList){
	// list of stop words
	var TheStopList=Application.List.NoiseWords;
	
	var delims = ",";
	var i=1;
	var OriginalSize=0;
	var results="";
	
	//check for declared delimiter
	if(arrayLen(arguments) gt 1) delims = arguments[2];
	
	// get the size of the list
	OriginalSize=listlen(TheList,delims);
	
	// loop over the list and search for stop words
		for(; i lte OriginalSize; i=i+1){
		//if the word is not in the stop word list add it to the results
			if(ListFindNoCase(TheStopList, ListGetAt(TheList,i,delims),"," ) EQ 0) {
		// word a are added to new list (list is returned with the same delimiter passed in to the function)
					results=ListAppend(results,(ListGetAt(TheList,i,delims)),delims);
				}
			}
			return results;
	}
	</cfscript>
</cfcomponent>