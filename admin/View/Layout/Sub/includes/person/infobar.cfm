<cfoutput>
<cfset qStatuses = Application.Com.StatusGateway.getByAttributes(OrderBy="Name")>
<cfif Session.Account.getAuthorityID() EQ 3>
  <div id="Authority">
      <h3><i class="fg fg-lock"></i> Authority Level</h3>
      <div class="box">
        <cfset qAuthLevels = Application.List.AuthLevels>
        <select name="AuthLevel" id="AuthLevel" class="span24">
          <option value="0">None</option>
          <cfloop query="qAuthLevels">
            <option value="#Trim(qAuthLevels.AuthID)#"<cfif Attributes.AuthorityID EQ qAuthLevels.AuthID> SELECTED</cfif>>#qAuthLevels.Name#</option>
            </cfloop>
        </select>
      </div>
  </div>
  </cfif>
  <div id="Status">
    <h3>Person Status</h3>
    <div class="box">
      <div class="project-status person-status js-person-status">
        <select name="StatusChanger" id="StatusChanger" class="span24">
          <option value="">No Status</option>
          <cfloop query="qStatuses">
          <option value="#qStatuses.StatusID#"<cfif PersonBean.getStatusID() EQ qStatuses.StatusID> selected</cfif>>#qStatuses.Name#</option>
          </cfloop>
        </select>
      </div>
    </div>
  </div>
</cfoutput>