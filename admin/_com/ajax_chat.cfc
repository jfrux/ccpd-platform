<cfcomponent extends="ajax">
  <cffunction name="xmpp-auth" access="remote" output="no" returntype="string" returnformat="plain">
    <cfscript>
    xmpp = createObject("component","admin._com.XMPPPrebind").init(
          $jabberHost="localhost", 
          $boshUri="http://localhost:8888/http-bind", 
          $resource="ccpd-web");
    xmpp.connect(session.personid,session.person.getPassword());
    xmpp.auth();
    sessionInfo = xmpp.getSessionInfo();
    return serializeJson(sessionInfo);
    </cfscript>
    <cfcontent type="application/json" />
    <cfreturn true />
  </cffunction>
</cfcomponent>