<!--- <cffunction name="setCookie" access="public" returnType="void" output="false">
    <cfargument name="name" type="string" required="true">
    <cfargument name="value" type="string" required="false">
    <cfargument name="expires" type="any" required="false">
    <cfargument name="domain" type="string" required="false">
    <cfargument name="httpOnly" type="boolean" required="false">
    <cfargument name="path" type="string" required="false">
    <cfargument name="secure" type="boolean" required="false">
    <cfset var args = {}>
    <cfset var arg = "">
    <cfloop item="arg" collection="#arguments#">
        <cfif not isNull(arguments[arg])>
            <cfset args[arg] = arguments[arg]>
        </cfif>
    </cfloop>

    <cfcookie attributecollection="#args#">
</cffunction> --->
<cfscript>
xmpp = createObject("component","admin._com.XMPPPrebind").init(
      $jabberHost="ccpd.uc.edu", 
      $boshUri="http://localhost:8888/http-bind/", 
      $resource="ccpd-web");
xmpp.connect('admin','cfr010408');
// rid = randRange(100000000,1000000000);
// libprefix = "org.jivesoftware.smack."
// loader = application.javaloader;

// // xmpp = loader.create("edu.uc.ccpd.XMPP");
// //writeDump(xmpp.connect('admin','cfr010408').getRegisterSASLMechanisms()[2].SASLDigestMD5Mechanism);
// //create Bosh configuration
// config = loader.create("#libPrefix#BOSHConfiguration").init("ccpd.uc.edu");

// //create a connection
// connection = loader.create("#libPrefix#BOSHConnection").init(config);
// connection.connect();
// connection.login('admin', "cfr010408", "");

// writeDump(connection);
// setCookie('xmpp_sid',connection.getSessionID(),createTimeSpan(0,60,0,0),'localhost',false,'/admin/event/');
// setCookie('xmpp_user','admin',createTimeSpan(0,60,0,0),'localhost',false,'/admin/event/');
</cfscript>

// <script>
// // connection = new Strophe.Connection('http://localhost:8888/http-bind/');
// // connection.attach('admin', connection.getSessionID(), rid, function() {
// //       console.log(arguments);
// // });
// </script>