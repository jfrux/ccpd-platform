<script>
$(document).ready(function() {
$(".importDialog").dialog({
	title:"Batch Attendee Import",
	modal: false, 
	autoOpen: false,
	height:200,
	width:500,
	buttons: { 
			Done:function() {
				updateRegistrants();
				$(".importDialog").find('iframe').attr('src',sMyself + 'activity.import?activityid=' + nActivity);
				$(".importDialog").dialog("close");
			}
		}
});

	$(".batchLink").click(function() {
		$(".importDialog").dialog("open");
	});
});
</script>
<cfoutput>
<div class="MultiFormRight_SectTitle">What can I do?</div>
<div class="MultiFormRight_LinkList">
</div>
<div class="MultiFormRight_LinkList">
	<cf_cePersonFinder Instance="Attendee" DefaultName="Add Registrant" DefaultID="" AddPersonFunc="saveAttendee();" ActivityID="#Attributes.ActivityID#">
	<div>
	<a href="javascript:;" class="batchLink">Batch Import</a>
	</div>
</div>
<div class="MultiFormRight_SectSubTitle">Other Details</div>
<div class="MultiFormRight_SectBody">

    	<table cellspacing="2" cellpadding="3" width="140">
        	<tr>
            	<td nowrap="nowrap" style=" color:##555;">Max Registrants</td>
				<td style="text-align:right;"><input type="text" name="MaxRegistrants" id="MaxRegistrants" value="#Attributes.MaxRegistrants#" style="width: 50px;" /></td>
			</tr>
			<tr>
                <td nowrap="nowrap" style=" color:##555;">Addl Attendees</td>
				<td style="text-align:right;"><input type="text" name="AddlAttendees" id="AddlAttendees" value="#Attributes.AddlAttendees#" style="width: 50px;" /></td>
            </tr>
        </table>

</div>
<div class="MultiFormRight_SectSubTitle">Change Statuses</div>
<div class="MultiFormRight_SectBody">
	<select name="StatusID" id="StatusID">
    	<option value="">Select one...</option>
        <cfloop query="qStatuses">
    	<option value="#qStatuses.AttendeeStatusID#">#qStatuses.Name#</option>
        </cfloop>
    </select>
    <input type="button" name="btnStatusSubmit" id="btnStatusSubmit" value="OK" />
</div>
<div class="MultiFormRight_SectSubTitle">Removal Options</div>
<div class="MultiFormRight_LinkList">
	<a href="javascript:void(0);" id="RemoveChecked" title="Remove selected registrants"><img src="#Application.Settings.RootPath#/_images/icons/application_form_delete.png" align="absmiddle" style="padding-right:4px;" />Remove Checked</a>
	<a href="javascript:void(0);" id="RemoveAll" title="Remove all registrants"><img src="#Application.Settings.RootPath#/_images/icons/cancel.png" align="absmiddle" style="padding-right:4px;" />Remove All</a>
</div>
<div class="MultiFormRight_SectSubTitle">Reports</div>
<div class="MultiFormRight_LinkList">
	<div style="padding:4px; font-size:13px;"><input type="checkbox" name="PrintSelected" id="PrintSelected" checked=checked /><label for="PrintSelected" title="Print items for the selected members only."> Only use checked</label>&nbsp;<span id="CheckedCount" style="font-weight: bold;"></span></div>
	
	<cfloop query="qActivityCredits">
    	<cfswitch expression="#qActivityCredits.CreditName#">
            <cfcase value="CME">
                <a href="javascript://" id="PrintCMECert" title="This link provides certificates for CME credit ONLY."><img src="#Application.Settings.RootPath#/_images/icons/award_star_bronze_2.png" border="0" align="absmiddle" /> CME Certificates</a>
            </cfcase>
            <cfcase value="CNE">
				    <a href="javascript://" id="PrintCNECert" title="This link provides certificates for CNE credit ONLY."><img src="#Application.Settings.RootPath#/_images/icons/award_star_bronze_2.png" border="0" align="absmiddle" /> CNE Certificates</a>
            </cfcase>
        </cfswitch>
    </cfloop>
	<!--- <a href="javascript://" id="PrintMailingLabels" title="This link provides mailing labels for all attendees for this activity."><img src="#Application.Settings.RootPath#/_images/icons/report_user.png" border="0" align="absmiddle" /> Mailing Labels</a>
	<a href="javascript://" id="PrintNameBadges" title="This link provides name badges for all attendees for this activity."><img src="#Application.Settings.RootPath#/_images/icons/report_user.png" border="0" align="absmiddle" /> Name Badges</a>
    <a href="javascript://" id="SigninSheet|Y" class="PrintSigninSheet" title="This link provides a sign-in sheet for all attendees for this activity including their SSN."><img src="#Application.Settings.RootPath#/_images/icons/report_user.png" border="0" align="absmiddle" /> Sign-in Sheet w/ SSN</a>
    <a href="javascript://" id="SigninSheet|N" class="PrintSigninSheet" title="This link provides a sign-in sheet for all attendees for this activity excluding their SSN."><img src="#Application.Settings.RootPath#/_images/icons/report_user.png" border="0" align="absmiddle" /> Sign-in Sheet w/o SSN</a> --->
</div>
<div class="importDialog">
	<iframe src="#myself#activity.import?activityid=#attributes.activityid#" frameborder="0" style="width: 400px; height: 100px;"></iframe>
</div>
</cfoutput>