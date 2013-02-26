<cfparam name="Attributes.ActivityID" default="" />

<cfoutput>
<H1>#ActivityBean.getTitle()#</H1>
<!--- LOOP THROUGH ASSESSMENTS --->
<cfloop query="qGetAssessments">

    <cfswitch expression="#qGetAssessments.AssessType#">
        <!--- PRE TEST SETUP --->
        <cfcase value="Pre Test">
            <div>
                <!--- GATHER ASSESSMENT RESULTS --->
                <cfquery name="qAssessmentData" datasource="#Application.Settings.DSN#">
                    SELECT 	ResultID,
                            PersonID,
                            Score,
                            ResultStatusID
                    FROM ce_AssessResult ar
                    WHERE 	(AssessmentID = #qGetAssessments.AssessmentID#) AND
                            (DeletedFlag = 'N')
                </cfquery>
                
                <!--- DEVELOP REPORT QUERIES --->
                <cfset qSuccessResultsPre = QueryNew("PersonID,Score")>
                <cfset qFailResultsPre = QueryNew("PersonID,Score")>
                
                <cfloop query="qAssessmentData">
                    <!--- CHECK IF RESULT IS PASS/FAIL --->
                    <cfif qAssessmentData.Score GTE qGetAssessments.PassingScore>
                    	<!--- ADD RECORD TO PRETEST SUCCESS QUERY --->
                        <cfset QueryAddRow(qSuccessResultsPre, 1)>
                        
                        <cfset QuerySetCell(qSuccessResultsPre, "PersonID", qAssessmentData.PersonID)>
                        <cfset QuerySetCell(qSuccessResultsPre, "Score", qAssessmentData.Score)>
                    <cfelse>
                    	<!--- ADD RECORD TO PRETEST FAIL QUERY --->
                        <cfset QueryAddRow(qFailResultsPre, 1)>
                        
                        <cfset QuerySetCell(qFailResultsPre, "PersonID", qAssessmentData.PersonID)>
                        <cfset QuerySetCell(qFailResultsPre, "Score", qAssessmentData.Score)>
                    </cfif>
                </cfloop>
                
                <!--- DEVELOP CHART --->
                <cfchart format="jpg" show3d="true" chartwidth="300" chartheight="300" pieslicestyle="solid" title="Pass/Fail Records for the #qGetAssessments.AssessType#">
                    <cfchartseries type="pie" valueColumn="Score" itemColumn="Success" colorlist="##77BB11,##884444">
                        <cfchartdata item="Success" value="#qSuccessResultsPre.RecordCount#" />
                        <cfchartdata item="Fail" value="#qFailResultsPre.RecordCount#"  />
                    </cfchartseries>
                </cfchart>
        </cfcase>
        <!--- POST TEST SETUP --->
        <cfcase value="Post Test">
                <!--- GATHER ASSESSMENT RESULTS --->
                <cfquery name="qAssessmentData" datasource="#Application.Settings.DSN#">
                    SELECT 	ResultID,
                            PersonID,
                            Score,
                            ResultStatusID
                    FROM ce_AssessResult ar
                    WHERE 	(AssessmentID = #qGetAssessments.AssessmentID#) AND
                            (DeletedFlag = 'N')
                </cfquery>
                
                <!--- DEVELOP REPORT  QUERIES --->
                <cfset qSuccessResultsPost = QueryNew("PersonID,Score")>
                <cfset qFailResultsPost = QueryNew("PersonID,Score")>
                
                <cfloop query="qAssessmentData">
                    <!--- CHECK IF RESULT IS PASS/FAIL --->
                    <cfif qAssessmentData.Score GTE qGetAssessments.PassingScore>
                    	<!--- ADD RECORD TO POSTTEST SUCCESS QUERY --->
                        <cfset QueryAddRow(qSuccessResultsPost, 1)>
                        
                        <cfset QuerySetCell(qSuccessResultsPost, "PersonID", qAssessmentData.PersonID)>
                        <cfset QuerySetCell(qSuccessResultsPost, "Score", qAssessmentData.Score)>
                    <cfelse>
                    	<!--- ADD RECORD TO POSTTEST SUCCESS QUERY --->
                        <cfset QueryAddRow(qFailResultsPost, 1)>
                        
                        <cfset QuerySetCell(qFailResultsPost, "PersonID", qAssessmentData.PersonID)>
                        <cfset QuerySetCell(qFailResultsPost, "Score", qAssessmentData.Score)>
                    </cfif>
                </cfloop>
                
                <!--- DEVELOP CHART --->
                <cfchart format="jpg" show3d="true" chartwidth="300" chartheight="300" pieslicestyle="solid" title="Pass/Fail Records for the #qGetAssessments.AssessType#">
                    <cfchartseries type="pie" valueColumn="Score" itemColumn="Success" colorlist="##77BB11,##884444">
                        <cfchartdata item="Success" value="#qSuccessResultsPost.RecordCount#" />
                        <cfchartdata item="Fail" value="#qFailResultsPost.RecordCount#"  />
                    </cfchartseries>
                </cfchart>
        </cfcase>
    </cfswitch>
</cfloop>

<!--- COMPARE BOTH CHARTS --->
<cfif qGetAssessments.RecordCount GT 1>
    <!--- DEVELOP CHART --->
    <cfchart format="flash" show3d="true" chartwidth="500" chartheight="300" pieslicestyle="solid" title="Comparison of the Pre Test and Post Test results">
        <cfchartseries type="bar" valueColumn="Successes" itemColumn="Successes" colorlist="##77BB11,##884444">
            <cfchartdata item="Pre Test" value="#qSuccessResultsPre.RecordCount#"  />
            <cfchartdata item="Post Test" value="#qSuccessResultsPost.RecordCount#" />
        </cfchartseries>
        <cfchartseries type="bar" valueColumn="Fails" itemColumn="Fails" colorlist="##77BB11,##884444">
            <cfchartdata item="Pre Test" value="#qFailResultsPre.RecordCount#"  />
            <cfchartdata item="Post Test" value="#qFailResultsPost.RecordCount#" />
        </cfchartseries>
    </cfchart>
</cfif>
</cfoutput>