<cfparam name="PostTestExists" default="False" />
<cfparam name="EvalExists" default="False" />
<cfparam name="Session.PersonID" default="" />
<cfparam name="AttendeeDetail.Status" default="" />

<cfif Attributes.RestrictedFlag EQ "Y" AND AttendeeDetail.Status EQ "" AND Session.PersonID NEQ "" AND Session.PersonID NEQ 0>
	This activity is restricted to a particular group of users.
	<cfabort>
</cfif>

<!--- STEP LOGIC --->
<cfquery name="qGetPostTest" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID
	FROM ce_Activity_PubComponent
	WHERE ComponentID = 11 AND ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>
<cfquery name="qGetPretest" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID
	FROM ce_Activity_PubComponent
	WHERE ComponentID = 12 AND ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>
<cfquery name="qGetEval" datasource="#Application.Settings.DSN#">
	SELECT AssessmentID
	FROM ce_Activity_PubComponent
	WHERE ComponentID = 5 AND ActivityID=<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag = 'N'
</cfquery>

<cfparam name="PreTestExists" default="false" />
<cfif qGetPretest.RecordCount GT 0>
	<cfset PreTestExists = true>
</cfif>
<cfparam name="PostTestExists" default="false" />
<cfif qGetPostTest.RecordCount GT 0>
	<cfset PostTestExists = true>
</cfif>
<cfparam name="EvalExists" default="false" />
<cfif qGetEval.RecordCount GT 0>
	<cfset EvalExists = true>
</cfif>

<script>
<cfoutput>
nActivity = #Attributes.ActivityID#;
nPerson = <cfif Session.PersonID GT 0>#Session.PersonID#<cfelse>0</cfif>;
</cfoutput>

