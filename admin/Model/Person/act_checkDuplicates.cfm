<cfparam name="Attributes.FirstName" default="">
<cfparam name="Attributes.LastName" default="">
<cfparam name="Attributes.Mode" default="Default">

<cfdump var="#attributes#"><cfabort>
<cfif IsDefined("Attributes.CheckDuplicates")>
	
</cfif>