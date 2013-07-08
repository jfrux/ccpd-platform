<script>
var nQuestionID = 0;
var sQuestionMode = "";
function updateQuestionList() {
	$.post(sMyself + "Activity.BuilderQList", { AssessmentID: nAssessmentID }, function(data) {
		$("#QuestionListDialog").html(data);
	});
}

$(document).ready(function() {
	$("#SortablesASSESS").sortable({
	 	placeholder: "Component PlaceHolder",
		handle: ".ComponentHandle",
		containment: "#SortablesASSESS",
		stop: function() {
			aIds = $("#SortablesASSESS").sortable("serialize");
			$.post(sRootPath + "/_com/AJAX_Builder.cfc", { method: 'saveComponentSort', Mode: 'A', Comp: aIds, returnformat: 'Plain' });
		}
	 });
	
	$("#SortablesLINKS").sortable({
	 	placeholder: "Component PlaceHolder",
		handle: ".ComponentHandle",
		containment: "#SortablesLINKS",
		stop: function() {
			aIds = $("#SortablesLINKS").sortable("serialize");
			$.post(sRootPath + "/_com/AJAX_Builder.cfc", { method: 'saveComponentSort', Mode: 'M', Comp: aIds, returnformat: 'Plain' });
		}
	 });
	
	$("#SortablesMATERIALS").sortable({
	 	placeholder: "Component PlaceHolder",
		handle: ".ComponentHandle",
		containment: "#SortablesMATERIALS",
		stop: function() {
			aIds = $("#SortablesMATERIALS").sortable("serialize");
			$.post(sRootPath + "/_com/AJAX_Builder.cfc", { method: 'saveComponentSort', Mode: 'M', Comp: aIds, returnformat: 'Plain' });
		}
	 });
	 
	$("a.ComponentEditLink").click(function() {
		var sType = $.ListGetAt(this.id,3,'|');
		nPubCompID = $.ListGetAt(this.id,2,'|');
		
		$("#" + sType + "Dialog").dialog("open");
	});
	
	$("a.ComponentRemoveLink").click(function() {
		var sType = $.ListGetAt(this.id,3,'|');
		var nRemoveID = $.ListGetAt(this.id,2,'|');
		
		if(confirm('Are you sure you want to remove this component?')) {
			$.post(sRootPath + "/_com/AJAX_Builder.cfc", { method: 'removeComponent', PubComponentID: nRemoveID, returnFormat: 'Plain' });
		} else {
			return false;
		}
		
		updateBuilder();
	});
	
	$("#QuestionListDialog").dialog({ 
			title: "Question Manager",
			modal: true, 
			autoOpen: false,
			height:500,
			width:700,
			resizable: true,
			draggable: true,
			position:'top',
			buttons: {
				Done:function() {
					updateBuilder();
					$(this).dialog("close");
				},
				'Add Question':function() {
					$("#QuestionDialog").dialog("open");
				}
			},
			open:function() {
				updateQuestionList();
			},
			close:function() {
				$("#QuestionListDialog").html("");
			}
		});	
		
		$(".QuestionsLink").click(function() {
			nAssessmentID = $.ListGetAt(this.id,2,'|');
			
			$("#QuestionListDialog").dialog("open");
			
			return false;
		});
	
	var Options = {
		beforeSubmit: function(){
			
		},
		success:function(responseText,statusText) {
			var d = new Date();
			
			if($.Trim(responseText) != 'success') {
				addError(responseText,250,6000,4000);
			} else {
				updateBuilder();
				updateQuestionList();
				$("#QuestionDialog").dialog("close");
			}
		}
	}	
	
	$("#QuestionDialog").dialog({ 
			title: "Question Form",
			modal: true, 
			autoOpen: false,
			height:500,
			width:525,
			position:[80,35],
			resizable: true,
			draggable: true,
			buttons:{
				Save:function() {
					$("#frmComp").ajaxSubmit(Options);
				},
				Cancel:function() {
					$(this).dialog("close");
				}
			},
			open:function() {
				$.post(sMyself + "Activity.BuilderQ", { AssessmentID: nAssessmentID, QuestionID: nQuestionID, QuestionMode: sQuestionMode, returnformat: 'Plain' }, function(data) {
					$("#QuestionDialog").html(data);
					$("#frmComp").submit(function() {
						$("#frmComp").ajaxSubmit(Options); 
						return false;
					});
				});
			},
			close:function() {
				$("#QuestionDialog").html("");
				nQuestionID = 0;
			}
		});
});
</script>

<cfoutput>

