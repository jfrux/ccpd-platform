<cfparam name="Attributes.ResultID" default="0" type="numeric" />

<script>
	$(document).ready(function() {
		<cfoutput>
		var AnswerFieldID = "";
		var nActivity = #Attributes.ActivityID#;
		var nAssessment = #Attributes.AssessmentID#;
		var nPerson = #Session.PersonID#;
		var nResult = #Attributes.ResultID#;
		var EvalType = '#Attributes.Type#';
		</cfoutput>
		
		$(".date-pick").mask("99/99/9999");
		
		//CLICK PROGRESS BAR TO SCROLL DOWN TO QUESTION
		$(".progressbar-item").click(function() {
			var nQuestion = $(this).attr('id').replace('progressbar-item-','');
			$(".questionslist").scrollTo('#Question_' + nQuestion,800);
		});
		
		$(".answer input,.answer label,.answer.selected input, .answer.selected label").hover(function() {
			$(this).parent('div').addClass('answerHover');
		},function() {
			$(this).parent('div').removeClass('answerHover');
		});
		
		$(".question").hover(function() {
			$(".question").removeClass('questionHover');
			$(this).addClass('questionHover');
		},function() {
			$(this).removeClass('questionHover');
		});
			
		$(".select-answer").live("change",function() {
			var AnswerFieldID = $.ListGetAt(this.id,1,"-");		// SET ID VARIABLE
			var $Question = $(this).parents('.question');
			var $NextQuestion = $Question.next();
			var AnswerToSubmit = $(this).siblings('label').children('span').html();
			var sFieldType = $.ListGetAt(this.id,2,"-");		
			var AnswerText = $.ListGetAt(this.id,3,"-");		// SET ANSWER LETTER VARIABLE
			var QuestionNumber = $.ListGetAt(this.id,5,"-");	// SET QUESTION NUMBER
			
			$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("<img src='/lms/_images/loading.gif' title='loading' />");	// PLACE LOADING ICON
			
			/* START AJAX POST */
			$.post("/lms/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerToSubmit, FieldType: sFieldType, returnFormat: "plain" },
				function(data){
					var status = $.trim($.ListGetAt(data,1,"<"));
					
					if(status == 'true') {
						$("#progressbar-item-" + AnswerFieldID).removeClass('error').addClass('answered');
						$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html(AnswerToSubmit);
					} else if(status == 'false') {
						$("#progressbar-item-" + AnswerFieldID).addClass('error');
						$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("N/A");
					}
			});
			/* FINISH AJAX POST */
			$(".questionslist").scrollTo($NextQuestion,800);
		});
		
		$(".CheckAnswer").click(function() {
			var AnswerFieldID = $.ListGetAt(this.id,1,"-");		// SET ID VARIABLE
			var $Question = $(this).parents('.question');
			var $NextQuestion = $Question.next();
			var AnswerToSubmit = $(this).siblings('label').children('span').html();
			var sFieldType = $.ListGetAt(this.id,2,"-");		
			var AnswerText = $.ListGetAt(this.id,3,"-");		// SET ANSWER LETTER VARIABLE
			var QuestionNumber = $.ListGetAt(this.id,5,"-");	// SET QUESTION NUMBER
			$(this).parents('.answer').addClass('selected');
			
			AnswerToSubmit = '';
			
			$.each($(this).parents('.answersline').children('div').children('input'), function(i, item) {
				if($(item).attr('checked')) {
					if(AnswerToSubmit != '') {
						AnswerToSubmit = AnswerToSubmit + ',' + $(item).val();
					} else{
						AnswerToSubmit = $(item).val();
					}
				}
			});
			
			$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("<img src='/lms/_images/loading.gif' title='loading' />");	// PLACE LOADING ICON
			
			/* START AJAX POST */
			$.post("/lms/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerToSubmit, FieldType: sFieldType, returnFormat: "plain" },
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
			$(".questionslist").scrollTo($NextQuestion,800);

		});
		
		$(".RadioAnswer").click(function() {
			var AnswerFieldID = $.ListGetAt(this.id,1,"-");		// SET ID VARIABLE
			var $Question = $(this).parents('.question');
			var $NextQuestion = $Question.next();
			var AnswerToSubmit = $(this).siblings('label').children('span').html();
			var sFieldType = $.ListGetAt(this.id,2,"-");		
			var AnswerText = $.ListGetAt(this.id,3,"-");		// SET ANSWER LETTER VARIABLE
			var QuestionNumber = $.ListGetAt(this.id,5,"-");	// SET QUESTION NUMBER
			
			$(this).parents('.answersline').children('div').removeClass('selected');
			$(this).parents('.answer').addClass('selected');
			
			$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("<img src='/lms/_images/loading.gif' title='loading' />");	// PLACE LOADING ICON
			
			/* START AJAX POST */
			$.post("/lms/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerToSubmit, FieldType: sFieldType, returnFormat: "plain" },
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
			
			$(".questionslist").scrollTo($NextQuestion,800);
		});
		
		$(".question.rating .answer input").click(function() {
			var AnswerFieldID = $.ListGetAt(this.id,1,"-");		// SET ID VARIABLE
			var $Question = $(this).parents('.question');
			var $NextQuestion = $Question.next();
			var AnswerToSubmit = $(this).siblings('label').children('span').html();
			var sFieldType = $.ListGetAt(this.id,2,"-");		
			var AnswerText = $.ListGetAt(this.id,3,"-");		// SET ANSWER LETTER VARIABLE
			var QuestionNumber = $.ListGetAt(this.id,5,"-");	// SET QUESTION NUMBER
			
			$(this).parents('.answersline').children('div').removeClass('selected');
			$(this).parents('.answer').addClass('selected');
			
			$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("<img src='/lms/_images/loading.gif' title='loading' />");	// PLACE LOADING ICON
			
			/* START AJAX POST */
			$.post("/lms/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerToSubmit, FieldType: sFieldType, returnFormat: "plain" },
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
			$(".questionslist").scrollTo($NextQuestion,800);
		});
		
		$(".question.text .answer input, .question.textmulti .answer textarea").blur(function() {
			var AnswerFieldID = $.ListGetAt(this.id,1,"-");		// SET ID VARIABLE
			var $Question = $(this).parents('.question');
			var $NextQuestion = $Question.next();
			var AnswerToSubmit = $(this).siblings('label').children('span').html();
			var sFieldType = $.ListGetAt(this.id,2,"-");		
			var QuestionNumber = $.ListGetAt(this.id,5,"-");	// SET QUESTION NUMBER
			var AnswerText = $(this).val();		// SET ASNWER LETTER VARIABLE
			
			$("#progressbar-item-" + AnswerFieldID + " .progressbar-value").html("<img src='/lms/_images/loading.gif' title='loading' />");	// PLACE LOADING ICON
			
			/* START AJAX POST */
			$.post("/lms/_com/AJAX_Assessment.cfc", { method: "saveAnswer", AssessmentID: nAssessment, QuestionID: AnswerFieldID, ResultID: nResult, Answer: AnswerText, FieldType: sFieldType, returnFormat: "plain" },
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
			/* FINISH AJAX POST */
			$(".questionslist").scrollTo($NextQuestion,800);
		});
		
		<!---var options = { 
			target:        '',   // target element(s) to be updated with server response 
			beforeSubmit:  showRequest,  // pre-submit callback 
			success:       showResponse,  // post-submit callback 
			
			// other available options: 
			url:       sRootPath + '/_com/AssessResult/AssessResultAJAX.cfc?method=CompleteTest&AssessmentID=' + nAssessment + '&ResultID=' + nResult,         // override for form's 'action' attribute 
			type:      'post'        // 'get' or 'post', override for form's 'method' attribute 
			//dataType:  null        // 'xml', 'script', or 'json' (expected server response type) 
			//clearForm: true        // clear all form fields after successful submit 
			//resetForm: true        // reset the form after successful submit 
	 
			// $.ajax options can be used here too, for example: 
			//timeout:   3000 
		}; 
	 
		// bind to the form's submit event 
			$('#frmTestSubmit').submit(function() { 
				// inside event callbacks 'this' is the DOM element so we first 
				// wrap it in a jQuery object and then invoke ajaxSubmit 
				$(this).ajaxSubmit(options); 
		 
				// !!! Important !!! 
				// always return false to prevent standard browser submit and page navigation 
				return false; 
			}); 
			
		$("#btnTestSubmit").click(function() {
			 $("#frmTestSubmit").submit();
		});--->

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
<cfset QuestionNo = 1>
<form id="frmTestSubmit" method="post" enctype="multipart/form-data">
<!--- END ANSWERS DIALOG LIST --->
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
        <!--- MULTIPLE CHOICE (MULTIANSWER) --->
		<cfcase value="8">
			<div class="question mc" id="Question_#qQuestions.QuestionID#">
				<div class="questionnumber">#QuestionNo#</div>
				<div class="questionline">
					
					<div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
				</div>
				<div class="answersline">
					<cfloop from="1" to="10" step="1" index="i">
					<cfif Evaluate("vc#i#") NEQ "">
					<div class="answer<cfif AnswerBean.getVC1() EQ Evaluate('vc#i#')> selected</cfif>" id="#QuestionNo#VC#i#">
					<input type="Checkbox" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc#i#-#Chr(64+i)#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="CheckAnswer" value="#Evaluate('vc#i#')#"<cfif listFind(AnswerBean.getVC1(),Evaluate('vc#i#'),",")> checked="checked"</cfif>/>
					<label for="#qQuestions.QuestionID#-vc#i#-#Chr(64+i)#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>">#Chr(64+i)#) <span>#Evaluate("vc#i#")#</span><cfif qQuestions.CorrectField EQ "VC#i#" AND ListFind("169841,113290", Session.PersonID, ",")><em><strong>*</strong></em></cfif></label></div>
					</cfif>
					</cfloop>
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
					<div class="answer" id="#QuestionNo#VC1"><input type="text" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc1-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="date-pick" value="#DateFormat(AnswerBean.getVC1(), 'MM/DD/YYYY')#"></div>
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
					<div class="answer" id="#QuestionNo#VC1"><input type="text" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc1-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="date-pick" value="#DateFormat(AnswerBean.getVC1(), 'MM/DD/YYYY')#"> <input type="text" name="Answer#qQuestions.QuestionID#" id="#qQuestions.QuestionID#-vc1-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>" class="date-pick" value="#DateFormat(AnswerBean.getVC2(), 'MM/DD/YYYY')#"></div>
				</div>
			</div>
			<cfset QuestionNo = QuestionNo + 1>
		</cfcase>
		<!--- DATE YEAR ONLY --->
		<cfcase value="14">
			<div class="question select" id="Question_#qQuestions.QuestionID#">
				<div class="questionnumber">#QuestionNo#</div>
				<div class="questionline">
					
					<div class="QuestionText"><cfif qQuestions.RequiredFlag EQ "Y">*</cfif>#qQuestions.LabelText#</div>
				</div>
				<div class="answersline">
					<div class="answer" id="#QuestionNo#VC1">
                        <select name="Answer#qQuestions.QuestionID#" class="select-answer" id="#qQuestions.QuestionID#-vc1-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>">
                        	<option value=""></option>
                           	<cfif AnswerBean.getVC1() NEQ "">
                                <cfloop from="1900" to="#year(now())#" index="currYear">
                                <option value="#currYear#"<cfif AnswerBean.getVC1() EQ currYear> SELECTED</cfif>>#currYear#</option>
                                </cfloop>
                            <cfelse>
                                <cfloop from="#year(now())-80#" to="#year(now())#" index="currYear">
                                <option value="#currYear#"<cfif currYear EQ year(now())> SELECTED</cfif>>#currYear#</option>
                                </cfloop>
                            </cfif>
                        </select>
                    </div>
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
					<label for="#qQuestions.QuestionID#-vc#i#-#Chr(64+i)#-<cfif qQuestions.RequiredFlag EQ "Y">#QuestionNo-1#<cfelse>0</cfif>">#Chr(64+i)#) <span>#Evaluate("vc#i#")#</span><cfif qQuestions.CorrectField EQ "VC#i#" AND ListFind("169841,113290", Session.PersonID, ",")><em><strong>*</strong></em></cfif></label></div>
					</cfif>
					</cfloop>
				</div>
				<cfset QuestionNo = QuestionNo + 1>
			</div>
		</cfdefaultcase>
	</cfswitch>
</cfloop>
</div>
<!--- ANSWERS DIALOG LIST --->
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

<br style="clear:both;height:0;width:100%;" />
</cfoutput>