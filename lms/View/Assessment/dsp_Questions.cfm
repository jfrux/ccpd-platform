<cfimport prefix="question" taglib="#Application.Settings.RootPath#/_tags/QuestionTypes">
<link href="#Application.Settings.RootPath#/_styles/Assessment.css" rel="stylesheet" type="text/css" />

<cfset QuestionNo = 1>

<script>
$(document).ready(function() {
	<!---<cfset qSectionSort = Application.Com.AssessmentSectionGateway.getByAttributes()>
	<cfloop query="qSectionSort">
		<cfquery name="qSubSort" dbtype="query">
			SELECT * FROM qSectionSort
			WHERE SectionID <> #qSectionSort.SectionID#
		</cfquery>
		<cfset CurrentSectID = qSectionSort.SectionID>
		$("##Section#qSectionSort.SectionID#").sortable({
			connectWith: [<cfloop query="qSubSort"><cfif qSubSort.SectionID NEQ CurrentSectID>"##Section#qSubSort.SectionID#"<cfif qSubSort.RecordCount NEQ qSubSort.CurrentRow>,</cfif></cfif></cfloop>],
			placeholder: "ui-selected",
			dropOnEmpty:true
		});
	</cfloop>--->	
	$("##QuestionsContainer").sortable({
	 	placeholder: "ui-selected",
		handle: ".DragHandle",
		containment: "##QuestionsContainer",
		stop: function() {
			aIds = $("##QuestionsContainer").sortable("serialize");
			$.post(sRootPath + "/_com/AJAX_Activity.cfc?method=saveQuestionSort&returnformat=Plain", aIds);
			
			$("div.QuestionNo").each(function (i) {
				$(this).html(i+1 + '.');
			});
		}
	 });
});
</script>
<cfoutput>
<div class="ViewSection">
<h3>#qDetails.Name# Questions</h3>
<p>Drag up and down to sort using the green icon to the left of your captions or questions.</p>
<p><a href="#myself#Assessment.QuestionCreate?AssessmentID=#Attributes.AssessmentID#" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/add.png" border="0" align="absmiddle" /> Add A Question</a></p>
</div>
<!---<cfset qSections = Application.Com.AssessmentSectionGateway.getByAttributes(ParentSectionID=0)>
<cfloop query="qSections">
	<div class="Section1" id="Section#qSections.SectionID#">
	#qSections.Name#
	<cfset qQuestions = Application.Com.AssessQuestionGateway.getByViewAttributes(SectionID=qSections.SectionID)>
	<cfloop query="qQuestions">
		<div class="Question" id="Question_#qQuestions.QuestionID#">
			<img src="#Application.Settings.RootPath#/_images/icons/layers.png" class="DragHandle" /><div class="Caption1Text">#qQuestions.LabelText#<span> <a href="#myself#Assessment.QuestionEdit?AssessmentID=#Attributes.AssessmentID#&QuestionID=#qQuestions.QuestionID#" id="Edit#qQuestions.QuestionID#" class="EditLink"><img src="#Application.Settings.RootPath#/_images/icons/pencil.png" border="0" /></a></span></div>
		</div>
	</cfloop>
	<cfset qSectionsSub = Application.Com.AssessmentSectionGateway.getByAttributes(ParentSectionID=qSections.SectionID)>
	<cfif qSectionsSub.RecordCount GT 0>
	<div class="Section2" id="Section#qSectionsSub.SectionID#">
	#qSectionsSub.Name#
	</div>
	</cfif>
	</div>
</cfloop>--->
<div id="QuestionsContainer">
<cfloop query="qQuestions">
	<cfswitch expression="#qQuestions.QuestionTypeID#">
		<cfcase value="5">
			<div class="Question" id="Question_#qQuestions.QuestionID#">
				<img src="#Application.Settings.RootPath#/_images/icons/layers.png" class="DragHandle" /><div class="Caption1Text">#qQuestions.LabelText#<span> <a href="#myself#Assessment.QuestionEdit?AssessmentID=#Attributes.AssessmentID#&QuestionID=#qQuestions.QuestionID#" id="Edit#qQuestions.QuestionID#" class="EditLink"><img src="#Application.Settings.RootPath#/_images/icons/pencil.png" border="0" /></a></span></div>
			</div>
		</cfcase>
		<cfcase value="6">
			<div class="Question" id="Question_#qQuestions.QuestionID#">
				<img src="#Application.Settings.RootPath#/_images/icons/layers.png" class="DragHandle" /><div class="Caption2Text">#qQuestions.LabelText#<span> <a href="#myself#Assessment.QuestionEdit?AssessmentID=#Attributes.AssessmentID#&QuestionID=#qQuestions.QuestionID#" id="Edit#qQuestions.QuestionID#" class="EditLink"><img src="#Application.Settings.RootPath#/_images/icons/pencil.png" border="0" /></a></span></div>
			</div>
		</cfcase>
		<cfcase value="7">
			<div class="Question" id="Question_#qQuestions.QuestionID#">
				<img src="#Application.Settings.RootPath#/_images/icons/layers.png" class="DragHandle" /><div class="Caption3Text">#qQuestions.LabelText#<span> <a href="#myself#Assessment.QuestionEdit?AssessmentID=#Attributes.AssessmentID#&QuestionID=#qQuestions.QuestionID#" id="Edit#qQuestions.QuestionID#" class="EditLink"><img src="#Application.Settings.RootPath#/_images/icons/pencil.png" border="0" /></a></span></div>
			</div>
		</cfcase>
		<cfdefaultcase>
		<div class="Question" id="Question_#qQuestions.QuestionID#">
			<img src="#Application.Settings.RootPath#/_images/icons/layers.png" class="DragHandle" /><div class="QuestionNo">#QuestionNo#.</div><div class="QuestionText">#qQuestions.LabelText# <span> <a href="#myself#Assessment.QuestionEdit?AssessmentID=#Attributes.AssessmentID#&QuestionID=#qQuestions.QuestionID#" id="Edit#qQuestions.QuestionID#" class="EditLink"><img src="#Application.Settings.RootPath#/_images/icons/pencil.png" border="0" /></a></span></div>
			<cfset QuestionNo++>
		</div>
		</cfdefaultcase>
	</cfswitch>
</cfloop>
</div>
</cfoutput>