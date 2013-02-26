<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.MultiFormContent" default="">
<cfparam name="Request.MultiFormRight" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">
<cfparam name="Attributes.UCID" default="">

<script>
<cfoutput>
var nPerson = #Attributes.PersonID#;
var cActNotesOpen = #Cookie.USER_ActNotesOpen#;
cActNotesPosX = #getToken(Cookie.USER_ActNotesPos,1,",")#;
cActNotesPosY = #getToken(Cookie.USER_ActNotesPos,2,",")#;
</cfoutput>
$(document).ready(function() {

	/* Status Changer */
	$("#StatusChanger").change(function() {
		$.post(sRootPath + "/_com/AJAX_Person.cfc", { method: "setStatus", PersonID: nPerson, StatusID:$(this).val(), returnFormat:"plain" },
		  function(data){
			var cleanData = $.trim(data);
			addMessage("Person status changed successfully!",250,6000,4000);
		  });
	});
	
	/* NOTES DIALOG */
	$("#NotesList").dialog({ 
		title:"Notes",
		modal: false, 
		autoOpen: cActNotesOpen,
		height:420,
		width:370,
		position:[cActNotesPosX,cActNotesPosY],
		resizable: false,
		dragStop: function(ev,ui) {
			$.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActNotesPos', position: ui.position.left + "," + ui.position.top });
		},
		open:function() {
			$("##NotesList").show();
			frmNotes.location = sMyself + 'Person.Notes?PersonID=' + nPerson;
			$.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActNotesOpen', IsOpen: 'true' });
			$("#NotesDialogLink").fadeOut();
		},
		close:function() {
			$("#NotesDialogLink").fadeIn();
			$.post(sRootPath + "/_com/UserSettings.cfc", { method:'setActNotesOpen', IsOpen: 'false' });
		}
	});

	$("##NotesDialogLink").click(function() {
		$("##NotesList").dialog("open");
	});
	/* // END NOTES DIALOG */
	
	/* UNSAVED CHANGES SCRIPTS */
	var Unsaved = false;
	var question232 = $("#question232");
	var TheLink = '';
	$(".PageStandard").hide();
	
	/*$("form input,form textarea").bind("keyup", function(){
		if (Unsaved==false) {
			Unsaved = true;
			$("#StatusBar").show();
			
			$(".PageStandard").fadeIn("slow").html("Unsaved Changes...");;
		}
	});*/
	
	/*$("form select").bind("change", function(){
		$("#StatusBar").show();
		$(".PageStandard").fadeIn("slow").html("Unsaved Changes...");;
		Unsaved = true;
	});
	
	$("a").bind("click", this, function(){
			TheLink = this.href;
			if (Unsaved) {
				$("#StatusBar").hide().fadeIn("fast").addClass("StatusError").fadeOut("fast").fadeIn("fast").fadeOut("fast").fadeIn("fast").html("Unsaved Changes...");
				$.extend($.blockUI.defaults.overlayCSS, { backgroundColor: '#000' });
				$.blockUI({message: question232, width: '275px' });
				
				return false;
			}
		});
	
	$('#yes').click(function() { 
		$.unblockUI();
		window.location=TheLink;
	}); 
	
	$('#no').click($.unblockUI);
	
	$('a.button').unbind("click");
	
	<cfif Request.MultiSubTabFlag EQ "Y">
	$(".FormSection").hide();

	$(".FormTabs a").addClass("FormTab").unbind("click");
	$(".FormTabs a").bind("click", this, function() { 
		$(".FormTabs a").removeClass("FormTabOn");
		
		$(this).addClass("FormTabOn");
		
		aSections = $.ListToArray(this.id,"|");
		
		$(".FormSection").hide();
		
		$.each(aSections, function() {
			$("#Sect" + this).slideDown();
		});
		
		return false;
	});
	$(".FormTabs a:first").click();
	</cfif>
	*/
});
</script>
<cfoutput>
<style>
.TabControl { width:850px; }
.MultiFormContent { width:700px!important;   }
.MultiForm { width:750px!important; }
</style>
<link href="#Application.Settings.RootPath#/_styles/Person.css" rel="stylesheet" type="text/css" />
<cfif PersonBean.getFirstName() EQ "" AND PersonBean.getLastName() EQ "" AND PersonBean.getBirthdate() EQ "" AND PersonBean.getSSN() EQ "">
	<div class="ContentTitle">THIS PERSON NO LONGER EXISTS</div>
<cfelse>
    <div class="ContentTitle">#Request.Page.Title#<cfif NOT IsEditable> <span style="font-size:16px; font-weight:normal; color:##666;"><img src="#Application.Settings.RootPath#/_images/icons/lock.png" /></span></cfif> <span><a href="#myself##Attributes.Fuseaction#?PersonID=#Attributes.PersonID#" target="_parent" style="font-size:13px;">View In Primary Window</a></span></div>
    <div class="clear-fix"><cf_ceTabControl Instance="MultiForm" Labels="#Request.MultiFormLabels#" Fuseactions="#Request.MultiFormFuseactions#" QueryString="#Request.MultiFormQS#" Current="#Attributes.Fuseaction#"></div>
    <table cellspacing="0" border="0" cellpadding="0" class="MultiForm">
        <tbody>
            <tr>
                <td class="MultiFormContent" >#Request.MultiFormContent#</td>
                <td class="MultiFormRight" valign="top">#Request.MultiFormRight#</td>
            </tr>
        </tbody>
    </table>
</cfif>
</cfoutput>
