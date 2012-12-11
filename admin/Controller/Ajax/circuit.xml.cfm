<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Ajax -->
<circuit access="public">
	<fuseaction name="PodSort">
		<do action="mAjax.PodSort" />
		<do action="vAjax.PodSort" contentvariable="Request.Page.Body" />
		<do action="vLayout.Blank" />
	</fuseaction>
</circuit>