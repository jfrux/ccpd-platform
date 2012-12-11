<cfparam name="Attributes.Submitted" default="" />
<cfparam name="Attributes.CardName" default="" />
<cfparam name="Attributes.CardNumber" default="" />
<cfparam name="Attributes.CardCode" default="" />
<cfparam name="Attributes.CardType" default="" />
<cfparam name="Attributes.CardExpireMonth" default="" />
<cfparam name="Attributes.CardExpireYear" default="" />
<cfparam name="Attributes.Phone" default="" />
<cfparam name="Attributes.RegAddress1" default="" />
<cfparam name="Attributes.RegAddress2" default="" />
<cfparam name="Attributes.RegCity" default="" />
<cfparam name="Attributes.RegState" default="" />
<cfparam name="Attributes.RegZip" default="" />
<cfparam name="Attributes.RegCountry" default="" />
<cfparam name="Attributes.FirstName" default="" />
<cfparam name="Attributes.MiddleName" default="" />
<cfparam name="Attributes.LastName" default="" />
<cfparam name="Attributes.Profession" default="" />
<cfparam name="Attributes.DOB" default="" />
<cfparam name="Attributes.Last4SSN" default="" />
<cfparam name="Attributes.Email" default="" />
<cfparam name="Attributes.Email2" default="" />
<cfparam name="Attributes.FeeAmount" default="0" />
<cfparam name="Attributes.PersonID" default="0" />
<cfparam name="Session.PersonID" default="0" />
<cfset Errors = "">
<cfset TheMode = "LIVE">
<cfdump var="#CGI.USER_AGENT#">
<cfif CGI.USER_AGENT CONTAINS "Pangolin" OR CGI.REMOTE_ADDR EQ "68.59.99.2">

<cfabort>
</cfif>

<cfswitch expression="#TheMode#">
	<cfcase value="TEST">
		<cfset SerialNumber = "000657150761">
		<cfset PostURL = "https://developer.skipjackic.com/scripts/evolvcc.dll?Authorize">
	</cfcase>
	<cfcase value="LIVE">
		<cfset SerialNumber = "000040232808">
		<cfset PostURL = "https://www.skipjackic.com/scripts/evolvcc.dll?Authorize">
	</cfcase>
</cfswitch>
<cfscript>
/**
* Tests passed value to see if it is a valid e-mail address (supports subdomain nesting and new top-level domains).
* Update by David Kearns to support '
* SBrown@xacting.com pointing out regex still wasn't accepting ' correctly.
* Should support + gmail style addresses now.
* More TLDs
* Version 4 by P Farrel, supports limits on u/h
* Added mobi
* v6 more tlds
*
* @param str      The string to check. (Required)
* @return Returns a boolean.
* @author Jeff Guillaume (SBrown@xacting.comjeff@kazoomis.com)
* @version 7, May 8, 2009
*/
function isEmail(str) {
return (REFindNoCase("^['_a-z0-9-\+]+(\.['_a-z0-9-\+]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|asia|biz|cat|coop|info|museum|name|jobs|post|pro|tel|travel|mobi))$",
arguments.str) AND len(listGetAt(arguments.str, 1, "@")) LTE 64 AND
len(listGetAt(arguments.str, 2, "@")) LTE 255) IS 1;
}
</cfscript>

