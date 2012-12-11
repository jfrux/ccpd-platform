<cfparam name="Attributes.CategoryID" default="0" />
<cfparam name="CategoryName" default="" />
<cfparam name="Attributes.Name" default="" />

<script>
$(document).ready(function() {
	$("#frmCategory").submit(function() {
        $(this).ajaxSubmit({
			success:function(responseText,statusText) {
				var cleanData = $.Trim(responseText);
				var status = $.ListGetAt(cleanData, 1, "|");
				var statusMsg = $.ListGetAt(cleanData, 2, "|");
				
				if(status == "Success") {
					window.location = sMyself + "Admin.Categories";
				} else {
					addError(statusMsg,250,6000,4000);
				}
			}
		});
		
		return false;
	});
});
</script>
<cfif Attributes.CategoryID GT 0>
<cfset CategoryName = Application.System.getCategory(Attributes.CategoryID)>
</cfif>
<cfoutput>
<h1>#Request.Page.Title#</h1>
<form action="#Application.Settings.RootPath#/_com/AJAX_System.cfc" method="post" name="frmCategory" id="frmCategory">
<input type="hidden" name="CategoryID" value="#Attributes.CategoryID#" />
<input type="hidden" name="method" value="<cfif Attributes.CategoryID EQ 0>save<cfelse>update</cfif>CategoryLMS" />
<input type="hidden" name="returnFormat" value="plain" />
<cfif Attributes.CategoryID NEQ 0>
<input type="hidden" name="CategoryName" value="#CategoryName#" />
</cfif>
<div style="clear:both;">
<h3>Name</h3>
<input type="text" name="<cfif Attributes.CategoryID NEQ 0>Updated</cfif>CategoryName" value="#CategoryName#" width="600" />
</div>
<div style="height:10px;"></div>
<div style="height:10px;"></div>

<div style="clear:both;">
<input type="hidden" name="Submitted" value="1" /><input type="submit" value="Save Category" name="submit" class="button" /> <a href="#myself#Admin.Categories">Cancel</a></div>

</form>
</cfoutput>