<cfparam name="Attributes.Message" default="" />
<script>
$(document).ready(function() {
	$("#frmSupport").submit(function () {
		var sMessage = "";
		var TotalError = 0;
		
		<!---if($("#FirstName").val() == '') {
			sMessage = sMessage + ",You must enter your first name.";
			$("#FirstName").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#FirstName").removeClass("FieldInputErr");
		}
		
		if($("#LastName").val() == '') {
			sMessage = sMessage + ",You must enter your last name.";
			$("#LastName").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#LastName").removeClass("FieldInputErr");
		}--->
		
		if($("#Email1").val() == '') {
			sMessage = sMessage + ",You must enter an email address.";
			$("#Email1,#Email2").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#Email1,#Email2").removeClass("FieldInputErr");
		}
		
		if($("#Email1").val() != $("#Email2").val()) {
			sMessage = sMessage + ",Your email address and retyped email do not match.";
			$("#Email1,#Email2").addClass("FieldInputErr");
			TotalError++;
		} else if($("#Email1").val() != '') {
			$("#Email1,#Email2").removeClass("FieldInputErr");
		}
		
		if($("#EmailBody").val() == '') {
			sMessage = sMessage + ",You must enter an email message.";
			$("#EmailBody").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#EmailBody").removeClass("FieldInputErr");
		}
		
		if(sMessage != '') {
			for(var i=1; i<TotalError+1; i++) {
				addError($.ListGetAt(sMessage,i+1,","),250,6000,4000);
			}
			return false;	
		}
	});					   
});
</script>
<script>
$(document).ready(function() {
	<cfif attributes.message NEQ "" and attributes.display EQ "popup">
		window.opener.addMessage('Support message sent successfully!');
		window.close();
	</cfif>
	<cfif len(attributes.FirstName) GT 0 AND len(attributes.lastName) GT 0 AND len(attributes.email1) GT 0 AND len(attributes.email2) GT 0>
	$('#EmailSubject').focus();
	</cfif>
	$(".uploadBtn").click(function() {
		var mode = $(this).attr('id').replace('img-','');
		popupUploader(mode);
	});
});
var uploadWindow = '';

function popupUploader(type) {
var w = 560;
var h = 420;
var left = (screen.width/2)-(w/2);
var top = (screen.height/2)-(h/2);
uploadWindow = window.open('/admin/index.cfm/event/image.' + type, 'uploader', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
}

function attachImage(params) {
	var data = $.parseJSON(params);
	uploadWindow.close();
	$('#image_file').val(data.IMAGEID + '_o.' + data.FILEEXT);
	$('.attachments').html('<li><img src="/_uploads/images/' + data.IMAGEID + '_i.' + data.FILEEXT + '" style="border:1px solid #555;" /> <span>' + data.FILENAME + '</span> <span>[X]</span></li>');
	
}
</script>
<style>
.message_list {
	font-weight: bold;
	color: Green;
}
</style>
<cfif attributes.display EQ "popup">
<style>
	.FieldLabel { font-size:12px; }
	.FieldInput input { font-size:12px; }
	#EmailBody { width:300px; height:100px; }
	div#ContentLeft { width:auto; }
</style>
</cfif>
<cfoutput>
<div class="ContentBlock">
	<h1>Support Center</h1>
	<cfif isDefined("Attributes.Message") AND Attributes.Message NEQ "">
    <p class="message_list">#Attributes.Message#</p><p>&nbsp;</p>
    </cfif>
	<cfif attributes.display EQ "default">
	<div id="ContentLeft">
	</cfif>
		<h2>Open up a new ticket</h2>
		<p>Feel free to email us your questions, comments, or feedback.</p>
    <form name="frmSupport" id="frmSupport" method="post" action="#Myself#Main.Support?Submitted=1&display=#attributes.display#&supporttype=#attributes.supporttype#">
    <table cellspacing="1" cellpadding="1" border="0">
	<tr>
		<td class="FieldLabel">First Name</td>
		<td class="FieldInput"><input type="text" name="FirstName" id="FirstName" value="#Attributes.FirstName#" /></td>
	</tr>
	<tr>
		<td class="FieldLabel">Last Name</td>
		<td class="FieldInput"><input type="text" name="LastName" id="LastName" value="#Attributes.LastName#" /></td>
	</tr>
	<tr>
		<td class="FieldLabel">Email</td>
		<td class="FieldInput"><input type="text" name="Email1" id="Email1" value="#Attributes.Email1#" /></td>
	</tr>
	<tr>
		<td class="FieldLabel">Confirm Email</td>
		<td class="FieldInput"><input type="text" name="Email2" id="Email2" value="#Attributes.Email2#" /></td>
	</tr>
        <tr>
            <td class="FieldLabel" colspan="2">Brief Subject</td>
        </tr>
		<tr>
            <td class="FieldInput" colspan="2"><input type="text" name="EmailSubject" id="EmailSubject" value="#Attributes.EmailSubject#" style="width:250px;" /></td>
        </tr>
		<tr>
            <td class="FieldLabel" colspan="2">Full Message</td>
        </tr>
        <tr>
            <td class="FieldInput" colspan="2"><textarea name="EmailBody" id="EmailBody">#Attributes.EmailBody#</textarea></td>
        </tr>
		<tr>
				<td class="FieldLabel" colspan="2"><label for="image_id">Attach a screenshot?</label></td>
		</tr>
		<tr>
			<td style="padding-bottom:5px;" colspan="2">
			<ul class="attachments">
				
			</ul>
			<a href="javascript:void(0);" id="img-pasteUpload" class="uploadBtn">Paste from clipboard</a> -or- <a href="javascript:void(0);" id="img-upload" class="uploadBtn">Image from computer</a>
			<input type="hidden" name="image_file" id="image_file" value="" /></td>
		</tr>
        <tr>
        	<td style="padding-top:5px;border-top:1px solid ##000;" colspan="2">
            	<!---<strong>IMPORTANT</strong>: Please copy and paste any error messages, web addresses in question, or any other relevant information regarding your issue into the email message so that we may better service your requests.  If you are contacting us to make changes to your account information, for security purposes we require that you include your DOB and last 4 of SSN.  Please be assured this site is secure.  If you prefer, you make request that we contact you by phone.  Please provide a number where you can be reached M-F 9am-5pm.<br />--->
                <input type="submit" name="btnFrmSubmit" id="btnFrmSubmit" value="Submit Ticket" class="btn" /><cfif attributes.display EQ "popup"> <a href="javascript:window.close();">Cancel</a></cfif>
            </td>
        </tr>
    </table>
    </form>
	<cfif attributes.display EQ "default">
	</div>
	</cfif>
	<cfif attributes.display NEQ "popup">
	<div id="ContentRight">
		 <p style="background-color: ##FFCCCC; padding: 3px; border: 1px solid ##BB9999;">
        <strong>NOTE:</strong> If you are emailing in regards to <strong>Blood Borne Pathogens Training</strong>, <a href="http://webcentral.uc.edu/cpd_online2/compliance/category.cfm?id=11">click here</a>.
		</p>
	</div>
	</cfif>
</div>
</cfoutput>