<script>
App.Activity.Faculty.Ahah.start();
</script>

<cfoutput>
<cfif qActivityFacultyList.RecordCount GT 0>
  <form name="FacultyList" method="post" id="MembersList">
  <table class="ViewSectionGrid DetailView table table-condensed table-bordered">
    <thead>
      <tr>
        <th width="15"><input type="checkbox" name="CheckAll" id="CheckAll" /></th>
        <th>Name</th>
        <th>Role</th>
        <th>Disclosure</th>
        <th>CV / Resume</th>
      </tr>
    </thead>
    <tbody>
      <cfloop query="qActivityFacultyList">
        <tr id="PersonRow#PersonID#" class="AllFaculty">
          <td>
            <input type="checkbox" name="Checked" class="MemberCheckbox" id="Checked#PersonID#" value="#PersonID#" />
          </td>
          <td>
            <a href="#myself#Person.Detail?PersonID=#PersonID#" class="PersonLink" id="PERSON|#PersonID#|#LastName#, #FirstName#" title="View person profile of #FirstName# #LastName#">#FirstName# #LastName#</a>
          </td>
          <td>#qActivityFacultyList.RoleName#</td>
          <td>
            <div id="Section#qActivityFacultyList.PersonID#">
              <div class="DislosureBox js-disclosure-box span12" id="DislosureBox#PersonID#">
                <cfif qActivityFacultyList.DisclosureFileID NEQ "">
                  <cfif qActivityFacultyList.DisclosureApproveFlag EQ "N">
                    <cfset DisclosureFileApproval = "Approve">
                  <cfelse>
                    <cfset DisclosureFileApproval = "Unapprove">
                  </cfif>
                  <div class="btn-group">
                    <a href="#Myself#File.Download?Mode=Person&ModeID=#qActivityFacultyList.PersonID#&ID=#qActivityFacultyList.DisclosureFileID#" class="btn js-disclosure-btn" title="Download Disclosure">
                      <i class="icon-download"></i>
                    </a>
                    <a id="Approve|Disclosure|#qActivityFacultyList.PersonID#" class="btn<cfif qActivityFacultyList.DisclosureApproveFlag EQ 'Y'> disabled</cfif> js-disclosure-btn approveFile" href="javascript:void(0);" data-tooltip-title="<cfif qActivityFacultyList.DisclosureApproveFlag EQ 'Y'>Approved #DateFormat(qActivityFacultyList.DisclosureCreatedDate,"MM/DD/YYYY")#<cfelse>Mark Approved</cfif>"><i class="icon-check"></i></a>
                    <a href="javascript:void(0);" id="Unapprove|Disclosure|#qActivityFacultyList.PersonID#" class="btn js-disclosure-btn approveFile<cfif qActivityFacultyList.DisclosureApproveFlag NEQ 'Y'> disabled</cfif>" data-tooltip-title="Revoke Approval"><i class="icon-remove"></i></a>
                    <a href="javascript:void(0);" class="UploadFile js-disclosure-btn btn" id="File|#qActivityFacultyList.PersonID#" data-tooltip-title="Upload New Disclosure"><i class="icon-upload-alt"></i></a>
                  </div>
                </cfif>
                
              </div>
            </div>
            </div>
          </td>
          <td>
            <div class="CVBox js-cv-box span12" id="CVBox#PersonID#">
              <cfif qActivityFacultyList.CVFileID NEQ "">
                <cfif qActivityFacultyList.CVApproveFlag EQ "N">
                    <cfset CVFileApproval = "Approved">
                  <cfelse>
                    <cfset CVFileApproval = "Unapprove">
                  </cfif>
                  <div class="btn-group">
                    <a class="btn js-cv-btn" href="#Myself#File.Download?Mode=Person&ModeID=#qActivityFacultyList.PersonID#&ID=#qActivityFacultyList.CVFileID#" title="Download CV"><i class="icon-download"></i></a>
                    <a class="btn js-cv-btn <cfif qActivityFacultyList.CVApproveFlag EQ 'Y'> disabled</cfif> approveFile" href="javascript:void(0);" id="Approve|CV|#qActivityFacultyList.PersonID#"   data-tooltip-title="<cfif qActivityFacultyList.CVApproveFlag EQ 'Y'>Approved #DateFormat(qActivityFacultyList.CVCreatedDate,"MM/DD/YYYY")#<cfelse>Mark Approved</cfif>"><i class="icon-check"></i></a>
                    <a class="btn js-cv-btn approveFile" id="Unapprove|CV|#qActivityFacultyList.PersonID#" href="javascript:void(0);" data-tooltip-title="Revoke Approval"><i class="icon-remove"></i></a>
                    <a class="UploadFile btn js-cv-btn" href="javascript:void(0);" id="File|#qActivityFacultyList.PersonID#" data-tooltip-title="Upload New CV"><i class="icon-upload-alt"></i></a>
                  </div>
              </cfif>
              
            </div>
          </td>
        </tr>
      </cfloop>
    </tbody>
  </table>
  </form>
<cfelse>
  <div class="alert alert-info">
    You have not added any faculty / speakers.<br />
    Please click '<a class="btn"><i class="icon-plus"></i></a> on the right to begin.
  </div>
</cfif>
</cfoutput>