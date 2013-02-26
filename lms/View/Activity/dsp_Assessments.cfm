<cfparam name="Session.PersonID" default="" />
<!--- STEP LOGIC --->
<cfquery name="qGetPostTest" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID
	FROM ce_Activity_PubComponent
	WHERE ComponentID = 11 AND ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>
<cfquery name="qGetPretest" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID
	FROM ce_Activity_PubComponent
	WHERE ComponentID = 12 AND ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>
<cfquery name="qGetEval" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID
	FROM ce_Activity_PubComponent
	WHERE ComponentID = 5 AND ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>

<cfparam name="PreTestExists" default="false" />
<cfif qGetPretest.RecordCount GT 0>
	<cfset PreTestExists = true>
</cfif>
<cfparam name="PostTestExists" default="false" />
<cfif qGetPostTest.RecordCount GT 0>
	<cfset PostTestExists = true>
</cfif>
<cfparam name="EvalExists" default="false" />
<cfif qGetEval.RecordCount GT 0>
	<cfset EvalExists = true>
</cfif>

<!--- COUNTS --->
<cfquery name="qAssCount" datasource="#Application.Settings.DSN#">SELECT COUNT(PubComponentID) AS AssessCount FROM ce_Activity_PubComponent	WHERE (ComponentID IN (5,11,12)) AND (ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />) AND (DeletedFlag = 'N')</cfquery>
<cfquery name="qMatCount" datasource="#Application.Settings.DSN#">SELECT COUNT(PubComponentID) AS MaterialCount FROM ce_Activity_PubComponent	WHERE (ComponentID IN (3, 4, 9, 13, 14, 10)) AND (ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />) AND (DeletedFlag = 'N')</cfquery>

<cfset Steps = "Status">
<cfif PretestExists>
	<cfset Steps = ListAppend(Steps,"PreTest",",")>
</cfif>
<cfif qMatCount.MaterialCount GT 0>
	<cfset Steps = ListAppend(Steps,"Material",",")>
</cfif>
<cfif PostTestExists>
	<cfset Steps = ListAppend(Steps,"PostTest",",")>
</cfif>
<cfif EvalExists>
	<cfset Steps = ListAppend(Steps,"Eval",",")>
</cfif>

<cfloop from="1" to="#ListLen(Steps,',')#" index="i">
	<cfset "#ListGetAt(Steps,i)#Step" = i>
</cfloop>
<script src="/lms/_scripts/jquery.dimensions.pack.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
	
	<cfif Session.PersonID GT 0>
	/* ASSESSMENT FUNCTIONS START */
		//OPEN ASSESSDIALOG
		$(document).scroll(function() {
			if(bAssessOpen) {
				$("#AssessmentDiv").show().css({
					"top":$(document).scrollTop()+25,
					"margin-left":"-350px",
					"z-index":"9999"
				});
			}
		});	
	/* ASSESSMENT FUNCTIONS END */
	</cfif>
});
</script>
<cfoutput>
<!--- CHECK IF USER IS CURRENTLY AN ATTENDEE --->
<!--- CHECK IF USER IS LOGGED IN --->
<cfif Session.PersonID GT 0>
	<!--- CREATE ATTENDEEBEAN --->
	<cfset AttendeeBean = CreateObject("component","#Application.Settings.Com#Attendee.Attendee").Init(ActivityID=Attributes.ActivityID,PersonID=Session.PersonID)>
    <cfset AttendeeExists = Application.Com.AttendeeDAO.Exists(AttendeeBean)>
    
    <!--- CHECK IF USER IS AN ATTENDEE --->
    <cfif AttendeeExists>
		<!--- GET ATTENDEE'S ACTIVITY STATUS --->
        <cfset AttendeeStatus = Application.ActivityAttendee.getActivityStatus(ActivityID=Attributes.ActivityID,PersonID=Session.PersoniD)>
    <cfelse>
    	<!--- USER IS NOT AN ATTENDEE YET --->
    	<cfset AttendeeStatus = "Unregistered">
	</cfif>
<cfelse>
	<!--- USER IS NOT LOGGED IN --->
	<cfset AttendeeStatus = "Not Logged in">
</cfif>