$(document).ready(function() {
	// START ACTIVITY DIALOG
	$("#divStartActivity").dialog({ 
		title: "Register for Activity",
		modal: true, 
		autoOpen: false,
		position:[180,50],
		height:450,
		width:630,
		modal: true,
		resizable: false,
		dragStop: function(ev,ui) {
			
		},
		open:function() {
		},
		close:function() {;
		},
		buttons: {
			Accept:function() {
				$('.ui-dialog-buttonpane').block({ message: 'Processing... please wait...' });
				$.post(sRootPath + "/_com/AJAX_Activity.cfc", { 
				method: "startActivity", 
				ActivityID: nActivity, 
				PersonID: nPerson, 
				Mode: $("#ActivityStartContainer").val(), 
				DegreeID: $("#DegreeID").val(), 
				BillPhone: $("#BillPhone").val(),
				BillAddr1: $("#BillAddr1").val(),
				BillAddr2: $("#BillAddr2").val(),
				BillCity: $("#BillCity").val(),
				BillState: $("#BillState").val(),
				BillZipCode: $("#BillZip").val(),
				CardName: $("#CardName").val(),
				CardNumber: $("#CardNumber").val(),
				CardType: $("#CardType").val(),
				CardExpireMonth: $("#CardExpireMonth").val(),
				CardExpireYear: $("#CardExpireYear").val(),
				returnFormat: "plain" },
					function(data){
						var cleanData = $.trim($.ListGetAt(data,1,"<"));
						var status = $.ListGetAt(cleanData, 1, "|");
						var statusMsg = $.ListGetAt(cleanData, 2, "|");
						var reasonMsg = $.ListGetAt(cleanData,3,"|");
						//console.log(status + ' // ' + statusMsg + ' // ' + reasonMsg);
						if(status == 'Success') {
							$("#divStartActivity").dialog("close");
							updateAssess();
							updateComments();
							updateLinks();
							updateStatus();
							updateMaterials();
							addMessage(statusMsg,250,6000,4000);
							$('.ui-dialog-buttonpane').unblock();
						} else {
							if(statusMsg == 'Payment') {
								$("#CCError").html(statusMsg + ' | ' + reasonMsg).show();
								$('.ui-dialog-buttonpane').unblock();
								return false;
							} else {
								$("#ActivityStartContainer").val(statusMsg);							
								// OPEN START ACTIVITY DIALOG
								$.post("/index.cfm/event/Activity.Start", { ActivityID: nActivity, Mode: statusMsg },
									function(data) {
										$("#divStartActivity").html(data);
										$.unblockUI();
								});
								$('.ui-dialog-buttonpane').unblock();
							}
						}
				});
			},
			Cancel:function() {
				$("#divStartActivity").dialog("close");
				
				updateStatus();
				updateAssess();
			}
		}
	});
	
	<cfif isDefined("Session.PersonID") AND Session.PersonID GT 0>
		// COMPLETE ACTIVITY BUTTON FUNCTION
		$("#btnCompleteActivity").bind("click", this, function() {
			$.post("/lms/_com/AJAX_Activity.cfc", { method: "markComplete", ActivityID: nActivity, PersonID: nPerson, returnFormat: "plain" },
				function(data) {
					var cleanData = $.trim(data);
					var Status = $.ListGetAt(cleanData,1,"|");
					var statusMsg = $.ListGetAt(cleanData,2,"|");
					
					if(Status == "true") {
						updateAssess();
						updateComments();
						updateLinks();
						updateStatus();
						updateMaterials();
						addMessage(statusMsg,250,6000,4000);
					} else {
						var errorList = cleanData.split("|");
						
						$(errorList).each(function(i) {
							addError($.ListGetAt(errorList,i+1,","),250,6000,4000);
						});
					}
			});
		});
		
		$("#btnStartActivity").bind("click", this, function() {
			$.post("/lms/_com/AJAX_Activity.cfc", { method: "startActivity", ActivityID: nActivity, PersonID: nPerson, returnFormat: "plain" },
				function(data){
					var cleanData = $.trim(data);
					var status = $.ListGetAt(cleanData, 1, "|");
					var statusMsg = $.ListGetAt(cleanData, 2, "|");
					
					if(status == 'Success') {
						updateAssess();
						updateComments();
						updateLinks();
						updateStatus();
						updateMaterials();
						addMessage(statusMsg,250,6000,4000);
					} else {						
						// OPEN START ACTIVITY DIALOG
						$.post(sMyself + "Activity.Start", { ActivityID: nActivity, Mode: statusMsg },
							function(data) {
								$("#divStartActivity").html(data);
								$("#divStartActivity").dialog("open");
								$("#ActivityStartContainer").val(statusMsg);
						});
					}
			});
		});
		
		$("#btnCancelActivity").bind("click", this, function() {
			$.blockUI({message: $('#CancelActivity'), css: { 'line-height': '35px', 'padding': '15px 0px 0px 0px' } });
		});
		
		$("#btnIgnoreCancel").bind("click", this, function() {
			$.unblockUI();
		});
		
		$("#btnConfirmCancel").bind("click", this, function() {
			$.post(sRootPath + "/_com/AJAX_Activity.cfc", { method: "cancelActivity", ActivityID: nActivity, PersonID: nPerson, returnFormat: "plain" },
				function(data){
					var cleanData = $.trim($.ListGetAt(data,1,"<"));
					var status = $.ListGetAt(cleanData, 1, "|");
					var statusMsg = $.ListGetAt(cleanData, 2, "|");
					
					if(status == 'Success') {
						addError(statusMsg,250,6000,4000);
						$.unblockUI();
						
						updateAssess();
						updateComments();
						updateLinks();
						updateStatus();
						updateMaterials();
					} else {
						$.unblockUI();
						updateStatus();
						addError(statusMsg,250,6000,4000);
					}
			});
		});
	</cfif>
});
</script>

