<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Forgot Password</title>
<link href="styles/inc_styles.css" rel="stylesheet" type="text/css" />
<link href="styles/Forms.css" rel="stylesheet" type="text/css" />
</head>
<style>
.FieldInput table tr td { font-size:10px!important;border-bottom:1px solid #EEE; }
.FieldInput select,.FieldInput input { font-size:14px!important; }
.FieldLabel { width:175px!important; font-size:14px!important; font-weight:bold; font-family:Verdana; background-color:#EEE; }
</style>

<body>
<cfinclude template="includes/inc_header.cfm">
<cfoutput>
<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<td class="content_cell" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="content_title">Forgot Password</td>
				</tr>
				<tr>
					<td class="content_body">
                    	<form name="frmCredentials" method="post" action="#Request.RootPath#/_com/AJAX_Person.cfc">
                        <input type="hidden" name="Method" value="requestPassword" />
                        <table>
                        	<tr>
                            	<td colspan="2"><em>Have you forgotten your password?  To retreive your login credentials, fill in the form below and we will send them to you.</em></td>
                            </tr>
							<cfif isDefined("URL.Error")>
                                <tr>
                                    <td colspan="2" class="error_list">#URL.Error#</td>
                                </tr>
                            </cfif>
                            <cfif isDefined("URL.Message")>
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
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
</body>
</html>