<!--- CHECK IF THEY HAVE TAKEN TEST BEFORE --->
<cfif NOT isDefined("URL.ResultID")>
	<cfinclude template="#Request.RootPath#/Includes/act_getResult.cfm" />
</cfif>

<cfinclude template="#Request.RootPath#/Includes/act_getDetail.cfm" />
<cfinclude template="#Request.RootPath#/Includes/act_getQuestions.cfm" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Evaluation</title>
<cfinclude template="#Request.RootPath#/Includes/inc_Scripts.cfm" />

<link href="styles/inc_styles.css" rel="stylesheet" type="text/css" />
<link href="styles/Assessment.css" rel="stylesheet" type="text/css" />
<link href="styles/jquery-themeroller.css" rel="stylesheet" type="text/css" />

</head>

<body>
<script>
<cfoutput>
var nActivity = #URL.AID#;
var nAssessment = #URL.AssessmentID#;
var nPerson = #Session.PersonID#;
var nResult = #URL.ResultID#;
</cfoutput>

	$(document).ready(function() {
		var AnswerFieldID = "";
	
		$(".RadioAnswer").click(function() {
			AnswerFieldID = $.ListGetAt(this.id,1,"|");		// SET ID VARIABLE
			AnswerToSubmit = $.ListGetAt(this.id,3,'|');
			AnswerText = $.ListGetAt(this.id,4,"|");		// SET ASNWER LETTER VARIABLE
			
			
			$("#AnswersList" + AnswerFieldID).html("<img src='images/loading_icon.gif' title='loading' />");	// PLACE LOADING ICON

			$.post(sRootPath + "/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerToSubmit, returnFormat: "plain" },
				function(data){
					var status = $.trim($.ListGetAt(data,1,"<"));
					
					if(status == 'true') {
						$("#AnswersList" + AnswerFieldID).html(AnswerText + "<img src='images/tick.png' title='Accepted' />");
						$("#AnswerContainer" + AnswerFieldID).removeClass("Required");
						$("#Question_" + AnswerFieldID).css("background-color", "#F7F7F7");
					} else if(status == 'false') {
						$("#AnswersList" + AnswerFieldID).html("<font color='#F00'>N/A</font>");
					}
			});

		});
		
		$(".TextAreaAnswer").blur(function() {
			AnswerFieldID = $.ListGetAt(this.id,1,"|");		
			AnswerText = $(this).val();		
			
			$("#AnswersList" + AnswerFieldID).html("<img src='images/loading_icon.gif' title='loading' />");	// PLACE LOADING ICON
			
			$.post(sRootPath + "/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerText, returnFormat: "plain" },
				function(data){
					var status = $.trim($.ListGetAt(data,1,"<"));
					
					if(status == 'true') {
						$("#AnswersList" + AnswerFieldID).html("<img src='images/tick.png' title='Accepted' />");
						$("#AnswerContainer" + AnswerFieldID).removeClass("Required");
						$("#Question_" + AnswerFieldID).css("background-color", "#F7F7F7");
					} else if(status == 'false') {
						$("#AnswersList" + AnswerFieldID).html("<font color='#F00'>N/A</font>");
					}
			});

		});
		
		$("#btnTestSubmit").click(function() {
			$.post(sRootPath + '/_com/AJAX_Assessment.cfc', { method: 'markComplete', ActivityID: nActivity, AssessmentID: nAssessment, ResultID: nResult, PersonID: nPerson, returnFormat: 'plain' },
				function(data) {
					var cleanData = $.Trim(data);
					var status = $.ListGetAt(cleanData, 1, "|");
					var statusMsg = $.ListGetAt(cleanData, 2, "|");
					
					if(status == "true") {
						window.open("http://ccpd.uc.edu/admin/index.cfm/event/Public.Cert?ActivityID=" + nActivity + "&ReportID=5&PersonID=" + nPerson,"Certificate");
						setTimeout("window.location = sRootPath + '/cdc_reg.cfm';",10000);
					} else {
						// GET THE MAX LOOP COUNT
						LoopCount = $.ListLen(cleanData, "|");
						
						// RESET QUESTION TITLE COLOR
						$(".AnswersList").removeClass("Required");
						$(".Question").css("background-color", "#F7F7F7");
						
						for(i=1;i<=LoopCount;i=i+1) {
							// GETS CURRENT ANSWER ID
							var CurrID = $.ListGetAt(cleanData,i,"|");
							$("#Question_" + CurrID).css("background-color", "#FFDDDD");
							$("#AnswerContainer" + CurrID).addClass("Required");
							
							//alert($("#AnswerContainer" + CurrID).css("background-color"));
							//alert($("#Question_" + CurrID).css("background-color"));
						}
						
						alert("Required questions have been marked in red.");
					}
			});
		});
		
		// SCROLLS ANSWER TO THE QUESTION
		$(".LinkTo").click(function() {
			var nId = $.ListGetAt(this.id, 2, "-");
			
			$.scrollTo($("#Question_" + nId), 500);
		});
		
		// SCROLLS THE ANSWERS LIST AROUND
		var name = "#AnswersList";  
		var menuYloc = null; 
		 
		menuYloc = parseInt($(name).css("top").substring(0,$(name).css("top").indexOf("px")))
		$(window).scroll(function () { 
			var offset = menuYloc+$(document).scrollTop()+"px";  
         	$(name).animate({top:offset},{duration:500,queue:false});  
     	}); 

	});
