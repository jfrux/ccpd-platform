/**
* Implmentation of DIGEST-MD5 SASL mechanism
*
* @author  Richard Heyes <richard@php.net>
* @access  public
* @version 1.0
* @package Auth_SASL
*/
component extends="base" {
  public function init() {
    variables.util = createObject("java","com.sun.security.sasl.digest.DigestMD5Base")
  }
  /**
  * Provides the (main) client response for DIGEST-MD5
  * requires a few extra parameters than the other
  * mechanisms, which are unavoidable.
  * 
  * @param  string $authcid   Authentication id (username)
  * @param  string $pass      Password
  * @param  string $challenge The digest challenge sent by the server
  * @param  string $hostname  The hostname of the machine you're connecting to
  * @param  string $service   The servicename (eg. imap, pop, acap etc)
  * @param  string $authzid   Authorization id (username to proxy as)
  * @return string            The digest response (NOT base64 encoded)
  * @access public
  */
  public function getResponse($authcid, $pass, $challenge, $hostname, $service, $authzid = '')
  {
    $challenge = _parseChallenge($challenge);
    $authzid_string = '';
    if ($authzid != '') {
      $authzid_string = ',authzid="' & $authzid & '"'; 
    }

    if (!isEmpty($challenge)) {
      $cnonce         = _getCnonce();
      $digest_uri     = sprintf('%s/%s',[arguments.$service, arguments.$hostname]);
      $response_value = _getResponseValue($authcid, $pass, $challenge['realm'], $challenge['nonce'], $cnonce, $digest_uri, $authzid);

      if (structKeyExists($challenge,'realm')) {
        return sprintf('username="%s",realm="%s"' & $authzid_string &
',nonce="%s",cnonce="%s",nc=00000001,qop=auth,digest-uri="%s",response=%s,maxbuf=%s', [$authcid, $challenge['realm'], $challenge['nonce'], $cnonce, $digest_uri, $response_value, $challenge['maxbuf']]);
      } else {
        return sprintf('username="%s"' & $authzid_string  & ',nonce="%s",cnonce="%s",nc=00000001,qop=auth,digest-uri="%s",response=%s,maxbuf=%s', [$authcid, $challenge['nonce'], $cnonce, $digest_uri, $response_value, $challenge['maxbuf']]);
      }
    } else {
      throw 'Invalid digest challenge';
    }
  }

  /**
  * Parses and verifies the digest challenge*
  *
  * @param  string $challenge The digest challenge
  * @return struct             The parsed challenge as an assoc
  *                           array in the form "directive => value".
  * @access private
  */
  function _parseChallenge($challenge)
  {
    var $tokens = {};
    var $matches = [];
    $matches = listToArray($challenge,',');
    
    for ($match in $matches) {
      $key = listFirst($match,'=');
      $value = replace(listLast($match,'='),'"','','ALL');
      // Ignore these as per rfc2831
      if ($match == 'opaque' OR $match == 'domain') {
        continue;
      }
      $tokens[$key] = $value;
    }

    /**
    * Defaults and required directives
    */
    // Realm
    if (!structKeyExists($tokens,'realm')) {
      $tokens['realm'] = "";
    }

    // Maxbuf
    if (!structKeyExists($tokens,'maxbuf')) {
      $tokens['maxbuf'] = "65536";
    } else {
      $tokens['maxbuf'] = numberformat($tokens['maxbuf'],'0.00');
    }

    // Required: nonce, algorithm
    if (!structKeyExists($tokens,'nonce') OR !structKeyExists($tokens,'algorithm')) {
      return {};
    }

    return $tokens;
  }

  /**
  * Creates the response= part of the digest response
  *
  * @param  string $authcid    Authentication id (username)
  * @param  string $pass       Password
  * @param  string $realm      Realm as provided by the server
  * @param  string $nonce      Nonce as provided by the server
  * @param  string $cnonce     Client nonce
  * @param  string $digest_uri The digest-uri= value part of the response
  * @param  string $authzid    Authorization id
  * @return string             The response= part of the digest response
  * @access private
  */    
  function _getResponseValue($authcid, $pass, $realm, $nonce, $cnonce, $digest_uri, $authzid = '')
  {
    if ($authzid == '') {
      $A1 = sprintf('%s:%s:%s', [hash(sprintf('%s:%s:%s', [$authcid, $realm, $pass]),'MD5'), $nonce, $cnonce]);
    } else {
      $A1 = sprintf('%s:%s:%s:%s', [hash(sprintf('%s:%s:%s', [$authcid, $realm, $pass]),'MD5'), $nonce, $cnonce, $authzid]);
    }
    $A2 = 'AUTHENTICATE:' & arguments.$digest_uri;
    return hash(sprintf('%s:%s:00000001:%s:auth:%s', [hash($A1,'MD5'), $nonce, $cnonce, hash($A2,'MD5')]),'MD5');
  }

  /**
  * Creates the client nonce for the response
  *
  * @return string  The cnonce value
  * @access private
  */
  function _getCnonce()
  {
    if (fileExists('/dev/urandom')) {
      $fd = fileOpen('/dev/urandom');
      return toBase64(FileRead($fd, 32));

    } else if (fileExists('/dev/random')) {
      $fd = fileOpen('/dev/random');
      return toBase64(FileRead($fd, 32));

    } else {
      $str = '';
      for ($i=0; $i<32; $i++) {
        $str &= chr(randrange(0, 255));
      }
      
      return toBase64($str);
    }
  }
}