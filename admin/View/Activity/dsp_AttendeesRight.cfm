<cfoutput>
  
  <div class="btn-group pull-left js-partic-actions">
    <a class="btn dropdown-toggle disabled" data-toggle="dropdown" href="##">SELECTED: <span id="label-status-selected" class="js-attendee-status-selected-count">0</span></a>
    <a class="btn dropdown-toggle disabled" data-toggle="dropdown" href="##">
      Actions
      <span class="caret"></span>
    </a>
    <ul class="dropdown-menu">
      <li><a href="javascript:void(0);" id="RemoveChecked" title="Remove selected registrants"><img src="#Application.Settings.RootPath#/_images/icons/application_form_delete.png" align="absmiddle" style="padding-right:4px;" />Remove</a></li>
      <li class="divider"></li>
      <li class="nav-header">CHANGE STATUSES</li>
      <li><a href="##" class="js-change-status" id="change-status-1">Complete</a></li>
      <li><a href="##" class="js-change-status" id="change-status-4">Failed</a></li>
      <li><a href="##" class="js-change-status" id="change-status-2">In Progress</a></li>
      <li><a href="##" class="js-change-status" id="change-status-3">Registered</a></li>
      <li class="divider"></li>
      <li class="nav-header">CERTIFICATES</li>
      <cfloop query="qActivityCredits">
      <cfswitch expression="#qActivityCredits.CreditName#">
        <cfcase value="CME">
        <li><a href="javascript://" id="PrintCMECert" class="js-print" title="This link provides certificates for CME credit ONLY.">CME Certificates</a></li>
        </cfcase>
        <cfcase value="CNE">
        <li><a href="javascript://" id="PrintCNECert" class="js-print" title="This link provides certificates for CNE credit ONLY.">CNE Certificates</a></li>
        </cfcase>
      </cfswitch>
      </cfloop>
    </ul>
  </div>
  <div class="btn-group">
    <a class="btn dropdown-toggle attendee-filter-btn" data-toggle="dropdown" href="##">
      <span>All</span>
      <span class="caret"></span>
    </a>
    <ul class="dropdown-menu attendees-filter">
      <li id="attendees-0"<cfif attributes.status EQ 0> class="current"</cfif>><a href="javascript://">All (<cfoutput>#totalCount#</cfoutput>)</a></li>
      <li id="attendees-1"<cfif attributes.status EQ 1> class="current"</cfif>><a href="javascript://">Complete (<cfoutput>#completeCount#</cfoutput>)</a></li>
      <li id="attendees-4"<cfif attributes.status EQ 4> class="current"</cfif>><a href="javascript://">Failed (<cfoutput>#failCount#</cfoutput>)</a></li>
      <li id="attendees-2"<cfif attributes.status EQ 2> class="current"</cfif>><a href="javascript://">In Progress (<cfoutput>#progressCount#</cfoutput>)</a></li>
      <li id="attendees-3"<cfif attributes.status EQ 3> class="current"</cfif>><a href="javascript://">Registered (<cfoutput>#registeredCount#</cfoutput>)</a></li>
    </ul>
  </div>
  <div class="btn-group">
    <a title="Add Registrant" class="btn" id="AttendeeLink" href="javascript:void(0);"><i class="icon-plus"></i> Add</a>
    <a href="javascript:;" class="btn batchLink"><i class="icon-upload"></i> Import</a>
  </div>
  <div class="form-inline pull-right">
    <label>Addl. Partic.
    <input type="text" name="AddlAttendees" id="AddlAttendees" value="#Attributes.AddlAttendees#" style="width: 50px;" />
    </label>
    <label class="hide">Max.
    <input type="text" name="MaxRegistrants" id="MaxRegistrants" value="#Attributes.MaxRegistrants#" style="width: 50px;" />
    </label>
  </div>

</cfoutput>