</script>

<cfoutput>
<cfset QuestionNo = 1>
<form id="frmTestSubmit" method="post" enctype="multipart/form-data">

<!--- ANSWERS DIALOG LIST --->
<div id="AnswersList" style="position:absolute; left:675px; top:100px;">
	<table class="AnswersListTable">
    	<tr>
        	<td><input type="button" id="btnTestSubmit" value="Complete" /></td>
        </tr>
    	<cfloop query="qQuestions">
            <cfset AnswerBean = CreateObject("component","#Application.Settings.Com#AssessAnswer.AssessAnswer").Init(QuestionID=qQuestions.QuestionID,ResultID=URL.ResultID)>
            
			<cfif Application.Com.AssessAnswerDAO.Exists(AnswerBean)>
                <cfset AnswerBean = Application.Com.AssessAnswerDAO.Read(AnswerBean)>
            </cfif>
            
        	<cfif NOT ListFind("5,6,7",qQuestions.QuestionTypeID,",")>
            	<cfswitch expression="#qQuestions.QuestionTypeID#">
                	<cfcase value="4">
                    	<cfif qQuestions.RequiredFlag EQ "Y">
							<cfif AnswerBean.getVC1() NEQ "">
                                <tr>
                                    <td id="AnswerContainer#qQuestions.QuestionID#" class="AnswersList"><a href="javascript://" class="LinkTo" id="linkto-#qQuestions.QuestionID#">#QuestionNo#) <span id="AnswersList#qQuestions.QuestionID#"><cfif Len(AnswerBean.getVC1()) GT 5>#Left(AnswerBean.getVC1(), 1)#...<cfelse>#AnswerBean.getVC1()#</cfif><img src='images/tick.png' title='Accepted' /></span>*</a></td>
                                </tr>
                            <cfelse>
                                <tr>
                                    <td id="AnswerContainer#qQuestions.QuestionID#" class="AnswersList"><a href="javascript://" class="LinkTo" id="linkto-#qQuestions.QuestionID#">#QuestionNo#) <span id="AnswersList#qQuestions.QuestionID#">N/A</span>*</a></td>
                                </tr>
                            </cfif>
                        	<cfset QuestionNo = QuestionNo + 1>
                        </cfif>
                    </cfcase>
                    <cfdefaultcase>
						<cfif AnswerBean.getVC1() NEQ "">
                            <tr>
                                <td id="AnswerContainer#qQuestions.QuestionID#" class="AnswersList"><a href="javascript://" class="LinkTo" id="linkto-#qQuestions.QuestionID#">#QuestionNo#) <span id="AnswersList#qQuestions.QuestionID#"><cfif Len(AnswerBean.getVC1()) GT 5>#Left(AnswerBean.getVC1(), 1)#...<cfelse>#AnswerBean.getVC1()#</cfif><img src='images/tick.png' title='Accepted' /></span><cfif qQuestions.RequiredFlag EQ "Y">*</cfif></a></td>
                            </tr>
                        <cfelse>
                            <tr>
                                <td id="AnswerContainer#qQuestions.QuestionID#" class="AnswersList"><a href="javascript://" class="LinkTo" id="linkto-#qQuestions.QuestionID#">#QuestionNo#) <span id="AnswersList#qQuestions.QuestionID#">N/A</span><cfif qQuestions.RequiredFlag EQ "Y">*</cfif></a></td>
                            </tr>
                        </cfif>
                    	<cfset QuestionNo = QuestionNo + 1>
                    </cfdefaultcase>
                </cfswitch>
            </cfif>
		</cfloop>
        <tr>
        	<td>* = REQUIRED</td>
        </tr>
    </table>
