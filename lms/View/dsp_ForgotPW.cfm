<cfoutput>
<link rel="stylesheet" href="#Application.Settings.RootPath#/_styles/Forms.css" type="text/css" />

<div class="ContentBlock">
	<h1>Forgot Password Request</h1>
    <form name="frmCredentials" method="post" action="#Application.Settings.RootPath#/_com/AJAX_Person.cfc">
    <input type="hidden" name="Method" value="requestPassword" />
    <table>
        <tr>
            <td colspan="2"><em>Have you forgotten your password?  To retreive your login credentials, fill in the form below and we will send them to you.</em></td>
        </tr>
        <cfif isDefined("Attributes.Error")>
            <tr>
                <td colspan="2" class="error_list">#URL.Error#</td>
            </tr>
        </cfif>
        <cfif isDefined("Attributes.Message")>
            <tr>
                <td colspan="2" class="message_list">#URL.Message#</td>
            </tr>
        </cfif>
        <tr>
            <td class="FieldLabel">Email:</td>
            <td class="FieldInput"><input type="text" name="Email" id="Email" /></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="Get Credentials" /></td>
        </tr>
    </table>
    </form>
</div>
</cfoutput>