<cfoutput>
<input type="hidden" name="ActivityStartContainer" id="ActivityStartContainer" value="blank" />
<input type="hidden" name="DegreeID" id="DegreeID" value="blank" />
<!--- DETERMINE IF THE ACTIVITY IS A BROCHURE ONLY OR A FULL ACTIVITIY --->
<cfif attributes.extHostFlag EQ "Y">
	<h4>External Activity</h4>
    <p>This activity is hosted on another website and can be accessed by clicking the button below.</p>
	<p><input type="button" value="View Activity" onClick="javascript:window.location='<cfif left(attributes.extHostLink, 4) NEQ "http">http://</cfif>#attributes.extHostLink#';" /></p>
<cfelse>
	<!--- USER HAS ATTENDEE RECORD FOR THE ACTIVITY --->
    <cfif AttendeeDetail.Status NEQ "">
        <!---<img src="#application.settings.rootpath#/_images/icons/AssessStatus#AttendeeDetail.StatusCode#.png" />---><h4>#AttendeeDetail.Status#</h4>
        
        <cfif AttendeeDetail.Status NEQ "Terminated">
            <cfif AttendeeDetail.Status EQ "Pending">
                <p>To begin, click below...</p>
                <ul>
                    <cfif AttendeeDetail.TermsFlag EQ "N">
                    <li>Accept and agree to activity terms.</li>
                    </cfif>
                    <cfif AttendeeDetail.PaymentFlag EQ "N">
                    <li>Accept and agree to activity payment.</li>
                    </cfif>
                </ul>
                <div><input type="button" name="btnCancelActivity" id="btnCancelActivity" value="Cancel" /><input type="button" name="btnStartActivity" id="btnStartActivity" value="Continue Registration" /></div>
            <cfelseif PretestStatus NEQ 1>
                <em>To begin, please start the pre-test.</em>
            <cfelseif AttendeeDetail.Status EQ "In Progress">
                <p>Review any materials &amp; complete the post-test/evaluation.</p>
                
                <cfif Application.Assessment.areAssessComplete(ActivityID=Attributes.ActivityID,PersonID=Session.PersonID)>
                    <p><input type="button" name="btnCompleteActivity" id="btnCompleteActivity" value="Mark Complete" /></p>
                </cfif>
            <cfelseif AttendeeDetail.Status EQ "Complete">
                <cfset AttendeeCreditBean = CreateObject("component","#Application.Settings.Com#AttendeeCredit.AttendeeCredit").Init(AttendeeID=Attributes.AttendeeID)>
                <cfset AttendeeCreditExists = Application.Com.AttendeeCreditDAO.Exists(AttendeeCreditBean)>
                    
                    <p><input type="button" id="Certificate|#Attributes.ActivityID#|#Session.Person.getPersonID()#" class="CertificateButton" value="View certificate" /></p>
            </cfif>
        <cfelse>
                <p>Activity failed. <a href="javascript:history.back(-1);">Click here to return to the previous page.</a></p>
        </cfif>
    <!--- USER HAS NO ATTENDEE RECORD BUT, IS LOGGED IN --->
    <cfelseif Session.PersonID GT 0>
        
        <h4>Getting Started</h4>
        <p>To begin, click below...</p>
        <div><input type="button" name="btnStartActivity" id="btnStartActivity" value="Start Activity" /></div>
    <!--- USER IS NOT LOGGED IN --->
    <cfelse>
        To take this activity, <a href="#Myself#Main.Login">please click here to login</a> OR <a href="#myself#main.register">click here to register</a>.
    </cfif>
    <div id="CancelActivity" style="display:none;">
        <img src="#application.settings.rootpath#/_images/cancel_activity.png" title="Cancel Activity" /><br />
        <span style="font-family:arial; font-size: 22px; font-weight: bold;">
            Are you sure you want to cancel the activity:
        </span><br />
        #Attributes.Title#<br />
        <input type="button" id="btnIgnoreCancel" name="btnIgnoreCancel" value="Return to activity" />
        <input type="button" id="btnConfirmCancel" name="btnConfirmCancel" value="Cancel Registration" />
    </div>
    <div id="divStartActivity">
    </div>
</cfif>
</cfoutput>