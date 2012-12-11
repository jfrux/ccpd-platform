<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- mFile -->
<circuit access="internal">
	<fuseaction name="deleteFile">
		<include template="act_deleteFile" />
	</fuseaction>
    
	<fuseaction name="doUpload">
		<include template="act_doUpload" />
	</fuseaction>
	
	<fuseaction name="getFileInfo">
		<include template="act_getFileInfo" />
	</fuseaction>
	
	<fuseaction name="saveFileDB">
		<include template="act_saveFileDB" />
	</fuseaction>
	
	<fuseaction name="doScanUpload">
		<include template="act_doScanUpload" />
	</fuseaction>
	
	<fuseaction name="saveScanFileDB">
		<include template="act_saveScanFileDB" />
	</fuseaction>

</circuit>