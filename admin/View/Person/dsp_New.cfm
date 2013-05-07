<link rel="stylesheet" href="/_styles/person.css" type="text/css" />

<cfparam name="Attributes.PersonID" type="numeric" default="0">
<cfparam name="Attributes.FirstName" type="String" default="">
<cfparam name="Attributes.MiddleName" type="String" default="">
<cfparam name="Attributes.LastName" type="String" default="">
<cfparam name="Attributes.BirthDate" type="String" default="">
<cfparam name="Attributes.Email" type="String" default="">
<cfparam name="Attributes.SSN" type="String" default="">
<cfparam name="Attributes.QuickEntry" type="string" default="N">
<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.Instance" default="">

<script>
<cfoutput>
nPerson = #Attributes.PersonID#;
sMode = "#Attributes.Mode#";
sQuickEntry = "#Attributes.QuickEntry#";
nDegree = 7;
<cfif Attributes.Instance NEQ "">
nActivity = #Attributes.ActivityID#;
sInstance = "#Attributes.Instance#";
</cfif>
</cfoutput>

function checkQuickEntry() {
	if($("#QuickEntry").attr("checked")) {
		sQuickEntry = "Y";
	} else {
		sQuickEntry = "N";
	}
}

function savePerson(CurrID) {
	var sFirstName = $("#FirstName").val();
	var sMiddleName = $("#MiddleName").val();
	var sLastName = $("#LastName").val();
	var dtBirthdate = $("#date1").val();
	var nSSN = $("#SSN").val();
	var sEmail = $("#Email").val();
	var sPassword = $("#Password").val();
	var sConfirmPassword = $("#ConfirmPassword").val();
	var sSkip = "N";
	var nError = 0;
	
	if(sFirstName == "") {
		addError("Please enter a First Name.",250,6000,4000);
		nError = nError + 1;
	}
	
	if(sLastName == "") {
		addError("Please enter a Last Name.",250,6000,4000);
		nError = nError + 1;
	}
		
	
	if(sEmail == "") {
		if(!$.IsDate(dtBirthdate) && nSSN == "") {
			addError("You must provide either Last 4 of SSN and valid Birthdate or an Email Address.",250,6000,4000);
			nError = nError + 1;
		} else if(!$.IsDate(dtBirthdate)) {
			addError("You must provide a valid Birthdate.",250,6000,4000);
			nError = nError + 1;
		} else if(nSSN == "" || ($.Len(nSSN) != 4)) {
			addError("You must provide Last 4 SSN.",250,6000,4000);
			nError = nError + 1;
		}
	}
	
	if($.Len(sPassword) > 0) {
		if(sPassword != sConfirmPassword) {
			addError("The password you have entered does not match the confirmed password.",250,6000,4000);
			nError = nError + 1;
		}
	}
	
	if(nError > 0) {
		return false;
	} else {
		if(CurrID == "skip-dup") {
			sSkip = "Y";
		}
	}
	
	$.getJSON(sRootPath + "/_com/AJAX_Person.cfc", { method: "createPerson", PersonID: nPerson, FirstName: sFirstName, MiddleName: sMiddleName, LastName: sLastName, Birthdate: dtBirthdate, SSN: nSSN, Password: sPassword, Email: sEmail, DegreeID: nDegree, SkipDuplicates: sSkip, returnFormat: "plain" },
		function(data) {
			if(data.STATUS) {
				<cfif listFind("Attendee,Faculty,Committee",attributes.instance)>
					window.location = sMyself + "Person.Finder?Instance=" + sInstance + "&ActivityID=" + nActivity + "&PersonID=" + data.STATUSMSG + "&Message=Personal Data has been saved!";
				<cfelse>
					if(sQuickEntry == "N") {
						window.location = sMyself + "Person.Detail?PersonID=" + data.STATUSMSG;
					} else {
						$("#FirstName").val("");
						$("#MiddleName").val("");
						$("#LastName").val("");
						$("#Email").val("");
						$("#Password").val("");
						$("#ConfirmPassword").val("");
						$("#date1").val("");
						$("#SSN").val("");
						
						$(".duplicate-viewer").dialog("close");
						
						addMessage("Person has been saved.",250,6000,4000);	
					}
				</cfif>
			} else if($.ArrayLen(data.DATASET) > 0) {
				var sTempHTML = "";
				var oSkipDup = "<a href='javascript://' class='person-save' id='skip-dup'>Create person anyway</a>";
				
				sTempHTML = "<table spacing='0'>";
				sTempHTML = sTempHTML + "<tr style='background-color: #DDD;'>";
				sTempHTML = sTempHTML + "<td width='100'></td>";
				sTempHTML = sTempHTML + "<td width='200'>Name</td>";
				sTempHTML = sTempHTML + "<td width='150'>Birth Date</td>";
				sTempHTML = sTempHTML + "<td width='180'>Email</td>";
				sTempHTML = sTempHTML + "</tr>";
				
				$.each(data.DATASET, function(i,item){
					var nPerson = item.PERSONID;
					var sFullName = item.FIRSTNAME + " " + item.LASTNAME;
					var dtBirthdate = item.BIRTHDATE;
					var sEmail = item.EMAIL;
					
					sTempHTML = sTempHTML + "<tr>";
					sTempHTML = sTempHTML + "<td><a href='" + sMyself + "Person.Detail?PersonID=" + nPerson + "'>View Profile</a></td>";
					sTempHTML = sTempHTML + "<td>" + sFullName + "</td>";
					sTempHTML = sTempHTML + "<td>" + dtBirthdate + "</td>";
					sTempHTML = sTempHTML + "<td>" + sEmail + "</td>";
					sTempHTML = sTempHTML + "</tr>";
				});
				
				sTempHTML = sTempHTML + "<tr>";
				sTempHTML = sTempHTML + "<td colspan='4'>" + oSkipDup +"</td>";
				sTempHTML = sTempHTML + "</tr>";
				sTempHTML = sTempHTML + "</table>";
				
				$(".duplicate-viewer").html(sTempHTML);
				$(".duplicate-viewer").dialog("open");
			} else {
				$.each(data.ERRORS, function(i,item){
					addError(item.MESSAGE,250,6000,4000);
				});
				
				$(".saving").css("display","none");
				$(".person-save").css("display","");
			}
			
			
			return false;
			var Status = $.ListGetAt(cleanData, 1, "|");
			
			if($.Left(cleanData, 1) == "{") {
				
			} 
	});
}

