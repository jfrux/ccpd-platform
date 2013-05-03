<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveJS.cfm" />
<script>
	<cfoutput>
	var nDegree = <cfif PersonDegreeInfo.DegreeID NEQ "">#PersonDegreeInfo.DegreeID#<cfelse>0</cfif>;
	</cfoutput>
	// GATHERS PERSON SPECIALTIES
	function getPersonSpecialties(nPerson) {
		$.getJSON(sRootPath + "/_com/AJAX_person.cfc", { method: "getPersonSpecialties", personId: nPerson, returnFormat: "plain" },
			function(data) {
			$.each(data.DATASET, function(i, item) {
				$("#Specialty" + item.SPECIALTYID).attr("checked",true);
				updateSpecialtyOption(item.SPECIALTYID)
			});
		});
	}
	
	// GATHERS SPECIALTIES
	function getSpecialties() {
		$.getJSON(sRootPath + "/_com/AJAX_activity.cfc", { method: "getSpecialties", returnFormat: "plain" },
			function(data) {
			
			if($.ArrayLen(data.DATASET) > 0) {
				var $specialtytemplate = $("#specialty-template").html();
				var $specialtyoutput = "";
				
				$.each(data.DATASET, function(i, item) {
					$specialtyoutput = $specialtyoutput + $specialtytemplate.replace(/%specialtyId%/gi,item.SPECIALTYID);
					$specialtyoutput = $specialtyoutput.replace('%name%',item.NAME);
				});
				
				$(".specialties p").html($specialtyoutput);
			} else {
				addError(data.STATUSMSG,250,6000,4000);
			}
		});
	}
	
	// STYLIZES THE DEGREE DIVS
	function updateDegreeOption(nId) {
		$(".degreeOption").removeClass("formOptionSelected");
		$("#degree-" + nId).addClass("formOptionSelected");
	}
	
	// STYLIZES THE SPECIALTY DIVS
	function updateSpecialtyOption(nId) {
			if($("#specialty-" + nId).is('.formOptionSelected')) {
				$("#specialty-" + nId).removeClass("formOptionSelected");
			} else {
				$("#specialty-" + nId).addClass("formOptionSelected");
			}
	}

	$(document).ready(function() {
		getSpecialties();
		getPersonSpecialties(nPerson);
		
		$(".degreeOption").addClass("formOption");
		$(".specialtyOption").addClass("formOption");
		
		updateDegreeOption(nDegree);
		
		$(".specialtyOption").live("change",function() {
			var nSpecialty = $.ListGetAt(this.id, 2, "-");
			updateSpecialtyOption(nSpecialty);
		});
		
		$(".degreeid").click(function() {
			var nDegree = $.ListGetAt(this.id,2,'-');
			
			$.getJSON(sRootPath + "/_com/AJAX_Person.cfc", { method: 'saveDegree', PersonID: nPerson, DegreeID: nDegree, returnFormat: 'plain' },
				function(data) {
					if(data.STATUS) {
						updateDegreeOption(nDegree);
						addMessage(data.STATUSMSG,250,6000,4000);
					} else {
						addError(data.STATUSMSG,250,6000,4000);
					}
			
			});
		});
	});
</script>

<cfoutput>
<form action="#Application.Settings.RootPath#/_com/AJAX_Person.cfc" method="post" name="frmEditActivity" id="EditForm">
<input type="hidden" name="method" id="method" value="savePersonSpecialties" />
<input type="hidden" name="PersonID" id="PersonID" value="#Attributes.PersonID#" />
<input type="hidden" name="ChangedFields" id="ChangedFields" />
<input type="hidden" name="ChangedValues" id="ChangedValues" />
<input type="hidden" name="returnformat" id="returnformat" value="plain" />
<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveInfo.cfm" />
	<h2>Profession</h2>
	<div class="degrees">
    <cfloop query="Application.List.Degrees">
    	<div class="degreeOption" id="degree-#Application.List.Degrees.DegreeID#">
            <input type="radio" name="DegreeID" id="DegreeID-#Application.List.Degrees.DegreeID#" class="degreeid" value="#Application.List.Degrees.DegreeID#"<cfif PersonDegreeInfo.DegreeID EQ Application.List.Degrees.DegreeID> CHECKED</cfif> />
            <label for="DegreeID-#Application.List.Degrees.DegreeID#"> #Application.List.Degrees.Name#</label>
        </div>
    </cfloop>
    </div>
    <div class="specialties">
        <h2 class="Head Gray">Specialty Interests</h2>
        <p>
        </p>
            <input type="hidden" name="Submitted" value="1" />
    </div>
</form>
<div id="specialty-template" style="display:none;">
	<div class="specialtyOption" id="specialty-%specialtyId%"><input type="checkbox" name="Specialties" id="Specialty%specialtyId%" value="%specialtyId%" /> <label for="Specialty%specialtyId%">%name%</label></div>
</div>
</cfoutput>