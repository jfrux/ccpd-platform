<cfparam name="Attributes.Column" default="">
<cfparam name="Attributes.Mode" default="">
<cfparam name="Attributes.Items" default="">
<cfoutput>
#Cookie.Settings.PodSort1#<br>
#Cookie.Settings.PodSort2#
</cfoutput>

<cfset ColumnNum = Replace(Attributes.Column,"sort","")>
<cfset Pod = "Cookie.Settings.PodSort#ColumnNum#">
<cfset PodShort = "Settings.PodSort#ColumnNum#">
<cfswitch expression="#Attributes.Mode#">
	<cfcase value="Sort">
		<cfcookie name="Settings.PodSort#ColumnNum#" value="#Attributes.Items#">
	</cfcase>
	<cfcase value="Remove">
		<cfcookie name="Settings.PodSort#ColumnNum#" value="#ListDeleteAt(Pod,ListFind(Pod,Attributes.Items)+1)#">
	</cfcase>
</cfswitch>