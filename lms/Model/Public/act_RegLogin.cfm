<cfparam name="Attributes.Submitted" default="">
<cfparam name="Attributes.username" default="">
<cfparam name="Attributes.password" default="">

<cfif Session.LoggedIn>
	<cflocation url="/register/#Attributes.ActivityID#/Payment" addtoken="no" />
</cfif>

<cfif Attributes.Submitted NEQ "">
	<cfif Attributes.username EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must enter an Account ID.","|")>
	</cfif>
	
	<cfif Attributes.password EQ "">
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"You must enter an Password.","|")>
	</cfif>
	
	<cfif Request.Status.Errors EQ "">
    	
		<cfinvoke 
		   webservice="http://webcentral.uc.edu/admin/service/prod/LoginServices/wsAuthentication2.cfc?wsdl"
		   method="authenticate"
		   datasource="cmeRWprod"
		   uname="#Attributes.username#"
		   passwd="#Attributes.password#"
		   institutionid="1"
		   returnVariable = "Variables.LoginOutput">
		<cfdump var="#Variables.LoginOutput#">
		<cfset Session.PersonID = Variables.LoginOutput[2]>
		
		<cfif Session.PersonID NEQ "">
			<cfset Session.LoggedIn = true>
			<cfset Session.Person = CreateObject("component","#Application.Settings.Com#Person").init(PersonID=Session.PersonID)>
			<cfset Session.Person = Application.Com.PersonDAO.Read(Session.Person)>
			<cfcookie name="Person.FirstName" value="#Session.Person.getFirstName()#">
			
			<cflocation url="/register/#Attributes.ActivityID#/Payment" addtoken="no">
		<cfelse>
			<cflocation url="#myself#Main.Login?LoginError=Authentication failed.  Try again!" addtoken="no" />
		</cfif>
	<cfelse>
		<cflocation url="#myself#Main.Login?LoginError=Authentication failed.  Try again!" addtoken="no" />
	</cfif>
</cfif>