function proceed() {
	$("#frmPersonCreate").attr("action","Person.Create?ForceCreate=1");
	SubmitForm(document.frmPersonCreate);
}

function recede() {
	$.unblockUI();
}
	
function updateDegreeOption(nId) {
	$(".degreeOption").removeClass("formOptionSelected");
	$("#degree-" + nId).addClass("formOptionSelected");
	nDegree = nId;
}

function clearDegreeInfo() {
	nDegree = 7;
	$(".degreeOption").addClass("formOption");
	$("#DegreeID-" + nDegree).attr("Checked", true);
	updateDegreeOption(nDegree);
}

$(document).ready(function() {
	checkQuickEntry();
	clearDegreeInfo();
	$("#FirstName").focus();
	
	$(".degreeid").click(function() {
		var nId = $.ListGetAt(this.id, 2, "-");
		updateDegreeOption(nId);
	});
	
	<cfif isDefined("qDupes") and qDupes.RecordCount GT 0>
	$.blockUI({ message: $('#DupesList'), css: { width:'550px', left:'5px', top:'5px' } }); 
	$(document).keyup(function(e) {
		if(e.keyCode == 13) {
			proceed();
		}
		
		if(e.keyCode == 27){ 
			recede();
		}
	});
	
	$("#Continue").click(function() {
		proceed();
	});
	
	$("#Cancel").click(function() {
		recede();
	});
	</cfif>
	
	$(".PasswordLink").bind("click", this, function() {
		var sAction = $.ListGetAt(this.id, 2, "-");
		
		if(sAction == "show") {
			$("#password-show").hide();
			$("#password-hide").show();
			
			$(".Password").show();
		} else {
			$("#password-hide").hide();
			$("#password-show").show();
			
			$("#Password").val("");
			$("#ConfirmPassword").val("");
			
			$(".Password").hide();
		}
	});
	
	$("#QuickEntry").bind("change", this, function() {
		checkQuickEntry();
	});
	
	$(".person-save").live("click", function() {
		savePerson();
	});
	
	$(document).keyup(function(e) {
		if(e.keyCode == 13) {
			console.log("OUT");
			savePerson();
		}
	});
	
	$(".duplicate-viewer").dialog({ 
		title: "Duplicates Found",
		modal: true, 
		autoOpen: false,
		position:[40,40],
		height:270,
		width:700,
		resizable: false,
		open:function() {
			$(".duplicate-viewer").show();
		},
		close:function() {
			$(".duplicate-viewer").hide();
			$(".duplicate-viewer").html("");
		}
	});
});
</script>
<cfoutput>
<div class="ViewSection">
	<h3>General Information</h3>
    	<div class="left-side">
		
		<table width="100%">
        	<tr>
            	<td width="50%">
                	<table>
                        <tr>
                            <td><label for="PersonID">First Name:</label></td>
                            <td><input id="FirstName" name="FirstName" type="text" class="inputText" style="width:100px;" value="#Attributes.FirstName#" /></td>
                        </tr>
                        <tr>
                            <td><label for="PersonID">Middle Name:</label></td>
                            <td><input id="MiddleName" name="MiddleName" type="text" class="inputText" style="width:100px;" value="#Attributes.MiddleName#" /></td>
                        </tr>
                        <tr>
                            <td><label for="PersonID">Last Name:</label></td>
                            <td><input id="LastName" name="LastName" type="text" class="inputText" style="width:100px;" value="#Attributes.LastName#" /></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                            <td><label for="PersonID">Email:</label></td>
                            <td><input id="Email" name="Email" type="text" class="inputText" value="#Attributes.Email#" style="width:270px;" /></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <a href="javascript://" id="password-show" class="PasswordLink">Set password</a>
                                <a href="javascript://" id="password-hide" class="PasswordLink" style="display:none;">Cancel set password</a>
                            </td>
                        </tr>
                        <tr class="Password" style="display: none;">
                            <td><label for="PersonID">Password:</label></td>
                            <td><input id="Password" name="Password" type="Password" class="inputText" value="" /></td>
                        </tr>
                        <tr class="Password" style="display: none;">
                            <td><label for="PersonID">Confirm Password:</label></td>
                            <td><input id="ConfirmPassword" name="ConfirmPassword" type="Password" class="inputText" value="" /></td>
                        </tr>
                        <tr>
                            <td colspan="2">-------------------------OR-------------------------</td>
                        </tr>
                        <tr>
                            <td><label for="PersonID">Birth Date:</label></td>
                            <td><input id="date1" name="BirthDate" type="text" class="inputText" style="width:100px;" value="#Attributes.BirthDate#" /></td>
                        </tr>
                        <tr>
                            <td><label for="PersonID">Last 4 SSN:</label></td>
                            <td><input id="SSN" name="SSN" type="text" class="inputText" value="#Attributes.SSN#" /></td>
                        </tr>
                     </table>
                 </td>
                 <td width="50%" valign="top">
                 	<table>
                    	<tr>
                            <td colspan="2">
                                <h2>Profession</h2>
                                <div class="degrees">
                                <cfloop query="Application.List.Degrees">
                                    <div class="degreeOption" id="degree-#Application.List.Degrees.DegreeID#">
                                        <input type="radio" name="DegreeID" id="DegreeID-#Application.List.Degrees.DegreeID#" class="degreeid" value="#Application.List.Degrees.DegreeID#" />
                                        <label for="DegreeID-#Application.List.Degrees.DegreeID#"> #Application.List.Degrees.Name#</label>
                                    </div>
                                </cfloop>
                                </div>			
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
		<input type="hidden" name="Submitted" value="1" /><input type="hidden" name="Instance" id="Instance" value="#Attributes.Instance#" />
		<cfif Attributes.Mode NEQ "Insert"><input type="checkbox" name="QuickEntry" id="QuickEntry" value="Y"<cfif Attributes.QuickEntry EQ "Y"> checked</cfif> /> <label for="QuickEntry">Return me to this form automatically to enter another person.</label></cfif>
    <div class="duplicate-viewer" style="display: none;">
    
    </div>
	
	<cfif Attributes.Mode EQ "Insert">
	<div class="clear">
	<input type="button" value="Continue" class="person-save" />
	#jButton("Cancel","#myself#Person.Finder?instance=#attributes.instance#&activityId=#attributes.activityId#","delete","")# 
	</div>
	</cfif>
	
	<cfif isDefined("qDupes")>
	<div id="DupesList" style="display:none;text-align:left; padding:10px; width:550px;">
		<h2 style="font-size:18px;margin:0px;padding:0px;color:##FF0000;">Attention!</h2>
			<div>The following have been tagged as possible duplicates for your entry.<br />If you believe this is not a duplicate, simply press 'Enter' to continue.</div>
			<table border="0" width="500" cellpadding="0" cellspacing="0" class="ViewSectionGrid">
				<tbody>
					<cfloop query="qDupes">
						<tr>
							<td>#qDupes.LastName#, #qDupes.Salutation# #qDupes.FirstName# #qDupes.MiddleName#<cfif qDupes.NameSuffix NEQ ""> <span style="font-size:12px;color:##888;">#qDupes.NameSuffix#</span></cfif><cfif qDupes.DisplayDegree NEQ "">, #qDupes.DisplayDegree#</cfif></td>
							<td><cfif qDupes.UCID NEQ ""><img src="#Application.Settings.RootPath#/_images/uc_icon16x16.png" align="absmiddle" hspace="3" />#qDupes.UCID#<cfelse>&nbsp;</cfif></td>
							<td><cfif qDupes.Email1 NEQ "">#qDupes.Email1#<cfelse>&nbsp;</cfif></td>
							<td><cfif qDupes.Birthdate NEQ "">#DateFormat(qDupes.Birthdate,"mm/dd/yyyy")#</cfif></td>
						</tr>
					</cfloop>
				</tbody>
			</table>
			<div style="padding:8px 0px 0px 0px;"><input type="button" id="Continue" value="Proceed Anyway" /> <input type="button" id="Cancel" value="Cancel" /></div>
	</div>
	</cfif>
</div>
</div>
</div>
</cfoutput>