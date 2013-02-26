<cfparam name="Attributes.Submitted" default="">
<cfparam name="Attributes.username" default="">
<cfparam name="Attributes.password" default="">
<cfparam name="Attributes.Step" default="">
<cfif Attributes.Submitted NEQ "">
	<!--- LOOKUP FIRST --->
	<cfset AlreadyExists = false>
	
	<!--- EMAIL LOOKUP --->
	<cfinvoke 
	   webservice="#Application.Settings.LookupService#"
	   method="emailLookup"
	   emailaddress="#Attributes.Email#"
	   returnvariable="LookupResult">

	<cfif LookupResult[2] EQ 1>
		<cfset AlreadyExists = true>
	</cfif>
	
	<!--- IF NOT EMAIL ADDRESS FOUND --->
	<cfif NOT AlreadyExists>
		<cfinvoke 
		   webservice="#Application.Settings.LookupService#"
		   method="nameDOBLookup"
		   firstname="#Attributes.FirstName#"
		   middleinitial=""
		   lastname="#Attributes.LastName#"
		   birthdate="#Attributes.BirthDate#"
		   ssn="#Attributes.SSN#"
		   returnvariable="LookupResult">
		
		<cfif LookupResult[2] EQ 1>
			<cfset AlreadyExists = true>
		</cfif>
	</cfif>
	
	<!--- NEW MEMBER --->
	<cfif NOT AlreadyExists>
		<cfset PersonInfo = CreateObject("component","#Application.Settings.Com#Person.Person").init(PersonID=0)>
		<cfset PersonInfo.setFirstName(Attributes.FirstName)>
		<cfset PersonInfo.setLastName(Attributes.LastName)>
		<cfset PersonInfo.setEmail1(Attributes.Email)>
		<cfset PersonInfo.setBirthdate(Attributes.BirthDate)>
		<cfset PersonInfo.setSSN(Attributes.SSN)>
		
		<cfset NewPersonInfo = Application.Com.PersonNewDAO.Create(PersonInfo)>

		<!--- END-USER EMAIL --->
		<!---<cfmail to="#Attributes.Email#" from="do-not-reply@uc.edu" replyto="do-not-reply@uc.edu" bcc="#Application.Settings.AdminEmails#" subject="Registration Confirmation - CCPD" type="html">
			<div style="font-family:Arial, Helvetica, sans-serif;font-size:12px;">
			<b>#Attributes.FirstName# #Attributes.LastName#</b>,<br />
			<br />
			Thank you for registering with the CCPD Online Continue Education Portal.<br />
			Attached is your login/password for future reference in logging into our website.<br />
			<br />
			You may sign-in anytime by visiting #Application.Settings.WebURL#.<br />
			<br />
			Use the following credentials to sign-in:<br />
			<strong>Username:</strong> #NewPersonInfo.Username#<br />
			<strong>Password:</strong> #NewPersonInfo.Password#<br />
			<br />
			
			Hold on to this email since your password is automatically generated for you and cannot be changed.<br /><br />
			
			Thank you,<br />
			Center for Continuous Professional Development<br />
			University of Cincinnati
			</div>
		</cfmail>--->
		
		<!--- ADMIN EMAIL 
		<cfmail to="#Application.Settings.AdminEmails#" from="do-not-reply@uc.edu" replyto="do-not-reply@uc.edu" subject="Registration Notification - CCPD" type="html">
			<div style="font-family:Arial, Helvetica, sans-serif;font-size:12px;">
			This is a notification that #Attributes.FirstName# #Attributes.LastName# (PersonID: #NewPersonInfo.PersonID#) has registered on CCPD LMS Portal.<br /><br />
			<cfdump var="#NewPersonInfo#"><br />
			<cfdump var="#LookupResult#">			
			</div>
		</cfmail>--->
		
		<cfoutput>success|#NewPersonInfo.PersonID#|#NewPersonInfo.Username#|#NewPersonInfo.Password#</cfoutput><cfabort>
	<!--- EXISTING MEMBER --->
	<cfelse>
		<!--- LOOKUP CS_USER INFO --->
		<cfset TheEmailAddr = "needsdone@thisisntdone.com">
		<!--- ALREADY EXISTS EMAIL --->
		<!---<cfmail to="#Attributes.Email#" from="do-not-reply@uc.edu" replyto="do-not-reply@uc.edu" bcc="#Application.Settings.AdminEmails#" subject="Registration Confirmation - CCPD" type="html">
			<div style="font-family:Arial, Helvetica, sans-serif;font-size:12px;">
			<b>#Attributes.FirstName# #Attributes.LastName#</b>,<br />
			<br />
			Thank you for registering with the CCPD Online Continue Education Portal.<br />
			Attached is your login/password for future reference in logging into our website.<br />
			<br />
			You may sign-in anytime by visiting #Application.Settings.WebURL#.<br />
			<br />
			Use the following credentials to sign-in:<br />
			<strong>Username:</strong> #NewPersonInfo.Username#<br />
			<strong>Password:</strong> #NewPersonInfo.Password#<br />
			<br />
			
			Hold on to this email since your password is automatically generated for you and cannot be changed.<br /><br />
			
			Thank you,<br />
			Center for Continuous Professional Development<br />
			University of Cincinnati
			</div>
		</cfmail>--->
		failed|already exists.<cfabort>
	</cfif>
</cfif>