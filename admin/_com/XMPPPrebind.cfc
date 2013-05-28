component displayname="XMPPPrebind" accessors="true" {
  property string XMLNS_BODY;
  property string XMLNS_BOSH;
  property string XMLNS_CLIENT;
  property string XMLNS_SESSION;
  property string XMLNS_BIND;
  property string XMLNS_SASL;
  property string XMLNS_VCARD;

  property string XML_LANG;
  property string CONTENT_TYPE;

  property string ENCRYPTION_PLAIN;
  property string ENCRYPTION_DIGEST_MD5;
  property string ENCRYPTION_CRAM_MD5;

  property string SERVICE_NAME;
  
  this.setXMLNS_BODY('http://jabber.org/protocol/httpbind');
  this.setXMLNS_BOSH('urn:xmpp:xbosh');
  this.setXMLNS_CLIENT('jabber:client');
  this.setXMLNS_SESSION('urn:ietf:params:xml:ns:xmpp-session');
  this.setXMLNS_BIND('urn:ietf:params:xml:ns:xmpp-bind');
  this.setXMLNS_SASL('urn:ietf:params:xml:ns:xmpp-sasl');
  this.setXMLNS_VCARD('vcard-temp');
  this.setXML_LANG('en');
  this.setCONTENT_TYPE('text/xml charset=utf-8');
  this.setENCRYPTION_PLAIN('PLAIN');
  this.setENCRYPTION_DIGEST_MD5('DIGEST-MD5');
  this.setENCRYPTION_CRAM_MD5('CRAM-MD5');
  this.setSERVICE_NAME('xmpp');

  /**
   * Create a new XmppPrebind Object with the required params
   *
   * @param string $jabberHost Jabber Server Host
   * @param string $boshUri    Full URI to the http-bind
   * @param string $resource   Resource identifier
   * @param bool   $useSsl     Use SSL (not working yet, TODO)
   * @param bool   $debugEnable debug
  **/
  public XMPPPrebind function init($jabberHost, $boshUri, $resource, $useSsl = false) {
    $this = this;
    $this.jabberHost = arguments.$jabberHost;
    $this.boshUri    = arguments.$boshUri;
    $this.resource   = arguments.$resource;
    $this.useSsl = arguments.$useSsl;
    $this.mechanisms = [];
    /*
     * The client MUST generate a large, random, positive integer for the initial 'rid' (see Security Considerations)
     * and then increment that value by one for each subsequent request. The client MUST take care to choose an
     * initial 'rid' that will never be incremented above 9007199254740991 [21] within the session.
     * In practice, a session would have to be extraordinarily long (or involve the exchange of an extraordinary
     * number of packets) to exceed the defined limit.
     *
     * @link http://xmpp.org/extensions/xep-0124.html#rids
     */

     $this.rid = RandRange(1000000000, 10000000000);
     $log('#chr(10)#==============================#chr(10)#init xmpp-prebind...');
    return $this;
  }

  private function debug($obj,$label) {
    writeDump(var=$obj,label=$label);
  }

  private function $log(text) {
    writeLog(arguments.text,"information", "no","xmpp-prebind")
  }

  /**
   * connect to the jabber server with the supplied username & password
   *
   * @param string $username Username without jabber host
   * @param string $password Password
  **/
  public function connect($username, $password) {
    this.jid      = $username & '@' & this.jabberHost & '/' & this.resource;
    this.password = $password;
    $log('connect > connecting... #arguments.$username# [#this.jid#]');
    $response = this.sendInitialConnection();
    $log('connect > response received.');
    
    $documentObj = XmlParse($response);
    $log('connect > parsed response.');
    this.sid = $documentObj.XmlRoot.XmlAttributes['sid'];
    $log('connect > sid detected: #this.sid#');
    this.debug(this.sid, 'sid');
    
    $mechanisms = $documentObj.XmlChildren[1].XmlChildren[1].XmlChildren[1];
    for ($value in $mechanisms.XmlChildren) {
      this.mechanisms.add($value.XmlText);
    }
    if (arrayFindNoCase(this.mechanisms,this.getENCRYPTION_DIGEST_MD5())) {
      this.encryption = this.getENCRYPTION_DIGEST_MD5();
    } elseif (arrayFindNoCase(this.mechanisms,this.getENCRYPTION_CRAM_MD5())) {
      this.encryption = this.getENCRYPTION_CRAM_MD5();
    } elseif (arrayFindNoCase(this.mechanisms,this.getENCRYPTION_PLAIN())) {
      this.encryption = this.getENCRYPTION_PLAIN();
    } else {
      throw "No encryption supported by the server is supported by this library.";
    }
    this.encryption = this.getENCRYPTION_DIGEST_MD5();
    //this.encryption = "ENCRYPTION_PLAIN";
    $log('connect > encryption set: #this.encryption#');
    //this.debug(this.encryption, 'encryption used');
  }

  /**
   * Try to authenticate
   *
   * @throws XmppPrebindException if invalid login
   * @return bool
   */
  public function auth() {
    $auth = createObject("component","lib.auth_sasl.#lcase(replace(this.encryption,'-','','ALL'))#");
    $log('auth > #this.encryption#');
    
    switch (this.encryption) {
      case ENCRYPTION_PLAIN:
        $authXml = this.buildPlainAuth($auth);
        $log('auth > #this.encryption# XML #$authXml#');
    
        break;
      case ENCRYPTION_DIGEST_MD5:
        $authXml = this.sendChallengeAndBuildDigestMd5Auth($auth);
        $log('auth > #this.encryption# XML #$authXml#');
    
        break;
      case ENCRYPTION_CRAM_MD5:
        $authXml = this.sendChallengeAndBuildCramMd5Auth($auth);
        $log('auth > #this.encryption# XML #$authXml#');
    
        break;
    }
    $log('auth > sending authXml to host...');
    
    $response = this.send($authXml);

    $log('auth > response received.');
    $body = getBodyFromXml($response);

    $log('auth > body parsed from response.');
    writeDump(var=$body);
    if (arrayLen($body.XmlChildren) GT 0 || $body.XmlChildren[1].name NEQ 'success') {
      $log('auth > authentication failed. invalid login.');
    
      throw "Invalid login";
      abort;
    }

    this.sendRestart();
    this.sendBindIfRequired();
    this.sendSessionIfRequired();

    return true;
  }

  /**
   * Get jid, sid and rid for attaching
   *
   * @return array
   */
  public struct function getSessionInfo() {
    return {'jid': this.jid, 'sid': this.sid, 'rid': this.rid };
  }

  /**
   * Send xmpp restart message after successful auth
   *
   * @return string Response
   */
  private function sendRestart() {
    var $domDocument = this.buildBody();
    var $body = $domDocument.XmlRoot;
    $log('sendRestart > built body dom document.');
    
    $body.XmlAttributes['to'] = this.jabberHost;
    $body.XmlAttributes['xmlns:xmpp'] = this.getXMLNS_BOSH();
    $body.XmlAttributes['xmpp:restart'] = true;

    $restartResponse = this.send(ToString($domDocument));

    $restartBody = getBodyFromXml($restartResponse);
    for ($bodyChildNodes in $restartBody.childNodes) {
      if ($bodyChildNodes.nodeName === 'stream:features') {
        for ($streamFeatures in $bodyChildNodes.childNodes) {
          if ($streamFeatures.nodeName === 'bind') {
            this.doBind = true;
          } elseif ($streamFeatures.nodeName === 'session') {
            this.doSession = true;
          }
        }
      }
    }

    return $restartResponse;
  }

  /**
   * Send xmpp bind message after restart
   *
   * @return string Response
   */
  private function sendBindIfRequired() {
    if (this.doBind) {
      $domDocument = this.buildBody();
      $body = getBodyFromDomDocument($domDocument);
      $iq = $body['iq'] = XmlElemNew($domDocument,'iq');
      
      $iq.XmlAttributes['xmlns'] = getXMLNS_CLIENT();
      $iq.XmlAttributes['type'] = 'set';
      $iq.XmlAttributes['id'] = 'bind_' & rand();
      
      $bind = $iq['bind'] = XmlElemNew($domDocument,'bind');
      $bind.XmlAttributes['xmlns'] = getXMLNS_BIND();

      $resource = $bind['resource'] = XmlElemNew($domDocument,'resource');
      $resource.XmlText = this.resource;

      return this.send(ToString($domDocument));
    }
    return false;
  }

  /**
   * Send session if there's a session node in the restart response (within stream:features)
   */
  private function sendSessionIfRequired() {
    if (this.doSession) {
      $domDocument = this.buildBody();
      $body = getBodyFromDomDocument($domDocument);

      $body['iq'] = XmlElemNew($domDocument,'iq');
      
      $body['iq'].XmlAttributes['xmlns'] = getXMLNS_CLIENT();
      $body['iq'].XmlAttributes['type'] = 'set';
      $body['iq'].XmlAttributes['id'] = 'session_auth_' & rand();
      
      $session = $iq['session'] = XmlElemNew($domDocument,'session');
      $session.XmlAttributes['xmlns'] = getXMLNS_SESSION();

      return this.send(ToString($domDocument));
    }

    return false;
  }

  /**
   * Send initial connection string
   *
   * @return string Response
   */
  private function sendInitialConnection() {
    $domDocument = this.buildBody();
    $body = $domDocument.body;

    $waitTime = 60;
    $domDocument.XmlRoot.XmlAttributes['hold'] = "1";
    $domDocument.XmlRoot.XmlAttributes['to'] = this.jabberHost;
    $domDocument.XmlRoot.XmlAttributes['xmlns:xmpp'] = this.getXMLNS_BOSH();
    $domDocument.XmlRoot.XmlAttributes['xmpp:version'] = '1.0';
    $domDocument.XmlRoot.XmlAttributes['wait'] = $waitTime;

    return this.send(ToString($domDocument));
  }

  /**
   * Send challenge request
   *
   * @return string Challenge
   */
  private function sendChallenge() {
    $domDocument = this.buildBody();
    $body = $domDocument.XmlRoot;
    $log('sendChallenge > sending challenge...');
    $auth = $body['auth'] = XmlElemNew($domDocument,'auth');
    $auth.XmlAttributes['xmlns'] = this.getXMLNS_SASL();
    $auth.XmlAttributes['mechanism'] = this.encryption;
    
    $response = this.send(ToString($domDocument));
    $log('sendChallenge > response RECV: #$response#');
    $body = XmlParse($response).XmlRoot;
    
    $challenge = ToString(ToBinary($body.XmlChildren[1].XmlText));
    $log('sendChallenge > decode challenge: #$challenge#');
    
    return $challenge;
  }

  /**
   * Build PLAIN auth string
   *
   * @param Auth_SASL_Common $auth
   * @return string Auth XML to send
   */
  private function buildPlainAuth($auth) {
    $authString = $auth.getResponse(getNodeFromJid(this.jid), this.password, getBareJidFromJid(this.jid));
    $authString = toBase64($authString);
    this.debug($authString, 'PLAIN Auth String');

    $domDocument = this.buildBody();
    $body = $domDocument.XmlRoot;

    $auth = $body['auth'] = XmlElemNew($domDocument,'auth');
    $auth.XmlAttributes['xmlns'] = this.getXMLNS_SASL();
    $auth.XmlAttributes['mechanism'] = this.getENCRYPTION_PLAIN();
    $auth.XmlText = $authString;
    
    return ToString($domDocument);
  }

  /**
   * Send challenge request and build DIGEST-MD5 auth string
   *
   * @param Auth_SASL_Common $auth
   * @return string Auth XML to send
   */
  private function sendChallengeAndBuildDigestMd5Auth($auth) {
    $log('buildDigestMD5Auth > sending challenge ##1');
    
    $challenge = this.sendChallenge();
    $log('buildDigestMD5Auth > challenge ##1 response: #$challenge#');
    $authString = $auth.getResponse(getNodeFromJid(this.jid), this.password, $challenge, this.jabberHost, getSERVICE_NAME(), this.jid);
    $log('buildDigestMD5Auth > authString: #$authString#');
    $authString = toBase64($authString);
    $log('buildDigestMD5Auth > Converted to base64: #$authString#');
    
    $domDocument = this.buildBody();
    $body = getBodyFromDomDocument($domDocument);

    $response = $body['response'] = XmlElemNew($domDocument,'response');
    $response.XmlAttributes['xmlns'] = getXMLNS_SASL();
    $response.XmlText = $authString
    $responseXml = ToString($domDocument);
    $log('buildDigestMD5Auth > sending challenge ##2 - SEND: #$responseXml#');
    $challengeResponse = this.send($responseXml);
    $log('buildDigestMD5Auth > received challenge response ##2 - RECV: #$challengeResponse#');

    $log('buildDigestMD5Auth > sending challenge ##3 - SEND: #$challengeResponse#')
    $challengeResponse3 = this.replyToChallengeResponse($challengeResponse);
    $log('buildDigestMD5Auth > received challenge response ##3 - SEND: #$challengeResponse3#')
    return $challengeResponse3
  }

  /**
   * Send challenge request and build CRAM-MD5 auth string
   *
   * @param Auth_SASL_Common $auth
   * @return string Auth XML to send
   */
  private function sendChallengeAndBuildCramMd5Auth($auth) {
    $challenge = this.sendChallenge();

    $authString = $auth.getResponse(getNodeFromJid(this.jid), this.password, $challenge);
    this.debug($authString, 'CRAM-MD5 Auth String');

    $authString = toBase64($authString);

    $domDocument = this.buildBody();
    $body = getBodyFromDomDocument($domDocument);

    $response = $body['response'] = XmlElemNew($domDocument,'response');
    $response.XmlAttributes['xmlns'] = getXMLNS_SASL();
    $response.XmlText = $authString;

    $challengeResponse = this.send(ToString($domDocument));

    return this.replyToChallengeResponse($challengeResponse);
  }

  /**
   * CRAM-MD5 and DIGEST-MD5 reply with an additional challenge response which must be replied to.
   * After this additional reply, the server should reply with "success".
   */
  private function replyToChallengeResponse($challengeResponse) {
    $body = getBodyFromXml($challengeResponse);
    $log('replyToChallengeResponse > decoding response: #$body.XmlChildren[1]#');
    $challenge = ToString(BinaryDecode($body.XmlChildren[1], "base64"));
    $log('replyToChallengeResponse > decoded response: #$challenge#');
    if (!findNoCase($challenge, 'rspauth')) {
      throw 'Invalid challenge response received';
    }

    $domDocument = this.buildBody();
    $body = getBodyFromDomDocument($domDocument);
    $response = $domDocument.createElement('response');
    $response.appendChild(getNewTextAttribute($domDocument, 'xmlns', XMLNS_SASL));

    $body.appendChild($response);

    return $domDocument.saveXML();
  }

  /**
   * Send XML via CURL
   *
   * @param string $xml
   * @return string Response
   */
  private function send($xml) {
    var $ch = new HTTP();
    var $response = {};
    
    $ch.setUrl(this.boshUri);
    $ch.setMethod("POST");
    $ch.setRedirect(true);
    
    $log('send > new HTTP connection... #this.boshUri# [POST] redirects:true');
    $xml = REReplace($xml, "<\?xml[^>]*>", "", "one" )
    $ch.addParam(type='body',value=$xml);
    $ch.addParam(type='header',name="content-type",value='text/xml');
    
    $log('send > sending HTTP connecting...');
    $log('send > SEND: #$xml#...');
    
    $response = $ch.send().getPrefix();
    $log('send > response received...');
    $log('send > RECV: #$response.filecontent#...');

    return $response.filecontent;
  }

  /**
   * Build DOMDocument with standard xmpp body child node.
   *
   * @return DOMDocument
   */
  private function buildBody() {
    $xml = XmlNew();

    $xml.xmlRoot = XmlElemNew($xml,"body")
    
    $xml.body.XmlAttributes['xmlns'] = this.getXMLNS_BODY();
    $xml.body.XmlAttributes['content'] = this.getCONTENT_TYPE()
    $xml.body.XmlAttributes['rid'] = getAndIncrementRid()
    $xml.body.XmlAttributes['xml:lang'] = this.getXML_LANG();

    if (structKeyExists(this,'sid') AND this.sid NEQ '') {
      $xml.body.XmlAttributes['sid'] = this.sid;
    }

    return $xml;
  }

  /**
   * Get jid in form of username@jabberHost
   *
   * @param string $jid Jid in form username@jabberHost/Resource
   * @return string JID
   */
  public function getBareJidFromJid($jid) {
    if ($jid == '') {
      return '';
    }
    $splittedJid = listFirst($jid,'/');
    return $splittedJid;
  }

  /**
   * Get node (username) from jid
   *
   * @param string $jid
   * @return string Node
   */
  public function getNodeFromJid($jid) {
    var $node = listFirst(arguments.$jid,'@');
    $log('getNodeFromJid > parsed "#$node#"')
    return $node;
  }

  /**
   * Get body node from DOMDocument
   *
   * @param DOMDocument $domDocument
   * @return DOMNode
   */
  private function getBodyFromDomDocument($domDocument) {
    return arguments.$domDocument.body;
  }

  /**
   * Parse XML and return DOMNode of the body
   *
   * @uses XmppPrebind.getBodyFromDomDocument()
   * @param string $xml
   * @return DOMNode
   */
  private function getBodyFromXml($xml) {
    var $domDocument = xmlParse(arguments.$xml);

    return $domDocument.XmlRoot;
  }

  private function NodeCount (xmlElement, nodeName)
  {
    nodesFound = 0;
    for (i = 1; i LTE ArrayLen(xmlElement.XmlChildren); i = i+1)
    {
        if (xmlElement.XmlChildren[i].XmlName IS nodeName)
            nodesFound = nodesFound + 1;
    }
    return nodesFound;
  }

  /**
   * Get the rid and increment it by one.
   * Required by RFC
   *
   * @return int
   */
  private function getAndIncrementRid() {
    return this.rid++;
  }
}