<cfif Attributes.Submitted NEQ "">
	<!---<cfif Attributes.PersonID LTE 0>
		<cfset Errors = ListAppend(Errors,"You must create an account or login before submitting.","|")>
	</cfif>--->
	
	<cfif Attributes.FirstName EQ "">
		<cfset Errors = ListAppend(Errors,"First Name is required.","|")>
	</cfif>
	
	<cfif Attributes.LastName EQ "">
		<cfset Errors = ListAppend(Errors,"Last Name is required.","|")>
	</cfif>
	
	<cfif Attributes.Last4SSN EQ "">
		<cfset Errors = ListAppend(Errors,"Last 4 SSN is required.","|")>
	</cfif>
	
	<cfif Attributes.DOB EQ "">
		<cfset Errors = ListAppend(Errors,"Date of Birth is required.","|")>
	</cfif>
	
	<cfif Attributes.Profession EQ "">
		<cfset Errors = ListAppend(Errors,"Profession is required.","|")>
	<cfelse>
		<cfswitch expression="#Attributes.Profession#">
			<cfcase value="Nurse">
				<cfset MDFlag = "N">
				<cfset Attributes.FeeAmount = 25>
			</cfcase>
			<cfcase value="Physician">
				<cfset MDFlag = "Y">
				<cfset Attributes.FeeAmount = 50>
			</cfcase>
			<cfdefaultcase>
				<cfset MDFlag = "N">
				<cfset Attributes.FeeAmount = 0>
			</cfdefaultcase>
		</cfswitch>
	</cfif>
	
	<cfif Attributes.Email EQ "">
		<cfset Errors = ListAppend(Errors,"Email is required.","|")>
	</cfif>
	
	<cfif Attributes.Email2 EQ "">
		<cfset Errors = ListAppend(Errors,"Re-Typed Email is required.","|")>
	</cfif>
	
	<cfif Attributes.Email NEQ Attributes.Email2>
		<cfset Errors = ListAppend(Errors,"Email and Re-Typed Email do not match.","|")>
	</cfif>
	
	<cfif NOT isEmail(Attributes.Email)>
		<cfset Errors = ListAppend(Errors,"You entered an invalid email address.","|")>
	</cfif>
	
	<cfif Attributes.Phone EQ "">
		<cfset Errors = ListAppend(Errors,"Phone is required.","|")>
	</cfif>
	
	<cfif Attributes.RegAddress1 EQ "">
		<cfset Errors = ListAppend(Errors,"Address is required.","|")>
	</cfif>
	
	<cfif Attributes.RegCity EQ "">
		<cfset Errors = ListAppend(Errors,"City is required.","|")>
	</cfif>
	
	<cfif Attributes.RegState LTE 0>
		<cfset Errors = ListAppend(Errors,"State is required.","|")>
	</cfif>
	
	<cfif Attributes.RegZip EQ "">
		<cfset Errors = ListAppend(Errors,"Zip Code is required.","|")>
	</cfif>
	
	<cfif Attributes.RegCountry LTE 0>
		<cfset Errors = ListAppend(Errors,"Country is required.","|")>
	</cfif>
	
	<cfif Attributes.FeeAmount GT 0>
		<cfif Attributes.CardName EQ "">
			<cfset Errors = ListAppend(Errors,"Name On Card is required.","|")>
		</cfif>
		
		<cfif Attributes.CardNumber EQ "">
			<cfset Errors = ListAppend(Errors,"Card Number is required.","|")>
		</cfif>
		
		<cfif Attributes.CardCode EQ "">
			<cfset Errors = ListAppend(Errors,"Card Security Code is required.","|")>
		</cfif>
		
		<cfif Attributes.CardType EQ "">
			<cfset Errors = ListAppend(Errors,"Card Type is required.","|")>
		</cfif>
		
		<cfif Attributes.CardExpireMonth EQ "">
			<cfset Errors = ListAppend(Errors,"Expiration Month is required.","|")>
		</cfif>
		
		<cfif Attributes.CardExpireYear EQ "">
			<cfset Errors = ListAppend(Errors,"Expiration Year is required.","|")>
		</cfif>
	</cfif>
	
	<cfif Errors EQ "">
		<!--- DEVELOPMENT: https://developer.skipjackic.com/scripts/evolvcc.dll?Authorize
			PRODUCTION: https://www.skipjackic.com/scripts/evolvcc.dll?Authorize
		--->
		<cfif Session.PersonID EQ 169841>
			<cfset Attributes.FeeAmount = 0>
		</cfif>
		<cfif Attributes.FeeAmount GT 0>
			<cfhttp url="#PostURL#" method="post">
			
			<!----contact info---->
			<cfhttpparam type="formfield" name="sjname" value="#Attributes.CardName#">
			<cfhttpparam type="formfield" name="Email" value="#Attributes.Email#">
			<cfhttpparam type="formfield" name="Shiptophone" value="#Attributes.Phone#">
			
			<!----billing info---->
			<cfhttpparam type="formfield" name="Streetaddress" value="#Attributes.RegAddress1#">
			<cfhttpparam type="formfield" name="Streetaddress2" value="#Attributes.RegAddress2#">
			<cfhttpparam type="formfield" name="City" value="#Attributes.RegCity#">
			<cfhttpparam type="formfield" name="State" value="#Attributes.RegState#">
			<cfhttpparam type="formfield" name="Country" value="#Attributes.RegCountry#">
			<cfhttpparam type="formfield" name="Zipcode" value="#Attributes.RegZip#">
			
			<!----cc info---->
			<cfhttpparam type="formfield" name="type" value="#Attributes.CardType#">
			<cfhttpparam type="formfield" name="Month" value="#Attributes.CardExpireMonth#">
			<cfhttpparam type="formfield" name="Year" value="#Attributes.CardExpireYear#">
			<cfhttpparam type="formfield" name="Accountnumber" value="#Attributes.CardNumber#">
			
			<!----shipping info---->
			<cfhttpparam type="formfield" name="Shiptoname" value="#Attributes.FirstName# #Attributes.LastName#">
			<cfhttpparam type="formfield" name="Shiptostreetaddress" value="#Attributes.RegAddress1#">
			<cfhttpparam type="formfield" name="Shiptostreetaddress2" value="#Attributes.RegAddress2#">
			<cfhttpparam type="formfield" name="Shiptocity" value="#Attributes.RegCity#">
			<cfhttpparam type="formfield" name="Shiptostate" value="#Attributes.RegState#">
			<cfhttpparam type="formfield" name="Shiptocountry" value="#Attributes.RegCountry#">
			<cfhttpparam type="formfield" name="Shiptozipcode" value="#Attributes.RegZip#">
			
			<!----skip jack crap---->
			<cfhttpparam type="formfield" name="Ordernumber" value="#DateFormat(now(),'mmddyyyy')##TimeFormat(now(),'hhmmss')#">               
			<cfhttpparam type="formfield" name="Serialnumber" value="#SerialNumber#">
			<!--- DEVELOPER: 000657150761 
					PRODUCTION: 000040232808
					--->
			<cfhttpparam type="formfield" name="Transactionamount" value="#DecimalFormat(Trim(Attributes.FeeAmount))#">
			
			<!----the order details---->
			<cfhttpparam type="formfield" name="Orderstring" value="1~#ActivityBean.getTitle()#~#Attributes.FeeAmount#~1~N~||">
			
			</cfhttp>
			
			
			<!----check what skipjack says & kick the user out of that is the case---->
			<cfparam name="form.szIsApproved" default="">
			<cfparam name="form.szTransactionFileName" default="">
			<!---<cfoutput>#CFHTTP.FileContent# #form.szIsApproved#</cfoutput>--->
			<!--AUTHCODE=EMPTY--><!--szSerialNumber=000040232808--><!--szTransactionAmount=100--><!--szAuthorizationDeclinedMessage=--><!--szAVSResponseCode=--><!--szAVSResponseMessage=--><!--szOrderNumber=06012009033943--><!--szAuthorizationResponseCode=--><!--szIsApproved=0--><!--szCVV2ResponseCode=--><!--szCVV2ResponseMessage=--><!--szReturnCode=-97--><!--szTransactionFileName=--><!--szCAVVResponseCode=-->
			<cfset ValList="-AUTHCODE,-szSerialNumber,-szTransactionAmount,-szAuthorizationDeclinedMessage,-szAVSResponseCode,-szAVSResponseMessage,-szOrderNumber,-szAuthorizationResponseCode,-szReturnCode">
			<cfset VarList="strAuthCode,strSerialNumber,strTransactionAmount,strAuthorizationDeclinedMessage,strAVSResponseCode,strAVSResponseMessage,strOrderNumber,strAuthorizationResponseCode,strReturnCode">
			
			<cfset loopcount = 0>
			<cfloop list="#ValList#" index="Val_Name">
				<cfset loopcount = incrementvalue(loopcount)>
				<cfset length = Len(Val_Name)>
				<cfset start = FindNoCase(Val_Name, CFHTTP.FileContent, 1)+length+1>
				<cfset end = FindNoCase("-->", CFHTTP.FileContent, start)-start>
				<cfset Var_Name = #ListGetAt(VarList, loopcount, ",")#>
				<cfset a = #SetVariable(Var_name, "#Mid(CFHTTP.FileContent, start, end)#")#>
				<!---<cfoutput>#Var_Name#: #a#<br /></cfoutput>--->
			</cfloop>
		<cfelse>
			<cfset strAUTHORIZATIONRESPONSECODE = "123456">
			<cfset strRETURNCODE = "1">
		</cfif>
		<!--- Set Response Code and CC_OK --->
		<cfif Len(#strAUTHORIZATIONRESPONSECODE#) EQ '6' AND #strRETURNCODE# EQ '1'> 
			<CFSET CC_OK = 1>
			
			<!---<cfset StatusMsg = Application.ActivityAttendee.saveAttendee(Attributes.ActivityID,Session.PersonID,MDFlag)>--->
			
			<cfquery name="qInsert" datasource="Registration">
				INSERT INTO Registration (
					ActivityID,
					FirstName,
					MiddleName,
					LastName,
					Address1,
					Address2,
					City,
					State,
					Country,
					Zip,
					Phone,
					Last4SSN,
					DOB,
					Email,
					RegisterDate,
					Profession,
					FeeAmount
				) VALUES (
					<cfqueryparam value="#Attributes.ActivityID#" cfsqltype="cf_sql_integer" />,
					<cfqueryparam value="#Attributes.FirstName#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.MiddleName#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.LastName#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.RegAddress1#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.RegAddress2#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.RegCity#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.RegState#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.RegCountry#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.RegZip#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.Phone#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.Last4SSN#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.DOB#" cfsqltype="cf_sql_timestamp" />,
					<cfqueryparam value="#Attributes.Email#" cfsqltype="cf_sql_varchar" />,
					#CreateODBCDateTime(now())#,
					<cfqueryparam value="#Attributes.Profession#" cfsqltype="cf_sql_varchar" />,
					<cfqueryparam value="#Attributes.FeeAmount#" cfsqltype="cf_sql_float" />
				)
			</cfquery>
			
			<cfset qAgenda = Application.Com.AgendaGateway.getByAttributes(ActivityID=Attributes.ActivityID,OrderBy="EventDate,StartTime,EndTime")>
			
			<!--- USER EMAIL --->
			<cfmail type="html" to="#Attributes.Email#" from="do-not-reply@uc.edu" subject="Registration Confirmation - #ActivityBean.getTitle()#">
				
				<font face="Arial, Helvetica, sans-serif" size="2">
				Dear <strong>#Attributes.FirstName#</strong>,<br /><br />
				Thank you for registering for this activity.
				<br /><br />
				<cfif Attributes.FeeAmount GT 0>
				Your payment of <strong>#LSCurrencyFormat(Attributes.FeeAmount)#</strong> has been received.
				<br /><br /></cfif>
				You may use the following information as a reference for this activity:
				<br /><br />
				<strong>WHEN:</strong><br />
				<cfloop query="qAgenda">
				#DateFormat(qAgenda.EventDate,'mmmm dd, yyyy')# at #TimeFormat(qAgenda.StartTime,'hh:mm TT')# to #TimeFormat(qAgenda.EndTime,'hh:mm TT')#<br />
				</cfloop>
				<cfquery name="qState" datasource="#Application.Settings.DSN#">
					SELECT Code FROM pd_State
					WHERE StateID=<cfqueryparam value="#ActivityBean.getState()#" cfsqltype="cf_sql_integer" null="#Len(ActivityBean.getState()) LTE 0#" />
				</cfquery>
				<br />
				<strong>WHERE:</strong><br />
				#ActivityBean.getLocation()#<br />
				#ActivityBean.getAddress1()#<br />
				<cfif ActivityBean.getAddress2() NEQ "">
				#ActivityBean.getAddress2()#<br />
				</cfif>
				#ActivityBean.getCity()#, #qState.Code#, #ActivityBean.getPostalCode()#<br />
				<a href="http://maps.google.com/maps?f=q&q=#ActivityBean.getAddress1()# #ActivityBean.getAddress2()# #ActivityBean.getCity()#, #qState.Code#, #ActivityBean.getPostalCode()#">Show On Google Maps</a>
				<br /><br />
				Thank you!
				</font>
			</cfmail>
			
			<!--- ADMIN EMAIL --->
			<cfmail type="html" to="rountrjf@ucmail.uc.edu;fischemh@ucmail.uc.edu;forneyba@ucmail.uc.edu" from="do-not-reply@uc.edu" subject="Registration Received - #ActivityBean.getTitle()#">
				Hello,<br />
				<br />
				This email was sent to you as a notification that <strong>#Attributes.FirstName# #Attributes.LastName#</strong> has registered for the <strong>#ActivityBean.getTitle()#</strong> activity. <br />
				<br />
				Here are the details below:<br />
				<br />
				<strong>Full Name:</strong> #Attributes.FirstName# #Attributes.MiddleName# #Attributes.LastName#<br />
				<strong>Profession:</strong> #Attributes.Profession#<br />
				<strong>Address:</strong><br />
				#Attributes.RegAddress1#<br />
				#Attributes.RegAddress2#<br />
				#Attributes.RegCity#, #Attributes.RegState#, #Attributes.RegZip#, #Attributes.RegCountry#<br />
				<strong>Email:</strong> #Attributes.Email#<br />
				<strong>Phone:</strong> #Attributes.Phone#<br />
				<strong>Activity:</strong> #ActivityBean.getTitle()#<br />
				<strong>Amount Paid:</strong> #LSCurrencyFormat(Attributes.FeeAmount)# <br />
				<em>#MDFlag#</em>
			</cfmail>
			
			<cflocation url="/register/#Attributes.ActivityID#/Finished" addtoken="no" />
		<CFELSE>
			<cfset Errors = ListAppend(Errors,"Credit Card could not be authorized.  Please check your information and try again.","|")>
			<CFSET CC_OK = 0>
		</CFIF>
	</cfif>
</cfif>