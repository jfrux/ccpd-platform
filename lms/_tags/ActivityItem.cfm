<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.Published" default="No date found." />
<cfparam name="Attributes.RemoveDate" default="No date found." />
<cfparam name="Attributes.LastUpdated" default="#Attributes.Published#" />
<cfparam name="Attributes.PaymentFlag" default="N" />
<cfparam name="Attributes.Title" default="" />
<cfparam name="Attributes.Overview" default="" />
<cfparam name="Attributes.AllowRating" default="N" />
<cfparam name="Attributes.Instance" />
<cfparam name="Attributes.IconName" default="Book" />
<cfparam name="Attributes.VoteCount" default="0" />
<cfparam name="Attributes.VoteValue" default="0" />
<cfparam name="Attributes.Size" default="" />
<cfparam name="Attributes.AllowHide" default="N" />
<cfparam name="Attributes.MyStatus" default="0" />
<cfparam name="Attributes.LinkName" default="" />
<cfparam name="Session.PersonID" default="" />
<script>
$(document).ready(function() {
	<cfoutput>
	$('##HideLink-#Attributes.Instance#-#Attributes.ActivityID#').click(function() {
		var nActivity = $.ListGetAt(this.id,3,'-');
		
		$.post("/lms/_com/VoteAjax.cfc",{
			method: 'InterestExcept',
			returnFormat: 'plain',
			ActivityID: nActivity
		},function(data) {
			sStatusMsg = $.Trim(data);
			
			if(sStatusMsg == 'success') {
				$("##ActivityItem-#Attributes.Instance#-#Attributes.ActivityID#").slideUp();
			}
		});
	});
	
	$("##ActivityItem-#Attributes.Instance#-#Attributes.ActivityID#").mouseover(function() {
		$("##HideDiv-#Attributes.Instance#-#Attributes.ActivityID#").show();
	});
	
	$("##ActivityItem-#Attributes.Instance#-#Attributes.ActivityID#").mouseout(function() {
		$("##HideDiv-#Attributes.Instance#-#Attributes.ActivityID#").hide();
	});
	</cfoutput>
});
</script>
<cfset PagePath = "">

<cfif Attributes.LinkName NEQ "">
	<cfset PagePath = "/activity/#Attributes.LinkName#" />
<cfelse>
	<cfset PagePath = "/activity/#Attributes.ActivityID#" />
</cfif>
<cfset MaxRating = 5>
<cfset Rating = 0>
<cfif Attributes.VoteCount GT 0>
	<cfset Rating = Round(Attributes.VoteValue/Attributes.VoteCount)>
</cfif>
<cfset myself = "/lms/index.cfm/event/">
<cfoutput>
<cfinclude template="#Application.Settings.ComPath#/_UDF/RemoveHTML.cfm" />
<!--- FIND OUT IF ATTENDEE RECORD EXISTS --->
<cfif Session.PersonID GT 0>
	<cfset AttendeeBean = CreateObject("component","#Application.Settings.Com#Attendee.Attendee").Init(ActivityID=Attributes.ActivityID,PersonID=Session.PersonID)>
    <cfset AttendeeExists = Application.Com.AttendeeDAO.Exists(AttendeeBean)>
    
    <cfif AttendeeExists>
    	<cfset AttendeeBean = Application.Com.AttendeeDAO.Read(AttendeeBean)>
        <cfset AttendeeStatus = AttendeeBean.getStatusID()>
    </cfif>
</cfif>

<div class="ActivityItem<cfif Attributes.Size NEQ ""> #Attributes.Size#</cfif>" id="ActivityItem-#Attributes.Instance#-#Attributes.ActivityID#">
	<div class="RecordDetail">
	<h4><a href="#PagePath#" id="CourseLink#Attributes.ActivityID#" title="#Attributes.Title#"> #Attributes.Title#</a></h4>
	<p><cfif Attributes.Overview NEQ "">
	#Left(RemoveHTML(Attributes.Overview),200) & "..."# 
	</cfif>
    <cfif Attributes.MyStatus NEQ 1>
	<a href="#PagePath#" style="text-decoration:none;color:##CC3300;">Learn More &raquo;</a>
    <cfelse>
    <a href="/admin/index.cfm/event/Public.Cert?ActivityID=#Attributes.ActivityID#&PersonID=#Session.PersonID#" target="_blank" style="text-decoration:none;color:##CC3300;">Certificate</a>
    </cfif></p>
	</div>
	<div class="RecordInfoLine">
		<div class="RecordInfoText">
	<cfif Attributes.MyStatus NEQ "">
		<cfswitch expression="#Attributes.MyStatus#">
			<cfcase value="0">
				
			</cfcase>
			<cfcase value="1">
				<img src="/lms/_images/status_icons/complete_tiny.png" align="left" style="margin-right:4px;" /><strong>Completed</strong>
			</cfcase>
			<cfcase value="2">
				<img src="/lms/_images/status_icons/inprogress_tiny.png" align="left" style="margin-right:4px;" /><strong>In Progress</strong>
			</cfcase>
			<cfcase value="3">
				<img src="/lms/_images/status_icons/complete_tiny.png" align="left" style="margin-right:4px;" /><strong>Registered</strong>
			</cfcase>
			<cfcase value="4">
				<img src="/lms/_images/status_icons/terminated_tiny.png" align="left" style="margin-right:4px;" /><strong>Terminated</strong>
			</cfcase>
			<cfcase value="5">
				<img src="/lms/_images/status_icons/pending_tiny.png" align="left" style="margin-right:4px;" /><strong>Pending</strong>
			</cfcase>
		</cfswitch>
	</cfif>
	<cfif isDate(Attributes.Published)>Published: #DateFormat(Attributes.Published,'mmm dd, yyyy')#</cfif><cfif isDate(Attributes.RemoveDate)> Expires: #DateFormat(Attributes.RemoveDate,'mmm dd, yyyy')#</cfif><cfif Attributes.LastUpdated NEQ "" AND isDate(Attributes.LastUpdated)> Updated: #DateFormat(Attributes.LastUpdated,'mmm dd, yyyy')# </cfif><cfif Attributes.PaymentFlag EQ "Y"><img src="/lms/_images/icons/money_dollar.png" /></cfif>
	</div>
	<cfif Attributes.AllowRating EQ "Y">
	<div class="ActivityRating">
		<div class="ActivityRatingLabel" style="float:left;">Rating</div>
		<cfloop from="1" to="#MaxRating#" index="i">
		<input name="Rating-#Attributes.Instance#-#Attributes.ActivityID#" type="radio" value="#i#" style="display:none;" class="StarRating"<cfif i EQ Rating> checked</cfif><cfif isDefined("AttendeeStatus") AND AttendeeStatus NEQ 1 OR NOT isDefined("AttendeeStatus")> disabled="disabled"</cfif> />
		</cfloop>
	</div>
	</cfif>
	</div>
	
	<cfif Attributes.AllowHide EQ "Y">
	<div class="ActivityHide" id="HideDiv-#Attributes.Instance#-#Attributes.ActivityID#">
		<a href="javascript:void(0);" id="HideLink-#Attributes.Instance#-#Attributes.ActivityID#" class="HideLink">Hide</a>
	</div>
	</cfif>
</div>
</cfoutput>