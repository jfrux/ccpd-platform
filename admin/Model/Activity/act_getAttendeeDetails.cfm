<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.PersonID" default="" />

<!--- CREATE ATTENDEEBEAN --->
<cfset AttendeeBean = CreateObject("component","#Application.Settings.Com#Attendee.Attendee").Init(ActivityID=Attributes.ActivityID,PersonID=Attributes.PersonID)>
<cfset AttendeeExists = Application.Com.AttendeeDAO.Exists(AttendeeBean)>

<cfif AttendeeExists>
	<!--- GET ATTENDEE INFORMATION --->
	<cfset AttendeeBean = Application.Com.AttendeeDAO.Read(AttendeeBean)>
    
    <cfif AttendeeBean.getStatusID() NEQ "">
		<!--- GET ATTENDEE STATUS --->
        <cfquery name="AttendeeStatus" datasource="#Application.Settings.DSN#">
            SELECT Name
            FROM ce_Sys_AttendeeStatus
            WHERE AttendeeStatusID = <cfqueryparam value="#AttendeeBean.getStatusID()#" cfsqltype="cf_sql_integer" />
        </cfquery>
        
        <cfset AttendeeStatusName = AttendeeStatus.Name>
    </cfif>
    
    <!--- GET ASSESSMENTS --->
	<cfset qAssessments = Application.Com.AssessmentGateway.getByViewAttributes(ActivityID=Attributes.ActivityID,DeletedFlag="N")>
    
    <!--- GET RESULTSTATUSES --->
    <cfset ResultStatuses = "">
    
    <cfquery name="qResultStatuses" datasource="#Application.Settings.DSN#">
    	SELECT ResultStatusID, Name
        FROM ce_Sys_AssessResultStatus
        WHERE DeletedFlag = 'N'
    </cfquery>
    
    <cfif qResultStatuses.RecordCount GT 0>
    <cfloop query="qResultStatuses">
    	<cfset ResultStatuses = ListAppend(ResultStatuses, qResultStatuses.ResultStatusID & "|" & qResultStatuses.Name, ",")>
    </cfloop>
    </cfif>
    
	<!--- CREATE ASSESSMENT ARRAY --->
    <cfset arrAssessment = ArrayNew(3)>
    <cfset AssessmentCount = 1>
    <cfset ResultCount = 1>
    
    <!--- GET ASSESSMENT RESULTS --->
    <cfloop query="qAssessments">
    	<cfset qResults = Application.Com.AssessResultGateway.getByAttributes(AssessmentID=qAssessments.AssessmentID,PersonID=Attributes.PersonID,DeletedFlag="N")>
        
        <!--- FILL ARRAY --->
        <cfloop query="qResults">
        	<cfset arrAssessment[AssessmentCount][ResultCount][1] = qResults.ResultStatusID>
        	<cfset arrAssessment[AssessmentCount][ResultCount][2] = qResults.Score>
			<cfset ResultCount = ResultCount + 1>
        </cfloop>
        
        <!--- ADJUST COUNT VARS --->
    	<cfset ResultCount = 1>
		<cfset AssessmentCount = AssessmentCount + 1>
    </cfloop>
</cfif>