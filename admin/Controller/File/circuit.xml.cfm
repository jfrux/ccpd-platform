<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- File -->
<circuit access="public">
	<prefuseaction callsuper="true">
		<set name="Request.NavItem" value="5" />
		
    </prefuseaction>
	
	<fuseaction name="pasteImage">
		<do action="vFile.pasteImage" />
	</fuseaction>
	
	<fuseaction name="Delete">
		<do action="mFile.deleteFile" />
	</fuseaction>
	
	<fuseaction name="Download">
		<do action="mFile.getFileInfo" />
	</fuseaction>
	
	<fuseaction name="DownloadReport">
		<do action="vFile.downloadReport" />
	</fuseaction>

	<fuseaction name="Edit">
		<xfa name="UploadSubmit" value="File.Edit" />
		
		<do action="mActivity.getDocTypes" />
		<do action="mFile.saveFileDB" />
		<do action="mFile.getFileInfo" />
		<do action="vFile.Form" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="Upload">
		<do action="mActivity.getDocTypes" />
		<set name="Request.Page.Title" value="Upload Document" />
		<xfa name="UploadSubmit" value="File.Upload" />
		<do action="mFile.doUpload" />
		<do action="mFile.saveFileDB" />
		<do action="vFile.Form" />
	</fuseaction>
	
	<fuseaction name="Scan">
		<do action="mActivity.getDocTypes" />
		<set name="Request.Page.Title" value="Upload By Scanner" />
		<do action="mFile.doUpload" />
		<do action="mFile.saveFileDB" />
		
		<do action="vFile.Scan" contentvariable="Request.MultiFormContent" />
		<do action="vFile.ScanRight" contentvariable="Request.MultiFormRight" />
		<do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
		<do action="vLayout.Default" />
	</fuseaction>
	
	<fuseaction name="ScanUpload">
	
		<do action="mFile.doScanUpload" />
		<do action="mFile.saveScanFileDB" />
	</fuseaction>
</circuit>