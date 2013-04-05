<cfif structKeyExists(variables,'multiformright')>
  <cfoutput>#multiformright#</cfoutput>
</cfif>
<cfif structKeyExists(variables,'multiformcontent')>
  <cfoutput>#multiformcontent#</cfoutput>
</cfif>
<cfif structKeyExists(request.page,'body')>
  <cfoutput>#Request.Page.Body#</cfoutput>
</cfif>