<cfcontent type="text/javascript" />
<cfset sessionExpires = dateAdd("n",180,now()) />
<cfset returnStruct = {
  loggedIn: false,
  userId: 0,
  expires: #sessionExpires#
} />

<cfif session.loggedIn>
  <cfset returnStruct['loggedIn'] = true />
  <cfset returnStruct['userId'] = session.person.getpersonid() />
  <cfset returnStruct.expires = #sessionExpires# />
</cfif>

<cfoutput>#createObject("component","_com.returnData.buildStruct").jsonencode(returnStruct)#</cfoutput>
