<cfparam name="Attributes.Subject" type="String" default="">
<cfparam name="Attributes.Body" type="String" default="">
<script>
$(document).ready(function() {
	$("#attachImage").click(function() {
		popupUploader();
	});
});
var uploadWindow = '';
function popupUploader() {
var w = 560;
var h = 420;
var left = (screen.width/2)-(w/2);
var top = (screen.height/2)-(h/2);
uploadWindow = window.open('<cfoutput>#myself#</cfoutput>image.pasteUpload', 'uploader', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
}

function attachImage(params) {
	var data = $.parseJSON(params);
	uploadWindow.close();
	$('.attachments').append('<li><img src="/_uploads/images/' + data.IMAGEID + '_i.' + data.FILEEXT + '" style="border:1px solid #555;" /> <span>' + data.FILENAME + '</span> <span>[X]</span></li>');
	
}
</script>
<div class="ContentTitle"><cfoutput>#Request.Page.Title#</cfoutput></div> 
<div class="ContentBody">Having an issue with this application?  Submit a request for support on your particular issue and get your answer.  Your support requests help improve the application for everyone.</div>
<div class="ContentBody">

	<form action="<cfoutput>#xfa.frmSubmit#</cfoutput>&formsubmit=1" method="post" name="frmRequestSupport" class="">
		<cfif IsDefined("Errors")>
			<div class="Errors">
				<cfset arrErrors = ListToArray(Errors,",")>
				<ul>
				<cfloop index="i" from="1" to="#arrayLen(arrErrors)#">
					<li><cfoutput>#arrErrors[i]#</cfoutput></li>
				</cfloop>
				</ul>
			</div>
		</cfif>
		<table>
			<tr>
				<td><label for="Subject">Topic of Issue:</label></td>
				<td><input id="Subject" name="Subject" type="text" class="inputText" value="<cfoutput>#Attributes.Subject#</cfoutput>" /></td>
			</tr>
			<tr>
				<td valign="top"><label for="Body">Description of Issue:</label></td>
				<td><textarea id="Body" name="Body"><cfoutput>#Attributes.Body#</cfoutput></textarea></td>
			</tr>
			<tr>
				<td valign="top"><label for="image_id">Attachment:</label></td>
				<td>
				<ul class="attachments">
					
				</ul>
				<input type="button" id="attachImage" value="Attach Screenshot" name="attachImage" class="btn" />
				<input type="hidden" name="image_id" id="image_id" value="" /></td>
			</tr>
		</table>
		<div class="clear"> 
		     <cfoutput>
		    	#jButton("Request Support","javascript:void(0);","comment_add.gif","SubmitForm(document.frmRequestSupport);")# 
			</cfoutput>
		</div>
	</form>
</div>
