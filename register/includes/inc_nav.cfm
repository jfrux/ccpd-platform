<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/welcome.cfm">Welcome Center</a></td>
	</tr>
	<cfif isDefined("session.personid") AND session.personid NEQ "">
	<!---<cfif isDefined("session.authority") AND session.authority GT 1>
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/admin/">Administration</a></td>
	</tr>
	</cfif>--->
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/cdc_pif.cfm" style="color:green;">Activity Registeration</a></td>
	</tr>
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/cdc_reg.cfm" style="color:navy;">My Registrations<br /> &amp;	Documents</a></td>
	</tr>
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/Credentials.cfm" id="credentials-link">Update Credentials</a></td>
	</tr>
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/Includes/act_doLogout.cfm">Logout</a></td>
	</tr>
	<cfelse>
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/Register.cfm">Create Account</a></td>
	</tr>
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/login.cfm">Account Login</a></td>
	</tr>
	</cfif>
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/cdc_contact.cfm?type=3">Contact Us</a></td>
	</tr>
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/cdc_contact.cfm?type=2">Feedback</a></td>
	</tr>
	<tr>
		<td class="left_nav_item"><a href="#Request.RootPath#/cdc_contact.cfm?type=1">Tech Support</a></td>
	</tr>
    <cfif Session.Account.getAuthorityID() EQ 3>
    <tr>
    	<td class="left_nav_item"><strong style="color:##000;">Admin Options</strong></td>
    </tr>
	<tr>
		<td class="left_nav_item"><a href="#CGI.Script_Name#?#CGI.Query_String#<cfif NOT isDefined("URL.Reinit") OR isDefined("URL.Reinit") AND URL.Reinit NEQ 1>&reinit=1</cfif>">Reinitialize Application</a></td>
	</tr>
    </cfif>
</table>
</cfoutput>
<div id="CredentialsDialog"></div>