<cfloop query="qAssessments">
	<cfswitch expression="#qAssessments.ComponentID#">
		<!---- EVALUATION --->
		<cfcase value="5">
			<cfif Session.PersonID GT 0 AND AttendeeStatus NEQ "Unregistered" AND AttendeeStatus NEQ "Pending">
            	<!--- CHECK TO MAKE SURE PRETEST DOESNT EXIST/WAS COMPLETED, POSTTEST DOESNT EXIST/WAS COMPLETED AND ATTENDEE DIDNT FAIL --->
            	<cfif PretestStatus EQ 1 AND PostTestStatus EQ 1 AND AttendeeStatus NEQ "Terminated" AND AttendeeStatus NEQ "">
					<!--- GET ASSESSMENT --->
                    <cfset AssessmentBean = CreateObject("component","#Application.Settings.Com#Assessment.Assessment").Init(AssessmentID=qAssessments.AssessmentID)>
                    <cfset AssessmentBean = Application.Com.AssessmentDAO.Read(AssessmentBean)>
                    
                    <!--- GET ASSESSRESULT --->
                    <cfset AssessResultBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(AssessmentID=qAssessments.AssessmentID,PersonID=Session.Person.getPersonID())>
                    
                    <!--- CHECK IF RESULT EXISTS --->
                    <cfif Application.Com.AssessResultDAO.Exists(AssessResultBean)>
                       <cfset AssessResultBean = Application.Com.AssessResultDAO.Read(AssessResultBean)>
                        <cfset ResultStatusCode = Application.Assessment.getResultCode(ResultStatusID=AssessResultBean.getResultStatusID())>
                        
                        <div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
							<div class="Act-BoxStep">
								<h5>STEP</h5>
								<div class="StepNumber">#EvalStep#</div>
							</div>
							<div class="Act-BoxItemContent">
								<h4>Evaluation</h4>
								<p>
								<!--- ASSESSMENT HAS NOT BEEN STARTED ---->
								<cfif AssessResultBean.getResultStatusID() EQ "">
									<a href="javascript://" id="StartEval|#qAssessments.AssessmentID#" class="AssessLink">Start Evaluation</a><span id="StartEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
								<!--- CONTINUE ASSESSMENT --->
								<cfelseif AssessResultBean.getResultStatusID() EQ 2>
									<a href="javascript://" class="AssessLink" id="ContEval|#qAssessments.AssessmentID#">Continue Evaluation</a><span id="ContEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
								<!--- COMPLETED ASSESSMENT --->
								<cfelseif AssessResultBean.getResultStatusID() EQ 1 OR AssessResultBean.getResultStatusID() EQ 3>
									Complete!
								</cfif>
								</p>
							</div>
						</div>
                    <cfelse>
                        <cfif PretestStatus EQ 1 AND PostTestStatus EQ 1>
						 <div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
							<div class="Act-BoxStep">
								<h5>STEP</h5>
								<div class="StepNumber">#EvalStep#</div>
							</div>
							<div class="Act-BoxItemContent">
                                <h4>Evaluation</h4>
                               <p>
								<a href="javascript://" id="StartEval|#qAssessments.AssessmentID#" class="AssessLink">Start Evaluation</a><span id="StartEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
								</p>
                            </div>
						</div>
                        <cfelse>
                         <div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
							<div class="Act-BoxStep">
								<h5>STEP</h5>
								<div class="StepNumber">#EvalStep#</div>
							</div>
							<div class="Act-BoxItemContent">
                                <h4>Evaluation</h4>
								<p>
								<span id="StartEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> Required</cfif></span>
                                </p>
                            </div>
						</div>
                        </cfif>
                    </cfif>
                <cfelse>
                   	<div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
						<div class="Act-BoxStep">
							<h5>STEP</h5>
							<div class="StepNumber">#EvalStep#</div>
						</div>
						<div class="Act-BoxItemContent">
							<h4>Evaluation</h4>
							<p><em>Requires completed post-test</em></p>
						</div>
					</div>
                </cfif>
			<cfelse>
				<div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
					<div class="Act-BoxStep">
						<h5>STEP</h5>
						<div class="StepNumber">#EvalStep#</div>
					</div>
					<div class="Act-BoxItemContent">
						<h4>Evaluation</h4>
						<p></p>
					</div>
				</div>
            </cfif>
		</cfcase>
		<!---- POST TEST --->
		<cfcase value="11">
			<cfif Session.PersonID GT 0 AND AttendeeStatus NEQ "Unregistered" AND AttendeeStatus NEQ "Pending">
            	<!--- CHECK IF PRETEST DOES NOT EXIST AND ATTENDEE HAS NOT FAILED OR PRETEST IS NOT IN PROGRESS AND THEY HAVE NOT FAILED --->
            	<cfif PretestStatus EQ 1 AND AttendeeStatus NEQ "Terminated" AND AttendeeStatus NEQ "" OR PreTestStatus NEQ 2 AND AttendeeStatus NEQ "Terminated" AND AttendeeStatus NEQ "">
					<!--- GET ASSESSMENT --->
                    <cfset AssessmentBean = CreateObject("component","#Application.Settings.Com#Assessment.Assessment").Init(AssessmentID=qAssessments.AssessmentID)>
					<cfset AssessmentBean = Application.Com.AssessmentDAO.Read(AssessmentBean)>
                    
                    <!--- GET ASSESSRESULT --->
                    <cfset AssessResultBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(AssessmentID=qAssessments.AssessmentID,PersonID=Session.Person.GetPersonID())>
                    
                    <!--- CHECK IF  ASSESSRESULT EXISTS --->
                    <cfset ResultFound = false>
                    <cfif Application.Com.AssessResultDAO.ExistsOpenPostTest(AssessResultBean)>
                        <cfset AssessResultBean = Application.Com.AssessResultDAO.readOpenPosttest(AssessResultBean)>
                    	<cfset ResultFound = true>
                    <cfelseif Application.Com.AssessResultDAO.Exists(AssessResultBean)>
                        <cfset AssessResultBean = Application.Com.AssessResultDAO.readPosttest(AssessResultBean)>
                    	<cfset ResultFound = true>
                    </cfif>
                    
                    <cfif ResultFound>
						<div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
							<div class="Act-BoxStep">
								<h5>STEP</h5>
								<div class="StepNumber">#PostTestStep#</div>
							</div>
							<div class="Act-BoxItemContent">
								<h4>Post-Test</h4>
								<p>
								<!--- ASSESSMENT HAS NOT BEEN STARTED ---->
								<cfif AssessResultBean.getResultStatusID() EQ "">
									<cfset ResultStatusCode = Application.Assessment.getResultCode(ResultStatusID=AssessResultBean.getResultStatusID())>
									<a href="javascript://" id="StartEval|#qAssessments.AssessmentID#" class="AssessLink">Start Assessment</a>
									<span id="StartEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
								<!--- CONTINUE ASSESSMENT --->
								<cfelseif AssessResultBean.getResultStatusID() EQ 2>
									<cfset ResultStatusCode = Application.Assessment.getResultCode(ResultStatusID=AssessResultBean.getResultStatusID())>
									<a href="javascript://" class="AssessLink" id="ContEval|#qAssessments.AssessmentID#">Continue Assessment</a>
									<span id="ContEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
								<!--- COMPLETED ASSESSMENT --->
								<cfelseif AssessResultBean.getResultStatusID() EQ 1 OR AssessResultBean.getResultStatusID() EQ 3>
									<!--- GET THE NUMBER OF TIMES THE ASSESSMENT HAS BEEN TRIED --->
									<cfset AttemptCount = Application.Assessment.AttemptCount(AssessmentID=qAssessments.AssessmentID,PersonID=Session.Person.getPersonID())>
									
									<!--- CHECK IF THE USER HAS REACHED MAXATTEMPTS --->
									<cfif AssessmentBean.getMaxAttempts() GT AttemptCount AND AttendeeStatus NEQ "Complete" OR AssessmentBean.getMaxAttempts() EQ 0 AND AttendeeStatus NEQ "Complete">
										<cfset ResultStatusCode = Application.Assessment.getResultCode(ResultStatusID=AssessResultBean.getResultStatusID())>
										<!--- CHECK IF THE ASSESSMENT WAS PASSED/FAILED --->
										<cfif AssessResultBean.getScore() LT AssessmentBean.getPassingScore()>
											Complete! <strong>Failed #AssessResultBean.getScore()#%</strong><br />
											<a href="javascript://" class="AssessLink" id="RetryEval|#qAssessments.AssessmentID#">Retry</a>
										<cfelse>
											Complete! <font color="green"><strong>Passed #AssessResultBean.getScore()#%</strong></font><br />
											<cfif AssessResultBean.getScore() LT 100>
											<br />
											<a href="javascript://" class="AssessLink" id="RetryEval|#qAssessments.AssessmentID#">Retry</a>
											</cfif>
										</cfif>
									<cfelse>
										<!--- CHECK IF THE ASSESSMENT WAS PASSED/FAILED --->
										<cfset AllAssessFailed = Application.Assessment.AllAssessFailed(AssessmentID=qAssessments.AssessmentID,PersonID=Session.Person.getPersonID())>
                                        
										<cfset PassFail = getToken(AllAssessFailed,1,"|")>
										<cfset AssessScore = getToken(AllAssessFailed,2,"|")>
										
										<!--- GET BEST ASSESSRESULT RECORD --->
										<cfset BestResult = Application.Assessment.getBestResult(AssessmentID=qAssessments.AssessmentID,PersonID=Session.Person.getPersonID())>
										<cfset ResultStatusCode = Application.Assessment.getResultCode(ResultStatusID=BestResult.ResultStatusID)>
										
										<cfif PassFail EQ 1>
											Complete! <strong>Failed #AssessScore#%</strong>
										<cfelse>
											Complete! <font color="green"><strong>Passed #AssessScore#%</strong></font>
										</cfif>
									</cfif>
								</cfif>
								</p>
							</div>
						</div>
                    <cfelse>
                        <!--- ATTENDEE HAS EITHER FINISHED PRETEST OR PRETEST DOESNT EXIST --->
                        <cfif PretestStatus EQ 1>
                           <div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
								<div class="Act-BoxStep">
									<h5>STEP</h5>
									<div class="StepNumber">#PostTestStep#</div>
								</div>
								<div class="Act-BoxItemContent">
									<h4>Post-Test</h4>
									<p>
									<a href="javascript://" id="StartEval|#qAssessments.AssessmentID#" class="AssessLink">Start Assessment</a><span id="StartEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
									</p>
                            	</div>
							</div>
                        <!--- ATTENDEE HAS NOT FINISHED PRETEST --->
                        <cfelseif PretestStatus NEQ 1>
							<div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
								<div class="Act-BoxStep">
									<h5>STEP</h5>
									<div class="StepNumber">#PostTestStep#</div>
								</div>
								<div class="Act-BoxItemContent">
									<h4>Post-Test</h4>
									<p><span id="StartEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"><em>Required</em></cfif></span></p>
								</div>
							</div>
                        </cfif>
                    </cfif>
				<cfelse>
					<div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
						<div class="Act-BoxStep">
							<h5>STEP</h5>
							<div class="StepNumber">#PostTestStep#</div>
						</div>
						<div class="Act-BoxItemContent">
							<h4>Post-Test</h4>
						</div>
					</div>
                </cfif>
			<cfelse>
				<div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
					<div class="Act-BoxStep">
						<h5>STEP</h5>
						<div class="StepNumber">#PostTestStep#</div>
					</div>
					<div class="Act-BoxItemContent">
						<h4>Post-Test</h4>
					</div>
				</div>
			</cfif>
            <br />
		</cfcase>
		<!---- PRE TEST --->
		<cfcase value="12">
			<cfif Session.PersonID GT 0 AND AttendeeStatus NEQ 3 AND AttendeeStatus NEQ "Unregistered" AND AttendeeStatus NEQ "Pending" AND AttendeeStatus NEQ "">
				<!--- GET ASSESSMENT --->
				<cfset AssessmentBean = CreateObject("component","#Application.Settings.Com#Assessment.Assessment").Init(AssessmentID=qAssessments.AssessmentID)>
				<cfset AssessmentBean = Application.Com.AssessmentDAO.Read(AssessmentBean)>
                
                <!--- GET ASSESSRESULT --->
                <cfset AssessResultBean = CreateObject("component","#Application.Settings.Com#AssessResult.AssessResult").Init(AssessmentID=qAssessments.AssessmentID,PersonID=Session.Person.GetPersonID())>
                
                <!--- CHECK IF RESULT EXISTS --->
                <cfif Application.Com.AssessResultDAO.Exists(AssessResultBean)>
                    <cfset AssessResultBean = Application.Com.AssessResultDAO.Read(AssessResultBean)>
                    <cfset ResultStatusCode = Application.Assessment.getResultCode(ResultStatusID=AssessResultBean.getResultStatusID())>
                    
                    <div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
						<div class="Act-BoxStep">
							<h5>STEP</h5>
							<div class="StepNumber">#PreTestStep#</div>
						</div>
						<div class="Act-BoxItemContent">
                        <h4>Pre-Test</h4>
						<p>
                                <!--- ASSESSMENT HAS NOT BEEN STARTED ---->
                                <cfif AssessResultBean.getResultStatusID() EQ "">
                                    <a href="javascript://" id="StartEval|#qAssessments.AssessmentID#|You must return and complete this pretest before you can proceed to the activity.|Your answers will be recorded and you may now proceed to the activity." class="AssessLink">Start Assessment</a><span id="StartEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
                                <!--- CONTINUE ASSESSMENT --->
                                <cfelseif AssessResultBean.getResultStatusID() EQ 2>
                                    <a href="javascript://" id="ContEval|#qAssessments.AssessmentID#|You must return and complete this pretest before you can proceed to the activity.|Your answers will be recorded and you may now proceed to the activity." class="AssessLink">Continue Assessment</a><span id="ContEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
                                <!--- COMPLETED ASSESSMENT --->
                                <cfelseif AssessResultBean.getResultStatusID() EQ 1 OR AssessResultBean.getResultStatusID() EQ 3>
                                   Complete!
                                </cfif>
                        </p>
                    </div>
                <cfelse>
					<div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
						<div class="Act-BoxStep">
							<h5>STEP</h5>
							<div class="StepNumber">#PreTestStep#</div>
						</div>
						<div class="Act-BoxItemContent">
							<div class="Eval#qAssessments.AssessmentID#">
								<h4>Pre-Test</h4>
								<p><a href="javascript://" id="StartEval|#qAssessments.AssessmentID#|You must return and complete this pretest before you can proceed to the activity.|Your answers will be recorded and you may now proceed to the activity." class="AssessLink">Start Assessment</a><span id="StartEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span><br />
								</p>
							</div>
						</div>
					</div>
                </cfif>
			<cfelse>
				<div class="Act-BoxItem" id="Eval#qAssessments.AssessmentID#">
						<div class="Act-BoxStep">
							<h5>STEP</h5>
							<div class="StepNumber">#PreTestStep#</div>
						</div>
						<div class="Act-BoxItemContent">
							<h4>Pre-Test</h4>
							<p>
							</p>
						</div>
					</div>
				</div>
			</cfif>
		</cfcase>
	</cfswitch>
