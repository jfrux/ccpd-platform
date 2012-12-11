<!--- act_Access.cfm --->
<!--- ADDED A COMMENT FOR A FILE REFRESH --->
<cfsetting showdebugoutput="no" />	

    <cfif getToken(Attributes.Fuseaction,1,".") NEQ "Public">
        <!---<cfinvoke component="#Application.Settings.Com#Page" method="Get" Identifier="#Attributes.Fuseaction#" returnvariable="Request.PageInfo">--->
        
        <!--- Create Account Bean --->
        <cfif NOT isDefined("Session.Account")>
            <cfset Session.Account = CreateObject("component","#Application.Settings.Com#Account.Account").Init(AuthorityID=4)>
        </cfif>
        
        <cfif NOT isDefined("Session.Person")>
            <cfset Session.Person = CreateObject("component","#Application.Settings.Com#Person.Person").Init()>
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
		
		<cfif Session.Person.getPersonID() EQ "" AND Attributes.Fuseaction NEQ "Main.Login" AND Attributes.Fuseaction NEQ "Main.doLogin" AND Attributes.Fuseaction NEQ "File.ScanUpload" AND CGI.SCRIPT_NAME DOES NOT CONTAIN "API.cfc" AND CGI.SCRIPT_NAME DOES NOT CONTAIN "dailyReport.cfc">
			<cfif NOT request.isException>
			<cflocation url="#myself#Main.Login&FailMessage=Permission Denied." addtoken="no" />
			</cfif>
		<cfelseif NOT ListFind("1,2,3",Session.Account.getAuthorityID(),',') AND Attributes.Fuseaction NEQ "Main.Login" AND Attributes.Fuseaction NEQ "Main.doLogin" AND Attributes.Fuseaction NEQ "File.ScanUpload" AND CGI.SCRIPT_NAME DOES NOT CONTAIN "API.cfc" AND CGI.SCRIPT_NAME DOES NOT CONTAIN "dailyReport.cfc">
			<cfif NOT request.isException>
			<cflocation url="#myself#Main.Login&FailMessage=Permission Denied." addtoken="no" />
			</cfif>
		</cfif>
	</cfif>