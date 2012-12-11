<cfparam name="attributes.id" default="0" />

<cfif len(trim(attributes.id)) GT 0 AND attributes.id GT 0>
    <cfset status = Application.Person.setPrimaryEmail(email_id=attributes.id,person_id=session.personId)>
    
  	<cflocation url="#application.settings.rootPath#/preferences?message=#status.getStatusMsg()#" addtoken="false" />
<cfelse>
  	<cflocation url="#application.settings.rootPath#/preferences?message=More information is required to update the primary email." addtoken="false" />
</cfif>