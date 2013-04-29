<cfoutput>
<div class="btn-toolbar">
  <div class="btn-group pull-left js-selected-actions">
    <a class="btn btn-mini dropdown-toggle disabled" data-toggle="dropdown" href="##">SELECTED: <span id="label-status-selected" class="js-status-selected-count">0</span></a>
    <a class="btn btn-mini dropdown-toggle disabled" data-toggle="dropdown" href="##">
      Actions
      <span class="caret"></span>
    </a>
    <ul class="dropdown-menu">
      <li><a href="javascript:void(0);" id="RemoveChecked" title="Remove selected faculty"><i class="icon-trash"></i> Remove</a></li>
      <li class="divider"></li>
      <li class="nav-header">CHANGE ROLES</li>
      <cfloop query="qRoles">
      <li><a href="" class="js-change-type" data-roleid="#qRoles.RoleID#">#qRoles.Name#</a></li>
      </cfloop>
      <li class="divider"></li>
      <li><a href="" class="js-change-type" data-roleid="0">Remove Role</a></li>
    </ul>
  </div>
  <div class="btn-group">
    <a title="Add Faculty / Speaker" class="btn btn-mini js-add-person-link" id="FacultyLink" href="javascript:void(0);"><i class="icon-plus"></i></a>
  </div>
</div>
</cfoutput>