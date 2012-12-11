<cfparam name="Session.Person" type="any">
<cfset Application.Auth.doLogout()>
<cflocation url="#myself#Main.Login" addtoken="no">