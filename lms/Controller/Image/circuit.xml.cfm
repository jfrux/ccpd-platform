<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Image -->
<circuit access="public">
	
	<fuseaction name="upload">
		<set name="request.page.title" value="Upload From Computer" />
		<do action="vImage.upload" contentvariable="Request.Page.Body" />
		<do action="vLayout.None" />
	</fuseaction>
	
	<fuseaction name="pasteUpload">
		<set name="request.page.title" value="Paste From Clipboard" />
		<do action="vImage.pasteUpload" contentvariable="Request.Page.Body" />
		<do action="vLayout.None" />
	</fuseaction>
	
	<fuseaction name="delete">
		
	</fuseaction>

	<fuseaction name="edit">
		
	</fuseaction>
	
	<fuseaction name="attach">
		
	</fuseaction>
</circuit>