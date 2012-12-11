<cfparam name="Attributes.ActivityID" default="" />

<cfif Attributes.ActivityID NEQ "">
	<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=Attributes.ActivityID)>
    <cfset ActivityBean = Application.Com.ActivityDAO.Read(ActivityBean)>
    
    <cfquery name="qGetEvalID" datasource="#Application.Settings.DSN#">
    	SELECT  AssessmentID,
        		Name
        FROM ce_Assessment
        WHERE 	<cfif ActivityBean.getParentActivityID() NEQ "">
        			ActivityID = <cfqueryparam value="#ActivityBean.getParentActivityID()#" cfsqltype="cf_sql_integer" /> AND
                <cfelse>
        			ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND
                </cfif>
        		AssessTypeID = <cfqueryparam value="1" cfsqltype="cf_sql_integer" /> AND
                DeletedFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char" />
  	</cfquery>
    
    <cfset Attributes.AssessmentID = qGetEvalID.AssessmentID>
    <cfset Attributes.AssessmentName = qGetEvalID.Name>
</cfif>