<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveJS.cfm" />
<div class="ViewSection">
<script>
App.Activity.ACCME.start();
</script>
<cfoutput>
<form action="#Application.Settings.RootPath#/_com/AJAX_Activity.cfc" class="form-horizontal" method="post" name="frmEditActivity" id="EditForm">
  <input type="hidden" name="activityId" value="#attributes.activityId#" />
  <input type="hidden" value="saveACCMEInfo" name="Method" />
  <input type="hidden" value="plain" name="returnFormat" />
  <input type="hidden" value="" name="ChangedFields" id="ChangedFields" />
  <input type="hidden" value="" name="ChangedValues" id="ChangedValues" />

  <div class="control-group-heading">
    <span>Designed to Change...</span>
  </div>
  <div class="control-group">
    <label class="control-label" for="competenceDesign">Competence</label>
    <div class="controls">
      <select name="competenceDesign" id="competenceDesign">
        <option value="0"<cfif isDefined("attributes.competenceDesign") AND attributes.competenceDesign EQ 0> SELECTED</cfif>>No</option>
        <option value="1"<cfif isDefined("attributes.competenceDesign") AND attributes.competenceDesign EQ 1> SELECTED</cfif>>Yes</option>
      </select>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="performanceDesign">Performance</label>
    <div class="controls">
      <select name="performanceDesign" id="performanceDesign">
        <option value="0"<cfif isDefined("attributes.performanceDesign") AND attributes.performanceDesign EQ 0> SELECTED</cfif>>No</option>
        <option value="1"<cfif isDefined("attributes.performanceDesign") AND attributes.performanceDesign EQ 1> SELECTED</cfif>>Yes</option>
      </select>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="outcomesDesign">Patient Outcomes</label>
    <div class="controls">
      <select name="outcomesDesign" id="outcomesDesign">
        <option value="0"<cfif isDefined("attributes.outcomesDesign") AND attributes.outcomesDesign EQ 0> SELECTED</cfif>>No</option>
        <option value="1"<cfif isDefined("attributes.outcomesDesign") AND attributes.outcomesDesign EQ 1> SELECTED</cfif>>Yes</option>
      </select>
    </div>
  </div>
  <div class="divider"><hr></div>
  <div class="control-group-heading">
    <span>Evaluated changes in...</span>
  </div>
  <div class="control-group">
    <label class="control-label" for="competenceEval">Competence</label>
    <div class="controls">
      <select name="competenceEval" id="competenceEval">
        <option value="0"<cfif isDefined("attributes.competenceEval") AND attributes.competenceEval EQ 0> SELECTED</cfif>>No</option>
        <option value="1"<cfif isDefined("attributes.competenceEval") AND attributes.competenceEval EQ 1> SELECTED</cfif>>Yes</option>
      </select>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="performanceEval">Performance</label>
    <div class="controls">
      <select name="performanceEval" id="performanceEval">
        <option value="0"<cfif isDefined("attributes.performanceEval") AND attributes.performanceEval EQ 0> SELECTED</cfif>>No</option>
        <option value="1"<cfif isDefined("attributes.performanceEval") AND attributes.performanceEval EQ 1> SELECTED</cfif>>Yes</option>
      </select>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="outcomesEval">Patient Outcomes</label>
    <div class="controls">
      <select name="outcomesEval" id="outcomesEval">
        <option value="0"<cfif isDefined("attributes.outcomesEval") AND attributes.outcomesEval EQ 0> SELECTED</cfif>>No</option>
        <option value="1"<cfif isDefined("attributes.outcomesEval") AND attributes.outcomesEval EQ 1> SELECTED</cfif>>Yes</option>
      </select>
    </div>
  </div>
  <cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveInfo.cfm" />
    
</form>
</cfoutput>
</div>