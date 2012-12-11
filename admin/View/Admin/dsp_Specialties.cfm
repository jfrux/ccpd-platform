<style>
.alt { background-color: #EEEEEE; }
</style>
<script>
function updateZebra(sType) {
	$(".specialties tr").removeClass("alt");
	$(".specialties tr:" + sType).addClass("alt");
}

$(document).ready(function() {
	updateZebra('odd');
	
	$(".deleteSpecialty").click(function() {
		var nId = $.ListGetAt(this.id, 2, "-");
		
		$.post(sRootPath + "/_com/AJAX_System.cfc", { method: "deleteSpecialty", SpecialtyID: nId, returnFormat: "plain" },
			function(data) {
				var cleanData = $.Trim(data);
				var status = $.ListGetAt(cleanData, 1, "|");
				var statusMsg = $.ListGetAt(cleanData, 2, "|");
				
				if(status == 'Success') {
					$("#specialty-" + nId).remove();
					updateZebra('odd');
					addMessage(statusMsg,250,6000,4000);
				} else {
					addError(statusMsg,250,6000,4000);
				}
		});
	});
});
</script>
<cfoutput>
<h1>#Request.Page.Title#</h1>
<strong><a href="#myself#Admin.Specialty">Create Specialty</a></strong> OR click on a specialty below to edit.  Only specialties with no activities attached can be deleted.
<table width="400" cellspacing="1" cellpadding="1" border="0" class="specialties">
	<thead>
		<tr>
			<th style="width:20px;"></th>
			<th style="width:200px; text-align:left;">Name</th>
			<th style="width:90px;">Activity Count</th>
			<th>Delete</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
    	<cfset BGColor = "##EEEEEE">
        
		<cfloop query="qSpecialties">
		<tr id="specialty-#qSpecialties.SpecialtyID#">
			<td style="text-align:right;font-size:13px;font-weight:bold;"><a href="#myself#Admin.Specialty?SpecialtyID=#qSpecialties.SpecialtyID#" style="text-decoration:none;">#qSpecialties.SpecialtyID#</a></td>
			<td><a href="#myself#Admin.Specialty?SpecialtyID=#qSpecialties.SpecialtyID#">#qSpecialties.Name#</a></td>
			<td>#qSpecialties.ActivityCount#</td>
			<td align="center"><cfif qSpecialties.ActivityCount EQ 0><img src="#Application.Settings.RootPath#/_images/icons/delete.png" class="deleteSpecialty" id="delete-#qSpecialties.SpecialtyID#" /></cfif></td>
			<td></td>
		</tr>
		</cfloop>
	</tbody>
</table>
</cfoutput>