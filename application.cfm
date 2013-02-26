<cfif cgi.script_name DOES NOT CONTAIN "/lms">
	<cfswitch expression="#cgi.server_name#">
		<cfcase value="v2.ccpd.uc.edu">
			<cflocation url="http://v2.ccpd.uc.edu/lms/" addtoken="no" />
		</cfcase>
		<cfcase value="localhost">
			<cflocation url="http://localhost:8888/lms/" addtoken="no" />
		</cfcase>
<cfcase value="test.ccpd.uc.edu">
			<cflocation url="http://test.ccpd.uc.edu/lms/" addtoken="no" />
		</cfcase>
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