<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Welcome Center</title>
<link href="styles/inc_styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
<cfinclude template="includes/inc_header.cfm">
<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<td class="content_cell" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="content_title">Welcome Center</td>
				</tr>
				<tr>
					<td class="content_body">
						Thank you for accessing our Online Registration system.<br />
						<br />
						Due to this being an online registration process, we require that you create an identifiable account with us to help us manage the courses you have completed and ensure your privacy and security.<br />
						<br />
						This is a FREE, one time registration and once created will be very beneficial to you in streamlining the registration process for further courses and help retrieve certificates quicker!<br />
						<br />
						
						<cfif isDefined("session.personid") AND session.personid NEQ "">
						<cfoutput>
							<div id="info_box_blue">
								<strong>You are logged in as #Session.Person.getFirstName()# #Session.Person.getLastName()#!</strong>
								<div style="height:5px;"></div>
								<input type="button" name="registrations" value="Register for an Activity" style="width:220px;" onClick="window.location='cdc_pif.cfm';">
								<div style="height:5px;"></div>
								<input type="button" name="registrations" value="View My Registrations" style="width:220px;" onClick="window.location='cdc_reg.cfm';">
								<div style="height:5px;"></div>
							</div>
							<br>
						</cfoutput>
						<cfelse>
							<div id="info_box_blue">
							<strong>If you are new to this website, click the button below to continue. </strong>
							<div style="height:5px;"></div>							
							<input type="button" name="fldRegister" value="NEW USER? Click Here" style="width:220px;" onClick="window.location='Register.cfm';" />
							</div>
							<br />
							<div id="info_box_green">
							<strong>If you already have an account with us, click the button below. </strong>
							<div style="height:5px;"></div>
							<input type="button" name="fldLogin" value="Already a Member? Login Now!" style="width:220px;" onClick="window.location='login.cfm';" />
							</div>
							<br />
						</cfif>
						<div id="info_box_red">
						<strong>Need Assistance? Having trouble finding what you are looking for?</strong>
						<div style="height:5px;"></div>
						<input type="button" name="fldContact" value="Contact Technical Support" style="width:220px;" onClick="window.location='cdc_contact.cfm?type=1';" />
						</div>					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
