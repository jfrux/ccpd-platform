<script>
App.Activity.Files.Ahah.start();
</script>
<cfoutput>
<cfscript>
function FileType(path)
{
  var fso = CreateObject("COM", "Scripting.FileSystemObject");
  var theFile = fso.GetFile(path);
  return theFile.Type;
}
</cfscript>
<cfif qFileList.RecordCount GT 0>
<table class="ViewSectionGrid DetailView table table-condensed table-bordered">
  
  <cfset FilePath = "#ExpandPath("./_uploads/ActivityFiles/#Attributes.ActivityID#/")#">
    <thead>
      <tr>
        <th width="15"><input type="checkbox" name="CheckAll" id="CheckAll" class="js-select-all" /></th>
        <th></th>
        <th>Information</th>
      </tr>
    </thead>
    <tbody>
    <cfloop query="qFileList">
      <cfset FileType = Right(qFileList.FileName,Len(qFileList.FileName)-Find(".",qFileList.FileName))>
      <tr id="DocRow#qFileList.FileID#" data-key="#qFileList.fileid#" data-name="#qFileList.FileName#" class="js-select-all-rows js-row AllDocs">
        <td valign="top" style="padding-top:7px;" width="16"><input type="checkbox" name="Checked" class="DocCheckbox js-select-one" id="Checked#qFileList.FileID#" value="#qFileList.FileID#" /></td>
        <td valign="top" style="padding-top:7px;" width="16"><img src="#Application.Settings.RootPath#/_images/file_icons/#FileType#.png" /></td>
        <td>
          <a href="#Myself#File.Download?Mode=Activity&ModeID=#Attributes.ActivityID#&ID=#qFileList.FileID#" style="text-decoration:none; font-size:15px;">
            <strong>#qFileList.FileName#</strong></a>
          <div style="font-size:10px; color:##555;">
            "#qFileList.FileCaption#" #qFileList.FileTypeName# File by #qFileList.CreatedByFName# #qFileList.CreatedByLName#
          </div>
          <div>
          <cfif qFileList.ComponentCount GT 0>
              <em>Published File</em> || <a href="javascript://" id="Unpublish-#qFileList.FileID#" class="UnpublishLink">Unpublish</a>
            <cfelse>
                <a href="javascript://" id="Publish-3-#qFileList.FileID#" class="PublishLink">Publish to File Download</a> || <a href="javascript://" id="Publish-4-#qFileList.FileID#" class="PublishLink">Publish to Document Viewer</a>
            </cfif>
          </div>
        </td>
        <td>
          <div class="btn-group btn-group-vertical">
            <a href="#Myself#File.Download?Mode=Activity&ModeID=#Attributes.ActivityID#&ID=#qFileList.FileID#" title="Download Document" class="btn js-download-file-link" data-tooltip-title="Download File"><i class="icon-download"></i></a>
            <a href="#Myself#File.Edit&Mode=Activity&ModeID=#Attributes.ActivityID#&ID=#qFileList.FileID#" title="Edit Details" class="btn js-edit-file-link" data-tooltip-title="Edit File Details"><i class="icon-pencil"></i></a>
            <a href="##" title="Copy File Link" class="btn js-copy-file-link" data-clipboard-text="http://ccpd.uc.edu/download/Activity/#Attributes.ActivityID#/#qFileList.FileID#" data-tooltip-title="Copy Public Link"><i class="icon-link"></i></a>
          </div>
          </td>
      </tr>
    </cfloop>
  </tbody>
</table>
<cfelse>
<div class="alert alert-info">
  You have not added any documents.<br />
  Click <a class="btn btn-small" href="javascript:void(0);"><i class="icon-plus"></i></a> above to upload some.
</div>
</cfif>
</cfoutput>