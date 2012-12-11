<cfparam name="Attributes.Submitted" default="" />
<cfparam name="Attributes.Specialties" default="" />
<cfparam name="Attributes.Degree" default="" />
<cfparam name="Attributes.EmailSpecialty" default="N" />
<cfparam name="Attributes.Email" default="">
<cfparam name="Attributes.ConEmail" default="">
<cfparam name="Attributes.Password" default="">
<cfparam name="Attributes.ConPassword" default="">
<cfparam name="attributes.emailErrors" default="">

<cfset PersonSpecialties = Attributes.Specialties>

<cfif Attributes.Submitted NEQ "">
	<!--- PERSON PREFERENCES --->
	<cfset PersonPrefs = CreateObject("component","#Application.Settings.Com#PersonPref.PersonPref").init(PersonID=Session.PersonID)>
    <cfset personPrefsExist = application.com.personPrefDAO.exists(personPrefs)>
    
    <cfif personPrefsExist>
    	<cfset personPrefs = application.com.personPrefDAO.read(personPrefs)>
    </cfif>
    
	<cfset PersonPrefs.setEmailSpecialtyFlag(Attributes.EmailSpecialty)>
	<cfset Application.Com.PersonPrefDAO.Save(PersonPrefs)>
	
	<!--- SPECIALTY INTERESTS --->
	<cfset SpecialtiesSaved = Application.Person.saveSpecialties(Session.PersonID, Attributes.Specialties)>
	
	<!--- DEGREES --->
    <cfif attributes.degree NEQ "">
		<cfset DegreeSaved = Application.Person.saveDegree(Session.PersonID, Attributes.Degree)>
    </cfif>
    
    <!--- CREDENTIALS --->
    <cfif Attributes.Password NEQ "">
    	<cfset CredentialsSaved = Application.Person.saveCredentials(
										PersonID=Session.PersonID,
										Pass=Attributes.Password,
										ConPass=Attributes.Conpassword)>
    </cfif>
	
    <!--- EMAILS --->
    <cfif structKeyExists(attributes, "emailaddress0") AND len(trim(attributes.emailAddress0)) GT 0>
    	<cflocation url="#application.settings.rootPath#/event/member.confirm?e=#attributes.emailaddress0#" addtoken="false">
    </cfif>
    
	<cflocation url="#myself#Member.Account?Message=Preferences Saved!" addtoken="no" />
</cfif>