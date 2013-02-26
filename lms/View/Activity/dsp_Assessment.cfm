<script>
<cfoutput>
var nAssessment = #Attributes.AssessmentID#;
var nPerson = #Attributes.PersonID#;
var nResult = #Attributes.ResultID#;
</cfoutput>

function updateAttendeeDetails() {		
	$.post(sMyself + "Activity.AttendeeDetailAHAH", { ActivityID: nActivity, PersonID: nPerson },
		function(data) {
			$("#PersonDetailContent").html(data);
	});
}

$(document).ready(function() {
	$(".ce-dialog-close,#assessment-close").click(function() {
		$("#assessment-container").hide();
		updateAttendeeDetails();
		$("#assessment-container").html("");
	});
	$(".RadioAnswer").click(function() {
		AnswerFieldID = $.ListGetAt(this.id,1,"-");		// SET ID VARIABLE
		sFieldType = $.ListGetAt(this.id,2,"-");
		AnswerToSubmit = $(this).siblings('label').children('span').html();
		AnswerText = $.ListGetAt(this.id,3,"-");		// SET ASNWER LETTER VARIABLE
		QuestionNumber = $.ListGetAt(this.id,5,"-");	// SET QUESTION NUMBER
		$(this).parents('.answersline').children('div').removeClass('selected');
		$(this).parents('.answer').addClass('selected');
		
		$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("<img src='/_images/loading.gif' title='loading' />");	// PLACE LOADING ICON
		
		/* START AJAX POST */
		$.post(sRootPath + "/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerToSubmit, FieldType: sFieldType, returnFormat: "plain" },
			function(data){
				var status = $.trim($.ListGetAt(data,1,"<"));
				
				if(status == 'true') {
					$("#progressbar-item-" + AnswerFieldID).removeClass('error').addClass('answered');
					$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html(AnswerText + ') ' + AnswerToSubmit);
				} else if(status == 'false') {
					$("#progressbar-item-" + AnswerFieldID).addClass('error');
					$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html(AnswerText);
				}
		});
		/* FINISH AJAX POST */

	});
	
	$(".CheckAnswer").click(function() {
		var AnswerFieldID = $.ListGetAt(this.id,1,"-");		// SET ID VARIABLE
		var newanswer = $(this).val();
		var checkedfield = $('#checkedanswers-' + AnswerFieldID);
		var curranswers = checkedfield.val(); // assumes your checkboxes are in a form tag
		var answerslist = curranswers;
		
		if($(this).attr('checked')) {
			answerslist = $.ListAppend(answerslist,newanswer,'^');
		} else {
			answerslist = $.ListDeleteAt(answerslist,$.ListFind(answerslist,newanswer,','),'^');
		}
		checkedfield.val(answerslist);
		
		QuestionID = $.ListGetAt(this.id,1,"-");	// SET ID VARIABLE
		sFieldType = $.ListGetAt(this.id,2,"-");
		AnswerToSubmit = checkedfield.val();
		AnswerText = $.ListGetAt(this.id,3,"-");	
		QuestionNumber = $.ListGetAt(this.id,4,"-");	// SET QUESTION NUMBER
		
		$(this).parents('.answersline').children('div').removeClass('selected');
		$(this).parents('.answer').addClass('selected');
		
		$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("<img src='/_images/loading.gif' title='loading' />");	// PLACE LOADING ICON
		
		/* START AJAX POST */
		$.post(sRootPath + "/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerToSubmit, FieldType: sFieldType, returnFormat: "plain" },
			function(data){
				var status = $.trim($.ListGetAt(data,1,"<"));
				
				if(status == 'true') {
					$("#progressbar-item-" + AnswerFieldID).removeClass('error').addClass('answered');
					$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html(AnswerText + ') ' + AnswerToSubmit);
				} else if(status == 'false') {
					$("#progressbar-item-" + AnswerFieldID).addClass('error');
					$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html(AnswerText);
				}
		});
		/* FINISH AJAX POST */

	});
	
	$(".question.rating .answer input").click(function() {
		AnswerFieldID = $.ListGetAt(this.id,1,"-");		// SET ID VARIABLE
		sFieldType = $.ListGetAt(this.id,2,"-");
		AnswerToSubmit = $(this).siblings('label').children('span').html();
		QuestionNumber = $.ListGetAt(this.id,4,"-");	// SET QUESTION NUMBER
		
		$(this).parents('.answersline').children('div').removeClass('selected');
		$(this).parents('.answer').addClass('selected');
		
		$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("<img src='/_images/loading.gif' title='loading' />");	// PLACE LOADING ICON
		
		/* START AJAX POST */
		$.post(sRootPath + "/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerToSubmit, FieldType: sFieldType, returnFormat: "plain" },
			function(data){
				var status = $.trim($.ListGetAt(data,1,"<"));
				
				if(status == 'true') {
					$("#progressbar-item-" + AnswerFieldID).removeClass('error').addClass('answered');
					$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html(AnswerToSubmit);
				} else if(status == 'false') {
					$("#progressbar-item-" + AnswerFieldID).addClass('error');
					$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html(AnswerText);
				}
		});
		/* FINISH AJAX POST */
	});
	
	$(".question.text .answer input, .question.textmulti .answer textarea").blur(function() {
		AnswerFieldID = $.ListGetAt(this.id,1,"-");		// SET ID VARIABLE
		sFieldType = $.ListGetAt(this.id,2,"-");
		QuestionNumber = $.ListGetAt(this.id,3,"-");		// SET QUESTION NUMBER
		AnswerText = $(this).val();		// SET ASNWER LETTER VARIABLE
		
		$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("<img src='/_images/loading.gif' title='loading' />");	// PLACE LOADING ICON
		
		/* START AJAX POST */
		$.post(sRootPath + "/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerText, FieldType: sFieldType, returnFormat: "plain" },
			function(data){
				var status = $.trim($.ListGetAt(data,1,"<"));
				
				if(status == 'true') {
					$("#progressbar-item-" + AnswerFieldID).removeClass('error').addClass('answered');
					$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html('&quot;' + AnswerText + '&quot;');
				} else if(status == 'false') {
					$("#progressbar-item-" + AnswerFieldID).addClass('error');
					$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html('&quot;' + AnswerText + '&quot;');
				}
		});
	});
		
	/* FINISH AJAX POST */// COMPLETE ASSESSMENT BUTTON FUNCTION
	$("#assessment-complete").click(function() {
		$.ajax({
			url: sRootPath + "/_com/AJAX_Assessment.cfc", 
			type: 'post',
			data: { method: "markComplete", ActivityID: nActivity, AssessmentID: nAssessment, PersonID: nPerson, ResultID: nResult, returnFormat: "plain" },
			dataType: 'json',
			success: function(data) {
				var cleanData = $.trim(data);
				var Status = $.ListGetAt(cleanData,1,"|");
				var statusMsg = $.ListGetAt(cleanData,2,"|");
				
				if(data.STATUS) {
					updateAttendeeDetails();
					
					// HIDE ASSESSMENT
					$("#assessment-container").css("display","none");
					
					addMessage(data.STATUSMSG,250,6000,4000);
				} else {
					$.each(data.ERRORS, function(i, item) {
						$("#progressbar-item-" + data.ERRORS[i].MESSAGE).addClass('error');
						$("#progressbar-item-" + data.ERRORS[i].MESSAGE + " .progressbar-value").html('Answer Required!');
					});
					
					firstErrorID = $(".error:first").attr('id').replace('progressbar-item-','');
					$(".questionslist").scrollTo('#Question_' + firstErrorID,800);
					$(".progressbar").scrollTo('#progressbar-item-' + firstErrorID,800);
				}
			}
		});
	});
});
		
