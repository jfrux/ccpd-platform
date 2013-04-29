<cfparam name="Attributes.SSN" default="">
<cfparam name="Attributes.Birthdate" default="">
<cfparam name="Attributes.FirstName" default="">
<cfparam name="Attributes.LastName" default="">
<cfparam name="Attributes.Email" default="">
<cfparam name="Attributes.UCID" default="">
<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.Instance" default="">
<cfparam name="Attributes.Search" default="">
<cfparam name="Attributes.Message" default="">

<cfif Attributes.Search NEQ "" AND Attributes.SSN EQ "" AND Attributes.FirstName EQ "" AND Attributes.LastName EQ "" AND Attributes.Email EQ "" AND Attributes.UCID EQ "" AND Attributes.Birthdate EQ "">
	<cfset Request.Status.Errors = "You must specify search criteria before searching...">
</cfif>

<cfif Request.Status.Errors EQ "">
	<cfif Attributes.Search NEQ "">
        <cfset qPeople = Application.Com.PersonGateway.getBySearch(SSN=Attributes.SSN,Birthdate=Attributes.Birthdate,FirstName=Attributes.FirstName,LastName=Attributes.LastName,UCID=Attributes.UCID,Email=Attributes.Email,DeletedFlag="N",OrderBy="P.LastName,P.FirstName")>
        <cfset PeoplePager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
        <!--- 
        <cfset PeoplePager.setQueryToPaginate(qPeople)>
        <cfset PeoplePager.setBaseLink("#myself##xfa.SearchSubmit#?Instance=#Attributes.Instance#&Search=1&SSN=#Attributes.SSN#&Birthdate=#Attributes.Birthdate#&FirstName=#Attributes.FirstName#&LastName=#Attributes.LastName#&UCID=#Attributes.UCID#&Email=#Attributes.Email#&ActivityID=#Attributes.ActivityID#") />
        <cfset PeoplePager.setItemsPerPage(9) />
        <cfset PeoplePager.setUrlPageIndicator("page") />
        <cfset PeoplePager.setShowNumericLinks(true) />
        <cfset PeoplePager.setClassName("green") />
 --->
        <cfset PeoplePager.setQueryToPaginate(qPeople)>
        <cfset PeoplePager.setMissingNumbersHTML("<span>...</span>")>
        <cfset PeoplePager.setBaseLink("#myself##xfa.SearchSubmit#?Instance=#Attributes.Instance#&Search=1&SSN=#Attributes.SSN#&Birthdate=#Attributes.Birthdate#&FirstName=#Attributes.FirstName#&LastName=#Attributes.LastName#&UCID=#Attributes.UCID#&Email=#Attributes.Email#&ActivityID=#Attributes.ActivityID#") />
        <cfset PeoplePager.setItemsPerPage(7) />
        <cfset PeoplePager.setUrlPageIndicator("page") />
        <cfset PeoplePager.setShowNumericLinks(true) />
        <cfset PeoplePager.setClassName("green span24") />
    <cfelse>
       <!--- <cfset qPeople = Application.Com.PersonGateway.getBySearch(Limit=1000,DeletedFlag="N",OrderBy="P.LastName,P.FirstName")>
        <cfset PeoplePager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
        <cfset PeoplePager.setQueryToPaginate(qPeople)>
        <cfset PeoplePager.setBaseLink("#myself##xfa.SearchSubmit#?Instance=#Attributes.Instance#&ActivityID=#Attributes.ActivityID#") />
        <cfset PeoplePager.setItemsPerPage(9) />
        <cfset PeoplePager.setUrlPageIndicator("page") />
        <cfset PeoplePager.setShowNumericLinks(true) />
        <cfset PeoplePager.setClassName("green") />--->
    </cfif>
</cfif>

<!--- CHECKS IF A PERSON WAS JUST CREATED // CLEARS VARIABLES SO THE SEARCH FIELDS DO NOT FILL IN WITH CREATED PERSON'S INFO | ADDED BY JS 11/19/2010 --->
<cfif Attributes.Message NEQ "">
	<cfset attributes.FirstName = "">
	<cfset attributes.LastName = "">
	<cfset attributes.Birthdate = "">
	<cfset attributes.SSN = "">
	<cfset attributes.Email = "">
</cfif>