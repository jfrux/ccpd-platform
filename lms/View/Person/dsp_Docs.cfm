<cfparam name="qFiles.FileUpdated" default="" />
<script>
nId = 0;

function updateDocs() {
	$.post(sMyself + "Person.DocsAHAH", { PersonID: nPerson },
		function(data) {
			$("#DocsContainer").html(data);
			$("#DocsLoading").hide();
			
	});
}

$(document).ready(function() {
	updateDocs();
	
	$(".upload-add").bind("click", this, function() {
		$.post(sMyself + "File.Upload", { Mode: "Person", ModeID: nPerson },
			function(data) {
				$("#doc-uploader").html(data);
		});
		
		$("#doc-uploader").dialog("open");
	});
	
	$("#doc-uploader").dialog({ 
			title: "Upload a Document",
			modal: true, 
			autoOpen: false,
			position:[40,40],
			height:230,
			width:300,
			resizable: false,
			buttons: {
				"Upload": function() {
					var nError = 0;
					
				},
				"Cancel": function() {
					$("#doc-uploader").dialog("close");
				}
			},
			open:function() {
			},
			close:function() {
				$("#doc-uploader").html("");
			}
		});
	<!--- $().ajaxStart(function(){
		$.blockUI({ message: '<h1>Updating information...</h1>'});
	});
			
	$().ajaxStop(function(){
		$.unblockUI();
	}); --->
});
</script>

<div class="ViewSection">
	<h3>Documents & Materials</h3>
	<div id="DocsContainer"></div>
	<div id="DocsLoading" class="Loading"><img src="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_images/ajax-loader.gif" />
	<div>Please Wait</div>
	</div>
</div>
<div id="doc-uploader"></div>