<cfparam name="Attributes.Title" default="">
<cfparam name="Attributes.Description" default="">
<cfparam name="Attributes.MarkPrimary" default="N">
<cfoutput>
<div class="ContentTitle">Upload Photo</div>
<div class="ContentBody">
<form action="#myself#Photo.Upload&Mode=Person&PersonID=#Attributes.PersonID#" name="frmUpload" method="post" enctype="multipart/form-data">
	<table width="500" cellspacing="1" cellpadding="2" border="0">
		<tr>
			<td>Title:</td>
			<td><input name="Title" value="#Attributes.Title#" type="text" /></td>
		</tr>
		<tr>
			<td>Description:</td>
			<td><input name="Description" value="#Attributes.Description#" type="text" /></td>
		</tr>
		<tr>
			<td>File:</td>
			<td><input name="PhotoFile" type="file" /><input type="hidden" name="Submitted" value="1" /></td>
		</tr>
		<tr>
			<td>File Group:</td>
			<td><label for="MarkPrimaryNo"></label></td>
		</tr>
		<tr>
			<td colspan="2">#jButton("Upload Now","javascript:void(0);","accept.gif","SubmitForm(document.frmUpload);")#</td>
		</tr>
	</table>
</form>
</div>
</cfoutput>