</cfloop>

</cfoutput>
<!---
<cffunction access="public" name="RenderAssessment" output="no" returntype="string">
	<cfargument name="AssessmentID" required="yes" type="string" />
	<cfargument name="Name" required="yes" type="string" />
	<cfargument name="Type" requird="yes" type="string" />
	<cfargument name="StepNumber" required="yes" type="string" />
	<cfargument name="ResultStatusCode" required="yes" type="string" />

	<cfset var RtnOutput = "">
	
	<cfsavecontent variable="RtnOutput">
	<cfoutput>
	<div class="Act-BoxItem" id="Assess-#Arguments.AssessmentID#">
		<div class="Act-BoxStep">
			<h5>STEP</h5>
			<div class="StepNumber">#Arguments.StepNumber##</div>
		</div>
		<div class="Act-BoxItemContent">
			<h4>#Arguments.Type#</h4><br />
			<!--- ASSESSMENT HAS NOT BEEN STARTED ---->
			<cfif Arguments.ResultStatusCode EQ "">
				<img src="/lms/_images/icons/AssessStatus#Arguments.ResultStatusCode#.png" /><em>#Arguments.Name#</em><br />
				<a href="javascript://" id="StartEval|#qAssessments.AssessmentID#" class="AssessLink">Start Evaluation</a><span id="StartEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
			<!--- CONTINUE ASSESSMENT --->
			<cfelseif Arguments.ResultStatusCode EQ "IP">
				<img src="/lms/_images/icons/AssessStatus#ResultStatusCode#.png" /><em>#Arguments.Name#</em><br />
				<a href="javascript://" class="AssessLink" id="ContEval|#qAssessments.AssessmentID#">Continue Evaluation</a><span id="ContEval|#qAssessments.AssessmentID#|Required" class="Required"><cfif AssessmentBean.getRequiredFlag() EQ "Y"> <em>Required</em></cfif></span>
			<!--- COMPLETED ASSESSMENT --->
			<cfelseif Arguments.ResultStatusCode "C" OR Arguments.ResultStatusCode EQ "F">
				<img src="/lms/_images/icons/AssessStatus#ResultStatusCode#.png" /><em>#Arguments.Name#</em><br />
				Completed 
			</cfif><br />
			<sub>#qAssessments.Description#</sub>
		</div>
	</div>
	</cfoutput>
	</cfsavecontent>
</cffunction>--->