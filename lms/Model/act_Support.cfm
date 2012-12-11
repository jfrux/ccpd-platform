<cfparam name="Attributes.Submitted" default="0" />
<cfparam name="Attributes.FirstName" default="" />
<cfparam name="Attributes.LastName" default="" />
<cfparam name="Attributes.Email1" default="" />
<cfparam name="Attributes.Email2" default="" />
<cfparam name="Attributes.EmailSubject" default="" />
<cfparam name="Attributes.EmailBody" default="" />
<cfparam name="Attributes.supporttype" default="LMS" />
<cfparam name="Attributes.image_file" default="LMS" />
<cfparam name="Attributes.display" default="Default" />

<cfif Attributes.Submitted EQ 1>
	<!--- FORM VAILDATION --->
	
	<!---<cfif Attributes.FirstName EQ "">
    	<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter your First Name.","|")>
    </cfif>
	<cfif Attributes.LastName EQ "">
    	<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter your Last Name.","|")>
    </cfif>
	<cfif Attributes.Email1 EQ "" OR NOT isEmail(Attributes.Email1)>
    	<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter a valid Email Address.","|")>
	<cfelseif Attributes.Email2 EQ "">
    	<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please confirm your Email Address.","|")>
    <cfelseif Attributes.Email1 NEQ Attributes.Email2>
    	<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Your email addresses do not match.","|")>
    </cfif>
	<cfif Attributes.EmailBody EQ "">
    	<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Please enter your Email Message.","|")>
    </cfif>--->
    
    <!--- SEND EMAIL --->
    <cfif Request.Status.Errors EQ "">
    	<cfmail	to="ccpd_support@swodev.com"
        		from="#Attributes.Email1#"
                subject="[#Attributes.supporttype#] #attributes.emailsubject#"
                type="html">
        	#Attributes.EmailBody#
            <cfif isDefined("Session.Person") AND Session.Person.getPersonID() NEQ "">
            	<p>
                	PersonID: #Session.Person.getPersonID()#<br />
                	Name: #Session.Person.getFirstName()# #Session.Person.getLastName()#
                </p>
            <cfelse>
            	<p>
                	Name: #Attributes.FirstName# #Attributes.LastName#
                </p>
            </cfif>
			
			<cfsilent>
				<cfset imagepath = "#expandPath('/_uploads/images/')#" />
				<cfif len(attributes.image_file) GT 0 AND FileExists(imagepath & attributes.image_file)>
				<cfmailparam file="#imagepath & attributes.image_file#">
				</cfif>
		   </cfsilent>
		

        </cfmail>
        
        <!--- REFRESH PAGE --->
        <cflocation url="#Myself#main.support?Message=Your support message has been sent!&display=#attributes.display#" addtoken="no" />
    </cfif>
</cfif>

<cfscript>
function isEmail(str) {
	return (REFindNoCase("^['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|asia|biz|cat|coop|info|museum|name|jobs|post|pro|tel|travel|mobi))$",
	arguments.str) AND len(listGetAt(arguments.str, 1, "@")) LTE 64 AND
	len(listGetAt(arguments.str, 2, "@")) LTE 255) IS 1;
}
</cfscript>