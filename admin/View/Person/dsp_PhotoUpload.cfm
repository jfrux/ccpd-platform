<cfparam name="Attributes.Insert" default="">
<cfparam name="Attributes.ElementID" default="">
<script>
	$(document).ready(function() {
		<cfif Attributes.Insert NEQ "">
		<cfoutput>parent.$("###Attributes.ElementID#").attr("src","/_uploads/PersonPhotos/#Attributes.PersonID#.jpg?Seed=#TimeFormat(now(),'hhmmss')#");</cfoutput>
		parent.$("#PhotoUpload").dialog("close");
		</cfif>
		
		$("#Cancel").click(function() {
			parent.$("#PhotoUpload").dialog("close");
		});
	});
</script>
<cfoutput>
<div style="padding:4px;">This will overwrite this persons existing photo if any. <strong>(Only JPEG photos allowed)</strong><br />
<form name="frmUpload" method="post" action="#myself#Person.PhotoUpload?PersonID=#Attributes.PersonID#&ElementID=#Attributes.ElementID#" enctype="multipart/form-data">
	<input type="file" name="PhotoFile" /> <input type="submit" value="Upload" name="Submit" /> <input type="button" value="Cancel" name="Cancel" id="Cancel" /><input type="hidden" name="submitted" value="1" />
</form>
</div>
</cfoutput>