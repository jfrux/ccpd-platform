<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_LinkList">
	<cf_cePersonFinder Instance="Faculty" DefaultName="Add Faculty Member" DefaultID="" AddPersonFunc="saveFacultyMember();" ActivityID="#Attributes.ActivityID#">
</div>
<div class="MultiFormRight_SectSubTitle">Change Checked Roles</div>
<div class="MultiFormRight_LinkList">
	<select name="RoleID" id="RoleID">
    	<option value="">Select one...</option>
        <cfloop query="qRoles">
    	<option value="#qRoles.RoleID#"<cfif qRoles.Name EQ "Speaker"> selected="selected"</cfif>>#qRoles.Name#</option>
        </cfloop>
    	<option value="0">Remove Role</option>
    </select>
    <input type="button" name="btnRoleSubmit" id="btnRoleSubmit" value="OK" />
</div>
<div class="MultiFormRight_SectSubTitle">Removal Options</div>
<div class="MultiFormRight_LinkList">
<a href="javascript:void(0);" id="RemoveChecked" title="Remove selected faculty members"><img src="#Application.Settings.RootPath#/_images/icons/application_form_delete.png" align="absmiddle" style="padding-right:4px;" />Remove Checked</a>
<a href="javascript:void(0);" id="RemoveAll" title="Remove all faculty members"><img src="#Application.Settings.RootPath#/_images/icons/cancel.png" align="absmiddle" style="padding-right:4px;" />Remove All</a>
</div>
</cfoutput>