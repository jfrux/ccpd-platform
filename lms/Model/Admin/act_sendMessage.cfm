<cfparam name="Attributes.Subject" default="">
<cfparam name="Attributes.Body" default="">
<cfparam name="Attributes.Submitted" default="">
<cfparam name="Attributes.TestEmail" default="">

<cfif Attributes.Submitted NEQ "">
	<cfif Attributes.TestEmail NEQ "">
		<cfset NewBody = Attributes.Body>
		<cfset NewBody = Replace(NewBody,"%FirstName%",qGetAdmins.FirstName,"ALL")>
		<cfset NewBody = Replace(NewBody,"%MiddleName%",qGetAdmins.MiddleName,"ALL")>
		<cfset NewBody = Replace(NewBody,"%LastName%",qGetAdmins.LastName,"ALL")>
		<cfset NewBody = Replace(NewBody,"%Username%",qGetAdmins.Username,"ALL")>
		<cfset NewBody = Replace(NewBody,"%Password%",qGetAdmins.Password,"ALL")>
		<cfmail to="rountrjf@ucmail.uc.edu" from="rountrjf@ucmail.uc.edu" replyto="rountrjf@ucmail.uc.edu" subject="(TESTING) #Attributes.Subject# - #DateFormat(now(),'mm/dd/yyyy')#" type="html">
			#NewBody#
		</cfmail>
	<cfelse>
		<cfloop query="qGetAdmins">
			<cfset NewBody = Attributes.Body>
			<cfset NewBody = Replace(NewBody,"%FirstName%",qGetAdmins.FirstName,"ALL")>
			<cfset NewBody = Replace(NewBody,"%MiddleName%",qGetAdmins.MiddleName,"ALL")>
			<cfset NewBody = Replace(NewBody,"%LastName%",qGetAdmins.LastName,"ALL")>
			<cfset NewBody = Replace(NewBody,"%Username%",qGetAdmins.Username,"ALL")>
			<cfset NewBody = Replace(NewBody,"%Password%",qGetAdmins.Password,"ALL")>
			
			<cfmail to="#qGetAdmins.Email1#" from="rountrjf@ucmail.uc.edu" replyto="rountrjf@ucmail.uc.edu" subject="#Attributes.Subject# - #DateFormat(now(),'mm/dd/yyyy')#" type="html">
				#NewBody#
			</cfmail>
		</cfloop>
	</cfif>
	<cflocation url="#myself#Admin.Message?Message=Sent successfully." addtoken="no" />
</cfif>