<h4>Materials</h4>
<!--- MATERIALS --->
<div class="ViewSectionBlock" id="SortablesMATERIALS">
<cfloop query="qCompSortableMATERIALS">
	<div class="Component #qCompSortableMATERIALS.ComponentType#" id="Comp_#qCompSortableMATERIALS.PubComponentID#">
		<div class="ComponentHandle"><a href="javascript://" class="btn btn-small"><i class="icon-move"></i></a></div>
		<div class="ComponentDisplayName">&quot;#MidLimit(qCompSortableMATERIALS.DisplayName,50)#&quot;</div>
		<div class="ComponentOptions btn-group pull-right">
		<a href="javascript:void(0);" class="ComponentEditLink btn btn-small" id="Edit|#qCompSortableMATERIALS.PubComponentID#|#Trim(qCompSortableMATERIALS.ComponentType)#" style="text-decoration:none;"><i class="icon-pencil"></i></a>
		<cfif ListFind("5,11,12",qCompSortableMATERIALS.ComponentID,",")> <a href="javascript:void(0);" class="QuestionsLink btn btn-small" id="Questions|#qCompSortableMATERIALS.AssessmentID#" style="text-decoration:none;"><i class="icon-list"></i> (#qCompSortableMATERIALS.QuestionCount#)</a></cfif> 
		<a href="javascript:void(0);" class="ComponentRemoveLink btn btn-small" id="Remove|#qCompSortableMATERIALS.PubComponentID#|#Trim(qCompSortableMATERIALS.ComponentType)#" style="text-decoration:none;"><i class="icon-trash"></i></a>
		</div>
	</div>
</cfloop>
</div>

<h4>Assessments</h4>
<!--- ASSESSMENTS --->
<div class="ViewSectionBlock" id="SortablesASSESS">
<cfloop query="qCompSortableASSESS">
	<div class="Component #qCompSortableASSESS.ComponentType#" id="Comp_#qCompSortableASSESS.PubComponentID#">
		<div class="ComponentHandle"><a href="javascript://" class="btn btn-small"><i class="icon-move"></i></a></div>
		<div class="ComponentDisplayName">&quot;#MidLimit(qCompSortableASSESS.DisplayName,50)#&quot;</div>
		<div class="ComponentOptions btn-group pull-right">
		<a href="javascript:void(0);" class="ComponentEditLink btn btn-small" id="Edit|#qCompSortableMATERIALS.PubComponentID#|#Trim(qCompSortableASSESS.ComponentType)#" style="text-decoration:none;"><i class="icon-pencil"></i></a>
		<cfif ListFind("5,11,12",qCompSortableASSESS.ComponentID,",")> <a href="javascript:void(0);" class="QuestionsLink btn btn-small" id="Questions|#qCompSortableASSESS.AssessmentID#" style="text-decoration:none;"><i class="icon-list"></i></a></cfif> 
		<a href="javascript:void(0);" class="ComponentRemoveLink btn btn-small" id="Remove|#qCompSortableASSESS.PubComponentID#|#Trim(qCompSortableASSESS.ComponentType)#" style="text-decoration:none;"><i class="icon-trash"></i></a>
		</div>
	</div>
</cfloop>
</div>



<!--- <h4>Hidden / Non-Sortable</h4>
<div class="ViewSectionBlock" id="NonSortables">
<cfloop query="qCompNonSort">
	<div class="Component #qCompNonSort.ComponentType#">
		<div class="ComponentHandle"><img src="#Application.Settings.RootPath#/_images/icons/lock.png" /></div>
		<div class="ComponentDisplayName">&quot;#qCompNonSort.DisplayName#&quot;</div>
		<div class="ComponentOptions btn-group pull-right">
		<a href="javascript:void(0);" class="ComponentEditLink btn btn-small" id="Edit|#qCompSortableMATERIALS.PubComponentID#|#Trim(qCompSortableASSESS.ComponentType)#" style="text-decoration:none;"><i class="icon-pencil"></i></a>
		<cfif ListFind("5,11,12",qCompSortableASSESS.ComponentID,",")> <a href="javascript:void(0);" class="QuestionsLink btn btn-small" id="Questions|#qCompSortableASSESS.AssessmentID#" style="text-decoration:none;"><i class="icon-list"></i></a></cfif> 
		<a href="javascript:void(0);" class="ComponentRemoveLink btn btn-small" id="Remove|#qCompSortableASSESS.PubComponentID#|#Trim(qCompSortableASSESS.ComponentType)#" style="text-decoration:none;"><i class="icon-trash"></i></a>
		</div>
	</div>
</cfloop>
</div> --->
</cfoutput>