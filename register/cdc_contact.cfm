<cfparam name="URL.Type" default="" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Welcome Center</title>
<link href="styles/inc_styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
<cfinclude template="/_com/_UDF/isEmail.cfm">
<cfinclude template="includes/inc_header.cfm">
<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<td class="content_cell" valign="top">
			<cfset sOutput = "">
            <cfif Session.Person.getFirstName() NEQ "">
				<cfset sFirstName = Session.Person.getFirstName()>
            <cfelse>
				<cfset sFirstName = "">
            </cfif>
            <cfif Session.Person.getLastName() NEQ "">
				<cfset sLastName = Session.Person.getLastName()>
            <cfelse>
				<cfset sLastName = "">
            </cfif>
            <cfif Session.Person.getEmail() NEQ "">
				<cfset sEmail = Session.Person.getEmail()>
				<cfset sEmailConfirm = Session.Person.getEmail()>
            <cfelse>
				<cfset sEmail = "">
				<cfset sEmailConfirm = "">
            </cfif>
			<cfset sComments = "">
			<cfset sError = "">
			<cfset sEmailAdminBody = "">
			<cfset sEmailUserBody = "">
			<cfset sUserAgent = CGI.HTTP_USER_AGENT>
			<cfset sReferer = CGI.HTTP_REFERER>
			<cfset sIPAddress = CGI.REMOTE_ADDR>
			<cfset sHostAddress = CGI.REMOTE_HOST>
			
			<!---CONTACT TYPE REFERENCE --->
			<cfset sContactTypes = "Technical Support,Website Feedback,General Contact">
			
			<cfif len(url.type) GT 0>
				<cfset nContactType = url.type>
			<cfelse>
				<!--- set default --->
				<cfset nContactType = 3>
			</cfif>
			
			<cfswitch expression="#nContactType#">
				<cfcase value="1">
					<cfset sContactType = getToken(sContactTypes,1,",")>
                    <cfset sContactFormTitle = "Fill out the form below to receive Technical Support!">
                    <cfset sCommentsName = "Support Questions or Errors">
                    <cfset sCommentsNotes = "IMPORTANT: If you are contacting us to make changes of your account information, please include your DOB, and Last 4 of SSN in your comments for security purposes.  Please copy and paste any error messages, web addresses in question, or any other relevant information to your issue for us to better service your requests.">
                    <cfset sEmailAdminSubject = "Cincinnati STD/HIV Prevention Training Center Technical Support Submitted">
                    <cfset sEmailAdminHeaderImg = "email_header_ts.gif">
                    <cfset sEmailAdminContentTitle = "The following was submitted to Cincinnati STD/HIV Prevention Training Center Technical Support">
                    <cfset sEmailUserSubject = "Cincinnati STD/HIV Prevention Training Center Technical Support Automated Response">
                    <cfset sEmailUserHeaderImg = "email_header_ts.gif">
                    <cfset sEmailUserContentTitle = "Automated Response">
                    <cfset sEmailUserContents =  "Thank you for contacting Cincinnati STD/HIV Prevention Training Center Technical Support!<br />" &
                                                "We are reviewing your support questions/concerns and should respond within 24 hours.<br /><br />" &
                                                "-Cincinnati STD/HIV Prevention Training Center<br>Technical Support">
					<cfset nMessageId = 1>
				</cfcase>
				<cfcase value="2">
				   	<cfset sContactType = getToken(sContactTypes,2,",")>
					<cfset sContactFormTitle = "Fill out the form below to submit Website Feedback!">
                    <cfset sCommentsName = "Comments/Concerns">
                    <cfset sCommentsNotes = "IMPORTANT: If you are contacting us to make changes of your account information, please include your DOB, and Last 4 of SSN in your comments for security purposes.  Please copy and paste any error messages, web addresses in question, or any other relevant information to your issue for us to better service your requests.">
                    <cfset sEmailAdminSubject = "Cincinnati STD/HIV Prevention Training Center Feedback Submitted">
                    <cfset sEmailAdminHeaderImg = "email_header_fb.gif">
                    <cfset sEmailAdminContentTitle = "The following was submitted to Cincinnati STD/HIV Prevention Training Center Feedback">
                    <cfset sEmailUserSubject = "Cincinnati STD/HIV Prevention Training Center Feedback Automated Response">
                    <cfset sEmailUserHeaderImg = "email_header_ty.gif">
                    <cfset sEmailUserContentTitle = "Automated Response">
                    <cfset sEmailUserContents =  "Thank you for sending Cincinnati STD/HIV Prevention Training Center Feedback!<br />" &
                                                "We are reviewing your feedback and will respond within 24 hours if necessary.<br /><br />" &
                                                "-Cincinnati STD/HIV Prevention Training Center<br>Technical Support Staff">
					<cfset nMessageId = 2>
				</cfcase>
				<cfcase value="3">
					<cfset sContactType = getToken(sContactTypes,3,",")>
                    <cfset sContactFormTitle = "Fill out the form below to contact us!">
                    <cfset sCommentsName = "Comments/Concerns">
                    <cfset sCommentsNotes = "IMPORTANT: If you are contacting us to make changes of your account information, please include your DOB, and Last 4 of SSN in your comments for security purposes.  Please copy and paste any error messages, web addresses in question, or any other relevant information to your issue for us to better service your requests.">
                    <cfset sEmailAdminSubject = "Cincinnati STD/HIV Prevention Training Center General Contact Submitted">
                    <cfset sEmailAdminHeaderImg = "email_header_gc.gif">
                    <cfset sEmailAdminContentTitle = "The following was submitted to Cincinnati STD/HIV Prevention Training Center General Contact">
                    <cfset sEmailUserSubject = "Cincinnati STD/HIV Prevention Training Center Automated Response">
                    <cfset sEmailUserHeaderImg = "email_header_ty.gif">
                    <cfset sEmailUserContentTitle = "Automated Response">
                    <cfset sEmailUserContents = "Thank you for contacting Cincinnati STD/HIV Prevention Training Center !<br />" &
                                        "We are reviewing your comments/concerns and will issue a response within 24 hours if necessary.<br /><br />" &
                                        "-Cincinnati STD/HIV Prevention Training Center<br>Technical Support Staff">
					<cfset nMessageId = 3>
				</cfcase>
				<cfdefaultcase>
                    <cfset sContactType = getToken(sContactTypes,3,",")>
                    <cfset sContactFormTitle = "Fill out the form below to contact us!">
                    <cfset sCommentsName = "Comments/Concerns">
                    <cfset sCommentsNotes = "IMPORTANT: If you are contacting us to make changes of your account information, please include your DOB, and Last 4 of SSN in your comments for security purposes.  Please copy and paste any error messages, web addresses in question, or any other relevant information to your issue for us to better service your requests.">
                    <cfset sEmailAdminSubject = "Cincinnati STD/HIV Prevention Training Center General Contact Submitted">
                    <cfset sEmailAdminHeaderImg = "email_header_gc.gif">
                    <cfset sEmailAdminContentTitle = "The following was submitted to Cincinnati STD/HIV Prevention Training Center General Contact">
                    <cfset sEmailUserSubject = "Cincinnati STD/HIV Prevention Training Center Automated Response">
                    <cfset sEmailUserHeaderImg = "email_header_ty.gif">
                    <cfset sEmailUserContentTitle = "Automated Response">
                    <cfset sEmailUserContents = "Thank you for contacting Cincinnati STD/HIV Prevention Training Center !<br />" &
                                        "We are reviewing your comments/concerns and will issue a response within 24 hours if necessary.<br /><br />" &
                                        "-Cincinnati STD/HIV Prevention Training Center<br>Technical Support Staff">
					<cfset nMessageId = 3>
				</cfdefaultcase>
            </cfswitch>
			
			<!--- SUBMITTED FORM ACTIONS --->
			<cfif parameterExists(form.fldSubmitted) AND form.fldSubmitted IS NOT "">
				<cfif parameterexists(form.fldFirstName) AND Len(form.fldFirstName) GT 0>
					<cfset sFirstName = form.fldFirstName>
				<cfelse>
					<cfset sError = sError & "- First Name is a required field.<br>">
				</cfif>
				
				<cfif parameterexists(form.fldLastName) AND Len(form.fldLastName) GT 0>
					<cfset sLastName = form.fldLastName>
				<cfelse>
					<cfset sError = sError & "- Last Name is a required field.<br>">
				</cfif>
				
				<cfif parameterexists(form.fldEmail) AND Len(form.fldEmail) GT 0>
					<cfset sEmail = form.fldEmail>
				<cfelse>
					<cfset sError = sError & "- Email is a required field.<br>">
				</cfif>
				
				<cfif parameterexists(form.fldEmail) AND NOT isEmail(form.fldEmail)>
					<cfset sError = sError & "- The email address you entered is invalid.<br>">
				</cfif>
				
				<cfif parameterexists(form.fldEmailConfirm) AND Len(form.fldEmailConfirm) GT 0>
					<cfset sEmailConfirm = form.fldEmailConfirm>
				<cfelse>
					<cfset sError = sError & "- Email Confirm is a required field.<br>">
				</cfif>
				
				<cfif parameterexists(sEmail) AND parameterexists(sEmailConfirm) AND sEmail IS NOT sEmailConfirm>
					<cfset sError = sError & "- The email address does not match the confirmed email field.  Please check the spelling.<br>">
				</cfif>
				
				<cfif parameterexists(form.fldComments) AND Len(form.fldComments) GT 0>
					<cfset sComments = form.fldComments>
				<cfelse>
					<cfset sError = sError & "- " & sCommentsName & " is a required field.<br>">
				</cfif>
				
				<cfif sError EQ "">
					<!--- build emails --->
					<cfsavecontent variable="sEmailAdminBody">
                    	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
						<html xmlns="http://www.w3.org/1999/xhtml">
						<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
						<title>#sEmailAdminSubject#</title>
						<style type="text/css">
						<!--
						body	{ margin:0px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:12px; background-color:#FFFFFF;background-image:url('<cfoutput>#Request.RootPath#</cfoutput>/images/nav_bg.gif');background-repeat:repeat-y; }
						a:link,a:visited,a:active	{ color:#517088; }
						a:hover	{ color:#000000;text-decoration:underline; }
						#table_main { background-color:#FFFFFF; }
						#table_cell_title { background-color:#3d597e; color:#FFFFFF; font-weight:bold; }
						#table_cell_subtitle { background-color:#6282ae; color:#FFFFFF; font-weight:bold; }
						#table_cell_content { background-color:#EFEFEF; }
						-->
						</style>
						</head>
						
						<body>
                        <cfoutput>
						<table width="500" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="1" cellpadding="3" id="table_main">
										<tr>
											<td id="table_cell_title">#sEmailAdminContentTitle#</td>
										</tr>
										<tr>
											<td id="table_cell_content">
												<strong>First Name:</strong> #sFirstName#<br />
												<strong>Last Name:</strong> #sLastName#<br />
												<strong>Email:</strong> #sEmail#<br />
												<strong>Comments/Questions:</strong><br />
												#sComments#<br>
												<strong>IP Address:</strong> #sIPAddress#<br />
												<strong>Host Address:</strong> #sHostAddress#<br />
												<strong>Referring URL:</strong> #sReferer#<br />
												<strong>Web Browser:</strong> #sUserAgent#<br />
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
                        </cfoutput>
						</body>
						</html>
                    </cfsavecontent>
					
                    <cfsavecontent variable="sEmailUserBody">
                    	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
						<html xmlns="http://www.w3.org/1999/xhtml">
						<head>
						<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
						<title>#sEmailUserSubject#</title>
						<style type="text/css">
						<!--
						body	{ margin:0px; font-family:Verdana, Arial, Helvetica, sans-serif; font-size:12px; background-color:#FFFFFF;background-image:url('<cfoutput>#Request.RootPath#</cfoutput>/images/nav_bg.gif');background-repeat:repeat-y; }
						a:link,a:visited,a:active	{ color:#517088; }
						a:hover	{ color:#000000;text-decoration:underline; }
						#table_main { background-color:#FFFFFF; }
						#table_cell_title { background-color:#3d597e; color:#FFFFFF; font-weight:bold; }
						#table_cell_subtitle { background-color:#6282ae; color:#FFFFFF; font-weight:bold; }
						#table_cell_content { background-color:#EFEFEF; }
						-->
						</style>
						</head>
						<body>
						<cfoutput>
						<table width="500" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="1" cellpadding="3" id="table_main">
										<tr>
											<td id="table_cell_title">#sEmailUserContentTitle#</td>
										</tr>
										<tr>
											<td id="table_cell_content">
												<strong>#sFirstName# #sLastName#</strong>,<br />
												#sEmailUserContents#
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
                        </cfoutput>
						</body>
						</html>
					</cfsavecontent>
                    
                    <cfset AdminEmails = "slamkajs@ucmail.uc.edu;rountrjf@ucmail.uc.edu;">
                    
					<!--- send admin email --->
					<cfmail to="#AdminEmails#"
                    		from="Support@cme.uc.edu"
                            subject="#sEmailAdminSubject#"
                            type="HTML">
						#sEmailAdminBody#
                    </cfmail>
					
					<!--- send user email --->
					<cfmail to="#sEmail#"
                            from="Support@cme.uc.edu"
                            subject="#sEmailUserSubject#"
                            type="HTML">
                    	#sEmailUserBody#
                    </cfmail>
					
					<cflocation url="#Request.RootPath#/cdc_message.cfm?p=#nMessageId#" addtoken="no" />
            	</cfif>
			</cfif>
		<cfoutput>
        <form action="#Request.RootPath#/cdc_contact.cfm?type=#nContactType#" method="post" name="frmContact" id="frmContact">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td id="content_title">#sContactType#</td>
			</tr>
			<cfif parameterExists(sError)>
			<tr>
				<td id="content_errors">#sError#</td>
			</tr>
            </cfif>
			<tr>
				<td id="content_body">
					<table id="table_main" width="100%" border="0" cellspacing="1" cellpadding="3">
						<tr>
							<td id="table_cell_title" colspan="2">#sContactFormTitle#</td>
						</tr>
						<tr>
							<td id="table_cell_subtitle" colspan="2">Your Information</td>
						</tr>
						<tr>
							<td id="table_cell_formtext" width="20%">First Name</td>
							<td id="table_cell_formfield"><input type="text" id="fldFirstName" name="fldFirstName" value="#sFirstName#" /></td>
						</tr>
						<tr>
							<td id="table_cell_formtext">Last Name</td>
							<td id="table_cell_formfield"><input type="text" id="fldLastName" name="fldLastName" value="#sLastName#" /></td>
						</tr>
						<tr>
							<td id="table_cell_formtext">Email Address</td>
							<td id="table_cell_formfield"><input type="text" id="fldEmail" name="fldEmail" value="#sEmail#" /></td>
						</tr>
						<tr>
							<td id="table_cell_formtext">Email Confirm</td>
							<td id="table_cell_formfield"><input type="text" id="fldEmailConfirm" name="fldEmailConfirm" value="#sEmailConfirm#" /></td>
						</tr>
						<tr>
							<td id="table_cell_subtitle" colspan="2">Contact Details</td>
						</tr>
						<tr>
							<td id="table_cell_formtext">Contact Type</td>
							<td id="table_cell_formfield">#sContactType#</td>
						</tr>
						<tr>
							<td colspan="2" id="table_cell_formtext">#sCommentsName#</td>
						</tr>
						<tr>
						  <td colspan="2" id="table_cell_formfield"><textarea style="width:99%;height:130px;" id="fldComments" name="fldComments">#sComments#</textarea></td>
						</tr>
						<tr>
							<td colspan="2" id="table_cell_content">#sCommentsNotes#</td>
						</tr>
						<tr>
							<td colspan="2" id="table_cell_formfield"><input type="submit" name="fldSubmit" id="fldSubmit" value="Submit" /> <input type="button" name="fldCancel" value="Cancel" onClick="window.location='welcome.cfm';"><input type="hidden" name="fldSubmitted" id="fldSubmitted" value="1" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</form>
        </cfoutput>
		</td>
	</tr>
</table>
</body>
</html>
