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

<cfoutput>
<script>
$(document).ready(function() {

	<cfif NOT IsEditable>
		$('input,select,textarea').attr('disabled',true);
	</cfif>
	/* Status Changer */
	$("##StatusChanger").change(function() {
		$.post("/lms/_com/Person/PersonAjax.cfc", { method: "setStatus", PersonID: #Attributes.PersonID#, StatusID:$(this).val(), returnFormat:"plain" },
		  function(data){
			var cleanData = $.trim(data);
			addMessage("Person status changed successfully!",250,6000,4000);
		  });
	});
	
	/* NOTES DIALOG */
	$("##NotesList").dialog({ 
		title:"Notes",
		modal: false, 
		autoOpen: #Cookie.Settings.ActNotesOpen#,
		height:420,
		width:370,
		position:[#Cookie.Settings.ActNotesPos#],
		resizable: false,
		dragStop: function(ev,ui) {
			$.post("/lms/_com/UserSettings.cfc", { method:'setActNotesPos', position: ui.position.left + "," + ui.position.top });
		},
		open:function() {
			$("##NotesList").show();
			frmNotes.location = '#myself#Person.Notes?PersonID=#Attributes.PersonID#';
			$.post("/lms/_com/UserSettings.cfc", { method:'setActNotesOpen', IsOpen: 'true' });
			$("##NotesDialogLink").fadeOut();
		},
		close:function() {
			$("##NotesDialogLink").fadeIn();
			$.post("/lms/_com/UserSettings.cfc", { method:'setActNotesOpen', IsOpen: 'false' });
		}
	});

	$("##NotesDialogLink").click(function() {
		$("##NotesList").dialog("open");
	});
	/* // END NOTES DIALOG */
	
	/* UNSAVED CHANGES SCRIPTS */
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
			$("##Sect" + this).slideDown();
		});
		
		return false;
	});
	$(".FormTabs a:first").click();
	</cfif>
});
</script>
<link href="/_styles/Person.css" rel="stylesheet" type="text/css" />
<cfif PersonBean.getFirstName() EQ "" AND PersonBean.getLastName() EQ "" AND PersonBean.getBirthdate() EQ "" AND PersonBean.getSSN() EQ "">
	<div class="ContentTitle">THIS PERSON NO LONGER EXISTS</div>
<cfelse>
    <div class="ContentTitle">#Request.Page.Title#<cfif NOT IsEditable> <span style="font-size:16px; font-weight:normal; color:##666;"><img src="/lms/_images/Icons/lock.png" /></span></cfif></div>
    <div class="clear-fix"><cf_ceTabControl Instance="MultiForm" Labels="#Request.MultiFormLabels#" Fuseactions="#Request.MultiFormFuseactions#" QueryString="#Request.MultiFormQS#" Current="#Attributes.Fuseaction#"></div>
    <table width="979" cellspacing="0" border="0" cellpadding="0" class="MultiForm">
        <tbody>
            <tr>
                <td class="MultiFormContent">#Request.MultiFormContent#</td>
                <td class="MultiFormRight" valign="top" style="width:170px;" width="170">#Request.MultiFormRight#</td>
                <td class="InfoBar" valign="top">
                    <div id="Status">
                        <h3>Person Status</h3>
                        <table width="100%" cellspacing="1" border="0" cellpadding="2">
                            <tr>
                                <td>Status</td>
                                <td>
                                    <cfset qStatuses = Application.List.PersonStatuses>
                                    <select name="StatusChanger" id="StatusChanger" style="width:95px;">
                                        <cfloop query="qStatuses">
                                        <option value="#qStatuses.personstatusid#"<cfif PersonBean.getPersonStatusID() EQ qStatuses.personstatusid> selected</cfif>>#qStatuses.description#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="LatestActions">
                        <h3>Latest Actions</h3>
                        <div class="ActionList">
                        <cfif qActions.RecordCount GT 0>
                            <cfloop query="qActions">
                            <div class="ActionShort">#qActions.ShortName#</div>
                            <div class="ActionAuthor">by <a href="#myself#Person.Detail?PersonID=#qActions.CreatedBy#" title="#qActions.FirstName# #qActions.LastName#" style="color:##999;">#qActions.username#</a> on #DateFormat(qActions.Created,"mm/dd/yy")# #TimeFormat(qActions.Created,"hh:mmTT")#</div>
                            </cfloop>
                        </cfif>
                        </div>
                        <div style="padding:0px 4px 6px 8px;"><a href="#myself#Person.Actions?PersonID=#Attributes.PersonID#">View All Actions</a></div>
                    </div>
                    <div id="Stats">
                        <h3>Statistics</h3>
                        <table width="100%" cellspacing="1" cellpadding="3" border="0">
                            <tr>
                                <td width="46%" nowrap="nowrap">Activities:</td>
                                <td width="54%">&nbsp;</td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
    
    <div id="PersonDialogs">
        <a href="javascript:void(0);" id="NotesDialogLink" style="text-decoration:none;<cfif Cookie.Settings.ActNotesOpen>display:none;</cfif>"><img src="/lms/_images/note.gif" border="0" align="absmiddle" /> Open Notes</a><a href="#Myself#Person.VCard?PersonID=#Attributes.PersonID#" style="text-decoration:none;"><img src="/lms/_images/file_icons/vcf.png" border="0" align="absmiddle" /> Generate vCard</a>
    </div>
    <div id="NotesList" style="display:none;">
        <iframe width="360" height="380" src="" id="frmNotes" frameborder="0" name="frmNotes"></iframe>
    </div>
</cfif>
</cfoutput>
