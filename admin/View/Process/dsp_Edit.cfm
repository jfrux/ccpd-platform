<cfparam name="Attributes.Title" default="">
<cfparam name="Attributes.HiddenFlag" default="N">
<cfoutput>
<form name="frmEdit" class="MainForm" method="post" action="#Myself#Process.Edit&ProcessID=#Attributes.ProcessID#">
<div class="FormArea">
	<div class="FormSection" id="Sect1">
		<h3>Process Info</h3>
		<table width="100%" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td class="FieldLabel">Process Title</td>
				<td class="FieldInput"><input type="text" name="Title" value="#Attributes.Title#" style="width:250px;" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" valign="top">Hidden Process</td>
				<td class="FieldInput"><input type="radio" name="HiddenFlag" value="Y"<cfif Attributes.HiddenFlag EQ "Y"> Checked</cfif> /> Yes <input type="radio" name="HiddenFlag" value="N"<cfif Attributes.HiddenFlag EQ "N"> Checked</cfif> /> No
				<div style="font-size:10px;">By selecting 'Yes', this process will only be visible to Process Managers.</td>				
			</tr>
		</table>
	</div>
</div>
<input type="hidden" name="Submitted" value="1" />
</form>
</cfoutput>