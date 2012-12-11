<cffunction name="Static" access="remote" output="no">
	<cfset var urls = "">
	<cfcontent type="text/xml" />
	<cfset urls = "http://ccpd.uc.edu/,http://ccpd.uc.edu/about,http://ccpd.uc.edu/browse,http://ccpd.uc.edu/signup,http://ccpd.uc.edu/support,http://ccpd.uc.edu/login" />
	
	<cfset siteMapXML = generateSiteMap(data=urls,changefreq="hourly",priority="0.2", lastmod=now())>

	<cfreturn xmlParse(siteMapXML)>
</cffunction>

<cffunction name="Activity" access="remote" output="no">
	<cfcontent type="text/xml" />
	<cfset qActivities = Application.Com.ActivityGateway.getBySearchLMS(OrderBy="c.StartDate,c.Title")>
	
	<cfquery name="qActivityMap" dbtype="query">
		SELECT 'http://ccpd.uc.edu/activity/' + CAST(ActivityID as VARCHAR) As url,Created AS lastmod,'weekly' As changefreq, '1.0' As priority
		FROM qActivities
	</cfquery>
	<cfreturn xmlParse(generateSiteMap(qActivityMap))>
</cffunction>

<cffunction name="Category" access="remote" output="no">
	<cfcontent type="text/xml" />
	<cfquery name="qCategories" datasource="#Application.Settings.DSN#">
	SELECT CategoryID,Name,Description,(SELECT     COUNT(ActC.Activity_LMS_CategoryID) AS Expr1
	FROM         ce_Activity_CategoryLMS AS ActC INNER JOIN
	  ce_Activity AS A ON ActC.ActivityID = A.ActivityID INNER JOIN
	  ce_Activity_PubGeneral AS PG ON A.ActivityID = PG.ActivityID
	WHERE     (ActC.CategoryID = C.CategoryID) AND (ActC.DeletedFlag = 'N') AND (A.DeletedFlag = 'N') AND (PG.PublishDate <= GETDATE()) AND (PG.RemoveDate > GETDATE()) AND 
	  (A.StatusID = 1)
	  ) As ActivityCount
	FROM ce_Sys_CategoryLMS C
	ORDER BY Name
	</cfquery>
	
	<cfquery name="qCategoryMap" dbtype="query">
		SELECT 'http://ccpd.uc.edu/category/' + CAST(CategoryID as VARCHAR) As url,'#DateFormat(now(),'mm/dd/yyyy')#' AS lastmod,'daily' As changefreq, '1.0' As priority
		FROM qCategories
	</cfquery>
	<cfreturn xmlParse(generateSiteMap(qCategoryMap))>
</cffunction>

<cffunction name="Specialty" access="remote" output="no">
	<cfcontent type="text/xml" />
	<cfquery name="qSpecialties" datasource="#Application.Settings.DSN#">
		SELECT SpecialtyID,Name,Description,(SELECT     COUNT(ActS.Activity_LMS_SpecialtyID) AS Expr1
		FROM         ce_Activity_SpecialtyLMS AS ActS INNER JOIN
		ce_Activity AS A ON ActS.ActivityID = A.ActivityID
		WHERE     (ActS.SpecialtyID = S.SpecialtyID) AND (ActS.DeletedFlag = 'N') AND (A.DeletedFlag = 'N')) As ActivityCount
		FROM ce_Sys_SpecialtyLMS S
		ORDER BY Name
	</cfquery>
	
	<cfquery name="qSpecialtyMap" dbtype="query">
		SELECT 'http://ccpd.uc.edu/specialty/' + CAST(SpecialtyID as VARCHAR) As url,'#DateFormat(now(),'mm/dd/yyyy')#' AS lastmod,'daily' As changefreq, '1.0' As priority
		FROM qSpecialties
	</cfquery>
	<cfreturn xmlParse(generateSiteMap(qSpecialtyMap))>
</cffunction>

<!---
Generates a valid Site Map XML from either a list of URLs or a query of URLs.

