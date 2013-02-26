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
nPerson = #Attributes.PersonID#;
sPersonName = '#replace(Attributes.FirstName, "'", "\'", "ALL")# #replace(Attributes.LastName, "'", "\'", "ALL")#';
<cfif Session.Account.getAuthorityID() EQ 3>
nAccount = #Attributes.AccountID#;
</cfif>
cActNotesOpen = #Cookie.USER_ActNotesOpen#;
cActNotesPosX = #getToken(Cookie.USER_ActNotesPos,1,",")#;
cActNotesPosY = #getToken(Cookie.USER_ActNotesPos,2,",")#;
</cfoutput>

function updateAll() {
	updateActions();
}

function updateActions() {
	$.post(sMyself + 'Person.ActionsShort', { PersonID: nPerson }, 
		function(data) {
			$('#LatestActions').html(data);
			$('#LatestActions').show();
	});
}

function updateAccountID(sAccountID) {
	$('#AccountID').html(sAccountID);
}

$(document).ready(function() {
	updateAll();

	<cfif NOT IsEditable>
		$('input,select,textarea').attr('disabled',true);
	</cfif>
	<cfif Session.Account.getAuthorityID() EQ 3>
	/* Authority Level Changer */
	$('#AuthLevel').change(function() {
		$.getJSON(sRootPath + '/_com/AJAX_Person.cfc', { method: 'setAuthLevel', AccountID: nAccount, AuthorityID:$(this).val(), returnFormat:'plain' },
		  function(data){
			if(data.STATUS) {
				addMessage(data.STATUSMSG,250,6000,4000);
			} else {
				addError(data.STATUSMSG,250,6000,4000);
			}
		});
	});
	</cfif>
	/* Status Changer */
	$('#StatusChanger').change(function() {
		$.getJSON(sRootPath + '/_com/AJAX_Person.cfc', { method: 'setStatus', PersonID: nPerson, StatusID:$(this).val(), returnFormat:'plain' },
		  function(data){
		  	if(data.STATUS) {
				addMessage(data.STATUSMSG,250,6000,4000);
			} else {
				addError(data.STATUSMSG,250,6000,4000);
			}
		  });
	});
	
	/* NOTES DIALOG */
	$('#NotesList').dialog({ 
		title:'Notes',
		modal: false, 
		autoOpen: cActNotesOpen,
		height:420,
		width:370,
		position:[cActNotesPosX,cActNotesPosY],
		resizable: false,
		dragStop: function(ev,ui) {
			$.post(sRootPath + '/_com/UserSettings.cfc', { method:'setActNotesPos', position: ui.position.left + ',' + ui.position.top });
		},
		open:function() {
			$('#frmNotes').attr('src',sMyself + 'Person.Notes?PersonID=' + nPerson);
			$('#NotesList').show();
			$.post(sRootPath + '/_com/UserSettings.cfc', { method:'setActNotesOpen', IsOpen: 'true' });
			$('#NotesDialogLink').fadeOut();
		},
		close:function() {
			$('#NotesDialogLink').fadeIn();
			$('#frmNotes').html('');
			$('#frmNotes').attr('src','');
			$.post(sRootPath + '/_com/UserSettings.cfc', { method:'setActNotesOpen', IsOpen: 'false' });
		}
	});

	$('#NotesDialogLink').click(function() {
		$('#NotesList').dialog('open');
	});
	/* // END NOTES DIALOG */
	
	/* CREDENTIALS DIALOG */
	$('#CredentialsContainer').dialog({ 
		title:'Credentials',
		modal: false, 
		autoOpen: false,
		height:200,
		width:370,
		position:[100,100],
		resizable: false,
		buttons: {
				'Save': function() {
					var sPass = $('#NewPassword').val();
					var sConPass = $('#ConfirmPassword').val();
					
					$.getJSON(sRootPath + '/_com/AJAX_Person.cfc', { method: 'saveCredentials', PersonID: nPerson, Pass: sPass, ConPass: sConPass },
						function(data) {
							if(data.STATUS) {
								addMessage(data.STATUSMSG,250,6000,4000);
								$('#CredentialsContainer').dialog('close');
								$('#NewPassword').val('');
								$('#ConfirmPassword').val('');
							} else {
								if($.ArrayLen(data.ERRORS) > 0) {
									$.each(data.ERRORS, function(i,item){
										addError(item.MESSAGE,250,6000,4000);
									});
								} else {
									addError(data.STATUSMSG,250,6000,4000);
								}
							}
					});
				},
				'Close': function() {
					$('#CredentialsContainer').dialog('close');
					$('#CredentialsContainer').html('');
				}
		},
		open:function() {
			$.post(sMyself + "Person.Credentials", { PersonID: nPerson },
				function(data) {
					$('#CredentialsContainer').html(data);
			});
			
			$('#CredentialsDialogLink').fadeOut();
		},
		close:function() {
			$('#CredentialsDialogLink').fadeIn();
		}
	});

	$('#CredentialsDialogLink').click(function() {
		$('#CredentialsContainer').dialog('open');
	});
	/* // END CREDENTIALS DIALOG */
	
	/* START DELETE PERSON */
	$("#DeletePersonLink").click(function() {
		var sReason = prompt("Do you really want to delete " + sPersonName + "?  What is the reason?","");
		
		if(sReason != null && sReason != "") {
			$.getJSON(sRootPath + "/_com/AJAX_Person.cfc", { method: "deletePerson", PersonID: nPerson, Reason: sReason, returnFormat: "plain" },
				function(data) {					
					if(data.STATUS) {
						window.location = sMyself + "Person.Home?Message=" + data.STATUSMSG;
					} else {
						addError(data.STATUSMSG,250,6000,4000);
					}
			});
		} else {
			addError('Please provide a reason.',250,6000,4000);
		}
	});
	/* END DELETE PERSON */
	
	/* THIS SECTION WAS COMMENTED OUT BY JUSTIN SLAMKA DUE TO INCOMPATIBILITY WITH OTHER UNSAVED CHANGES CODE (/view/includes/SaveJS.cfm) // 07/14/2010
	UNSAVED CHANGES SCRIPTS */
	/* var Unsaved = false;
	var question232 = $('#question232');
	var TheLink = '';
	$('.PageStandard').hide();
	
	$('form input,form textarea').bind('keyup', function(){
		if (Unsaved==false) {
			Unsaved = true;
			$('#StatusBar').show();
			
			$('.PageStandard').fadeIn('slow').html('Unsaved Changes...');;
		}
	});
	
	$('form select').bind('change', function(){
		$('#StatusBar').show();
		$('.PageStandard').fadeIn('slow').html('Unsaved Changes...');;
		Unsaved = true;
	});
	
	$('a').bind('click', this, function(){
			TheLink = this.href;
			if (Unsaved) {
				$('#StatusBar').hide().fadeIn('fast').addClass('StatusError').fadeOut('fast').fadeIn('fast').fadeOut('fast').fadeIn('fast').html('Unsaved Changes...');
				$.extend($.blockUI.defaults.overlayCSS, { backgroundColor: '#000' });
				$.blockUI({message: question232, width: '275px' });
				
				return false;
			}
		});
	
	$('#yes').click(function() { 
		$.unblockUI();
		window.location=TheLink;
	}); 
	
	$('#no').click($.unblockUI); */
	
	$('a.button').unbind('click');
	
	<cfif Request.MultiSubTabFlag EQ "Y">
	$('.FormSection').hide();

	$('.FormTabs a').addClass('FormTab').unbind('click');
	$('.FormTabs a').bind('click', this, function() { 
		$('.FormTabs a').removeClass('FormTabOn');
		
		$(this).addClass('FormTabOn');
		
		aSections = $.ListToArray(this.id,'|');
		
		$('.FormSection').hide();
		
		$.each(aSections, function() {
			$('#Sect' + this).slideDown();
		});
		
		return false;
	});
	$('.FormTabs a:first').click();
	</cfif>
});
</script>

