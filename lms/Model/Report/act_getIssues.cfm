<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.Title" default="">
<cfparam name="Attributes.CreatedBy" default="">
<cfparam name="Attributes.StartDate" default="">
<cfparam name="Attributes.EndDate" default="">
<cfparam name="Attributes.Reason" default="">

<cfset Filter = "">

<cfif Attributes.ActivityID NEQ "">
	<cfset Filter = ListAppend(Filter,"ActivityID = #Attributes.ActivityID#","|")>
</cfif>

<cfif Attributes.Title NEQ "">
	<cfset Attributes.Title = Replace(Attributes.Title,"'","''","ALL")>
	<cfset Filter = ListAppend(Filter,"Title LIKE '%#Attributes.Title#%'","|")>
</cfif>

<cfif Attributes.CreatedBy NEQ "">
	<cfset Filter = ListAppend(Filter,"CreatedBy = #Attributes.CreatedBy#","|")>
</cfif>

<cfif Attributes.StartDate NEQ "" AND Attributes.EndDate NEQ "">
	<cfset Filter = ListAppend(Filter,"ReleaseDate BETWEEN '#Attributes.StartDate# 00:00:00' AND '#Attributes.EndDate# 23:59:59'","|")>
</cfif>

<cfset Filter = Replace(Filter,"|"," AND ","ALL")>

<cfset FieldSet = "ActivityID,Title,ReleaseDate">

<cfquery name="qIssues" datasource="#Application.Settings.DSN#">
/* Status Missing */
SELECT #FieldSet#,'No Status' As Reason
FROM ce_Activity
WHERE 
	StatusID IS NULL<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>
OR
	StatusID = ''<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>

/* Sponsorship Missing */
UNION
SELECT #FieldSet#,'No Sponsorship' As Reason
FROM ce_Activity
WHERE
	Sponsorship IS NULL<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>
OR
	Sponsorship = ''<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>

/* Jointly But No Sponsorship */
UNION
SELECT #FieldSet#,'Joint Sponsored But No Sponsor' As Reason
FROM ce_Activity
WHERE
	Sponsorship = 'J' AND Sponsor IS NULL<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>
OR
	Sponsorship = 'J' AND Sponsor = ''<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>

/* Differing Sponsorship Between Child Activities */
UNION
SELECT #FieldSet#,'Differing Sponsorship Between Child Activities' As Reason
FROM ce_Activity A
WHERE
	(SELECT Count(ActivityID) FROM ce_Activity A2 WHERE A2.ParentActivityID=A.ActivityID AND Sponsorship='J') > 0
AND 
	(SELECT Count(ActivityID) FROM ce_Activity A2 WHERE A2.ParentActivityID=A.ActivityID AND Sponsorship='D') > 0
<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>

/* Differing Sponsorship Between Parent and Children Activities */
UNION
SELECT #FieldSet#,'Differing Sponsorship Between Parent and Children Activities' As Reason
FROM ce_Activity A
WHERE
	(SELECT Count(ActivityID) FROM ce_Activity A2 WHERE A2.ParentActivityID=A.ActivityID AND A2.Sponsorship <> A.Sponsorship) > 0
	<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>

<!---UNION
SELECT 'Location for this activity is missing.' AS Reason
FROM ce_Activity
WHERE isNull(City,'') = '' OR isNull(State,'') = ''
<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>

UNION
SELECT 'Location for this activity is missing.' AS Reason
FROM ce_Activity
WHERE isNull(City,'') = '' OR isNull(State,'') = ''
<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>
--->
/* Differing Grouping Between Parent and Children Activities */
UNION
SELECT #FieldSet#,'Differing Grouping Between Parent and Children Activities' As Reason
FROM ce_Activity A
WHERE
	(SELECT Count(ActivityID) FROM ce_Activity A2 WHERE A2.ParentActivityID=A.ActivityID AND A2.GroupingID <> A.GroupingID) > 0
	<cfif Filter NEQ ""> AND #PreserveSingleQuotes(Filter)#</cfif>
ORDER BY 2
</cfquery>

<!--- GET REASONS --->
<cfquery name="qReasons" dbtype="query">
	SELECT DISTINCT Reason
	FROM qIssues
	ORDER BY Reason
</cfquery>

<cfset IssuesPager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
<cfset IssuesPager.setQueryToPaginate(qIssues)>
<cfset IssuesPager.setBaseLink("#myself#Report.Issues") />
<cfset IssuesPager.setItemsPerPage(50) />
<cfset IssuesPager.setUrlPageIndicator("page") />
<cfset IssuesPager.setShowNumericLinks(true) />
<cfset IssuesPager.setClassName("green") />