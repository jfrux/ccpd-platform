<SCRIPT  LANGUAGE="javascript">
function btnScan_onclick() 
{
	frmScan.DynamicWebTwain1.SelectSource();
	frmScan.DynamicWebTwain1.AcquireImage();
	
}

function btnUpload_onclick() 
{
	var strActionPage;
	var strHostIP;
	
	var CurrentPathName = unescape(location.pathname);	// get current PathName in plain ASCII	
	var CurrentPath = CurrentPathName.substring(0, CurrentPathName.lastIndexOf("/") + 1);
	
	
	strActionPage = CurrentPath + "imageupload.asp"; //the ActionPage's file path 
	strHostIP = "localhost";			 //the host's ip or name

  frmScan.DynamicWebTwain1.HTTPPort = 80;
	frmScan.DynamicWebTwain1.HTTPUploadThroughPost(strHostIP, 0, strActionPage, "ImageData.JPG");

	if (frmScan.DynamicWebTwain1.ErrorCode != 0)					//Failed to upload image
		alert(frmScan.DynamicWebTwain1.ErrorString);
		//alert(frmScan.DynamicWebTwain1.HTTPPostResponseString);	
	else															//Successful
		frmScan.submit();
}

function btnEdit_onclick()
{
    frmScan.DynamicWebTwain1.ImageEditorWindowTitle = frmScan.DynamicWebTwain1.ImageEditorWindowTitle;
    frmScan.DynamicWebTwain1.ImageEditorIfReadonly = false;
    frmScan.DynamicWebTwain1.ImageEditorIfEnableEnumerator = true;
    frmScan.DynamicWebTwain1.ShowImageEditor();
}
</SCRIPT>

<OBJECT CLASSID = "clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
	<PARAM NAME="LPKPath" VALUE="DynamicWebTwain.lpk">
</OBJECT>  

<form name="frmScan" id="frmScan" action="ShowResult.asp">
	<table width="100%">
	<tr>
	<td>
	<center>	
	<object classid="clsid:FFC6F181-A5CF-4EC4-A441-093D7134FBF2" id="DynamicWebTwain1" width="250" height="350"
			CodeBase = "/_scripts/scanner/DynamicWebTWAIN.cab#version=5,0">
   		<param name="_cx" value="847">
   		<param name="_cy" value="847">
  		<param name="JpgQuality" value="80">
  		<param name="Manufacturer" value="DynamSoft Corporation">
  		<param name="ProductFamily" value="Dynamic Web TWAIN">
  		<param name="ProductName" value="Dynamic Web TWAIN">
  		<param name="VersionInfo" value="Dynamic Web TWAIN 5.0">
  		<param name="TransferMode" value="0">
  		<param name="BorderStyle" value="0">
  		<param name="FTPUserName" value>
  		<param name="FTPPassword" value>
  		<param name="FTPPort" value="21">
  		<param name="HTTPUserName" value>
  		<param name="HTTPPassword" value>
  		<param name="HTTPPort" value="80">
  		<param name="ProxyServer" value>
  		<param name="IfDisableSourceAfterAcquire" value="0">
  		<param name="IfShowUI" value="-1">
  		<param name="IfModalUI" value="-1">
  		<param name="IfTiffMultiPage" value="0">
  		<param name="IfThrowException" value="0">
  		<param name="MaxImagesInBuffer" value="1">
  		<param name="TIFFCompressionType" value="0">
  		<param name="IfFitWindow" value="-1">
	</object>
	</center>	
	</td>
	</tr>
		
	<tr>
	<td>
	<center>	
	<input type="button" value="Scan" ID = "btnScan" style="width: 100; height: 30" onclick='return btnScan_onclick()'>
	<input type="button" value="Upload" ID = "btnUpload" style="width: 100; height: 30" onclick='return btnUpload_onclick()'>
	<input type="button" value="Edit" ID = "btnEdit" style="width: 100; height: 30" onclick='return btnEdit_onclick()'>
	</center>
	</td>
	</tr>
	
</table>
</form>