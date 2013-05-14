<cfparam name="attributes.ssn" default="">
<cfparam name="attributes.birthdate" default="">
<cfparam name="attributes.q" default="">
<cfparam name="attributes.firstname" default="">
<cfparam name="attributes.lastname" default="">
<cfparam name="attributes.email" default="">
<cfparam name="attributes.ucid" default="">
<cfparam name="attributes.activityid" default="">
<cfparam name="attributes.instance" default="">
<cfparam name="attributes.search" default="">
<cfparam name="attributes.message" default="">

<cfif attributes.search NEQ "" AND attributes.ssn EQ "" AND attributes.firstname EQ "" AND attributes.lastname EQ "" AND attributes.email EQ "" AND attributes.ucid EQ "" AND attributes.birthdate EQ "">
	<cfset Request.Status.Errors = "You must specify search criteria before searching...">
</cfif>

<cfif Request.Status.Errors EQ "">
	<cfif attributes.search NEQ "">
        <cfset qPeople = Application.Com.PersonGateway.getBysearch(ssn=attributes.ssn,birthdate=attributes.birthdate,firstname=attributes.firstname,lastname=attributes.lastname,ucid=attributes.ucid,email=attributes.email,DeletedFlag="N",OrderBy="P.lastname,P.firstname")>
        <cfset PeoplePager = CreateObject("component","#Application.Settings.Com#Pagination").init()>
        <cfset PeoplePager.setQueryToPaginate(qPeople)>
        <cfset PeoplePager.setMissingNumbersHTML("<span>...</span>")>
        <cfset PeoplePager.setBaseLink("#myself##xfa.searchSubmit#?instance=#attributes.instance#&search=1&ssn=#attributes.ssn#&birthdate=#attributes.birthdate#&firstname=#attributes.firstname#&lastname=#attributes.lastname#&ucid=#attributes.ucid#&email=#attributes.email#&activityid=#attributes.activityid#") />
        <cfset PeoplePager.setItemsPerPage(7) />
        <cfset PeoplePager.setUrlPageIndicator("page") />
        <cfset PeoplePager.setShowNumericLinks(true) />
        <cfset PeoplePager.setClassName("green span24") />
    </cfif>
</cfif>

<!--- CHECKS IF A PERSON WAS JUST CREATED // CLEARS VARIABLES SO THE SEARCH FIELDS DO NOT FILL IN WITH CREATED PERSON'S INFO | ADDED BY JS 11/19/2010 --->
<cfif attributes.message NEQ "">
	<cfset attributes.firstname = "">
	<cfset attributes.lastname = "">
	<cfset attributes.birthdate = "">
	<cfset attributes.ssn = "">
	<cfset attributes.email = "">
</cfif>