<script>
$(document).ready(function() {
	/* DIALOGS START */
		// ASSESS QUESTION DIALOG
		$("#QuestionsDialog").dialog({ 
			title: "Questions",
			modal: true, 
			autoOpen: false,
			height:550,
			width:900,
			position:[200,100],
			resizable: false,
			draggable: true,
			overlay: { 
				opacity: 0.5, 
				background: "black" 
			} ,
			buttons: { 
				Done:function() {
					$(this).dialog("close");
				}
			},
			open:function() {
				$.post(sMyself + "Assessment.Questions?AssessmentID=" + nAssessmentID, function(data) {
					$("#QuestionsForm").html(data);
				});
			},
			close:function() {
				$("#QuestionsForm").html("");
			}
		});	
		
		// ASSESSMENT EDIT DIALOG
		$("#AssessDialog").dialog({ 
			title: "Assessment",
			modal: true, 
			autoOpen: false,
			height:550,
			width:900,
			position:[200,100],
			resizable: false,
			draggable: true,
			overlay: { 
				opacity: 0.5, 
				background: "black" 
			} ,
			buttons: { 
				Save:function() {
					$("#formDetail").ajaxSubmit(); 
					addMessage("Assessment successfully created.",250,6000,4000);
					$(this).dialog("close");
					updateAssessments();
					
				},
				Cancel:function() {
					$(this).dialog("close");
				}
			},
			open:function() {
				$.post(sMyself + "Assessment." + AssessType + "?ActivityID=" + nActivity + "&AssessmentID=" + nAssessmentID, function(data) {
					$("#AssessForm").html(data);
				});
			},
			close:function() {
				$("#AssessForm").html("");
			}
		});	
	/* DIALOGS END */
	
	/* DIALOG FUNCTIONS START */
		// QUESTIONS DIALOG OPENER
		$(".QuestionsLink").click(function() {
			nAssessmentID = $.Replace(this.id,'QuestionLink','');
			$("#frmQuestions").attr("src",sMyself + "Assessment.Questions?AssessmentID=" + nAssessmentID);
			
			$("#QuestionsDialog").dialog("open");
			
			return false;
		});
		
		// ASSESSMENT DIALOG OPENER
		$(".AssessLink").click(function() {
			AssessType = "Edit";
			nAssessmentID = $.Replace(this.id,"Assess","","ALL");
			
			$("#AssessDialog").dialog("open");
			
			return false;
		});		
	/* DIALOG FUNCTIONS END */			   
});
</script>
<div class="ViewSection">
	<cfif isDefined("qAssessments") AND qAssessments.RecordCount GT 0 >
	<table border="0" width="100%" cellpadding="0" cellspacing="0" class="ViewSectionGrid">
		<thead>
			<tr>
				<th width="150">Name</th>
				<th width="150">Type</th>
				<th>&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="qAssessments">
				<tr id="PersonRow" class="AllAttendees">
					<td>#qAssessments.Name#</td>
					<td>#qAssessments.AssessTypeName#</td>
					<td><a href="javascript://" class="AssessLink" id="Assess#qAssessments.AssessmentID#">Edit Details</a> <a href="#myself#Assessment.Questions?AssessmentID=#qAssessments.AssessmentID#" target="_blank" class="QuestionsLink" id="QuestionLink#qAssessments.AssessmentID#">Questions</a></td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
	<cfelse>
		<div style="background-image:url(/_images/Sample_Attendees.jpg); font-size:18px; text-align:center; height:151px; width:631px;">
			<div style="padding:25px 20px;">You have not added any assessments.<br />Click the 'Create Assessment' link on the right to begin.</div>
		</div>
	</cfif>
</div>