<cfoutput>
<div class="btn-toolbar">
  <div class="btn-group pull-left js-selected-actions">
    <a class="btn btn-mini dropdown-toggle disabled" data-toggle="dropdown" href="##">SELECTED: <span id="label-status-selected" class="js-status-selected-count">0</span></a>
    <a class="btn btn-mini dropdown-toggle disabled" data-toggle="dropdown" href="##">
      Actions
      <span class="caret"></span>
    </a>
    <ul class="dropdown-menu">
      <li><a href="javascript:void(0);" id="RemoveChecked" title="Remove selected documents"><i class="icon-trash"></i> Remove</a></li>
    </ul>
  </div>
  <div class="btn-group">
    <a title="Upload Document" class="btn btn-mini UploadLink" href="javascript:void(0);" data-tooltip-title="Upload File"><i class="icon-plus"></i></a>
    <a class="btn btn-mini" href="#Myself#Activity.PubBuilder?ActivityID=#Attributes.ActivityID#"><img src="#Application.Settings.RootPath#/_images/file_icons/html.png" align="absmiddle" style="padding-right:4px;" />View Published Files</a>
  </div>
</div>
</cfoutput>