<cfoutput>
<link href="#Application.Settings.RootPath#/_styles/Person.css" rel="stylesheet" type="text/css" />
<cfif PersonBean.getFirstName() EQ "" AND PersonBean.getLastName() EQ "" AND PersonBean.getBirthdate() EQ "" AND PersonBean.getSSN() EQ "">
	<div class="ContentTitle">THIS PERSON NO LONGER EXISTS</div>
<cfelse>
    <h1>#PersonBean.getDisplayName()#<span>(#PersonBean.getLastName()#, #PersonBean.getFirstName()#)</span><cfif personBean.getDeletedFlag() EQ "Y"><span><font color="##DDBBBB"><strong>DELETED</strong></font></span></cfif><!---<cfif NOT IsEditable> <span style="font-size:16px; font-weight:normal; color:##666;"><img src="#Application.Settings.RootPath#/_images/icons/lock.png" /></span></cfif>--->
	</h1>
    <div class="clear-fix"><cf_ceTabControl Instance="MultiForm" Labels="#Request.MultiFormLabels#" Fuseactions="#Request.MultiFormFuseactions#" QueryString="#Request.MultiFormQS#" Current="#Attributes.Fuseaction#"></div>
    <table width="960" cellspacing="0" border="0" cellpadding="0" class="MultiForm">
        <tbody>
            <tr>
                <td class="MultiFormContent">#Request.MultiFormContent#</td>
                <td class="MultiFormRight" valign="top" style="width:170px;" width="170">#Request.MultiFormRight#</td>
                <td class="InfoBar" valign="top">
                	<cfif Session.Account.getAuthorityID() EQ 3>
                    <div id="Authority">
                        <h3>Authority Level</h3>
                        <table width="100%" cellspacing="1" border="0" cellpadding="2">
                            <tr>
                                <td>Level</td>
                                <td>
                                    <cfset qAuthLevels = Application.List.AuthLevels>
                                    <select name="AuthLevel" id="AuthLevel" style="width:95px;">
                                    	<option value="0">None</option>
                                    	<cfloop query="qAuthLevels">
                                        <option value="#Trim(qAuthLevels.AuthID)#"<cfif Attributes.AuthorityID EQ qAuthLevels.AuthID> SELECTED</cfif>>#qAuthLevels.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
                    </cfif>
                    <div id="Status">
                        <h3>Person Status</h3>
                        <table width="100%" cellspacing="1" border="0" cellpadding="2">
                            <tr>
                                <td>Status</td>
                                <td>
                                    <cfset qStatuses = Application.List.PersonStatuses>
                                    <select name="StatusChanger" id="StatusChanger" style="width:95px;">
                                        <cfloop query="qStatuses">
                                        <option value="#qStatuses.personstatusid#"<cfif PersonBean.getStatusID() EQ qStatuses.personstatusid> selected</cfif>>#qStatuses.Name#</option>
                                        </cfloop>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
					<div id="GlobalOptions">
                    	<cfif Attributes.PersonID NEQ Session.PersonID>
						<h3>Global Options</h3>
						<div style="padding:6px 4px;"><a href="javascript://" id="DeletePersonLink" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/user_delete.png" align="absmiddle" style="padding-right:4px;" />Delete Person</a></div>
                        </cfif>
					</div>
                </td>
            </tr>
        </tbody>
    </table>
    
    <div id="PersonDialogs">
        <a href="javascript:void(0);" id="CredentialsDialogLink" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/icons/lock.png" border="0" align="absmiddle" /> Credentials</a>
        <a href="javascript:void(0);" id="NotesDialogLink" style="text-decoration:none;<cfif Cookie.USER_ActNotesOpen>display:none;</cfif>"><img src="#Application.Settings.RootPath#/_images/icons/note.png" border="0" align="absmiddle" /> Open Notes</a>
        <a href="#Myself#Person.VCard?PersonID=#Attributes.PersonID#" style="text-decoration:none;"><img src="#Application.Settings.RootPath#/_images/file_icons/vcf.png" border="0" align="absmiddle" /> Generate vCard</a>
    </div>
    <div id="NotesList" style="display:none;">
        <iframe width="360" height="380" src="" id="frmNotes" frameborder="0" name="frmNotes"></iframe>
    </div>
    <div id="CredentialsContainer" style="display: none;">
    </div>
</cfif>
</cfoutput>
