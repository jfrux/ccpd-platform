<script type="text/javascript" src="/admin/_scripts/Supa.js"></script>
<script type="text/javascript">
<!--
function paste() {
  // Call the paste() method of the applet.
  // This will paste the image from the clipboard into the applet :)
  try {
	var applet = document.getElementById( "SupaApplet" );
	if( !applet.pasteFromClipboard ) {
	  throw "SupaApplet is not loaded (yet)";
	}
	var err = applet.pasteFromClipboard(); 
	switch( err ) {
	  case 0:
		/* no error */
		break;
	  case 1: 
		alert( "Unknown Error" );
		break;
	  case 2:
		alert( "Empty clipboard" );
		break;
	  case 3:
		alert( "Clipboard content not supported. Only image data is supported." );
		break;
	  case 4:
		alert( "Clipboard in use by another application. Please try again in a few seconds." );
		break;
	  default:
		alert( "Unknown error code: "+err );
	}
  } catch( e ) {
	alert(e);
	throw e;
  }

  return false;
}

function upload() {
  // Get the base64 encoded data from the applet and POST it via an AJAX 
  // request. See the included Supa.js for details
  var s = new supa();
  var applet = document.getElementById( "SupaApplet" );

  try { 
	var result = s.ajax_post( 
	  applet,       // applet reference
	  "/admin/_com/upload.cfc?method=uploader", // call this url
	  "screenshot", // this is the name of the POSTed file-element
	  "screenshot.jpg", // this is the filename of tthe POSTed file
	  { form: document.forms["form"] } // elements of this form will get POSTed, too
	);
	
	if(result) {
		resultData = $.parseJSON(result);
		
		if(resultData.STATUSMSG == 'success') {
			handleImage(resultData);
		} else {
			alert('UPLOAD FAILED FOR UNKNOWN REASON!');
		}
	}
	
   /*if( result.match( "^OK" ) ) {
	  var url = result.substr( 3 );
	  window.open( url, "_blank" );
	} else {
	  alert( result );
	}*/

  } catch( ex ) {
	if( ex == "no_data_found" ) {
	  alert( "Please paste an image first" );
	} else {
	  alert( ex );
	}
  }

  return false; // prevent changing the page
}

function handleImage(params) {
	
	var submitData = params;
	
	submitData.TYPE = 1;
	submitData.KEY = 0;
	submitData.isBase64 = true;
	
	$.ajax({
		url: '/admin/_com/upload.cfc?method=imageHandler',
		type:'POST',
		data:submitData,
		async:false,
		success:function(data) {
					window.opener.attachImage(data);
		}
	});
}
//-->
</script>
<style>
#imagePreview { 
    -moz-border-radius: 6px 6px 6px 6px;
    background-color: #EEEEEE;
    border: 1px solid #CCCCCC;
    height: 250px;
    padding: 8px;
    width: 300px;
}
#imagePreview h3 { 
    color: #888888;
    font-size: 15px;
    padding-bottom: 5px;
    text-transform: uppercase;
}

#popup-header {
	background-color:#555;
	color:#FFF;
}
</style>
<style>
.popup-top { background-color:#000; height:25px; margin:auto; width:100%; position:absolute; left:0; right:0; top:0; padding:5px; }
.popup-top h1 { color:#FFF; font-size:16px; font-weight:normal; line-height:25px; }
.popup-content { margin-top:35px; padding:5px;} 
.popup-content p { margin-bottom:10px; }
</style>
<div class="popup-top"><h1>PASTE FROM CLIPBOARD</h1></div>
<div class="popup-content">
<p>
You will need to accept the JAVA applet popup when it is presented.<br />
This applet is used to access the contents of your 'COPIED' image file in your clipboard
</p>


<form name="form" action="#none" enctype="multipart/form-data">
	<input type="button" value="paste image from clipboard" onClick="return paste();" class="btn"><br>
	
	<!-- This is the applet that will receive the image from the clipboard -->
	
	<div id="imagePreview">
		<h3>Image</h3>
	  <applet id="SupaApplet"
			  archive="/_java/Supa.jar"
			  code="de.christophlinder.supa.SupaApplet" 
			  width="299" 
			  height="230">
		<!--param name="clickforpaste" value="true"-->
		<param name="imagecodec" value="png">
		<param name="encoding" value="base64">
		<param name="previewscaler" value="fit to canvas">
		<!--param name="trace" value="true"-->
		Applets disabled :(
	  </applet> 
	</div>
	<strong>Note:</strong> <a href="http://www.java.com">Java</a> is required to use the 'paste image' option.<br>

	<input type="hidden" value="uploader" name="method">
	<input type="hidden" value="image" name="mode">
	<input type="hidden" value="screenshot" name="filefield">
	<input type="hidden" value="true" name="isBase64">
	<!-- Control buttons. Please note: there's no submit! -->
	<input type="button" value="upload" onClick="return upload();" class="btn">
	<input type="button" value="clear" class="btn" onClick="document.getElementById( 'SupaApplet' ).clear(); return false;">
</form>
</div>
 

