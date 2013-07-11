<script>
App.Activity.Faculty.Ahah.start();
</script>

<cfoutput>
<cfif qActivityFacultyList.RecordCount GT 0>
  <form name="FacultyList" method="post" id="MembersList">
  <table class="ViewSectionGrid DetailView table table-condensed table-bordered">
    <thead>
      <tr>
        <th width="15"><input type="checkbox" name="CheckAll" class="js-select-all" /></th>
        <th>Name</th>
        <th>Role</th>
        <th>Disclosure</th>
        <th>CV / Resume</th>
      </tr>
    </thead>
    <tbody>
      <cfloop query="qActivityFacultyList">
        <tr id="PersonRow#PersonID#" data-key="#PersonID#" data-name="#LastName#, #FirstName#" class="js-row js-select-all-rows AllFaculty">
          <td>
            <input type="checkbox" name="Checked" class="MemberCheckbox js-select-one" id="Checked#PersonID#" value="#PersonID#" />
          </td>
          <td>
            <a href="#myself#Person.Detail?PersonID=#PersonID#" class="PersonLink" id="PERSON|#PersonID#|#LastName#, #FirstName#" title="View person profile of #FirstName# #LastName#">#FirstName# #LastName#</a>
          </td>
          <td>#qActivityFacultyList.RoleName#</td>
          <td>
            <div id="Section#qActivityFacultyList.PersonID#">
              <div class="DislosureBox js-disclosure-box span12" id="DislosureBox#PersonID#">
                <div class="btn-group">
                <cfif qActivityFacultyList.DisclosureFileID NEQ "">
                  
                  <a href="#Myself#File.Download?Mode=Person&ModeID=#qActivityFacultyList.PersonID#&ID=#qActivityFacultyList.DisclosureFileID#" class="btn btn-default js-disclosure-btn" title="Download Disclosure">
                    <i class="icon-download"></i>
                  </a>
                  <cfif qActivityFacultyList.DisclosureApproveFlag EQ "N">
                    <a id="Approve|Disclosure|#qActivityFacultyList.PersonID#" class="btn<cfif qActivityFacultyList.DisclosureApproveFlag EQ 'Y'> disabled<cfelse> approveFile</cfif> js-disclosure-btn" href="javascript:void(0);" data-tooltip-title="<cfif qActivityFacultyList.DisclosureApproveFlag EQ 'Y'>Approved #DateFormat(qActivityFacultyList.DisclosureCreatedDate,"MM/DD/YYYY")#<cfelse>Mark Approved</cfif>">
                      <i class="icon-check"></i>
                    </a>
                  <cfelse>
                    <a href="javascript:void(0);" id="Unapprove|Disclosure|#qActivityFacultyList.PersonID#" class="btn btn-default js-disclosure-btn<cfif qActivityFacultyList.DisclosureApproveFlag NEQ 'Y'> disabled<cfelse> approveFile</cfif>" data-tooltip-title="Revoke Approval">
                      <i class="icon-remove"></i>
                    </a>
                  </cfif>
                </cfif>
                <a href="javascript:void(0);" class="UploadFile js-disclosure-btn btn" id="File|#qActivityFacultyList.PersonID#" data-tooltip-title="Upload New Disclosure">
                  <i class="icon-upload"></i>
                </a>
                </div>
              </div>
            </div>
            </div>
          </td>
          <td>
            <div class="CVBox js-cv-box span12" id="CVBox#PersonID#">
              <div class="btn-group">
              <cfif qActivityFacultyList.CVFileID NEQ "">
                  
                <a class="btn btn-default js-cv-btn" href="#Myself#File.Download?Mode=Person&ModeID=#qActivityFacultyList.PersonID#&ID=#qActivityFacultyList.CVFileID#" title="Download CV">
                  <i class="icon-download"></i>
                </a>
                <cfif qActivityFacultyList.CVApproveFlag EQ "N">
                  <a class="btn btn-default js-cv-btn<cfif qActivityFacultyList.CVApproveFlag EQ 'Y'> disabled<cfelse> approveFile</cfif>" href="javascript:void(0);" id="Approve|CV|#qActivityFacultyList.PersonID#"   data-tooltip-title="<cfif qActivityFacultyList.CVApproveFlag EQ 'Y'>Approved #DateFormat(qActivityFacultyList.CVCreatedDate,"MM/DD/YYYY")#<cfelse>Mark Approved</cfif>">
                    <i class="icon-check"></i>
                  </a>
                <cfelse>
                  <a class="btn btn-default js-cv-btn<cfif qActivityFacultyList.CVApproveFlag NEQ 'Y'> disabled<cfelse> approveFile</cfif>" id="Unapprove|CV|#qActivityFacultyList.PersonID#" href="javascript:void(0);" data-tooltip-title="Revoke Approval">
                    <i class="icon-remove"></i>
                  </a>
                </cfif>
              </cfif>
              <a class="UploadFile btn js-cv-btn" href="javascript:void(0);" id="File|#qActivityFacultyList.PersonID#" data-tooltip-title="Upload New CV">
                <i class="icon-upload"></i>
              </a>
              </div>
            </div>
          </td>
        </tr>
      </cfloop>
    </tbody>
  </table>
  </form>
<cfelse>
  <div class="alert alert-info">
    You have not added any faculty members.<br />
    Click <a class="btn btn-default btn-small js-add-person-link" href="javascript:void(0);"><i class="icon-plus"></i></a> above to add someone.
  </div>
</cfif>
</cfoutput>