<cfcomponent displayname="Attendee Stat Fixer" output="no">
	<cffunction name="ParseTags" output="yes" access="remote" returntype="string" returnformat="plain">
		<cfargument name="ActivityID" type="numeric" required="no" default="0" />
		<cfargument name="mode" type="string" required="no" default="auto">
		
		<cfset var nUpdatedBy = 1 />
		<cfset var qSelector = "" />
		<cfset var qUpdater = "" />
		
		<cfquery name="qSelector" datasource="#Application.Settings.DSN#">
			SELECT
				*
			FROM View_Activities
			WHERE activityid >= 8322
		</cfquery>
		
		<cfoutput>
		<cfloop query="qSelector">
			<div>[#qSelector.activityId#]
			<cfset stripped = application.UDF.stripAllBut(qSelector.title,'abcdefghijklmnopqrstuvwxyz ',false) />
			#stripped#
			</div>
			
			<cfset tags = listToArray(stripped,' ') />
			
			<cfloop from="1" to="#arrayLen(tags)#" index="i">
				<cfset tag = tags[i] />
				
				<cfquery name="qCheck" datasource="#application.settings.DSN#">
					SELECT name FROM ce_activity_tags
					WHERE name = <cfqueryparam value="#trim(tag)#" cfsqltype="cf_sql_varchar">
				</cfquery>
				
				<cfif qCheck.recordCount>
					<cfquery name="qInsert" datasource="#application.settings.dsn#">
						UPDATE ce_activity_tags
						SET
							tagcount=tagcount+1
						WHERE name=<cfqueryparam value="#trim(tag)#" cfsqltype="cf_sql_varchar">
					</cfquery>
				<cfelse>
					<cfquery name="qInsert" datasource="#application.settings.dsn#">
						INSERT INTO ce_activity_tags
						(
							name
						) 
							VALUES 
						(
							<cfqueryparam value="#trim(tag)#" cfsqltype="cf_sql_varchar">
						)
					</cfquery>
				</cfif>
			</cfloop>
		</cfloop>
		</cfoutput>
		<!---
		<cfset returnData.setStatus(true) />
		<cfset returnData.setStatusMsg('Stats are up to date!') />
		
		<cflog text="Stat Fixer script ran successfully." file="ccpd_script_log">
		
		<cfreturn returnData.getJSON() />--->
	</cffunction>
	<cffunction name="tagCloud" access="remote">
		<cfquery name="tags" datasource="#application.settings.dsn#">
		/****** Script for SelectTopNRows command from SSMS  ******/
		SELECT 
			[id]
			,[name]
			,(SELECT Count(*) FROM [ceschema].ce_activity_tag_relates AS TR WHERE T.id=TR.tagid) As tagCount
		FROM [ceschema].[ce_activity_tags] AS T
		WHERE hideflag=0 AND (SELECT Count(*) FROM [ceschema].ce_activity_tag_relates AS TR WHERE T.id=TR.tagid) > 20
		ORDER BY NEWID()
		</cfquery>
		<cfoutput>
		<cfset tagValueArray = ListToArray(ValueList(tags.tagCount))>
		<cfset max = ArrayMax(tagValueArray)>
		<cfset min = ArrayMin(tagValueArray)>
		<cfset diff = max - min>
		<cfset distribution = diff / 3>
		
		<style>
		.smallestTag { font-size: 9px; }
		.smallTag { font-size: 15px; }
		.mediumTag { font-size: 35px; }
		.largeTag { font-size: 45px; }
		.largestTag { font-size: 60px; } 
		</style>
		<cfloop query="tags">
			<cfif tags.tagCount EQ min>
				<cfset class="smallestTag">
			<cfelseif tags.tagCount EQ max>
				<cfset class="largestTag">
			<cfelseif tags.tagCount GT (min + (distribution*2))>
				<cfset class="largeTag">
			<cfelseif tags.tagCount GT (min + distribution)>
				<cfset class="mediumTag">
			<cfelse>
				<cfset class="smallTag">
			</cfif>
			<a href="/tag/#tags.name#" class="#class#">#tags.name#</a>
		</cfloop>
		</cfoutput>
	</cffunction>
	<cffunction name="assocTagActivity" output="yes" access="remote" returntype="string" returnformat="plain">
		
		<cfset var nUpdatedBy = 1 />
		<cfset var qSelector = "" />
		<cfset var qUpdater = "" />
		
		<cfquery name="qTags" datasource="#application.settings.dsn#">
			SELECT     tags.id, tags.name, tags.tagcount
			FROM         ce_activity_tags AS tags
			ORDER BY tags.name DESC
		</cfquery>
		
		<cfoutput>
			<cfloop query="qTags">
				<cfquery name="qActivities" datasource="#application.settings.dsn#">
					SELECT    
						ActivityID, 
						Title
					FROM 
						ce_Activity AS A
					WHERE 
						(Title LIKE '%#qtags.name#%')
					ORDER BY title
				</cfquery>
				
				<cfif qActivities.RecordCount>
					<cfloop query="qActivities">
						<cftry>
						<cfquery name="qInsert" datasource="#application.settings.dsn#">
							INSERT INTO ce_activity_tag_relates
							(
								activityid,
								tagid
							) 
								VALUES 
							(
								<cfqueryparam value="#trim(qActivities.activityid)#" cfsqltype="cf_sql_integer">,
								<cfqueryparam value="#trim(qTags.id)#" cfsqltype="cf_sql_integer">
							)
						</cfquery>
						<cfcatch>
						
						</cfcatch>
						</cftry>
					</cfloop>
				</cfif>
			</cfloop>
		</cfoutput>
	</cffunction>
	
	<cffunction name="setSpecialtiesByTags" access="remote" output="yes">
		<cfquery name="qTags" datasource="#application.settings.dsn#">
			SELECT     tags.id, tags.name, tags.tagcount, spec.SpecialtyID, spec.Name AS specialtyname
			FROM         ce_activity_tags AS tags INNER JOIN
				  ce_Sys_SpecialtyLMS AS spec ON tags.name = spec.Name
		</cfquery>
		
		<cfloop query="qTags">
			<cfquery name="qActivities" datasource="#application.settings.dsn#">
			SELECT    
				ActivityID, 
				Title
			FROM 
				ce_Activity AS A
			WHERE 
				(Title LIKE '%#qtags.name#%')
					AND
				(SELECT     COUNT(AC.ActivityID) AS Expr1
				FROM          ce_Activity_SpecialtyLMS AS AC
				WHERE AC.ActivityID = A.ActivityID AND AC.SpecialtyID = #qTags.specialtyid#) = 0
			</cfquery>
			
			<cfif qActivities.RecordCount>
			<cfloop query="qActivities">
				<cfquery name="qInsert" datasource="#application.settings.dsn#">
					INSERT INTO ce_Activity_SpecialtyLMS
					(
						activityid,
						specialtyid,
						createdby
					) 
						VALUES 
					(
						<cfqueryparam value="#trim(qActivities.activityid)#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#trim(qTags.specialtyid)#" cfsqltype="cf_sql_integer">,
						1
					)
				</cfquery>
			</cfloop>
			</cfif>
		</cfloop>
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