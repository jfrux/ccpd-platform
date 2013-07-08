<cfparam name="Attributes.Page" default="0">

<script>
App.Activity.Committee.Ahah.start();
</script>

<cfoutput>

<div style="display: none;" id="prototypes">
	<div style="display: none;" id="action_menu">
		<ul style="display: block;" class="round" id="menuActions-{personid}">
    	<cfloop query="qActivityCredits">
            <cfswitch expression="#qActivityCredits.CreditName#">
                <cfcase value="CME">
                    <li class="pCMECert"><a href="Report.CMECert?ActivityID=#Attributes.ActivityID#&ReportID=5&SelectedMembers={personid}"><i/>CME Certificate</a></li>
                </cfcase>
                <cfcase value="CNE">
                    <li class="CNECert"><a href="Report.CNECert?ActivityID=#Attributes.ActivityID#&ReportID=6&SelectedMembers={personid}"><i/>CNE Certificate</a></li>
                </cfcase>
            </cfswitch>
        </cfloop>
      <li class="sendCertificate"><a href="javascript:void(0);"><i/>Send Certificate</a></li>
			<li class="assess"><a href="#myself#Activity.AttendeeDetails?ActivityID={activityid}&PersonID={personid}"><i/>Assessments</a></li>
			<li class="pifform"><a href="#myself#Activity.AttendeeCDC?ActivityID={activityid}&PersonID={personid}"><i/>PIF Form</a></li>
			<li class="credits"><a href="#myself#Activity.AdjustCredits?ActivityID={activityid}&PersonID={personid}"><i/>Credits</a></li>
			<li class="togglemd"><a href="javascript:void(0);"><i/>Toggle MD</a></li>
			<li class="reset"><a href="javascript:void(0);"><i/>Reset <span>user</span></a></li>
			<li class="remove"><a href="javascript:void(0);"><i/>Remove <span>user</span></a></li>
		</ul>
	</div>
