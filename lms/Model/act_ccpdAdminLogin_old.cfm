<cfparam name="Attributes.Username" type="string" default="">
<cfparam name="Attributes.Password" type="string" default="">
<cfparam name="Attributes.RememberMe" type="string" default="">

<!--- CHECK IF CLIENT.LOGIN EXISTS // REMEMBER ME FUNCTIONALITY --->
<cfif isDefined("Client.Login") AND Client.Login NEQ "">
	<cfquery name="qClientLogin" datasource="#Application.Settings.DSN#">
		SELECT Username, Password
		FROM cs_User
		WHERE PersonID = #Client.Login#
	</cfquery>
    
    <cfset Attributes.Username = qClientLogin.Username>
    <cfset Attributes.Password = qClientLogin.Password>
</cfif>

<cfif Attributes.Username NEQ "" AND Attributes.Password NEQ "">
	<cfquery name="qCheckUser" datasource="#Application.Settings.DSN#">
		SELECT A.AccountID, A.PersonID
		FROM 
			ce_Account AS A INNER JOIN
			dbo.cs_user AS U ON A.PersonID = U.personid
		WHERE   U.username=<cfqueryparam value="#Attributes.Username#" cfsqltype="cf_sql_varchar" /> AND 
				U.password=<cfqueryparam value="#Attributes.Password#" cfsqltype="cf_sql_varchar" />
	</cfquery>
	
	<cfif qCheckUser.RecordCount EQ 1>
		<cfset Session.LoggedIn = true>
		<cfset Session.Account.setAccountID(qCheckUser.AccountID)>
		<cfset Session.Account = Application.Com.AccountDAO.Read(Session.Account)>
		<cfset Session.Person.setPersonID(qCheckUser.PersonID)>
		<cfset Session.Person = Application.Com.PersonDAO.Read(Session.Person)>
		<cfcookie name="Person.FirstName" value="#Session.Person.getFirstName()#">
		<cfcookie name="Account.Username" value="#Attributes.Username#">
        
        <!--- CHECK IF REMEMBER ME CHECKBOX WAS CHECKED --->
        <cfif Attributes.RememberMe NEQ "">
        	<!--- CREATE CLIENT.LOGIN --->
        	<cfset Client.Login = qCheckUser.PersonID>
        </cfif>
        
		<cflocation url="#Cookie.Settings.LastPage#" addtoken="no" />
	<cfelse>
		<cflocation url="#myself#Main.Login?FailMessage=Authentication failed." addtoken="no" />
	</cfif>
<cfelse>
	<cflocation url="#myself#Main.Login?FailMessage=Authentication failed." addtoken="no" />
</cfif>