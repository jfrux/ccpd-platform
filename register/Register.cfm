<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Cincinnati STD/HIV Prevention Training Center | Welcome Center</title>
<link href="styles/inc_styles.css" rel="stylesheet" type="text/css" />
<link href="styles/forms.css" rel="stylesheet" type="text/css" />
<cfinclude template="#Request.RootPath#/Includes/Inc_Scripts.cfm" />
</head>

<script>
var sDisplayName = "";

function updateDisplayName() {
	if($("#firstname").val() == "" || $("#lastname").val() == "") {
		$(".displayname-container").hide();
	} else {
		$(".displayname-container").show();
		
		if($.Len($("#middlename").val()) > 0) {
			// INTEGRATE MIDDLE NAME VALUE
			// RADIO VALUES
			$(".MiddleName").show();
			
			$("#displayname-1").val($("#firstname").val() + " " + $("#middlename").val() + " " + $("#lastname").val());
			$("#displayname-2").val($("#firstname").val() + " " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
			$("#displayname-3").val($.Left($("#firstname").val(),1) + ". " + $("#middlename").val() + " " + $("#lastname").val());
			$("#displayname-4").val($.Left($("#firstname").val(),1) + ". " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
			$("#displayname-5").val($("#firstname").val() + " " + $("#lastname").val());
			$("#displayname-6").val($.Left($("#firstname").val(),1) + ". " + $("#lastname").val());
		
			// TEXT DISPLAY
			$("#displayname-1-label").html($("#firstname").val() + " " + $("#middlename").val() + " " + $("#lastname").val());
			$("#displayname-2-label").html($("#firstname").val() + " " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
			$("#displayname-3-label").html($.Left($("#firstname").val(),1) + ". " + $("#middlename").val() + " " + $("#lastname").val());
			$("#displayname-4-label").html($.Left($("#firstname").val(),1) + ". " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
			$("#displayname-5-label").html($("#firstname").val() + " " + $("#lastname").val());
			$("#displayname-6-label").html($.Left($("#firstname").val(),1) + ". " + $("#lastname").val());
		} else {
			// DO NOT INTEGRATE MIDDLE NAME
			// RADIO VALUES
			$(".MiddleName").hide();
			
			$("#displayname-1").val($("#firstname").val() + " " + $("#middlename").val() + " " + $("#lastname").val());
			$("#displayname-2").val($("#firstname").val() + " " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
			$("#displayname-3").val($.Left($("#firstname").val(),1) + ". " + $("#middlename").val() + " " + $("#lastname").val());
			$("#displayname-4").val($.Left($("#firstname").val(),1) + ". " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
			$("#displayname-5").val($("#firstname").val() + " " + $("#lastname").val());
			$("#displayname-6").val($.Left($("#firstname").val(),1) + ". " + $("#lastname").val());
		
			// TEXT DISPLAY
			$("#displayname-1-label").html($("#firstname").val() + " " + $("#middlename").val() + " " + $("#lastname").val());
			$("#displayname-2-label").html($("#firstname").val() + " " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
			$("#displayname-3-label").html($.Left($("#firstname").val(),1) + ". " + $("#middlename").val() + " " + $("#lastname").val());
			$("#displayname-4-label").html($.Left($("#firstname").val(),1) + ". " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
			$("#displayname-5-label").html($("#firstname").val() + " " + $("#lastname").val());
			$("#displayname-6-label").html($.Left($("#firstname").val(),1) + ". " + $("#lastname").val());
		}
	}
}

function updateDisplayNameValue(sName) {
	$("#displaynamecustom").val(sName);
	$("#displayname-7").val(sName);
}

$(document).ready(function() {
	$(".displayname-container").hide(); 
	$("#date1").mask("99/99/9999");
	updateDisplayName();
	
	$("#frmSubmit").click(function() {
		$.getJSON(sRootPath + "/_com/AJAX_Auth.cfc", { method: "Validate", Birthdate: $("#date1").val(), FirstName: $("#firstname").val(), MiddleName: $("#middlename").val(), LastName: $("#lastname").val(), Suffix: $("#suffix").val(), DisplayName: $("#displaynamecustom").val(), Email1: $("#email1").val(), Email2: $("#email2").val(), SSN: $("#ssn").val(), Gender: $("#Gender").val(), Password1: $("#password1").val(), Password2: $("#password2").val(), returnFormat: "plain"}, 
			function(data) {
				
				if(data.STATUS) {
					$("#frmRegister").submit();
				} else {
					var sErrorList = "<ul>";
					
					// REMOVE ERROR CLASS
					$("label").removeClass("FieldInputErr");
					
					$.each(data.ERRORS, function(i,item){
						sErrorList = sErrorList + "<li>" + item.MESSAGE + "</li>";
						
						// TEST IF THE ERROR IS TIED TO TWO FIELDS
						if(!($.Find(":", item.FIELDNAME))) {
							$("#" + item.FIELDNAME + "-label").addClass("FieldInputErr");
						} else {
							$("#" + $.ListGetAt(item.FIELDNAME, 1, ":") + "-label").addClass("FieldInputErr");
							$("#" + $.ListGetAt(item.FIELDNAME, 2, ":") + "-label").addClass("FieldInputErr");
						}
					});
					
					sErrorList = sErrorList + "</ul>";
					$(".error_list").html(sErrorList);
					
					return false;
				}
		});
	});
	
	$("#firstname, #middlename, #lastname").keyup(function() {
		updateDisplayName();
	});
	
	$("#displaynamecustom").keyup(function() {
		$("#displayname-7").val($("#displaynamecustom").val());
	});
	
	$(".displayname").click(function() {
		updateDisplayNameValue($(this).val());
	});
});
</script>

<body>
<cfinclude template="includes/inc_header.cfm">
<table width="770" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="nav_cell" valign="top">
			<cfinclude template="includes/inc_nav.cfm">
		</td>
		<td class="content_cell" valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="content_title">Create Account</td>
				</tr>
                <tr>
                	<td class="error_list"></td>
                </tr>
				<tr>
                	<form name="frmRegister" id="frmRegister" method="post" action="<cfoutput>#Request.RootPath#</cfoutput>/_com/AJAX_Auth.cfc">
					<td class="content_body">
                        <table width="500" cellspacing="1" cellpadding="3" border="0">
                            <tr>
                                <td class="FieldLabel"><label for="firstname" id="firstname-label">First Name*</label></td>
                                <td class="FieldInput"><input name="firstname" id="firstname" type="text" size="20" style="width:150px;" /></td>
                            </tr>
                            <tr>
                                <td class="FieldLabel"><label for="middlename" id="middlename-label">Middle Name</label></td>
                                <td class="FieldInput"><input name="middlename" id="middlename" type="text" size="20" style="width:150px;" /></td>
                            </tr>
                            <tr>
                                <td class="FieldLabel"><label for="lastname" id="lastname-label">Last Name*</label></td>
                                <td class="FieldInput"><input name="lastname" id="lastname" type="text" size="20" style="width:150px;" /></td>
                            </tr>
                            <tr>
                            	<td class="FieldLabel"><label for="suffix" id="suffix-label">Suffix</label></td>
                            	<td class="FieldInput"><input name="suffix" id="suffix" type="text" size="20" style="width:150px;" /></td>
                            </tr>
                            <tr>
                                <td width="142" class="FieldLabel"><label for="email1" id="email1-label">Email Address*</label></td>
                                <td width="343" class="FieldInput"><input name="email1" id="email1" type="text" size="20" style="width:200px;" /></td>
                            </tr>
                            <tr>
                                <td class="FieldLabel"><label for="email2" id="email2-label">Retype Email*</label></td>
                                <td class="FieldInput"><input name="email2" id="email2" type="text" size="20" style="width:200px;" /></td>
                            </tr>
                            <tr>
                                <td class="FieldLabel"><label for="password1" id="password1-label">Password</label></td>
                                <td class="FieldInput"><input name="password1" id="password1" type="password" size="20" style="width:200px;" /></td>
                            </tr>
                            <tr>
                                <td class="FieldLabel"><label for="password2" id="password2-label">Retype Password</label></td>
                                <td class="FieldInput"><input name="password2" id="password2" type="password" size="20" style="width:200px;" /></td>
                            </tr>
                            <tr>
                                <td class="FieldLabel"><label for="birthdate" id="birthdate-label">Birthdate*</label><br />
                                <span>(mm/dd/yyyy)</span></td>
                                <td class="FieldInput"><input name="birthdate" id="date1" type="text" size="20" style="width:94px;" /></td>
                            </tr>
                            <tr>
                                <td class="FieldLabel"><label for="ssn" id="ssn-label">Last 4 SSN*</label><br />
                                    <span>(Social Security Number)</span></td>
                                <td class="FieldInput"><input name="SSN" id="ssn" type="text" size="4" /></td>
                            </tr>
                            <tr>
                                <td class="FieldLabel"><label for="gender">Gender:</label></td>
                                <td class="FieldInput">
                                    <select name="Gender" id="Gender">
                                        <option value="">Select One...</option>
                                        <option value="F">Female</option>
                                        <option value="M">Male</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" width="328" colspan="2">
                                    <table>
                                        <tr>
                                            <td class="FieldLabel" valign="top">
                                            	<label id="displayname-label">Display Name*</label><br />
                                                - This will be the name used on your certificate.
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="FieldInput displayname-container MiddleName"><input type="radio" name="DisplayName" id="displayname-1" value="" class="displayname" CHECKED /><label for="displayname-1" id="displayname-1-label"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="FieldInput displayname-container MiddleName"><input type="radio" name="DisplayName" id="displayname-2" value="" class="displayname" /><label for="displayname-2" id="displayname-2-label"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="FieldInput displayname-container MiddleName"><input type="radio" name="DisplayName" id="displayname-3" value="" class="displayname" /><label for="displayname-3" id="displayname-3-label"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="FieldInput displayname-container MiddleName"><input type="radio" name="DisplayName" id="displayname-4" value="" class="displayname" /><label for="displayname-4" id="displayname-4-label"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="FieldInput displayname-container"><input type="radio" name="DisplayName" id="displayname-5" value="" class="displayname" /><label for="displayname-5" id="displayname-5-label"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="FieldInput displayname-container"><input type="radio" name="DisplayName" id="displayname-6" value="" class="displayname" /><label for="displayname-6" id="displayname-6-label"></label></td>
                                        </tr>
                                        <tr>
                                            <td class="FieldInput displayname-container" nowrap="nowrap"><input type="radio" name="DisplayName" id="displayname-7" class="displayname" value="" /><input type="text" name="displaynamecustom" id="displaynamecustom" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <input type="button" id="frmSubmit" value="Create Account" />
                    </td>
                    <input type="hidden" name="Method" value="Register" />
                    </form>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>