</div>
</cfoutput>
<style>
#pifForm { overflow:auto; height:356px; }
</style>
<cfif isDefined("qAttendees") AND qAttendees.RecordCount GT 0>
	<cfif AttendeePager.getTotalNumberOfPages() GT 1><div style="row-fluid"><cfoutput>#AttendeePager.getRenderedHTML()#</cfoutput></div></cfif>
    <div class="row-fluid">
    <table class="ViewSectionGrid profile-grid span24 table table-bordered table-condensed">
      <thead>
        <tr>
          <th class="span1"><input type="checkbox" name="CheckAll" id="CheckAll" class="js-select-all" /></th>
          <th class="span7">Name</th>
          <th class="span5">Status</th>
          <th class="span3">Is MD?</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody>
        <cfoutput query="qAttendees" startrow="#AttendeePager.getStartRow()#" maxrows="#AttendeePager.getMaxRows()#">
          <tr id="attendeeRow-#qAttendees.attendeeId#" class="<cfif personId GT 0>personRow</cfif> js-row js-select-all-rows AllRows AllAttendees<cfif qAttendees.personDeleted> personDeleted</cfif>" data-key="#attendeeid#" data-personkey="#personid#" data-name="#LastName#, #FirstName#" class="js-row js-select-all-rows AllRows" rel="##PersonOptions#PersonID#">
            <td valign="top">
						<input type="checkbox" name="Checked" class="MemberCheckbox js-select-one" id="Checked#PersonID#" value="#PersonID#" />
						<input type="hidden" class="attendeeId" value="#attendeeId#" />
						<input type="hidden" class="personId" value="#qAttendees.personId#" />
					</td>
           <td valign="top" nowrap="nowrap">
						<cfif personId GT 0>
							<a href="#myself#person.detail?personID=#PersonID#" id="PERSON|#PersonID#|#LastName#, #FirstName#">#UCase(qAttendees.FullName)#</a>
						<cfelse>
							#UCase(qAttendees.FullName)#
						</cfif>
						
						<!---<cfif NOT qAttendees.personDeleted><a href="#myself#Person.Detail?PersonID=#PersonID#" class="PersonLink" id="PERSON|#PersonID#|#LastName#, #FirstName#">#LastName#, #FirstName# <cfif MiddleName NEQ "">#Left(MiddleName, 1)#.</cfif></a><cfelse>#LastName#, #FirstName# <cfif MiddleName NEQ "">#Left(MiddleName, 1)#.</cfif> **deleted</cfif>---></td>
                    <td class="StatusDate" id="StatusDate-#qAttendees.AttendeeId#">
                    	<!--- <span id="datefill-#qAttendees.AttendeeId#">
						            <cfswitch expression="#qAttendees.StatusID#">
                        	<cfcase value="1">
                            	#DateFormat(qAttendees.CompleteDate, "MM/DD/YYYY")#
                            </cfcase>
                            <cfcase value="2">
                            	#DateFormat(qAttendees.RegisterDate, "MM/DD/YYYY")#
                            </cfcase>
                            <cfcase value="3">
                            	#DateFormat(qAttendees.RegisterDate, "MM/DD/YYYY")#
                            </cfcase>
                            <cfcase value="4">
                            	#DateFormat(qAttendees.TermDate, "MM/DD/YYYY")#
                            </cfcase>
                        </cfswitch>
                        </span> --->
						<!--- <cfif personID GT 0>
                        <div id="editdatecontainer-#qAttendees.attendeeId#" style="display:none;position:relative;"><input type="text" class="EditDateField" id="EditDateField-#qAttendees.attendeeId#" /><img src="#Application.Settings.RootPath#/_images/icons/tick.png" class="SaveDateEdit" id="SaveDate-#qAttendees.attendeeId#" style="position: absolute; left: -20px; top: 0pt;" /></div>
                        <div id="editdatelink-#qAttendees.attendeeId#" style="position:relative;"><input type="hidden" id="CurrStatusDate-#qAttendees.attendeeId#" value="" /><img src="#Application.Settings.RootPath#/_images/icons/pencil.png" class="EditStatusDate" id="editstatusdate-#qAttendees.attendeeId#" style="position: absolute; top: -16px; left: -20px;" /></div>
						</cfif> --->
            <cfsavecontent variable="tooltip_content">
              <strong>Completed:</strong> #DateFormat(qAttendees.CompleteDate, "MM/DD/YYYY")#<br />
              <strong>Registered:</strong> #DateFormat(qAttendees.RegisterDate, "MM/DD/YYYY")#<br />
              <strong>In Progress:</strong> #DateFormat(qAttendees.RegisterDate, "MM/DD/YYYY")#<br />
              <strong>Terminated:</strong> #DateFormat(qAttendees.TermDate, "MM/DD/YYYY")#
            </cfsavecontent>
            <cfset labels = {
                "registered":"info",
                "complete":"success",
                "terminated":"danger",
                "in progress":"warning"
              } />
                      <span class="label label-#labels[qAttendees.statusname]#" data-title="#qAttendees.statusname#" data-content="#tooltip_content#">#qAttendees.StatusName#</span>
                    </td>
                    <td valign="top"><span class="MDNonMD" id="MDNonMD#qAttendees.attendeeId#"><cfif qAttendees.MDFlag EQ "Y">Yes<cfelse>No</cfif></span></td>
                    <td valign="top" class="user-actions-outer">
						<cfif personID GT 0>
						<ul class="user-actions">
							<li class="action-menu menu">
								<button value="Actions" class="btn" id="btnActions-#PersonID#"><i/></button>
								
							</li>
						</ul>
						<cfelse>
							<a href="javascript:;" class="deleteLink">Delete</a>
						</cfif>
					</td>
                </tr>
            </cfoutput>
        </tbody>
    </table>
  </div>
	<cfif AttendeePager.getTotalNumberOfPages() GT 1><div style="row-fluid"><cfoutput>#AttendeePager.getRenderedHTML()#</cfoutput></div></cfif>
    
<cfelse>
	<cfif attributes.status GT 0>
      <div class="alert">
        <!--- <button type="button" class="close" data-dismiss="alert">&times;</button> --->
        There are not any participants with that status.
      </div>
    <cfelse>
      <div class="alert alert-info">
        You have not added any registrants.<br />
        Please click '<a class="btn"><i class="icon-plus"></i></a> on the right to begin.
      </div>
        
    </cfif>
</cfif>
<div id="PersonDetailContainer" class="simple_overlay">
	<div id="PersonDetailContent"></div>
</div>