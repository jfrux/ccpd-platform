<script>
App.Activity.Committee.Ahah.start();
</script>
<style>
.PersonPhoto { width:50px; }
</style>
<cfoutput>

<cfif qActivityCommitteeList.RecordCount GT 0>
<table class="ViewSectionGrid DetailView table table-condensed table-bordered">
  <thead>
    <tr>
      <th width="15"><input type="checkbox" name="CheckAll" id="CheckAll" class="js-select-all" /></th>
      <th>Information</th>
      <th>Role</th>
    </tr>
  </thead>
  <tbody>
    <cfloop query="qActivityCommitteeList">
      <tr id="PersonRow#PersonID#" data-key="#PersonID#" data-name="#LastName#, #FirstName#" class="js-row js-select-all-rows AllRows">
        <td valign="top"><input type="checkbox" name="Checked" class="MemberCheckbox js-select-one" id="Checked#PersonID#" value="#PersonID#" /></td>
        <!--- <td valign="top" width="70" style="text-align:center;"><cfif FileExists(ExpandPath("\_uploads\PersonPhotos\#PersonID#.jpg"))><img src="/_uploads/PersonPhotos/#PersonID#.jpg" id="Photo#PersonID#" class="PersonPhoto" /><cfelse><img src="#Application.Settings.RootPath#/_images/icon_<cfif Gender EQ "F">female<cfelse>male</cfif>.gif" id="Photo#PersonID#" class="PersonPhoto" /></cfif></td> --->
        <td valign="top"><a href="#myself#Person.Detail?PersonID=#PersonID#" class="PersonLink" id="PERSON|#PersonID#|#LastName#, #FirstName#">#FirstName# #LastName#</a></td>
        <td valign="top">#qActivityCommitteeList.RoleName#</td>
      </tr>
    </cfloop>
  
  </tbody>
</table>
<cfelse>
  <div class="alert alert-info">
    You have not added any committee members.<br />
    Click <a class="btn btn-small js-add-person-link" href="javascript:void(0);"><i class="icon-plus"></i></a> above to add someone.
  </div>
</cfif>
</cfoutput>