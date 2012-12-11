<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.ResultID" default="" />

<cfif Attributes.ActivityID NEQ "" AND Attributes.ResultID NEQ "">
	<cfoutput>
    <!--- GET EVALUATION --->
	<cfset ActivityBean = CreateObject("component","#Application.Settings.Com#Activity.Activity").Init(ActivityID=Attributes.ActivityID)>
    <cfset ActivityBean = Application.Com.ActivityDAO.Read(ActivityBean)>
    
    <cfif ActivityBean.getParentActivityID() NEQ "">
        <cfquery name="qGetAssess" datasource="#Application.Settings.DSN#">
            SELECT  AssessmentID,
                    Name
            FROM ce_Assessment
            WHERE 	
                    ActivityID = <cfqueryparam value="#ActivityBean.getParentActivityID()#" cfsqltype="cf_sql_integer" /> AND
                    DeletedFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char" />
        </cfquery>
        
        <cfif qGetAssess.RecordCount EQ 0>
        <cfquery name="qGetAssess" datasource="#Application.Settings.DSN#">
            SELECT  AssessmentID,
                    Name
            FROM ce_Assessment
            WHERE 	
                    ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND
                    DeletedFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char" />
        </cfquery>
        </cfif>
    <cfelse>
        <cfquery name="qGetAssess" datasource="#Application.Settings.DSN#">
            SELECT  AssessmentID,
                    Name
            FROM ce_Assessment
            WHERE 	
                    ActivityID = <cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND
                    DeletedFlag = <cfqueryparam value="N" cfsqltype="cf_sql_char" />
        </cfquery>
    </cfif>
    
    <cfset qQuestions = Application.Com.AssessQuestionGateway.getByAttributes(AssessmentID=qGetAssess.AssessmentID,DeletedFlag="N",OrderBy="Sort")>
    <link href="#Application.Settings.RootPath#/_styles/Assessment.css" type="text/css" />
    <table cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                        <cfset QuestionNo = 1>
                        <cfset QuestionCount = 1>
                        <cfset aAnswers = ArrayNew(2)>
                        
                        <div>
                        <cfloop query="qQuestions">
                        	<cfquery name="qGetAnswer" datasource="#Application.Settings.DSN#">
                            	SELECT AnswerID, VC1
                                FROM ce_AssessAnswer
                                WHERE QuestionID = <cfqueryparam value="#qQuestions.QuestionID#" cfsqltype="cf_sql_integer" /> AND ResultID = <cfqueryparam value="#Attributes.ResultID#" cfsqltype="cf_sql_integer" />
                            </cfquery>
                            
                            <cfswitch expression="#qQuestions.QuestionTypeID#">
                                <!--- TEXT SINGLE LINE --->
                                <cfcase value="3">
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        <div class="Caption3Text">#qQuestions.LabelText#<span></span></div>
                                    </div>
                                    <div class="Answers">
                                        <div class="Answer" id="#QuestionNo#VC1"><input type="text" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#|vc1" class="TextAreaAnswer" value="#qGetAnswer.VC1#"></div>
                                    </div>
                                </cfcase>
                                <!--- TEXT MULTI LINE --->
                                <cfcase value="4">
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        #qQuestions.LabelText#
                                    </div>
                                    <div class="Answers">
                                        <div class="Answer" id="#QuestionNo#VC1"><textarea name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#|vc1" class="TextAreaAnswer">#qGetAnswer.VC1#</textarea></div>
                                    </div>
                                </cfcase>
                                <!--- CAPTION 1 --->
                                <cfcase value="5">
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        <div class="Caption1Text">#qQuestions.LabelText#<span></span></div>
                                    </div>
                                </cfcase>
                                <!--- CAPTION 2 --->
                                <cfcase value="6">
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        <div class="Caption2Text">#qQuestions.LabelText#<span></span></div>
                                    </div>
                                </cfcase>
                                <!--- CAPTION 3 --->
                                <cfcase value="7">
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        <div class="Caption3Text">#qQuestions.LabelText#<span></span></div>
                                    </div>
                                </cfcase>
                                <!--- RATING 1-5, AGREE-DISAGREE --->
                                <cfcase value="9">
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        <div class="QuestionNo">#QuestionNo#.</div><div class="QuestionText">#qQuestions.LabelText#</div>
        
                                        <cfset QuestionNo = QuestionNo + 1>
                                    </div>
                                    <div class="Answers">
                                        <cfloop from="1" to="5" step="1" index="i">
                                        <div class="Answer" id="#QuestionNo#VC#i#"><input type="Radio" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#|vc#i#|#i#|#Chr(64+i)#" class="RadioAnswer" <cfif i EQ qGetAnswer.VC1>CHECKED </cfif>/><label for="#qQuestions.QuestionID#|vc#i#|#i#|#Chr(64+i)#">#Chr(64+i)#) #i#<cfif i EQ 1> - Strongly Disagree<cfelseif i EQ 5> - Strongly Agree</cfif></label></div>
                                        </cfloop>
                                    </div>
                                </cfcase>
                                <!--- RATING 1-5, EFFECTIVE NOT EFFECTIVE --->
                                <cfcase value="11">
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        <div class="QuestionNo">#QuestionNo#.</div><div class="QuestionText">#qQuestions.LabelText#</div>
        
                                        <cfset QuestionNo = QuestionNo + 1>
                                    </div>
                                    <div class="Answers">
                                    	<cfset CharCount = 1>
                                        <cfloop from="5" to="1" step="-1" index="i">
                                        <div class="Answer" id="#QuestionNo#VC#i#">
                                        	<input type="Radio" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#|vc#i#|#i#|#Chr(64+CharCount)#|<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="RadioAnswer" <cfif i EQ qGetAnswer.VC1>CHECKED </cfif>/>
                                            <label for="#qQuestions.QuestionID#|vc#i#|#i#|#Chr(64+CharCount)#|<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>">#Chr(64+CharCount)#) #i#<cfif i EQ 1> - Not Effective<cfelseif i EQ 5> - Effective</cfif></label>
                                            </div>
                                        
                                        <cfset CharCount = CharCount + 1>
                                        </cfloop>
                                    </div>
                                </cfcase>
                                <cfdefaultcase>
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        <div class="QuestionNo">#QuestionNo#.</div><div class="QuestionText">#qQuestions.LabelText#</div>
        
                                        <cfset QuestionNo = QuestionNo + 1>
                                    </div>
                                    <div class="Answers">
                                        <cfloop from="1" to="10" step="1" index="i">
                                        <cfif #Evaluate("vc#i#")# NEQ "">
                                        <div class="Answer" id="#QuestionNo#VC#i#"><input type="Radio" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#|vc#i#|#Evaluate("vc#i#")#|#Chr(64+i)#" class="RadioAnswer" <cfif qGetAnswer.VC1 EQ Evaluate('vc#i#')>CHECKED </cfif>/><label for="#qQuestions.QuestionID#|vc#i#|#Evaluate("vc#i#")#|#Chr(64+i)#">#Chr(64+i)#) #Evaluate("vc#i#")#</label></div>
                                        </cfif>
                                        </cfloop>
                                    </div>
                                </cfdefaultcase>
                            </cfswitch>
                        </cfloop>
                        </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </cfoutput>
</cfif>