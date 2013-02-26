<style>
.alt { background-color: #EEEEEE; }
</style>
<script>
function updateZebra(sType) {
	$(".categories tr").removeClass("alt");
	$(".categories tr:" + sType).addClass("alt");
}

$(document).ready(function() {
	updateZebra('odd');
	
	$(".deleteCategory").click(function() {
		var nId = $.ListGetAt(this.id, 2, "-");
		
		$.post(sRootPath + "/_com/AJAX_System.cfc", { method: "deleteCategoryLMS", CategoryID: nId, returnFormat: "plain" },
			function(data) {
				var cleanData = $.Trim(data);
				var status = $.ListGetAt(cleanData, 1, "|");
				var statusMsg = $.ListGetAt(cleanData, 2, "|");
				
				if(status == 'Success') {
					$("#category-" + nId).remove();
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
<strong><a href="#myself#Admin.Category">Create Category</a></strong> OR click on a category below to edit.  Only categories with no activities attached can be deleted.
<table width="510" cellspacing="1" cellpadding="1" border="0" class="categories">
	<thead>
		<tr>
			<th style="width:20px;"></th>
			<th style="width:400px; text-align:left;">Name</th>
			<th style="width:90px;">Activity Count</th>
			<th>Delete</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
    	<cfset BGColor = "##EEEEEE">
        
		<cfloop query="qCategories">
		<tr id="category-#qCategories.CategoryID#">
			<td style="text-align:right;font-size:13px;font-weight:bold;"><a href="#myself#Admin.Category?CategoryID=#qCategories.CategoryID#" style="text-decoration:none;">#qCategories.CategoryID#</a></td>
			<td><a href="#myself#Admin.Category?CategoryID=#qCategories.CategoryID#">#qCategories.Name#</a></td>
			<td>#qCategories.ActivityCount#</td>
			<td align="center"><cfif qCategories.ActivityCount EQ 0><img src="#Application.Settings.RootPath#/_images/icons/delete.png" class="deleteCategory" id="delete-#qCategories.CategoryID#" /></cfif></td>
			<td></td>
		</tr>
		</cfloop>
	</tbody>
</table>
</cfoutput>