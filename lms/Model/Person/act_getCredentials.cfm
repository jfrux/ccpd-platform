<cfparam name="Attributes.PersonID" type="numeric">

<cfset Credentials = Application.Person.getCredentials(Attributes.PersonID)>

<cfset attributes.email = credentials.email>
<cfset attributes.password = credentials.password>