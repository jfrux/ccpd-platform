<cfparam name="Attributes.Submitted" default="0" />
<cfparam name="Attributes.ActivityID" default="" />
<cfparam name="Attributes.Mode" default="Start" />
<cfparam name="Attributes.AcceptTerms" default="0" />
<cfparam name="Attributes.AcceptPayment" default="0" />
<cfparam name="AttendeeExists" default="false" />
<cfoutput>
<cfif Attributes.Submitted EQ 1>
	<!--- DEFINE SESSIONS --->
    <cfparam name="Session.Activity#Attributes.ActivityID#.Payment" default="N" />
    <cfparam name="Session.Activity#Attributes.ActivityID#.Terms" default="N" />
    
	<!--- CHECK IF TERMS OR PAYMENT IS NEEDED --->
    <cfset PaymentNeeded = Attributes.PaymentFlag>
    <cfset TermsNeeded = Attributes.TermsFlag>
    
    <!--- CHECK IF USER IS AN ATTENDEE --->
	<cfif NOT AttendeeExists>
   		<!--- CHECK IF ACTIVITY NEEDS TERMS BUT USER HAS NOT BEEN ACCEPTED --->
        <cfif TermsNeeded EQ "Y" AND Attributes.AcceptTerms EQ 0 AND Evaluate("Session.Activity#Attributes.ActivityID#.Terms") NEQ "Y">
            <cflocation url="#Myself#Activity.Start&ActivityID=#Attributes.ActivityID#&Mode=Terms" addtoken="no" />
        <!--- CHECK IF TERMS HAVE BEEN ACCEPTED --->
        <cfelseif TermsNeeded EQ "Y" AND Attributes.AcceptTerms EQ 1 AND Evaluate("Session.Activity#Attributes.ActivityID#.Terms") NEQ "Y" OR TermsNeeded EQ "N">
        	<cfset "Session.Activity#Attributes.ActivityID#.Terms" = "Y">
            
			<!--- CHECK IF PAYMENT IS NEEDED --->
			<cfif Attributes.PaymentFlag EQ "N">
            	<!--- SET PAYMENT SESSION TO ALLOW FOR SKIPPING PAYMENT STEP --->
            	<cfset "Session.Activity#Attributes.ActivityID#.Payment" = "Y">
            </cfif>
        </cfif>
        
		<!--- CHECK IF ACTIVITY NEEDS PAYMENT BUT USER HAS NOT PAID  --->
        <cfif PaymentNeeded EQ "Y" AND Attributes.AcceptPayment EQ 0 AND Evaluate("Session.Activity#Attributes.ActivityID#.Payment") NEQ "Y">
            <cflocation url="#Myself#Activity.Start&ActivityID=#Attributes.ActivityID#&Mode=Payment" addtoken="no" />
        <!--- CHEC IF PAYMENT HAS BEEN MADE --->
        <cfelseif PaymentNeeded EQ "Y" AND Attributes.AcceptPayment EQ 1 AND Evaluate("Session.Activity#Attributes.ActivityID#.Payment") NEQ "Y" OR PaymentNeeded EQ "N">
            <cfset "Session.Activity#Attributes.ActivityID#.Payment" = "Y">
        </cfif> 
    </cfif>
    
    <cfif Evaluate("Session.Activity#Attributes.ActivityID#.Payment") EQ "Y" AND Evaluate("Session.Activity#Attributes.ActivityID#.Terms") EQ "Y">
		<!--- INCLUDE isMD UDF FUNCTION --->
        <cfinclude template="/_com/_UDF/isMD.cfm" />
        
		<!--- CHECK IF MD --->
		<cfif isMD(Session.PersonID)>
			<cfset AttendeeBean.setMDFlag("Y")>
		<cfelse>
			<cfset AttendeeBean.setMDFlag("N")>
		</cfif>
        
		<!--- SET PAYMENT, TERMS, AND STATUSID --->
        <cfset AttendeeBean.setPaymentFlag("Y")>
        <cfset AttendeeBean.setTermsFlag("Y")>
        <cfset AttendeeBean.setStatusID(2)>
        
        <!--- SET LOG INFORMATION --->
        <cfset AttendeeBean.setCheckIn(DateFormat(Now(), "MM/DD/YYYY") & " " & TimeFormat(Now(), "hh:mm:ssTT"))>
        <cfset AttendeeBean.setRegisterDate(DateFormat(Now(), "MM/DD/YYYY") & " " & TimeFormat(Now(), "hh:mm:ssTT"))>
        <cfset AttendeeBean.setCreatedBy(Session.PersonID)>
    	<cfset AttendeeBean = Application.Com.AttendeeDAO.Create(AttendeeBean)>
         
        <cfset "Session.Activity#Attributes.ActivityID#.Payment" = "N">
        <cfset "Session.Activity#Attributes.ActivityID#.Terms" = "N">
        <cfset StructDelete(Session, "Activity#Attributes.ActivityID#")>
        
        <cflocation url="#Myself#Activity.Start?ActivityID=#Attributes.ActivityID#&Mode=Registered" addtoken="no" />
    </cfif>
</cfif>
</cfoutput>