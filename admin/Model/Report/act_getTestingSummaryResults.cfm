<cfparam name="Attributes.ActivityID" default="" />

<cfif Attributes.ActivityID NEQ "" AND Attributes.ActivityID NEQ "Undefined">
	<cfoutput>
    <!--- GET ACTIVITY INFO --->
	<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=Attributes.ActivityID)>
    <cfset ActivityBean = Application.Com.ActivityDAO.Read(ActivityBean)>
    
    <!--- GET ALL ASSESSMENTS --->
    <cfquery name="qGetAssessments" datasource="#Application.Settings.DSN#">
    	SELECT 	ass.AssessmentID, 
        		ass.Name AS AssessName,
        		ass.PassingScore,
        		sat.Name AS AssessType
        FROM ce_Assessment ass
        INNER JOIN ce_Sys_AssessType sat ON sat.AssessTypeID = ass.AssessTypeID
        WHERE 
        	(ass.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND ass.AssessTypeID = 2 AND ass.DeletedFlag = 'N') 
        OR 
        	(ass.ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND ass.AssessTypeID = 3 AND ass.DeletedFlag = 'N')
        ORDER BY ass.AssessTypeID DESC
    </cfquery>
    </cfoutput>
<cfelse>
	Please select an activity from the list to the right.<cfabort>
</cfif>