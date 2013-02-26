<cfif IsDefined("Attributes.FormSubmit")>
	<cfset Errors = "">
	<cfif Attributes.Subject EQ "">
		<cfset Errors = Errors & "Please enter the Topic of your issue,">
	</cfif>
	
	<cfif Attributes.Body EQ "">
		<cfset Errors = Errors & "Please enter a Description of your issue">
	</cfif>
	
	<cfif Errors EQ "">
		<cfset Subject = "CEAdmin Support: #Attributes.Subject#">
		<cfset Body = "<strong>First Name:</strong> #Session.Person.getFirstName()#<br>
						<strong>Last Name:</strong> #Session.Person.getLastName()#<br>
						<strong>Details:</strong> #Attributes.Body#">
		<cfset DateTime = CreateODBCDateTime(DateFormat(Now(), "MM/DD/YYYY") & " " & Timeformat(Now(), "hh:mm:ss tt"))>
					
		<!--- Create Bean --->
		<cfset SupportBean = CreateObject("component","#Application.Settings.Com#HelpTicket").Init()>
		
		<!--- Fills the Bean with values from Create Person form --->
		<cfset SupportBean.setTicketID(HelpTicketID)>
		<cfset SupportBean.setSubject(Subject)>
		<cfset SupportBean.setComments(Body)>
		<cfset SupportBean.setPersonID(Session.Person.getPersonID())>
		<cfset SupportBean.setCreated(DateTime)>
		<cfset SupportBean.setDeletedFlag('N')>
		
		<!--- Uses the Bean to submit data into the database --->
		<cfset SupportBean = Application.Com.HelpTicketDAO.Save(SupportBean)>
		
		<cfif IsDefined("Attributes.Referer")>
			<cflocation url="#Myself#Support.#Attributes.Referer#" addtoken="no">
		<cfelse>
			<cflocation url="#Myself#Support.Request" addtoken="no">
		</cfif>
	</cfif>
</cfif>