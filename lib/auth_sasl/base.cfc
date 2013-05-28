/**
  * Common functionality to SASL mechanisms
  *
  * @author Joshua F. Rountree <rountrjf@uc.edu>
  * @access public
  * @version 1.0
**/

component displayName="Auth_SASL_Common"
{
  variables.regx = createObject("component","vendor.jre-utils").init();
    
  function init(){
    // Store the MAC class definition so that its static methods can be accessed quickly.
    variables.macClass = createObject( "java", "javax.crypto.Mac" );

    // Return this object reference.
    return( this );

  }
  /**
  * Function which implements HMAC MD5 digest
  *
  * @param string key The secret key
  * @param string data The data to hash
  * @param bool raw_output Whether the digest is returned in binary or hexadecimal format.
  *
  * @return string The HMAC-MD5 digest
  */
   public function hmacMd5(
      String key,
      String input,
      String encoding = "hex"
    ){

    // Hash the input using Hmac MD5.
    var authenticationCode = this._hashInputWithAlgorithmAndKey( "HmacMD5", key, input );

    // Return the authentication code in the appropriate encoding.
    return(
    this._encodeByteArray( authenticationCode, encoding )
    );

    }
  /**
    * Function which implements HMAC-SHA-1 digest
    *
    * @param string key The secret key
    * @param string data The data to hash
    * @param bool raw_output Whether the digest is returned in binary or hexadecimal format.
    * @return string The HMAC-SHA-1 digest
    * @author Jehan <jehan.marmottard@gmail.com>
    * @access protected
    */
    public function hmacSha1(
        String key,
        String input,
        String encoding = "hex"
        ){

        // Hash the input using Hmac Sha-1.
        var authenticationCode = this._hashInputWithAlgorithmAndKey( "HmacSHA1", key, input );

        // Return the authentication code in the appropriate encoding.
        return(
        this._encodeByteArray( authenticationCode, encoding )
        );

        }
    public function hmacSha256(
      String key,
      String input,
      String encoding = "hex"
    ){

      // Hash the input using Hmac Sha-256.
      var authenticationCode = this._hashInputWithAlgorithmAndKey( "HmacSHA256", key, input );

      // Return the authentication code in the appropriate encoding.
      return(
      this._encodeByteArray( authenticationCode, encoding )
      );

    }

    // ---
// PRIVATE METHODS
// ---

function sprintf(format,argsArray) {
  return createObject("java","java.lang.String").format(arguments.format, arguments.argsArray);
}
// I encode the byte array / binary value using the given encoding. The Hex-encoding is used
// by default.
function _encodeByteArray(
Any bytes,
String encoding = "hex"
){

// Normalize the encoding value.
encoding = lcase( encoding );

// Checking encoding algorithm.
if (encoding == "hex"){

return(
lcase( binaryEncode( bytes, "hex" ) )
);

} else if (encoding == "base64"){

return(
binaryEncode( bytes, "base64" )
);

} else if (encoding == "binary"){

// No further encoding required.
return( bytes );

}

// If we made it this far, the encoding was not recognized or is not yet supported.
throw(
type = "InvalidEncoding",
message = "The requested encoding method [#encoding#] is not yet supported."
);

}

function SubStr(buf, start) {
    // third argument (optional)
    var length = 0;
    var sz = 0;
        
    sz = len(buf);
    
    if (arrayLen(arguments) EQ 2) {

        if (start GT 0) {
            length = sz;
        } else if (start LT 0) {
            length = sz + start;
            start = 1;
        }
    
    } else {
    
        length = Arguments[3];
        if (start GT 0) {
            if (length LT 0)   length = 1+sz+length-start;
        } else if (start LT 0) {
            if (length LT 0) length = length-start;
            start = 1+sz+start;
            
        }
    } 
    
    if (isNumeric(start) AND isNumeric(length) AND start GT 0 AND length GT 0) return mid(buf, start, length);
    else return "";
}
// I return a MAC generator for the given key and algorithm.
function _getMacInstance( String algorithm, String key ){

// Create the specification for our secret key.
var secretkeySpec = createObject( "java", "javax.crypto.spec.SecretKeySpec" ).init(
toBinary( toBase64( key ) ),
javaCast( "string", algorithm )
);

// Get an instance of our MAC generator for the given hashing algorithm.
var mac = variables.macClass.getInstance(
javaCast( "string", algorithm )
);

// Initialize the Mac with our secret key spec.
mac.init( secretkeySpec );

// Return the initialized Mac generator.
return( mac );

}


// I provide a generic method for creating an Hmac with various algorithms. The hash value
// is returned as a binary value / byte array.
function _hashInputWithAlgorithmAndKey(
String algorithm,
String key,
String input
){

// Create our MAC generator.
var mac = this._getMacInstance( algorithm, key );

// Hash the input.
var hashedBytes = mac.doFinal(
toBinary( toBase64( input ) )
);

return( hashedBytes );

}

function isEmpty(any varName) {
    if(isSimpleValue(varName)) {
        if(not len(varName)) return true;
    } else if(isArray(varName)) {
        if(arrayIsEmpty(varName)) return true;
    } else if(isStruct(varName)) {
        if(structIsEmpty(varName)) return true;
    } else if(isQuery(varName)) {
        if(not varName.recordCount) return true;
    }
        
    return false;
}
}