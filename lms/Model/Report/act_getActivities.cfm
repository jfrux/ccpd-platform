<cfparam name="Attributes.CategoryID" default="">
<cfif Attributes.Fuseaction EQ "Report.Assessment">
	<cfif Attributes.CategoryID NEQ "">
        <cfset qActivitiesPre = Application.Com.ActivityGateway.getByReportAttributes(StartDate=DateFormat(DateAdd("yyyy",-1,Now()),"MM/DD/YYYY")& "00:00:00",EndDate=DateFormat(DateAdd("m",4,Now()),"MM/DD/YYYY") & "23:59:59",NeedAssessments=1,CategoryID=Attributes.CategoryID)>
    <cfelse>
        <cfset qActivitiesPre = Application.Com.ActivityGateway.getByReportAttributes(StartDate=DateFormat(DateAdd("yyyy",-1,Now()),"MM/DD/YYYY")& "00:00:00",EndDate=DateFormat(DateAdd("m",4,Now()),"MM/DD/YYYY") & "23:59:59",NeedAssessments=1)>
    </cfif>
<cfelse>
	<cfif Attributes.CategoryID NEQ "">
        <cfset qActivitiesPre = Application.Com.ActivityGateway.getByReportAttributes(StartDate=DateFormat(DateAdd("yyyy",-1,Now()),"MM/DD/YYYY")& "00:00:00",EndDate=DateFormat(DateAdd("m",4,Now()),"MM/DD/YYYY") & "23:59:59",CategoryID=Attributes.CategoryID)>
    <cfelse>
        <cfset qActivitiesPre = Application.Com.ActivityGateway.getByReportAttributes(StartDate=DateFormat(DateAdd("yyyy",-1,Now()),"MM/DD/YYYY")& "00:00:00",EndDate=DateFormat(DateAdd("m",4,Now()),"MM/DD/YYYY") & "23:59:59")>
    </cfif>
</cfif>

<cfquery name="qActivities" dbtype="query">
	SELECT *
    FROM qActivitiesPre
    ORDER BY StartDate DESC
</cfquery>