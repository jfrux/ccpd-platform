<cfparam name="attributes.id" default="0" />

<!--- DETERMINE IF AN ID WAS PROVIDED --->
<cfif attributes.id GT 0>
	<cfset status = application.person.deleteEmail(email_id=attributes.id,person_id=session.personId)>
    
  	<cflocation url="#application.settings.rootPath#/preferences?message=#status.getStatusMsg()#" addtoken="false" />
<cfelse>
	<cflocation url="#application.settings.com#/preferences?message=You must choose an email address to delete." addtoken="no" />
</cfif>