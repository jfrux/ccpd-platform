<script>
App.Person.Preferences.start();
</script>

<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveJS.cfm" />
<script>
<cfoutput>
var nDegree = <cfif PersonDegreeInfo.DegreeID NEQ "">#PersonDegreeInfo.DegreeID#<cfelse>0</cfif>;
</cfoutput>

</script>

<cfoutput>
<form action="#Application.Settings.RootPath#/_com/AJAX_Person.cfc" method="post" name="frmEditActivity" class="form-horizontal js-formstate">
  <input type="hidden" name="method" id="method" value="savePersonSpecialties" />
  <input type="hidden" name="personid" id="personid" value="#attributes.personid#" />
  <input type="hidden" name="returnformat" id="returnformat" value="plain" />
  
  <div class="control-group">
    <label class="control-label">Profession</label>
    <div class="controls">
      <cfloop query="Application.List.Degrees">
        <label class="radio degreeOption" for="DegreeID-#Application.List.Degrees.DegreeID#">
          <input type="radio" name="DegreeID" id="DegreeID-#Application.List.Degrees.DegreeID#" class="degreeid" value="#Application.List.Degrees.DegreeID#"<cfif PersonDegreeInfo.DegreeID EQ Application.List.Degrees.DegreeID> CHECKED</cfif> />
          #Application.List.Degrees.Name#
        </label>
      </cfloop>
    </div>
  </div>
  <div class="control-group js-specialties">
    <label class="control-label">Specialty Interest Areas</label>
    <div class="controls">
      
    </div>
  </div>
  <input type="hidden" name="Submitted" value="1" />
</form>
</cfoutput>