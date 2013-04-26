<cfparam name="Attributes.Email" type="string" default="">
<cfparam name="Attributes.Password" type="string" default="">
<cfparam name="Attributes.RememberMe" type="string" default="">
<cfparam name="Attributes.freshdesk" default="0">
<cfparam name="LoggedIn" type="boolean" default="false" />
<!--- CHECK IF CLIENT.LOGIN EXISTS // REMEMBER ME FUNCTIONALITY
04/14/2010
TO DO: NEEDS UPDATED FOR NEW CE_PERSON TABLE LOGIN --->
<!--- function freshdesk_login_url($name, $email) {
$secret = '____Place your Single Sign On Shared Secret here_____';
$base = 'http://mycompany.freshdesk.me/';
 
return $base . "login/sso/?name=" . urlencode($name) . "&email=" . urlencode($email) . "&hash=" . hash('md5', $name . $email . $secret);
} --->

<cfscript>
function freshdesk_login_url($name, $email) {
  $secret = '900ff970b55c5b63cd468de4a7e798a5';
  $base = 'http://uccme.freshdesk.com/';
   
  return $base & "login/sso/?name=" & urlencode($name) & "&email=" & urlencode($email) & "&hash=" & lcase(hash($name & $email & $secret, 'MD5'));
}
</cfscript>


<cfif isDefined("Client.Login") AND Client.Login NEQ "">
	<cfset LoggedIn = Application.Auth.doLogin(PersonID=Client.Login)>
<cfelseif Attributes.Email NEQ "" OR Attributes.Password NEQ "">
	<cfset LoggedIn = Application.Auth.doLogin(Email=Attributes.Email, Password=Attributes.Password, RememberMe=Attributes.RememberMe)>
</cfif>

<cfif LoggedIn>
	<cfif isDefined("client.lastActivity") AND client.lastActivity NEQ 0>
		<cflocation url="/activity/#client.lastActivity#" addtoken="no">
  <cfelseif attributes.freshdesk EQ 1>
    <cflocation url="#freshdesk_login_url('#session.person.getCertName()#','#session.person.getEmail()#')#" addtoken="no">
    <cfdump var="#freshdesk_login_url('#session.person.getCertName()#','#session.person.getEmail()#')#" abort=true />
  <cfelse>
    <cfdump var="#Cookie#" />
		<cflocation url="/" addtoken="no">
  </cfif>
<cfelseif NOT LoggedIn>
	<cflocation url="#myself#Main.Login?freshdesk=#attributes.freshdesk#&FailMessage=Authentication failed.  If this is your first time logging in, please make sure you have verified your email address via the verification email you received." addtoken="no" />
<cfelse>
	<cflocation url="#myself#Main.Login" addtoken="no" />
</cfif>