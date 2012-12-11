<cfset PersonPrefs = CreateObject("component","#Application.Settings.Com#PersonPref.PersonPref").init(PersonID=Session.PersonID)>
<cfif Application.Com.PersonPrefDAO.Exists(PersonPrefs)>
	<cfset PersonPrefs = Application.Com.PersonPrefDAO.Read(PersonPrefs)>
	
	<cfset Attributes.EmailSpecialty = PersonPrefs.getEmailSpecialtyFlag()>
</cfif>
