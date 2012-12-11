<cfparam name="Attributes.FileType" default="1">
<div class="ViewSection">
	<h3>Preview</h3>
	<script>
	$(document).ready(function() {
		
		var Plugin = document.embeds[0];
		Plugin.MaxImagesInBuffer = 4; 
		var i;	
		
	});

	function btnScan_onclick() 
	{
		var Plugin = document.embeds[0];
		Plugin.IfShowUI = false;		
		Plugin.AcquireImage();
	}


function btnUpload_onclick(){
	var Plugin = document.embeds[0]; 
    if (Plugin.HowManyImagesInBuffer == 0)
	  {
	  	  em = "There is no image in buffer.\n";
         addError(em,250,6000,4000);
        return;
	  }
	var i,strHTTPServer,strActionPage,strImageType;
    if($("#FileName").val() == ""){
    	  em = "please input file name.\n";
        addError(em,250,6000,4000);
        return;
    }
	<cfoutput>
    strHTTPServer = "#cgi.server_name#";
    </cfoutput>
	var CurrentPathName = unescape(location.pathname);	// get current PathName in plain ASCII	
	var CurrentPath = CurrentPathName.substring(0, CurrentPathName.lastIndexOf("/") + 1);			
	var strActionPage = "<cfoutput>#myself#</cfoutput>File.ScanUpload"; //the ActionPage's file path
    Plugin.IfThrowException = true;
	<cfoutput>
	Plugin.SetHTTPFormField("Mode","#Attributes.Mode#");
	Plugin.SetHTTPFormField("ModeID","#Attributes.ModeID#");
	Plugin.SetHTTPFormField("FileType",$(".FileTypeRadios:checked").val());
	Plugin.SetHTTPFormField("FileCaption",$("##FileCaption").val());
	</cfoutput>
	Plugin.HTTPUploadAllThroughPostAsPDF(
		 strHTTPServer, 
		 strActionPage,
		 $("#FileName").val() + ".pdf");
		 //frmScan.submit();
	
	if ($.trim(Plugin.HTTPPostResponseString) == 0) {
		<cfoutput>window.location='#myself##Attributes.Mode#.Docs?#Attributes.Mode#ID=#Attributes.ModeID#';</cfoutput>
	} else {
		addError(Plugin.HTTPPostResponseString,250,6000,4000);
	}
}
//====================Preview Group End====================//

var em = "";
//====================Page Onload  Start==================//
function CheckIfImagesInBuffer() {
	var Plugin = document.embeds[0];
  if (Plugin.HowManyImagesInBuffer == 0)
	{
        //alert("There is no image in buffer");
        em = "There is no image in buffer.\n";
        addError(em,250,6000,4000);
        return;
	}
}
function CheckErrorString() {
	var Plugin = document.embeds[0];
  if (Plugin.ErrorCode != 0)
	{
        em = em + Plugin.ErrorString + "\n";
         addError(em,250,6000,4000);
        return;
	}
}
</script>
	<p>
	<EMBED
		TYPE="Application/DynamicWebTwain-Plugin"	
		WIDTH="575"
		HEIGHT="550"
		PLUGINSPAGE="DynamicWebTwain.xpi">	</EMBED>
	</p>
</div>