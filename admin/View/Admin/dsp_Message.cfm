<cfparam name="Attributes.Subject" default="">
<cfparam name="Attributes.Body" default="">
<cfoutput>
<div class="ViewSection">
	<h3>Message Details</h3>
	
	
	<form action="#myself#Admin.Message" method="post" name="frmSendMessage">
		<table width="100%" cellspacing="1" cellpadding="3" border="0">
			<tbody>
				<tr>
					<td>Subject</td>
					<td><input style="width:650px;font-size:18px;" type="text" name="Subject" id="Subject" value="#Attributes.Subject#" /></td>
				</tr>
				<tr>
					<td>Body</td>
					<td>
						<cfscript>
							fckEditor = createObject("component","#Application.Settings.Com#fckeditor");
							fckEditor.instanceName	= "Body";
							fckEditor.value			= '#Attributes.Body#';
							fckEditor.basePath		= "/_scripts/fckeditor/";
							fckEditor.height		= "300";
							fckEditor.Create() ; // create the editor.
						</cfscript>
					</td>
				</tr>
			</tbody>
		</table>
		<input type="checkbox" name="TestEmail" value="1" />
		<input type="hidden" name="submitted" value="1" />
	</form>
	
</div>
<div class="ViewSection">
	<h3>Recipients</h3>
	<cfloop query="qGetAdmins">
		#qGetAdmins.LastName#, #qGetAdmins.FirstName# [#qGetAdmins.Email#]<br />
	</cfloop>
</div></cfoutput>