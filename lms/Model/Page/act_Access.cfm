<!--- act_Access.cfm ---><!---
	<cfinvoke component="#Application.Settings.Com#Page" method="Get" Identifier="#Attributes.Fuseaction#" returnvariable="Request.PageInfo">--->
	
	<cfif NOT isDefined("Session.Person")>
		<cfset Session.Person = CreateObject("component","#Application.Settings.Com#Person.Person").Init()>
	</cfif>
        
	<cfif NOT isDefined("Session.Account")>
        <cfset Session.Account = CreateObject("component", "#Application.Settings.Com#Account.Account").Init()>
    </cfif>
        
	<!---<!--- AUTH CHECK --->
	<cfquery name="qAuthPage" datasource="#Application.Settings.DSN#">
		SELECT COUNT(AP.AuthorityPageID) AS AuthCount
		FROM ce_AuthorityPage AS AP 
		INNER JOIN ce_Page AS P ON AP.PageID = P.PageID
		WHERE (Filename=<cfqueryparam value="#Request.PageInfo.Filename#" cfsqltype="cf_sql_varchar">) AND (AP.AuthorityID = <cfqueryparam value="#Session.Account.getAuthorityID()#" cfsqltype="cf_sql_integer" />)
	</cfquery>
	
	<cfif qAuthPage.AuthCount NEQ 1>
		<cflocation url="#myself#Main.Login&FailMessage=Permission Denied." addtoken="no" />
	</cfif>--->

	<cfif Session.Person.getPersonID() EQ "" AND ListFind(Application.Settings.LoginPages,Attributes.Fuseaction,",") NEQ 0>
		<cflocation url="#myself#Main.Login?FailMessage=You must be logged in to view this page." addtoken="no" />
	</cfif>