@param data      Either a list of URLs or a query. (Required)
@param lastmod      Date to use for all URLs as their lastmod property. If not passed, the value will not be used in the XML unless a query is used and the column lastmod exists. (Optional)
@param changefreq      Value to use for all URLs as their changefreq property. If not passed, the value will not be used in the XML unless a query is used and the column changefreq exists. (Optional)
@param priority      Value to use for all URLs as their priority property. If not passed, the value will not be used in the XML unless a query is used and the column priority exists. (Optional)
@return Returns a string.
@author Raymond Camden (ray@camdenfamily.com)
@version 2, August 14, 2007
--->
<cffunction name="generateSiteMap" output="false" returnType="string">
    <cfargument name="data" type="any" required="true">
    <cfargument name="lastmod" type="date" required="false">
    <cfargument name="changefreq" type="string" required="false">
    <cfargument name="priority" type="numeric" required="false">
    
    <cfset var header = "<?xml version=""1.0"" encoding=""UTF-8""?><urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">">
    <cfset var s = createObject('java','java.lang.StringBuffer').init(header)>
    <cfset var aurl = "">
    <cfset var item = "">
    <cfset var validChangeFreq = "always,hourly,daily,weekly,monthly,yearly,never">
    <cfset var newDate = "">
    <cfset var tz = getTimeZoneInfo().utcHourOffset>
    <cfset var btz = replaceList(tz, "+,-","")>
    
    <cfif structKeyExists(arguments, "changefreq") and not listFindNoCase(validChangeFreq, arguments.changefreq)>
        <cfthrow message="Invalid changefreq (#arguments.changefreq#) passed. Valid values are #validChangeFreq#">
    </cfif>

    <cfif structKeyExists(arguments, "priority") and (arguments.priority lt 0 or arguments.priority gt 1)>
        <cfthrow message="Invalid priority (#arguments.priority#) passed. Must be between 0.0 and 1.0">
    </cfif>
    
    <!--- reformat datetime as w3c datetime / http://www.w3.org/TR/NOTE-datetime --->
    <cfif structKeyExists(arguments, "lastmod")>            
        <cfset newDate = dateFormat(arguments.lastmod, "YYYY-MM-DD")>      
    </cfif>
    
    <!--- Support either a query or list of URLs --->
    <cfif isSimpleValue(arguments.data)>
        <cfloop index="aurl" list="#arguments.data#">
            <cfsavecontent variable="item">
                <cfoutput>
                <url>
                    <loc>#xmlFormat(aurl)#</loc>
                    <cfif structKeyExists(arguments,"lastmod")>
                    <lastmod>#newDate#</lastmod>
                    </cfif>
                    <cfif structKeyExists(arguments,"changefreq")>
                    <changefreq>#arguments.changefreq#</changefreq>
                    </cfif>
                    <cfif structKeyExists(arguments,"priority")>
                    <priority>#arguments.priority#</priority>
                    </cfif>
                </url>
                </cfoutput>
            </cfsavecontent>
            <cfset item = trim(item)>
            <cfset s.append(item)>
        </cfloop>
    <!--- url, lastmod, changefreq, and priority were changed to have the arguments.data.whatever and I also added the array notation to each like so [arguments.data.currentrow] --->
    <cfelseif isQuery(arguments.data)>
        <cfloop query="arguments.data">
            <cfsavecontent variable="item">
                <cfoutput>
                <url>
                    <loc>#xmlFormat(arguments.data.url[arguments.data.currentrow])#</loc>
                    <cfif listFindNoCase(arguments.data.columnlist,"lastmod")>
                        <cfset newDate = dateFormat(arguments.data.lastmod[arguments.data.currentrow], "YYYY-MM-DD")>     
                        <lastmod>#newDate#</lastmod>
                    </cfif>
                    <cfif listFindNoCase(arguments.data.columnlist,"changefreq")>
                    <changefreq>#arguments.data.changefreq[arguments.data.currentrow]#</changefreq>
                    </cfif>
                    <cfif listFindNoCase(arguments.data.columnlist,"priority")>
                    <priority>#arguments.data.priority[arguments.data.currentrow]#</priority>
                    </cfif>
                </url>
                </cfoutput>
            </cfsavecontent>
            <cfset item = trim(item)>
            <cfset s.append(item)>
        
        </cfloop>
    </cfif>    
    <cfset s.append("</urlset>")>

    <cfreturn s>
    
</cffunction>