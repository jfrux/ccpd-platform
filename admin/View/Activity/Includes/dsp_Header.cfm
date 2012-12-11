
<cfoutput>

	<!--- Reset buffer and set content type. --->
	<cfcontent
		type="text/html"
		reset="true"
		/>

		<!-- Linked files. -->
		<script type="text/javascript" src="./linked/global.js"></script>
		<link rel="stylesheet" type="text/css" href="#Application.Settings.RootPath#/_styles/calendar.css"></link>
</cfoutput>