</div>
<!--- END ANSWERS DIALOG LIST --->

<cfinclude template="includes/inc_header.cfm">

<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<td class="content_cell" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="content_title">Evaluation</td>
				</tr>
				<tr>
					<td class="content_body">
					<cfset QuestionNo = 1>
                    <cfset QuestionCount = 1>
                    <cfset aAnswers = ArrayNew(2)>
                    
                    <div id="QuestionsContainer">
                    <cfloop query="qQuestions">
						<cfset AnswerBean = CreateObject("component","#Application.Settings.Com#AssessAnswer.AssessAnswer").Init(QuestionID=qQuestions.QuestionID,ResultID=URL.ResultID)>
                        
                        <cfif Application.Com.AssessAnswerDAO.Exists(AnswerBean)>
                        	<cfset AnswerBean = Application.Com.AssessAnswerDAO.Read(AnswerBean)>
                        </cfif>
                        
                        <cfswitch expression="#qQuestions.QuestionTypeID#">
                        	<!--- TEXT SINGLE LINE --->
                            <cfcase value="3">
                                <div class="Question" id="Question_#qQuestions.QuestionID#">
                                    <div class="Caption3Text">#qQuestions.LabelText#<span></span></div>
                                </div>
                            </cfcase>
                            <!--- TEXT MULTI LINE --->
                            <cfcase value="4">
                            	<cfif qQuestions.RequiredFlag EQ "Y">
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        <div class="QuestionNo">*#QuestionNo#.</div><div class="QuestionText">#qQuestions.LabelText#</div>
        
                                        <cfset QuestionNo = QuestionNo + 1>
                                    </div>
                                    <div class="Answers">
                                        <div class="Answer" id="#QuestionNo#VC1"><textarea name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#|vc1" class="TextAreaAnswer">#AnswerBean.getVC1()#</textarea></div>
                                    </div>
                                <cfelse>
                                    <div class="Question" id="Question_#qQuestions.QuestionID#">
                                        #qQuestions.LabelText#
                                    </div>
                                    <div class="Answers">
                                        <div class="Answer" id="#QuestionNo#VC1"><textarea name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#|vc1" class="TextAreaAnswer">#AnswerBean.getVC1()#</textarea></div>
                                	</div>
                                </cfif>
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
                                    <div class="QuestionNo"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#QuestionNo#.</div><div class="QuestionText">#qQuestions.LabelText#</div>
    
                                    <cfset QuestionNo = QuestionNo + 1>
                                </div>
                                <div class="Answers">
                                    <cfloop from="5" to="1" step="-1" index="i">
                                    <div class="Answer" id="#QuestionNo#VC#i#"><input type="Radio" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#|vc#i#|#i#|#Chr(64+i)#" class="RadioAnswer" <cfif i EQ AnswerBean.getVC1()>CHECKED </cfif>/><label for="#qQuestions.QuestionID#|vc#i#|#i#|#Chr(64+i)#">#Chr(64+i)#) #i#<cfif i EQ 1> - Strongly Disagree<cfelseif i EQ 5> - Strongly Agree</cfif></label></div>
                                    </cfloop>
                                </div>
                            </cfcase>
                            <cfdefaultcase>
                                <div class="Question" id="Question_#qQuestions.QuestionID#">
                                    <div class="QuestionNo"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#QuestionNo#.</div><div class="QuestionText">#qQuestions.LabelText#</div>
    
                                    <cfset QuestionNo = QuestionNo + 1>
                                </div>
                                <div class="Answers">
                                    <cfloop from="1" to="10" step="1" index="i">
                                    <cfif #Evaluate("vc#i#")# NEQ "">
                                    <div class="Answer" id="#QuestionNo#VC#i#"><input type="Radio" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#|vc#i#|#Evaluate("vc#i#")#|#Chr(64+i)#" class="RadioAnswer" <cfif AnswerBean.getVC1() EQ Evaluate('vc#i#')>CHECKED </cfif>/><label for="#qQuestions.QuestionID#|vc#i#|#Evaluate("vc#i#")#|#Chr(64+i)#">#Chr(64+i)#) #Evaluate("vc#i#")#</label></div>
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
</form>
</cfoutput>
</body>
</html>