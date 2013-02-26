<cfparam name="Attributes.CommentType" default="">
<script>
	nCommentID = "";
	sCommentType = "";
	
	function updateComments(sCommentType) {
		$("#CommentsLoading").show();
		$.post(sMyself + "Admin.CommentsAHAH", { CommentType: sCommentType }, function(data) {
			$("#CommentsContainer").html(data);
			$("#CommentsLoading").hide();
		});
	}
	
	function updateComment(sAction, nCommentID) {
		$.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", 
				{ method: sAction, CommentID: nCommentID, returnFormat: "plain" },
				function(data) {
					if(data.STATUS) {
						addMessage(data.STATUSMSG,250,6000,4000);
						updateComments(sCommentType);
					} else {
						addError(data.STATUSMSG,250,6000,4000);
					}
				});
	}
	
	$(document).ready(function() {
		// DOCUMENT LOAD FUNCTIONS
		updateComments(<cfif Attributes.CommentType NEQ ""><cfoutput>'#Attributes.CommentType#'</cfoutput></cfif>);
		
		$(".CommentsLink").bind("click", this, function() {
			if(this.id == "P") {
				$("#CommentTypeName").html("Pending Comments");
			} else if(this.id == "A") {
				$("#CommentTypeName").html("Approved Comments");
			} else if(this.id == "D") {
				$("#CommentTypeName").html("Denied Comments");
			}
			updateComments(this.id);
		});
	});
</script>
<cfoutput>
<div class="ViewSection">
	<h3 id="CommentTypeName">Pending Comments</h3>
	<div id="CommentsContainer"></div>
	<div id="CommentsLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
	<div>Please Wait</div></div>
</div>
</cfoutput>