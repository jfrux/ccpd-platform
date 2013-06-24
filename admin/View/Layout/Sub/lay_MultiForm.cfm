<cfparam name="MultiFormTitle" default="">
<cfparam name="MultiFormContent" default="">
<cfparam name="MultiFormRight" default="">
<cfparam name="MultiFormLabels" default="">
<cfparam name="MultiFormFuseactions" default="">
<cfparam name="MultiSubTabFlag" default="N">
<cfparam name="MultiFormQS" default="">
<cfparam name="MultiFormEditLabel" default="">
<cfparam name="MultiFormEditLink" default="">

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
	
	<cfif MultiSubTabFlag EQ "Y">
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
<cfif MultiFormFuseactions NEQ ""><div class="clear-fix"><cf_ceTabControl Instance="MultiForm" Labels="#MultiFormLabels#" Fuseactions="#MultiFormFuseactions#" QueryString="#MultiFormQS#" Current="#Attributes.Fuseaction#"></div></cfif>
<table cellspacing="0" border="0" cellpadding="0" class="MultiForm">
	<tbody>
		<tr>
			<td class="MultiFormContent">#MultiFormContent#</td>
			<td class="MultiFormRight" valign="top" style="width:170px;" width="170">#MultiFormRight#</td>
		</tr>
	</tbody>
</table>
<cfif MultiFormEditLabel NEQ "" AND MultiFormEditLink NEQ "" AND MultiFormEditLink DOES NOT CONTAIN Attributes.FuseAction>
<div class="EditLink"><a href="#MultiFormEditLink#"><img src="#Application.Settings.RootPath#/_images/pencil.gif" border="0" align="left" /> #MultiFormEditLabel#</a></div>
</cfif>
</cfoutput>