// pre-submit callback 
function showRequest(formData, jqForm, options) { 
	// formData is an array; here we use $.param to convert it to a string to display it 
	// but the form plugin does this for you automatically when it submits the data 
	var queryString = $.param(formData); 
 
	// jqForm is a jQuery object encapsulating the form element.  To access the 
	// DOM element for the form do this: 
	// var formElement = jqForm[0];  
 
	// here we could return false to prevent the form from being submitted; 
	// returning anything other than false will allow the form submit to continue 
	return true; 
} 
 
// post-submit callback 
function showResponse(responseText, statusText)  { 
	// for normal html responses, the first argument to the success callback 
	// is the XMLHttpRequest object's responseText property 
 
	// if the ajaxSubmit method was passed an Options Object with the dataType 
	// property set to 'xml' then the first argument to the success callback 
	// is the XMLHttpRequest object's responseXML property 
 
	// if the ajaxSubmit method was passed an Options Object with the dataType 
	// property set to 'json' then the first argument to the success callback 
	// is the json data object returned by the server 
	
	status = $.trim($.ListGetAt(responseText,1,"<"));
	if(status == "true") {
	} else {
		alert("There were errors, please try again.");
	}
}
</script>
<cfoutput>
<link href="/lms/_styles/Assessment.css" rel="stylesheet" title="text/css" />
<div class="ce-dialog-titlebar">Assessment: #qAssessment.AssessTypeName#</div>
<div class="ce-dialog-close"></div>
<div class="ce-dialog-content">
	<form id="frmTestSubmit" enctype="multipart/form-data" method="post">
    	<div class="questionslist">
			<cfset QuestionNo = 1>
            <cfset QuestionCount = 1>
            <cfset aAnswers = ArrayNew(2)>
            
        	<cfloop query="qQuestions">
            	<cfset AnswerBean = CreateObject("component","#Application.Settings.Com#AssessAnswer.AssessAnswer").Init(QuestionID=qQuestions.QuestionID,ResultID=Attributes.ResultID)>
                
                <cfif Application.Com.AssessAnswerDAO.Exists(AnswerBean)>
                    <cfset AnswerBean = Application.Com.AssessAnswerDAO.Read(AnswerBean)>
                </cfif>
                
                
                <cfswitch expression="#qQuestions.QuestionTypeID#">
                    <!--- TEXT SINGLE LINE --->
                    <cfcase value="3">
                        <div class="question text" id="Question_#qQuestions.QuestionID#">
                            <div class="questionnumber">#QuestionNo#</div>
                            <div class="questionline">
                                
                                <div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
                            </div>
                            <div class="answersline">
                                <div class="answer" id="#QuestionNo#VC1"><input type="text" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc1-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="TextAreaAnswer" value="#AnswerBean.getVC1()#"></div>
                            </div>
                        </div>
                        <cfset QuestionNo = QuestionNo + 1>
                        
                    </cfcase>
                    <!--- TEXT MULTI LINE --->
                    <cfcase value="4">
                        <div class="question textmulti" id="Question_#qQuestions.QuestionID#">
                            <div class="questionnumber">#QuestionNo#</div>
                            <div class="questionline">
                                <div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
                            </div>
                            
                            <div class="answersline">
                                <div class="answer" id="#QuestionNo#VC1">
                                    <textarea name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc1-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="TextAreaAnswer">#AnswerBean.getVC1()#</textarea>
                                </div>
                            </div>
                        </div>
                        <cfset QuestionNo = QuestionNo + 1>
                    </cfcase>
                    <!--- CAPTION 1 --->
                    <cfcase value="5">
                    <div class="Caption1Text">
                        #qQuestions.LabelText#
                    </div>
                    </cfcase>
                    <!--- CAPTION 2 --->
                    <cfcase value="6">
                    <div class="Caption2Text">
                        #qQuestions.LabelText#
                    </div>
                    </cfcase>
                    <!--- CAPTION 3 --->
                    <cfcase value="7">
                    <div class="Caption3Text">
                        #qQuestions.LabelText#
                    </div>
                    </cfcase>
                    <!--- RATING 1-5, AGREE-DISAGREE --->
                    <cfcase value="9">
                        <div class="question rating" id="Question_#qQuestions.QuestionID#">
                            <div class="questionnumber">#QuestionNo#</div>
                            <div class="questionline">
                                
                                <div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
                            </div>
                            <div class="answersline">
                                <cfloop from="5" to="1" step="-1" index="i">
                                <div class="answer<cfif i EQ AnswerBean.getVC1()> selected</cfif>" id="#QuestionNo#VC#i#"><input type="Radio" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc#i#-#i#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="ratingradio"<cfif i EQ AnswerBean.getVC1()> checked="checked"</cfif>/>
                                <label for="#qQuestions.QuestionID#-vc#i#-#i#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>"><span>#i#<cfif i EQ 1> - Strongly Disagree<cfelseif i EQ 5> - Strongly Agree</cfif></span></label></div>
                                </cfloop>
                            </div>
                        </div>
                        <cfset QuestionNo = QuestionNo + 1>
                    </cfcase>
                    <!--- RATING 1-5, LIKE-DISLIKE --->
                    <cfcase value="2">
                        <div class="question rating" id="Question_#qQuestions.QuestionID#">
                            <div class="questionnumber">#QuestionNo#</div>
                            <div class="questionline">
                                
                                <div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
                            </div>
                            <div class="answersline">
                                <cfloop from="5" to="1" step="-1" index="i">
                                <div class="answer<cfif i EQ AnswerBean.getVC1()> selected</cfif>" id="#QuestionNo#VC#i#"><input type="Radio" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc#i#-#i#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="ratingradio"<cfif i EQ AnswerBean.getVC1()> checked="checked"</cfif>/>
                                <label for="#qQuestions.QuestionID#-vc#i#-#i#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>"><span>#i#<cfif i EQ 1> - Dislike<cfelseif i EQ 5> - Like</cfif></span></label></div>
                                </cfloop>
                            </div>
                        </div>
                        <cfset QuestionNo = QuestionNo + 1>
                    </cfcase>
					 <!--- MULTICHOICE / MULTIANSWER --->
					<cfcase value="8">
						<div class="question mc" id="Question_#qQuestions.QuestionID#">
							<div class="questionnumber">#QuestionNo#</div>
							<div class="questionline">
								
								<div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
							</div>
							<div class="answersline">
								<cfloop from="1" to="10" step="1" index="i">
								<cfif Evaluate("vc#i#") NEQ "">
                                <cfset markSelected = false>
								<cfloop list='#AnswerBean.getVC1()#' index='currAnswer' delimiters='^'>
									<cfif currAnswer EQ Evaluate('vc#i#')>
                                    	<cfset markSelected = true>
									</cfif>
                                </cfloop>
                                <div class="answer<cfif markSelected> selected</cfif>" id="#QuestionNo#VC#i#">
								<input type="checkbox" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc#i#-#Chr(64+i)#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="CheckAnswer check#qQuestions.QuestionID#"<cfif markSelected> checked="checked"</cfif> value="#Evaluate('vc#i#')#" />
								<label for="#qQuestions.QuestionID#-vc#i#-#Chr(64+i)#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>">#Chr(64+i)#) <span>#Evaluate("vc#i#")#</span><cfif qQuestions.CorrectField EQ "VC#i#" AND ListFind("169841,113290", Session.PersonID, ",")><em><strong>*</strong></em></cfif></label></div>
								</cfif>
								</cfloop>
								<input type="hidden" name="AnswerVals#qQuestions.QuestionID#" id="checkedanswers-#qQuestions.questionid#" value="#AnswerBean.getVC1()#" />
							</div>
							<cfset QuestionNo = QuestionNo + 1>
						</div>
					</cfcase>
					<!--- DATE ENTRY // SINGLE DATE ENTRY --->
                    <cfcase value="12">
                        <div class="question text" id="Question_#qQuestions.QuestionID#">
                            <div class="questionnumber">#QuestionNo#</div>
                            <div class="questionline">
                                
                                <div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
                            </div>
                            <div class="answersline">
                                <div class="answer" id="#QuestionNo#VC1"><input type="text" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-dt1-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="date-pick" value="#DateFormat(AnswerBean.getDT1(), 'MM/DD/YYYY')#"></div>
                            </div>
                        </div>
                        <cfset QuestionNo = QuestionNo + 1>
                    </cfcase>
                    <!--- DATE RANGE ENTRY --->
                    <cfcase value="13">
                        <div class="question text" id="Question_#qQuestions.QuestionID#">
                            <div class="questionnumber">#QuestionNo#</div>
                            <div class="questionline">
                                
                                <div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
                            </div>
                            <div class="answersline">
                                <div class="answer" id="#QuestionNo#VC1"><input type="text" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-dt1-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="date-pick" value="#DateFormat(AnswerBean.getDT1(), 'MM/DD/YYYY')#"> <input type="text" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-dt2-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="date-pick" value="#DateFormat(AnswerBean.getDT2(), 'MM/DD/YYYY')#"></div>
                            </div>
                        </div>
                        <cfset QuestionNo = QuestionNo + 1>
                    </cfcase>
                    <cfdefaultcase>
                        <div class="question mc" id="Question_#qQuestions.QuestionID#">
                            <div class="questionnumber">#QuestionNo#</div>
                            <div class="questionline">
                                
                                <div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
                            </div>
                            <div class="answersline">
                                <cfloop from="1" to="10" step="1" index="i">
                                <cfif Evaluate("vc#i#") NEQ "">
                                <div class="answer<cfif AnswerBean.getVC1() EQ Evaluate('vc#i#')> selected</cfif>" id="#QuestionNo#VC#i#">
                                <input type="Radio" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc#i#-#Chr(64+i)#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="RadioAnswer"<cfif AnswerBean.getVC1() EQ Evaluate('vc#i#')> checked="checked"</cfif>/>
                                <label for="#qQuestions.QuestionID#-vc#i#-#Chr(64+i)#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>">#Chr(64+i)#) <span>#Evaluate("vc#i#")#</span><cfif qQuestions.CorrectField EQ "VC#i#" AND Session.PersonID EQ 169841><em><strong>*</strong></em></cfif></label></div>
                                </cfif>
                                </cfloop>
                            </div>
                            <cfset QuestionNo = QuestionNo + 1>
                        </div>
                    </cfdefaultcase>
                </cfswitch>
            </cfloop>
        </div>
        <div class="progressbar">
        	<cfset QuestionNo = 1>
            <ul>
            <cfloop query="qQuestions">
            	<cfset AnswerBean = CreateObject("component","#Application.Settings.Com#AssessAnswer.AssessAnswer").Init(QuestionID=qQuestions.QuestionID,ResultID=Attributes.ResultID)>
                
                <cfif Application.Com.AssessAnswerDAO.Exists(AnswerBean)>
                    <cfset AnswerBean = Application.Com.AssessAnswerDAO.Read(AnswerBean)>
                </cfif>
                
                <cfif qQuestions.QuestionTypeID NEQ 5 AND qQuestions.QuestionTypeID NEQ 6 AND qQuestions.QuestionTypeID NEQ 7>
                    <cfif AnswerBean.getVC1() NEQ "">
                        <li id="progressbar-item-#qQuestions.QuestionID#" class="progressbar-item answered"><span class="progressbar-number">#QuestionNo#</span><span class="progressbar-value"><cfif Len(AnswerBean.getVC1()) GT 5>#Left(AnswerBean.getVC1(), 20)#...<cfelse>#AnswerBean.getVC1()#</cfif></span></li>
                    <cfelse>
                        <li id="progressbar-item-#qQuestions.QuestionID#" class="progressbar-item"><span class="progressbar-number">#QuestionNo#</span><span class="progressbar-value">N/A</span></li>
                    </cfif>
                <cfset QuestionNo = QuestionNo + 1>
                </cfif>
                
            </cfloop>
            </ul>
        </div>
    </form>
</div>
<div class="ce-dialog-buttons">
	<button id="assessment-close" class="button-grey">Save and Close</button>
	<button id="assessment-complete" class="button-grey">Complete</button>
</div>
</cfoutput>