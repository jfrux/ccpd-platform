<link href="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_styles/Forms.css" type="text/css" rel="stylesheet"  />
<cfquery name="qDegrees" datasource="#Application.Settings.DSN#">
	SELECT DegreeID,Name,Abbrev
	FROM ce_Sys_Degree
	ORDER BY Sort
</cfquery>

<cfquery name="qSpecialties" datasource="#Application.Settings.DSN#">
	SELECT SpecialtyID,Name,Description
	FROM ce_Sys_SpecialtyLMS
	ORDER BY Name
</cfquery>

<cfquery name="qPersonDegrees" datasource="#Application.Settings.DSN#">
	SELECT DegreeID FROM ce_Person_Degree
	WHERE PersonID=<cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag='N'
</cfquery>
<cfset PersonDegrees = "">

<cfloop query="qPersonDegrees">
	<cfset PersonDegrees = ListAppend(PersonDegrees,qPersonDegrees.DegreeID,',')>
</cfloop>

<cfquery name="qPersonSpecialty" datasource="#Application.Settings.DSN#">
	SELECT SpecialtyID FROM ce_Person_SpecialtyLMS
	WHERE PersonID=<cfqueryparam value="#Session.PersonID#" cfsqltype="cf_sql_integer" /> AND DeletedFlag='N'
</cfquery>
<cfset PersonSpecialties = "">

<cfloop query="qPersonSpecialty">
	<cfset PersonSpecialties = ListAppend(PersonSpecialties,qPersonSpecialty.SpecialtyID,',')>
</cfloop>

