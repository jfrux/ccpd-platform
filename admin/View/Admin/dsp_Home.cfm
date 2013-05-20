<cfscript>
/* create new http service */ 
httpConn = new HTTP(); 
/* set attributes using implicit setters */ 
httpConn.setMethod("post"); 
httpConn.setCharset("utf-8"); 
httpConn.setUrl("http://ccpd.uc.edu:9090/plugins/userService/userservice"); 
/* add httpConnparams using addParam() */
httpConn.addParam(type="formfield",name="secret",value="zmogkdIp");
httpConn.addParam(type="formfield",name="type",value="add");
httpConn.addParam(type="formfield",name="username",value="#session.personid#"); 
httpConn.addParam(type="formfield",name="password",value="#session.person.getPassword()#"); 
httpConn.addParam(type="formfield",name="name",value="#session.person.getDisplayName()#"); 
httpConn.addParam(type="formfield",name="email",value="#session.person.getEmail()#");  
/* make the httpConn call to the URL using send() */ 
result = httpConn.send().getPrefix(); 
/* process the filecontent returned */ 
content = xmlParse(result.filecontent);

if(structKeyExists(content,'error')) {
	error = content.error.xmlText;
	if(error EQ "UserAlreadyExistsException") {
		//update user
	} else {
		writeDump(error);
	}
} else {
	writeDump(content);
}

httpConn = new HTTP();
httpConn.setMethod("post"); 
httpConn.setUrl('http://ccpd.uc.edu:7070/http-bind');
bodyContent = {
			from:'user@example.com',
      hold:'1',
      rid:'1573741820',
      to:'example.com',
      route:'xmpp:example.com:9999',
      secure:'true',
      wait:'60',
      "xml:lang":'en',
      'xmpp:version':'1.0',
      xmlns:'http://jabber.org/protocol/httpbind',
      'xmlns:xmpp':'urn:xmpp:xbosh'
};
httpConn.addParam(type="header",name="content-type", value="text/xml"); 
httpConn.addParam(type="body",value="<body content='text/xml; charset=utf-8'
      from='user@example.com'
      hold='1'
      rid='1573741820'
      to='example.com'
      route='xmpp:example.com:9999'
      secure='true'
      wait='60'
      xml:lang='en'
      xmpp:version='1.0'
      xmlns='http://jabber.org/protocol/httpbind'
      xmlns:xmpp='urn:xmpp:xbosh'/>");

result = httpConn.send().getPrefix();
writeDump(result);
</cfscript>