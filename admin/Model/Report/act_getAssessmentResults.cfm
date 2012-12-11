<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.PersonID" default="" />

<cfif Attributes.ActivityID NEQ "" AND Attributes.PersonID NEQ "">
	<cfset qAssessments = Application.Com.AssessmentGateway.getByAttributes(ActivityID=Attributes.ActivityID)>
    <cfset qAssessmentList = "">
    
    <cfloop query="qAssessments">
        <cfset qAssessmentList = ListAppend(qAssessmentList, qAssessments.AssessmentID, ",")>
    </cfloop>
    
    <cfif qAssessmentList NEQ "">
        <cfquery name="qGetResults" datasource="#Application.Settings.DSN#">
            SELECT  ar.ResultID,
                    ar.AssessmentID,
                    ass.Name AS AssessmentName,
                    ars.Name AS StatusName
            FROM ce_AssessResult ar
            INNER JOIN ce_Assessment ass ON ass.AssessmentID = ar.AssessmentID
            INNER JOIN ce_Sys_AssessResultStatus ars ON ars.ResultStatusID = ar.ResultStatusID
            WHERE 	ar.AssessmentID IN (#qAssessmentList#) AND 
                    ar.PersonID = <cfqueryparam value="#Attributes.PersonID#" cfsqltype="cf_sql_integer" /> AND
                    isNull(ar.Score,0) IN (SELECT MAX(isNull(ar2.Score,0)) FROM ce_AssessResult ar2 WHERE ar2.AssessmentID IN (#qAssessmentList#) AND ar2.PersonID = <cfqueryparam value="#Attributes.PersonID#" cfsqltype="cf_sql_integer" />) AND
                    ass.DeletedFlag = 'N'
            ORDER BY ar.AssessmentID, CreatedBy
        </cfquery>
	<cfelse>
    	There are no assessments.
        <cfabort>
    </cfif>
</cfif>