<script>
<cfoutput>
var nPerson = #session.personId#;
</cfoutput>
$(document).ready(function() {
	$('.add-link').click(function() {
		$container = $('<li />').text('New Email Address: ');
		$textField = $('<input />').attr({ 'type':'text', 'class':'new-email-address', 'name':'emailaddress0' });
		$cancelLink = $('<a />').attr({ 'class':'cancel-link', 'id':'cancel-0' }).css('cursor','pointer').text('CANCEL').click(function() { $(this).parent().detach(); });
		
		// BUILD HTML
		$container.append($textField);
		$container.append($cancelLink);
		
		// PLACE HTML
		$(this).parents('ul').append($container);
		$container.parent().append($(this).parent());
		
		// FOCUS ON FIELD
		$container.find('input').focus();
	});
	
	$(".CheckboxOption input").click(function() {
		$(".CheckboxOption").removeClass('.CheckboxOption SelectOn');
		$(this).parent().addClass('.CheckboxOption SelectOn');
	});
	
	$(".CheckboxOptionAlt input").click(function() {
		if($(this).attr('checked')) {
			$(this).parent().addClass('.CheckboxOptionAlt SelectOn');
		} else {
			$(this).parent().removeClass('.CheckboxOptionAlt SelectOn');
		}
	});
	
	$('.email-row').mouseover(function() {
		$($(this).find('.primary-link')).removeClass('dn');
	}).mouseout(function() {
		$($(this).find('.primary-link')).addClass('dn');
	});
	
	$('.verify-link').click(function() {
		var emailId = $(this).attr('id').split('-')[1];
	
		$.ajax({
			url: sRootPath + '/_com/ajax_person.cfc',
			type: 'post',
			data: { method: 'sendVerificationEmail', email_id: emailId, returnFormat: 'plain' },
			dataType: 'json',
			success: function(data) {
				if(data.STATUS) {
					alert(data.STATUSMSG);
				}
			}
		});
	});
	
	$('#frmAccount').submit(function() {
		$('.email-exists').detach();
		
		// CHECK IF ANY NEW EMAILS ARE ALREADY IN USE WITHIN THE DATABASE
		$('.new-email-address').each(function(i, item) {
			$.ajax({
				url: sRootPath + '/_com/ajax_person.cfc',
				type: 'post',
				data: { method: 'emailExists', email_address: $(this).val(), returnFormat: 'plain' },
				dataType: 'json',
				async: false,
				success: function(data)  {
					if(data.STATUS) {
						$errorMsg = $('<span />').attr('class','email-exists').css('color','#FF0000').text($(item).val() + ' already exists');
						$(item).parent().append($errorMsg);
					}
				}
			});
		});
		
		if ($('.email-exists').length > 0){
		  return false;
		}
	});
});
</script>
<style>
a { text-decoration: none; }
ul { list-style-type:none; }
li span { font-size:11px; }
.needs-verified { background-color: #EEEEEE; }
.verify-link { color: #FF0000; }
</style>
<cfoutput>
<form action="#myself#Member.Account" method="post" name="frmAccount" id="frmAccount">
<div class="ContentBlock">
	<div id="ContentLeft">
		<h1>Preferences</h1>
        <p class="message_list">
        <cfif isDefined("Attributes.Message") AND Attributes.Message NEQ "">
        	#Attributes.Message#
        </cfif>
        </p>
		<h2 class="Head Gray">Credentials</h2>
		<p>
        <div class="Credentials">
            <div id="EmailContainer">
				<div style="font-size:11px;font-style:italic;color:##777;padding:5px;clear:both;">Below is a list of email addresses we have on file for you.</div>
                <!--- CURRENT EMAIL ADDRESSES GO HERE --->
                <table style="width:80%;" cellspacing="0" cellpadding="2">
                    <tbody>
	                	<cfloop query="emailList">
                        <tr class="email-row<cfif NOT emailList.is_verified> needs-verified</cfif>" id="email-#emailList.email_id#">
                        	<cfif emailList.isPrimaryEmail>
                        	<td width="100" class="primary-container"><strong>PRIMARY</strong></td>
                            <cfelse>
                        	<td width="100" class="primary-container"><cfif emailList.is_verified><a href="#application.settings.rootPath#/event/member.primaryemail?id=#emailList.email_id#" class="primary-link dn" id="primary-#emailList.email_id#">make primary</a></cfif></td>
                            </cfif>
                        	<td>#emailList.email_address#</td>
                        	<td><span>
                            	<cfif emailList.is_verified EQ 0>
                                	<a href="javascript://" class="verify-link" id="verify-#emailList.email_id#">NEEDS VERIFIED</a> OR 
                                </cfif>
                                <cfif NOT emailList.isPrimaryEmail>
	                                <a href="#application.settings.rootPath#/event/member.deleteemail?id=#emailList.email_id#" class="delete-link" id="delete-#emailList.email_id#">DELETE</a>
								</cfif>
                                </span>
                            </td>
                        </tr>
                        </cfloop>
                    </tbody>
                </table>
                <!--- NEW EMAIL ADDRESSES GO HERE --->
            	<ul>
                    <li><a href="javascript://" class="add-link">Add new email address</a></li>
                </ul>
            </div>
			<div style="font-size:11px;font-style:italic;color:##777;padding:5px;clear:both;">Use the fields below if you wish to update your password</div>
            <div id="PasswordContainer">Password: <input type="password" name="Password" id="Password" /> Confirm Password: <input type="password" name="Conpassword" id="Conpassword" /></div>
        </div>
        </p>
        <cfif Session.PersonId EQ 113290>
        </cfif>
		<h2 class="Head Gray">Notifications</h2>
		<p>
			 <input type="checkbox" name="EmailSpecialty" id="EmailSpecialty" value="Y"<cfif Attributes.EmailSpecialty EQ "Y"> checked</cfif> /> <label for="EmailSpecialty">Please send me email notifications about changes made to my account, and credit awarded</label>
		 to me.</p>
		<h2 class="Head Gray">Profession</h2>
		<p>
			
			<cfloop query="qDegrees">
			<div class="CheckboxOption <cfif ListFind(PersonDegrees,qDegrees.DegreeID,",")> SelectOn</cfif>"><input id="Degree#qDegrees.DegreeID#" type="radio" name="Degree" value="#qDegrees.DegreeID#" <cfif ListFind(PersonDegrees,qDegrees.DegreeID,",")> checked</cfif> /> <label for="Degree#qDegrees.DegreeID#">#qDegrees.Name#</label></div>
			</cfloop>
			<div style="font-size:11px;font-style:italic;color:##777;padding:5px;clear:both;">This helps us determine the type of credit and certificate that you receive.</div>
		</p>
		<h2 class="Head Gray">Specialty Interests</h2>
		<p>
			<!--- CREATE ORGANIZING VARIABLES --->
			<cfset MaxPerColumn = Round(qSpecialties.RecordCount / 3)>
			<cfset RecordCounter = 0>
			
			<div style="float:left;">
			<!--- LOOP THROUGH QUERY --->
			<cfloop query="qSpecialties">
			<div class="CheckboxOptionAlt <cfif ListFind(PersonSpecialties,qSpecialties.SpecialtyID,",")> SelectOn</cfif>"><input type="checkbox" name="Specialties" id="Specialty#qSpecialties.SpecialtyID#"<cfif ListFind(PersonSpecialties,qSpecialties.SpecialtyID,",")> checked</cfif> value="#qSpecialties.SpecialtyID#" /> <label for="Specialty#qSpecialties.SpecialtyID#">#qSpecialties.Name#</label></div>
			<cfset RecordCounter = RecordCounter + 1>
			
			<cfif RecordCounter EQ MaxPerColumn>
				<cfset RecordCounter = 0>
				</div>
				<div style="float:left;">
			</cfif>
			</cfloop>
			</div>
		</p>
		<input type="hidden" name="Submitted" value="1" />
	</div>
	<div id="ContentRight">
		<input type="submit" value="Save Preferences" name="Submit" id="Submit" />
	</div>	
</div>
</form>
</cfoutput>