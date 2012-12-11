<cfcomponent displayname="Preference Ajax">
	<cffunction name="HideWelcome" access="remote" output="no">
		<cfcookie name="Pref.HideWelcome" value="true" />
		
		<cfreturn "success" />
	</cffunction>
</cfcomponent>