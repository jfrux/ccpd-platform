<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Welcome Center</title>
<link href="styles/inc_styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
<cfinclude template="includes/inc_header.cfm">
<cfoutput>
<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<td class="content_cell" valign="top">
			<cfif isDefined("url.p") AND url.p NEQ "">
				<cfset nMessageId = url.p>
			<cfelse>
				<cflocation url="#Request.RootPath#/welcome.cfm" addtoken="no">
			</cfif>
			
			<cfswitch expression="#nMessageId#">
				<cfcase value="1">
					<cfset sContentTitle = "Thank you for contacting Technical Support!">
                    <cfset sContentBody = "We are reviewing your support questions/concerns and should respond within 24 hours.">
                    <cfset sRedirectTime = "10">
                    <cfset sRedirectURL = "welcome.cfm">
				</cfcase>
				
				<cfcase value="2">
					<cfset sContentTitle = "Thank you for sending Feedback!">
                    <cfset sContentBody = "We are reviewing your feedback and will respond within 24 hours if necessary.">
                    <cfset sRedirectTime = "10">
                    <cfset sRedirectURL = "welcome.cfm">
				</cfcase>
				
				<cfcase value="3">
					<cfset sContentTitle = "Thank you for contacting!">
                    <cfset sContentBody = "We are reviewing your comments/concerns and will issue a response within 24 hours if necessary.">
                    <cfset sRedirectTime = "10">
                    <cfset sRedirectURL = "welcome.cfm">
				</cfcase>
				
				<cfcase value="4">
					<cfset sContentTitle = "Registration Submitted, but with problems!">
                    <cfset sContentBody = "Your registration has been submitted but we cannot currently provide you with a certificate.  If you feel you are receiving this message by mistake, please contact us by clicking <a href='cdc_contact.cfm?type=1'>here</a>.">
                    <cfset sRedirectTime = "15">
                    <cfset sRedirectURL = "welcome.cfm">
				</cfcase>
				
				<cfcase value="5">
					<cfset sContentTitle = "Registration Successfully Submitted!">
                    <cfset sContentBody = "Your registration has been submitted.  We require an evaluation to be completed before you may receive your certificate.  To proceed, click <a href='#Request.RootPath#/course_test_info.cfm?cid=#url.cid#&test_id=#url.eval_id#'>here</a>.">
                    <cfset sRedirectTime = "15">
                    <cfset sRedirectURL = "#Request.RootPath#/course_test_info.cfm?cid=#url.cid#&test_id=#url.eval_id#">
				</cfcase>
				
				<cfcase value="6">
					<cfset sContentTitle = "Registration Successfully Submitted!">
                    <cfset sContentBody = "Your registration has been submitted. To proceed to your certificate, click <a href='#Request.RootPath#/course_certificate.cfm?cid=#url.cid#&cert_id=#url.cert_id#'>here</a>.">
                    <cfset sRedirectTime = "15">
                    <cfset sRedirectURL = "#Request.RootPath#/course_certificate.cfm?cid=#url.cid#&cert_id=#url.cert_id#">
				</cfcase>
				
				<cfcase value="7">
					<cfset sContentTitle = "Registration Successfully Submitted!">
                    <cfset sContentBody = "Your registration has been submitted. Once you have attended the course, you may return here to receive your certificate.">
                    <cfset sRedirectTime = "10">
                    <cfset sRedirectURL = "welcome.cfm">
				</cfcase>
				
				<cfdefaultcase>
					<cfset sContentTitle = "ERROR!">
                    <cfset sContentBody = "Invalid credentials! If you feel you are here by mistake please contact Technical Support">
                    <cfset sRedirectTime = "10">
                    <cfset sRedirectURL = "#Request.RootPath#/cdc_contact.cfm?type=1">
				</cfdefaultcase>
            </cfswitch>
			
			<!--- build output --->
            <meta http-equiv="refresh" content="#sRedirectTime#;url=#sRedirectURL#">
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td id="content_title">#sContentTitle#</td>
                </tr>
                <tr>
                    <td id="content_body">#sContentBody#</td>
                </tr>
            </table>
		</td>
	</tr>
</table>
</cfoutput>
</body>
</html>
