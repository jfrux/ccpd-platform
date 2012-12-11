<cfparam name="attributes.submitted" default="0" />
<cfparam name="attributes.cemail" default="" />
<cfparam name="attributes.cpassword" default="" />
<cfparam name="attributes.ac" default="0" />
<cfparam name="attributes.e" default="" />
<cfparam name="attributes.r" default="" />
<cfparam name="instructions" default="To continue, you must provide your credentials.">
<cfparam name="attributes.returnMessage" default="" />
<!--- 
	// ATTRIBUTES EXPLANATION //
	AC is attempt counter 
	E is the email list
	R is the return location
--->

<cfif attributes.submitted EQ 1>
	<cfset status = application.auth.confirmCredentials(personId=session.personId,email=attributes.cemail,password=attributes.cpassword)>
	
	<!--- DETERMINE IF THE PROVIDED CREDENTIALS ARE VALID --->
    <cfif status.getStatus()>
    	<!--- SAVE EMAIL ADDRESSES --->
		<cfif len(trim(attributes.e)) GT 0>
            <cfloop list="#attributes.e#" index="currEmail">
            	<!--- SAVE EMAIL INFORMATION --->
                <cfset emailSaved = application.person.saveEmail(person_id=session.personId,email_address=currEmail)>
                
                <!--- DETERMINE IF THE EMAIL INFORMATION PROPERLY SAVED --->
                <cfif emailSaved.getStatus()>
                	<!--- GET THE EMAILBEAN FROM THE RETURN PAYLOAD --->
					<cfset emailBean = emailSaved.getPayload()>
                
        		    <!--- SEND VERIFICATION EMAIL  --->
		            <cfset application.email.send(EmailStyleID=6, toEmailAddress=emailBean.getEmail_address(), toEmailId=emailBean.getEmail_id(), toPersonId=emailBean.getPerson_id())>
                <cfelse>
                	<cfset errors = emailSaved.getErrors()>
                    
                    <!--- BUILD ERROR LIST --->
                	<cfloop from="1" to="#arrayLen(errors)#" index="currError">
	                	<cfset attributes.returnMessage = listAppend(attributes.returnMessage, errors[currError].message,", ")>
                    </cfloop>
                </cfif>
            </cfloop>
        </cfif>
		
        <!--- BUILD THE RETURN MESSAGE --->
		<cfif len(trim(attributes.returnMessage)) EQ 0>
            <cflocation url="#application.settings.rootPath#/preferences?message=Preferences Saved!" addtoken="no">
        <cfelse>
            <cfset attributes.returnMessage = "Preferences have been saved but, " & attributes.returnMessage>
            <cflocation url="#application.settings.rootPath#/preferences?message=#attributes.returnMessage#" addtoken="no">
        </cfif>
    <cfelse>
    	<!--- CREDENTIALS WERE INVALID --->
        <cfset attributes.message = status.getStatusMsg()>
    </cfif>
<cfelse>
	<cfset attributes.r = cgi.HTTP_REFERER>
    
    <cfif len(trim(attributes.e)) GT 0>
    	<cfset instructions = "To save new email addresses to your account, you must first confirm your current credentials.">
    </cfif>
</cfif>