<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.MultiFormContent" default="">
<cfparam name="Request.MultiFormRight" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">

<cfoutput>
<script>
$(document).ready(function() {
	<!---/* UNSAVED CHANGES SCRIPTS */
	var Unsaved = false;
	var question232 = $("##question232");
	var TheLink = '';
	$(".PageStandard").hide();
	
	$("form input,form textarea").bind("keyup", function(){
		if (Unsaved==false) {
			Unsaved = true;
			$("##StatusBar").show();
			
			$(".PageStandard").fadeIn("slow").html("Unsaved Changes...");;
		}
	});
	
	$("form select").bind("change", function(){
		$("##StatusBar").show();
		$(".PageStandard").fadeIn("slow").html("Unsaved Changes...");;
		Unsaved = true;
	});
	
	$("a").bind("click", this, function(){
			TheLink = this.href;
			if (Unsaved) {
				$("##StatusBar").hide().fadeIn("fast").addClass("StatusError").fadeOut("fast").fadeIn("fast").fadeOut("fast").fadeIn("fast").html("Unsaved Changes...");
				$.extend($.blockUI.defaults.overlayCSS, { backgroundColor: '##000' });
				$.blockUI({message: question232, width: '275px' });
				
				return false;
			}
		});
	
	$('##yes').click(function() { 
		$.unblockUI();
		window.location=TheLink;
	}); 
	
	$('##no').click($.unblockUI);
	
	$('a.button').unbind("click");--->
	
	<cfif Request.MultiSubTabFlag EQ "Y">
	$(".FormSection").hide();

	$(".FormTabs a").addClass("FormTab").unbind("click");
	$(".FormTabs a").bind("click", this, function() { 
		$(".FormTabs a").removeClass("FormTabOn");
		
		$(this).addClass("FormTabOn");
		
		aSections = $.ListToArray(this.id,"|");
		
		$(".FormSection").hide();
		
		$.each(aSections, function() {
			$("##Sect" + this).slideDown();
		});
		
		return false;
	});
	$(".FormTabs a:first").click();
	</cfif>
});
</script>
<div class="ContentTitle">#Request.Page.Title#</div>
<cfif Request.MultiFormFuseactions NEQ ""><div class="clear-fix"><cf_ceTabControl Instance="MultiForm" Labels="#Request.MultiFormLabels#" Fuseactions="#Request.MultiFormFuseactions#" QueryString="#Request.MultiFormQS#" Current="#Attributes.Fuseaction#"></div></cfif>
<table cellspacing="0" border="0" cellpadding="0" class="MultiForm">
	<tbody>
		<tr>
			<td class="MultiFormContent">#Request.MultiFormContent#</td>
			<td class="MultiFormRight" valign="top" style="width:170px;" width="170">#Request.MultiFormRight#</td>
		</tr>
	</tbody>
</table>
<cfif Request.MultiFormEditLabel NEQ "" AND Request.MultiFormEditLink NEQ "" AND Request.MultiFormEditLink DOES NOT CONTAIN Attributes.FuseAction>
<div class="EditLink"><a href="#Request.MultiFormEditLink#"><img src="#Application.Settings.RootPath#/_images/pencil.gif" border="0" align="left" /> #Request.MultiFormEditLabel#</a></div>
</cfif>
</cfoutput>
