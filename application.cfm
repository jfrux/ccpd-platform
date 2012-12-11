<cfif cgi.script_name DOES NOT CONTAIN "/lms">
	<cfswitch expression="#cgi.server_name#">
		<cfcase value="ccpd.uc.edu">
			<cflocation url="http://ccpd.uc.edu/lms/" addtoken="no" />
		</cfcase>
		<cfcase value="www.ccpd.uc.edu">
			<cflocation url="http://ccpd.uc.edu/lms/" addtoken="no" />
		</cfcase>
		<cfdefaultcase>
			<cflocation url="http://ccpd.uc.edu/lms/" addtoken="no" />
		</cfdefaultcase>
	</cfswitch>
<cfelseif cgi.server_name CONTAINS "www">
	<cflocation url="http://ccpd.uc.edu/lms" addtoken="no" />
<cfelseif cgi.script_name DOES NOT CONTAIN ".cfc">
	<cflocation url="http://ccpd.uc.edu/lms" addtoken="no" />
</cfif>