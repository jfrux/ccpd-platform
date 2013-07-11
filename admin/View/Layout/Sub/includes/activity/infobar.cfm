<cfoutput>
<cfset qStatuses = Application.Com.StatusGateway.getByAttributes(OrderBy="Name")>

<div id="Status">
  <h3><i class="fg fg-fruit"></i> Activity Health</h3>
  <div class="box">
    <div class="project-status activity-status js-activity-status">
      <select name="StatusChanger" id="StatusChanger">
        <option value="">No Status</option>
        <cfloop query="qStatuses">
        <option value="#qStatuses.StatusID#"<cfif ActivityBean.getStatusID() EQ qStatuses.StatusID> selected</cfif>>#qStatuses.Name#</option>
        </cfloop>
      </select>
    </div>

    <div class="overview-buttons">
      <div class="btn-group">
        <a href="javascript:void(0);" id="OverviewDialogLink" class="btn btn-default">Overview</a>
        <a href="javascript:void(0);" id="ActivityDialogLink" class="btn btn-default<cfif ParentBean.getSessionType() NEQ "M"> disabled</cfif>">Related</a>
      </div>
    </div>
    
    <div id="ActivityStats">
      
    </div>
  </div>
  
  
</div>
  
<div id="Containers">
  
</div>
</cfoutput>