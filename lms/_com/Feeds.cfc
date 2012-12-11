<cfcomponent displayname="Feeds">
	<cffunction name="RSS" access="remote" output="no" returntype="string">
		<cfargument name="Mode" type="string" required="yes" />
		<cfargument name="ModeID" type="string" required="no" default="0" />
	
		<cfset var header = "<?xml version=""1.0"" encoding=""UTF-8""?><rss version=""2.0"">">
		<cfset var footer = "</channel></rss>">
		<cfset var s = createObject('java','java.lang.StringBuffer').init(header)>
		<cfset var item = "">
		<cfset var feedtitle = "UC CCPD // #nameCase(Arguments.Mode)# Feed">
		<cfset var feeddesc = "CCPD LMS Feeds">
		<cfset var qActivities = "">
		<cfset var qCategories = "">
		<cfset var qSpecialties = "">
		
		<cfset var qQuery = "">
		<cfset var sOutput = "">
		
		<cfcontent type="text/xml" />
		<cfswitch expression="#Arguments.Mode#">
			<cfcase value="Activity">
				<cfset qActivities = Application.Com.ActivityGateway.getBySearchLMS(OrderBy="ACP.PublishDate DESC",Limit=25)>
				
				<cfquery name="qQuery" dbtype="query">
					SELECT Title,Overview As Description,'https://ccpd.uc.edu/activity/' + CAST(ActivityID as VARCHAR) As link,PublishDate AS pubDate
					FROM qActivities
				</cfquery>
			</cfcase>
			
			<!--- CATEGORY FEED --->
			<cfcase value="Category">
				<!--- ACTIVITIES BY CATEGORY ID --->
				<cfif Arguments.ModeID GT 0>
					<cfquery name="qCategory" datasource="#Application.Settings.DSN#">
						SELECT Name FROM ce_Sys_CategoryLMS WHERE CategoryID=<cfqueryparam value="#Arguments.ModeID#" cfsqltype="cf_sql_integer" />
					</cfquery>
					
					<cfset feedtitle = "UC CCPD // " & qCategory.Name & " Feed">
					<cfset feeddesc = "These are the latest CCPD activities in the #qCategory.Name# category.">
					
					<cfset qActivities = Application.Com.ActivityGateway.getBySearchLMS(CategoryLMSID=Arguments.ModeID,OrderBy="ACP.PublishDate DESC",Limit=25)>
				
					<cfquery name="qQuery" dbtype="query">
						SELECT Title,Overview As Description,'https://ccpd.uc.edu/activity/' + CAST(ActivityID as VARCHAR) As link,Created AS pubDate
						FROM qActivities
					</cfquery>
				
				<!--- CATEGORY LISTING --->
				<cfelse>
					<cfquery name="qCategories" datasource="#Application.Settings.DSN#">
						SELECT     
				CategoryID, 
				Name, 
				Description,
				
				/* ACTIVITY COUNT */
						(SELECT     COUNT(ActS.Activity_LMS_CategoryID) AS ActivityCount
						FROM          ce_Activity_CategoryLMS AS ActS INNER JOIN
										   ce_Activity AS A ON ActS.ActivityID = A.ActivityID INNER JOIN
										   ce_Activity_PubGeneral AS APG ON A.ActivityID = APG.ActivityID
						WHERE      (ActS.CategoryID = S.CategoryID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND (APG.RemoveDate > GETDATE())
											AND (A.StatusID = 1) OR
										   (ActS.CategoryID = S.CategoryID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND 
										   (APG.RemoveDate IS NULL) AND (A.StatusID = 1)) AS ActivityCount
					FROM         ce_Sys_CategoryLMS AS S
					WHERE     
						((SELECT     COUNT(ActS.Activity_LMS_CategoryID) AS ActivityCount
						FROM         ce_Activity_CategoryLMS AS ActS INNER JOIN
						   ce_Activity AS A ON ActS.ActivityID = A.ActivityID INNER JOIN
						   ce_Activity_PubGeneral AS APG ON A.ActivityID = APG.ActivityID
						WHERE     (ActS.CategoryID = S.CategoryID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND (APG.RemoveDate > GETDATE()) 
						   AND (A.StatusID = 1) OR
						   (ActS.CategoryID = S.CategoryID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (APG.PublishDate <= GETDATE()) AND 
						   (APG.RemoveDate IS NULL) AND (A.StatusID = 1)) > 0)
					ORDER BY Name
					</cfquery>
					
					<cfset feeddesc = "These are all CCPD categories that contain ACTIVE activities.">
					
					<cfquery name="qQuery" dbtype="query">
						SELECT CategoryID,Name As Title,Description,'https://ccpd.uc.edu/lms/category/' + CAST(CategoryID as VARCHAR) As link,'#DateFormat(now(),'mm/dd/yyyy')#' AS pubDate
						FROM qCategories
						WHERE ActivityCount > 0
						ORDER BY CategoryID DESC
					</cfquery>
				</cfif>
			</cfcase>
			<cfcase value="Specialty">
				<!--- ACTIVITIES BY SPECIALTY ID --->
				<cfif Arguments.ModeID GT 0>
					<cfquery name="qSpecialty" datasource="#Application.Settings.DSN#">
						SELECT Name FROM ce_Sys_SpecialtyLMS WHERE SpecialtyID=<cfqueryparam value="#Arguments.ModeID#" cfsqltype="cf_sql_integer" />
					</cfquery>
					
					<cfset feedtitle = "UC CCPD // " & qSpecialty.Name & " Feed">
					<cfset feeddesc = "These are the latest CCPD activities in the #qSpecialty.Name# specialty.">
					
					<cfset qActivities = Application.Com.ActivityGateway.getBySearchLMS(SpecialtyID=Arguments.ModeID,OrderBy="ACP.PublishDate DESC",Limit=25)>
				
					<cfquery name="qQuery" dbtype="query">
						SELECT Title,Overview As Description,'https://ccpd.uc.edu/activity/' + CAST(ActivityID as VARCHAR) As link,Created AS pubDate
						FROM qActivities
					</cfquery>
				
				<!--- SPECIALTY LISTING --->
				<cfelse>
					<cfquery name="qSpecialties" datasource="#Application.Settings.DSN#">
						SELECT SpecialtyID,Name,Description,(SELECT     COUNT(ActS.Activity_LMS_SpecialtyID) AS Expr1
						FROM         ce_Activity_SpecialtyLMS AS ActS INNER JOIN
						ce_Activity AS A ON ActS.ActivityID = A.ActivityID
						WHERE     (ActS.SpecialtyID = S.SpecialtyID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N')) As ActivityCount
						FROM ce_Sys_SpecialtyLMS S
						ORDER BY Name
					</cfquery>
					
					<cfset feeddesc = "These are all CCPD specialties that contain ACTIVE activities.">
					
					<cfquery name="qQuery" dbtype="query">
						SELECT SpecialtyID,Name As Title,Description,'https://ccpd.uc.edu/specialty/' + CAST(SpecialtyID as VARCHAR) As link,'#DateFormat(now(),'mm/dd/yyyy')#' AS pubDate
						FROM qSpecialties
						WHERE ActivityCount > 0
						ORDER BY SpecialtyID DESC
					</cfquery>
				</cfif>
			</cfcase>
			<cfdefaultcase>
				
			</cfdefaultcase>
		</cfswitch>
		
		<!--- RSS FORMAT --->
		<cfsavecontent variable="header">
		<cfoutput>
			<channel>
				<title>#XMLSafeText(feedtitle)#</title>
				<link>https://ccpd.uc.edu/</link>
				<description>#XMLSafeText(feeddesc)#</description>
				<lastBuildDate>#DateFormat(now(),'ddd, dd mmm yyyy')# #TimeFormat(now(),'HH:mm:ss')#</lastBuildDate>
				<language>en-us</language>
		</cfoutput>
		</cfsavecontent>
		<cfset header = trim(header)>
		<cfset s.append(header)>
		
		<cfloop query="qQuery">
			<cfsavecontent variable="item">
			<cfoutput>
			<item>
				<title>#XMLSafeText(qQuery.Title)#</title>
				<link>#qQuery.Link#</link>
				<guid>#qQuery.Link#</guid>
				<pubDate>#DateFormat(qQuery.pubDate,'ddd, dd mmm yyyy')# #TimeFormat(qQuery.pubDate,'HH:mm:ss')#</pubDate>
				<description>#XMLSafeText(removeHTML(qQuery.Description))#</description>
			</item>
			</cfoutput>
			</cfsavecontent>
			
			<cfset item = trim(item)>
			<cfset s.append(item)>
		</cfloop>

		<cfsavecontent variable="footer">
		<cfoutput>
			</channel>
			</rss>
		</cfoutput>
		</cfsavecontent>
		<cfset footer = trim(footer)>
		<cfset s.append(footer)>
			
		<cfreturn s />
	</cffunction>
	
	<cfinclude template="/_com/_UDF/nameCase.cfm" />
	<cfinclude template="/_com/_UDF/removeHTML.cfm" />
	<cfinclude template="/_com/_UDF/stripHTML.cfm" />
	<cfinclude template="/_com/_UDF/XMLSafeText.cfm" />
</cfcomponent>