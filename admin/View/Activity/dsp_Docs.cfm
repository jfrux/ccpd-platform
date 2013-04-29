<cfparam name="qFiles.FileUpdated" default="" />
<script>
	var nId = 0;
	
	App.Activity.Files.start();
</script>
<cfoutput>
<div class="ViewSection">
	<div id="FilesContainer"></div>
	<div id="FilesLoading" class="Loading"><img src="/admin/_images/ajax-loader.gif" />
	<div>Please Wait</div>
	</div>
</div>
<div id="UploadDialog">

</div>
</cfoutput>