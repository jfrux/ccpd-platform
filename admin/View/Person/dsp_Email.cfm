<script>
var nId = 0;
var currElem;

function addEmail() {
	var $content = $('#new-email-address').tmpl();
	var $cancelLink = $content.find('.cancel-link');
	var $saveLink = $content.find('.save-link');
	
	$content.appendTo('#email-addresses');
	
	setFocus($content);
	
	$cancelLink.click(function() {
		cancelFunc($(this));
	});
	
	$saveLink.click(function() {
		saveFunc($(this));
	});
	
}

function cancelFunc($elem) {
	var emailId = $elem.attr('id').split('-')[1];
	var $editRow = $($elem.parents('tr')[0]);
	var $viewRow = $editRow.prev();
	
	if(emailId == 0) {
		$editRow.detach();
	} else {
		showViews();
	}
}

function deleteFunc($elem) {
	var emailId = $elem.attr('id').split('-')[1];
	var $viewRow = $($elem.parents('tr')[0]);
	var emailAddress = $viewRow.find('.email-address').text();
	
	if(confirm('Are you sure you want to delete the email address \'' + emailAddress + '\'?  It will be permanently removed from the database.')) {
		if(emailId == 0) {
		} else {
			$.ajax({
				url: sRootPath + '/_com/ajax_person.cfc',
				type: 'post',
				data: { method: 'deleteEmail', person_id: nPerson, email_id: emailId, returnFormat: 'plain' },
				dataType: 'json',
				success: function(data) {
					if(data.STATUS) {
						addMessage(data.STATUSMSG,250,6000,4000);
						currElem = '';
						updateEmailList();
					} else {
						if(data.ERRORS.length > 0) {
							$.each(data.ERRORS, function(i, item) {
								addError(item.MESSAGE,250,6000,4000);
							});
						} else {
							addError(data.STATUSMSG,250,6000,4000);
						}
					}
				}
			});
			$('.email-' + emailId).detach();
		}
	}
}

function editFunc($elem) {
	var emailId = $elem.attr('id').split('-')[1];
	var $viewRow = $($elem.parents('tr')[0]);
	var $editRow = $viewRow.next();
	
	// HIDE ALL EDIT ROWS AND SHOW ALL VIEW ROWS
	showViews();
	
	// SWITCH OUT CURRENT FORMS
	$viewRow.addClass('dn');
	$editRow.removeClass('dn');
	
	// SET FORM FIELD FOCUS
	setFocus($editRow);
}

function hidePrimaryLink($elem) {
	$link = $elem.find('.primary-link');
	$link.addClass('dn');
}

function saveFunc($elem) {
	var emailId = $elem.attr('id').split('-')[1];
	var $editRow = $($elem.parents('tr')[0]);
	var $viewRow = $editRow.prev();
	var allowLogin = $editRow.find('.allow_login').val();
	var emailAddress = $editRow.find('.email_address').val();
	var isPrimary = $editRow.find('.is_primary').val();
	var isVerified = $editRow.find('.is_verified').val();
	
	$.ajax({
		url: sRootPath + '/_com/ajax_person.cfc',
		type: 'post',
		data: { method: 'saveEmail', email_id: emailId, person_id: nPerson, allow_login: allowLogin, email_address: emailAddress, is_primary: isPrimary, is_verified: isVerified, returnFormat: 'plain' },
		dataType: 'json',
		success: function(data) {
			if(data.STATUS) {
				addMessage(data.STATUSMSG,250,6000,4000);
				currElem = '';
				updateEmailList();
			} else {
				if(data.ERRORS.length > 0) {
					$.each(data.ERRORS, function(i, item) {
						addError(item.MESSAGE,250,6000,4000);
					});
				} else {
					addError(data.STATUSMSG,250,6000,4000);
				}
			}
		}
	});
	
	return false;
}

function setFocus($elem) {
	var $emailAddress = $elem.find('.email_address');
	var $saveLink = $elem.find('.save-link');
	
	currElem = $saveLink;
	
	$emailAddress.focus();
}

function setPrimaryEmail($elem) {
	var emailId = $elem.attr('id').split('-')[1];
	
	$.ajax({
		url: sRootPath + '/_com/ajax_person.cfc',
		type: 'post',
		data: { method: 'setPrimaryEmail', email_id: emailId, person_id: nPerson, returnFormat: 'plain' },
		dataType: 'json',
		success: function(data) {
			if(data.STATUS) {
				addMessage(data.STATUSMSG,250,6000,4000);
				updateEmailList();
			} else {
				addError(data.STATUSMSG,250,6000,4000);
			}
		}
	});
}

function showPrimaryLink($elem) {
	$link = $elem.find('.primary-link');
	$link.removeClass('dn');
}

function showViews() {
	$('.edit-row').addClass('dn');
	$('.view-row').removeClass('dn');
}

function updateEmailList() {
	$.post(sMyself + "Person.EmailAHAH", { PersonID: nPerson },
		function(data) {
			$("#EmailContainer").html(data);
			$("#EmailLoading").hide();
			
	});
}

function verifyFunc($elem) {
	var emailId = $elem.attr('id').split('-')[1];
	
	$.ajax({
		url: sRootPath + '/_com/ajax_person.cfc',
		type: 'post',
		data: { method: 'sendVerificationEmail', email_id: emailId, returnFormat: 'plain' },
		dataType: 'json',
		success: function(data) {
			if(data.STATUS) {
				addMessage(data.STATUSMSG,250,6000,4000);
			} else {
				addError(data.STATUSMSG,250,6000,4000);
			}
		}
	});
}

$(document).ready(function() {
	updateEmailList();
	
	$('#addEmailAddress').click(function() {
		addEmail();
	});
	
	$('input,select').live('keyup', function(e) {
		if(e.keyCode == 13) {
			saveFunc(currElem);
		}
		return false;
	});
});
</script>

<div class="ViewSection">
	<div id="EmailContainer"></div>
	<div id="EmailLoading" class="Loading"><img src="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_images/ajax-loader.gif" />
	<div>Please Wait</div>
	</div>
</div>