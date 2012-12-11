<script>
<cfoutput>
var nActivity = #Attributes.ActivityID#;
<cfif isDefined("Session.Person") AND Session.Person.getPersonID() NEQ "">
var nPerson = #Session.Person.getPersonID()#;
</cfif>
</cfoutput>
	$(document).ready(function() {
		$("#CommentsToggle").toggle(function() {
			$("#CommentsList").slideUp();
		},function() {
			$("#CommentsList").slideDown();
		});
<cfif isDefined("Session.Person") AND Session.Person.getPersonID() NEQ "">
		$("#CommentSubmit").bind("click", this, function() {
			var sCommentBody = $("#CommentBody").val();
			
			if(sCommentBody == "") {
				alert("Please enter a comment first before submitting.");
				return false;
			}
			
			$("#CommentSubmit").hide();
			$("#CommentSubmitContainer").html("Please wait while your comment is saved.");
			
			$.post(sRootPath + "/_com/AJAX_Activity.cfc", 
				{ method: "saveComment", ActivityID: nActivity, PersonID: nPerson, CommentBody: sCommentBody, returnFormat: "plain" },
				function(returnData) {
					cleanData = $.trim(returnData);
					status = $.ListGetAt(cleanData,1,"|");
					statusMsg = $.ListGetAt(cleanData,2,"|");
					
					if(status == 'Success') {
						addMessage(statusMsg,250,6000,4000);
						updateComments();
					} else if(status == 'Fail') {
						addError(statusMsg,250,6000,4000);
					}
				});
		});
		
		$(".DeleteComment").bind("click", this, function() {
			nCommentID = $.ListGetAt(this.id,2,"|");
			$.post(sRootPath + "/_com/AJAX_Activity.cfc", 
				{ method: "deleteComment", CommentID: nCommentID, returnFormat: "plain" },
				function(returnData) {
					cleanData = $.trim(returnData);
					status = $.ListGetAt(cleanData,1,"|");
					statusMsg = $.ListGetAt(cleanData,2,"|");
					
					if(status == 'Success') {
						addMessage(statusMsg,250,6000,4000);
						updateComments();
					} else if(status == 'Fail') {
						addError(statusMsg,250,6000,4000);
					}
				});
		});
	
</cfif>
	});
</script>
<cfoutput>
<div style="border-bottom:1px solid ##CCC;">
	<div id="CommentsTopLine">#qComments.RecordCount# Comment(s)<cfif qComments.RecordCount GT 0> <a href="javascript:void(0);" id="CommentsToggle">Show/Hide &raquo;</a></cfif></div>
	<div id="CommentsList"<cfif qComments.RecordCount EQ 0> style="display:none;"</cfif>>
<cfloop query="qComments">
    <cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person.Person").Init(PersonID=qComments.CreatedBy)>
	<cfset PersonBean = Application.Com.PersonDAO.Read(PersonBean)>
    
    <div class="ComponentBox" style="border-bottom:1px solid ##CCC;">
        <div class="Comment">
            <cite>#PersonBean.getFirstName()#</cite><span>#QualitativeDate(qComments.Created)#</span>
            <p>#qComments.Comment#</p>
        </div>
        <div class="RecordInfoLine">
            #DateFormat(qComments.Created,"MMM DD, YYYY")# #TimeFormat(qComments.Created,"h:mmtt")# <a href="javascript://" class="DeleteComment" id="Delete|#qComments.CommentID#" style="<cfif Session.PersonID NEQ PersonBean.getPersonID()>display:none;</cfif>float:right;">Delete comment</a>
        </div>
    </div>
</cfloop>
		<!---<div style="background-image: url(/lms/_images/CommentBoxGradient.png); background-position: center bottom; position: relative; width:250px; height: 35px; background-repeat: repeat-x; top: -36px;"></div>--->
	</div>
</div>
<cfif Session.LoggedIn AND Session.PersonID GT 0>
<div class="CommentTextBox">
	<!--- GET ATTENDEE'S ACTIVITY STATUS --->
    <cfset AttendeeStatus = Application.ActivityAttendee.getActivityStatus(ActivityID=Attributes.ActivityID,PersonID=Session.PersoniD)>
    
    <cfif AttendeeStatus EQ "Complete" OR AttendeeStatus EQ "Terminated" OR AttendeeStatus EQ "In Progress">
		<cfset PubGeneralBean = CreateObject("component","#Application.Settings.Com#ActivityPubGeneral.ActivityPubGeneral").Init(ActivityID=Attributes.ActivityID)>
		<cfset PubGeneralBean = Application.Com.ActivityPubGeneralDAO.Read(PubGeneralBean)>
        <div class="CommentLoginLine">Posting as #Session.Person.getFirstName()#</div>
        <cfif PubGeneralBean.getCommentApproveFlag() EQ "Y"><strong>**Note: Comments will not show up before approval on this activity.</strong><br/></cfif>
        <textarea name="CommentBody" id="CommentBody" style="width:262px;height: 38px;font-size:1.1em;font-family:Arial, Helvetica, sans-serif;"></textarea><br />
        <div id="CommentSubmitContainer"><input type="button" name="btnCommentSubmit" id="CommentSubmit" value="Submit Comment" class="MainButton" style="float:right;" /></div>
    </cfif>
</div>
</cfif>
</cfoutput>