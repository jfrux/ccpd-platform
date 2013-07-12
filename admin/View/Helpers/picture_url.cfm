<cffunction name="pictureUrl" output="false">
  <cfargument name="hash" default="" />
  <cfargument name="size" default="" />
  <cfset var result = "" />

  <cfset var baseUrl = "/public/system/photos" />

  <cfset result &= baseUrl />
  <cfset result &= "/" & hash & "_" & size />
  <cfset result &= ".jpg" />

  <cfreturn result />
</cffunction>