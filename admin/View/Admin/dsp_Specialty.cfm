<cfparam name="Attributes.SpecialtyID" default="0" />
<cfparam name="SpecialtyName" default="" />
<cfparam name="Attributes.Name" default="" />

<script>
$(document).ready(function() {
	$("#frmSpecialty").submit(function() {
        $(this).ajaxSubmit({
			success:function(responseText,statusText) {
				var cleanData = $.Trim(responseText);
				var status = $.ListGetAt(cleanData, 1, "|");
				var statusMsg = $.ListGetAt(cleanData, 2, "|");
				
				if(status == "Success") {
					window.location = sMyself + "Admin.Specialties";
				} else {
					addError(statusMsg,250,6000,4000);
				}
			}
		});
		
		return false;
	});
});
</script>
<cfif Attributes.SpecialtyID GT 0>
<cfset SpecialtyName = Application.System.getSpecialty(Attributes.SpecialtyID)>
</cfif>
<cfoutput>
<h1>#Request.Page.Title#</h1>
<form action="#Application.Settings.RootPath#/_com/AJAX_System.cfc" method="post" name="frmSpecialty" id="frmSpecialty">
<input type="hidden" name="SpecialtyID" value="#Attributes.SpecialtyID#" />
<input type="hidden" name="method" value="<cfif Attributes.SpecialtyID EQ 0>save<cfelse>update</cfif>Specialty" />
<input type="hidden" name="returnFormat" value="plain" />
<cfif Attributes.SpecialtyID NEQ 0>
<input type="hidden" name="SpecialtyName" value="#SpecialtyName#" />
</cfif>
<div style="clear:both;">
<h3>Name</h3>
<input type="text" name="<cfif Attributes.SpecialtyID NEQ 0>Updated</cfif>SpecialtyName" value="#SpecialtyName#" width="600" />
</div>
<div style="height:10px;"></div>
<div style="height:10px;"></div>

<div style="clear:both;">
<input type="hidden" name="Submitted" value="1" /><input type="submit" value="Save Specialty" name="submit" class="button" /> <a href="#myself#Admin.Specialties">Cancel</a></div>

</form>
</cfoutput>