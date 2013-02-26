      <link href="/uploadify/uploadify.css" type="text/css" rel="stylesheet" />
      <script type="text/javascript" src="/admin/_scripts/uploadify/swfobject.js"></script>
      <script type="text/javascript" src="/admin/_scripts/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
      <script type="text/javascript">
      $(document).ready(function() {
        $('#imagefile').uploadify({
          'uploader'  : '/admin/_scripts/uploadify/uploadify.swf',
          'script'    : '/admin/_com/upload.cfc',
		  'cancelImg' : '/admin/_scripts/uploadify/cancel.png',
          'folder'    : '/_uploads/images/',
		  'scriptData'	 : {
				'method' : 'uploader',
				'FILEFIELD' : 'FILEDATA',
				'returnformat' : 'plain'
			},
			'cancelImg'      : '/admin/_images/icons/cancel.png',
			'folder'         : '/_uploads',
			'multi'          : false,
			'auto' : true,
			'onError' : function(event,queueID,fileObj,errorObj) {
			
			/*console.log("ERROR: ");
			console.log(event);
			console.log(queueID);
			console.log(fileObj);
			console.log(errorObj);*/
			
		},
		  'onComplete' : function(event,queueID,fileObj,response,data) {
		  		returnData = $.parseJSON(response);
				sFileName = returnData.FILENAME;
				sContentType = returnData.CONTENTTYPE;
				sFileExt = returnData.FILEEXT;
				sStatus = returnData.STATUSMSG;
				
				/*
				console.log("complete: ");
				console.log(event);
				console.log(queueID);
				console.log(fileObj);
				console.log(response);
				console.log(data);
				*/
				
				if (sFileName != '') {
					$("#photoedit-caption-" + queueID).html("<div style=\"padding:16px; font-size:18px;\">Crunching... " + sFileName + "</div>");
					handleImage(returnData);
				} else {
					$("#photoedit-caption-" + queueID).html("<div style=\"padding:16px; font-size:18px;\">Upload failed...  " + fileObj.name + "</div>"<!---<div style=\"font-size:10px;color:#FF0000;\"><strong>Queue ID</strong> " + queueID + " // <strong>File Object</strong> Name: " + fileObj.name + " Size: " + fileObj.size + " Ext: " + fileObj.type + " // <strong>Response</strong> " + response + " // <strong>Data</strong> File Count: " + data.fileCount + " Avg Speed: " + data.speed--->);
				}
			}
        });
      });

		function handleImage(params) {
			
			var submitData = params;
			
			submitData.TYPE = 1;
			submitData.KEY = 0;
			
			submitData.isBase64 = false;
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
.popup-top { background-color:#000; height:25px; margin:auto; width:100%; position:absolute; left:0; right:0; top:0; padding:5px; }
.popup-top h1 { color:#FFF; font-size:16px; font-weight:normal; line-height:25px; }
.popup-content { margin-top:35px; padding:5px;} 
.popup-content p { margin-bottom:10px; }
</style>
<div class="popup-top"><h1>UPLOAD FROM COMPUTER</h1></div>
<div class="popup-content">
<p>
Click the 'SELECT FILES' button to find and upload the screenshot saved to your computer.
</p>
<cfoutput>

</cfoutput>

	<input type="file" name="imagefile" id="imagefile" />
</div>