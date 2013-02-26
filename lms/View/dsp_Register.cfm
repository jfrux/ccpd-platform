<link rel="stylesheet" href="/lms/_styles/jquery.tokeninput.css" type="text/css" />
<link href="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_styles/Forms.css" type="text/css" rel="stylesheet"  />
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

function validate() {
	$.ajax({
		url: sRootPath + "/_com/AJAX_Auth.cfc",
		type: 'post',
		data: { method: "Validate", Birthdate: $("#date1").val(), FirstName: $("#firstname").val(), MiddleName: $("#middlename").val(), LastName: $("#lastname").val(), Suffix: $("#suffix").val(), DisplayName: $('[name="DisplayName"]').val(), Email1: $("#email1").val(), Email2: $("#email2").val(), SSN: $("#ssn").val(), Gender: $("#Gender").val(), Password1: $("#password1").val(), Password2: $("#password2").val(), geonameId: $("#geonameid").val(), returnFormat: "plain"},
		dataType: 'json',
		beforeSend: function() {
			$('.error_list').html('');
			$('.message_list').text('Please wait for validation...');
		},
		success: function(data) {
			if(data.STATUS) {
				if(data.STATUSMSG == "") {
					$("#frmRegister").submit();
				} else {
					$(".message_list").text(data.STATUSMSG);
				}
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
				$('.message_list').text('');
				$(".error_list").html(sErrorList);
				
				return false;
			}
		}
	});
}

function updateDisplayNameValue(sName) {
	$("#displaynamecustom").val(sName);
	$("#displayname-7").val(sName);
}

$(document).ready(function() {
	$(".displayname-container").hide(); 
	updateDisplayName();
	
	$("#frmSubmit").click(function() {
		validate();
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
	
	$('input,select').keyup(function(e)  {
		if(e.keyCode == 13) {
			validate();
		}
	});
	
	$("#geonameid").tokenInput("http://ws.geonames.org/searchJSON?featureClass=P&style=full&maxRows=12",{
		queryParam:'name_startsWith',
		tokenLimit:1,
		tokenValue:'geonameId',
		jsonContainer:'geonames',
		resultsFormatter:function(item) {
			return "<li>" + item.name + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName + "</li>"
		},
		tokenFormatter:function(item) {
			return "<li><p>" + item.name + (item.adminName1 ? ", " + item.adminName1 : "") + ", " + item.countryName + "</p></li>"
		}
	});
	
	$.ajax({
		url:'http://freegeoip.net/json/',
		dataType:'jsonp',
		crossDomain:true,
		success:function(data) {
			$.ajax({
				url:'http://ws.geonames.org/searchJSON',
				type:'get',
				data:{
					featureClass:'P',
					style:'full',
					maxRows:12,
					q:data.region_name + ' ' + data.zipcode + ' ' + data.country_name
				},
				dataType:'json',
				success:function(data) {
					$("#geonameid").tokenInput('add',data.geonames[0]);
				}
			});
		}
	});
});
</script>
<div class="ContentBlock">
	<h1>Sign-up</h1>
	<div id="ContentLeft" class="Wide">
		<h2>Registration</h2>
		<table width="400" cellspacing="1" cellpadding="3" border="0">
            <tr>
                <td class="error_list"></td>
            </tr>
            <tr>
                <td class="message_list" style="width: 300px;"></td>
            </tr>
            <tr>
                <form name="frmRegister" id="frmRegister" method="post" action="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_com/AJAX_Auth.cfc">
                <td class="content_body">
                    <table width="500" cellspacing="1" cellpadding="3" border="0">
                        <tr>
                            <td class="FieldLabel2"><label for="firstname" id="firstname-label">First Name*</label></td>
                            <td class="FieldInput"><input name="firstname" id="firstname" type="text" size="20" style="width:150px;" /></td>
                        </tr>
                        <tr>
                            <td class="FieldLabel2"><label for="middlename" id="middlename-label">Middle Name</label></td>
                            <td class="FieldInput"><input name="middlename" id="middlename" type="text" size="20" style="width:150px;" /></td>
                        </tr>
                        <tr>
                            <td class="FieldLabel2"><label for="lastname" id="lastname-label">Last Name*</label></td>
                            <td class="FieldInput"><input name="lastname" id="lastname" type="text" size="20" style="width:150px;" /></td>
                        </tr>
                        <tr>
                            <td class="FieldLabel2"><label for="suffix" id="suffix-label">Suffix</label></td>
                            <td class="FieldInput"><input name="suffix" id="suffix" type="text" size="20" style="width:150px;" /></td>
                        </tr>
                        <tr>
                            <td class="FieldLabel2"><label for="geonameid" id="geonameid-label">City / Town*</label></td>
                            <td class="FieldInput"><input name="geonameid" id="geonameid" type="text" style="width:150px;" /></td>
                        </tr>
                        <tr>
                            <td width="142" class="FieldLabel2"><label for="email1" id="email1-label">Email Address*</label></td>
                            <td width="343" class="FieldInput"><input name="email1" id="email1" type="text" size="20" style="width:200px;" /></td>
                        </tr>
                        <tr>
                            <td class="FieldLabel2"><label for="email2" id="email2-label">Retype Email*</label></td>
                            <td class="FieldInput"><input name="email2" id="email2" type="text" size="20" style="width:200px;" /></td>
                        </tr>
                        <tr>
                            <td class="FieldLabel2"><label for="password1" id="password1-label">Password</label></td>
                            <td class="FieldInput"><input name="password1" id="password1" type="password" size="20" style="width:200px;" /></td>
                        </tr>
                        <tr>
                            <td class="FieldLabel2"><label for="password2" id="password2-label">Retype Password</label></td>
                            <td class="FieldInput"><input name="password2" id="password2" type="password" size="20" style="width:200px;" /></td>
                        </tr>
                        <tr>
                            <td class="FieldLabel2"><label for="gender">Gender:</label></td>
                            <td class="FieldInput">
                                <select name="Gender" id="Gender">
                                    <option value="">Select one...</option>
                                    <option value="F">Female</option>
                                    <option value="M">Male</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" width="328" colspan="2">
                                <table>
                                    <tr>
                                        <td class="FieldLabel2" valign="top">
                                            <label id="displayname-label">Display Name*</label><br />
                                            <font style="font-weight: normal;">- This will be the name used on your certificate.</font>
                                        </td>
                                    </tr>
                                    <tr class="displayname-container">
                                    	<td>
                                        	<table>
                                                <tr>
                                                    <td class="FieldInput MiddleName"><input type="radio" name="DisplayName" id="displayname-1" value="" class="displayname" CHECKED /><label for="displayname-1" id="displayname-1-label"></label></td>
                                                </tr>
                                                <tr>
                                                    <td class="FieldInput MiddleName"><input type="radio" name="DisplayName" id="displayname-2" value="" class="displayname" /><label for="displayname-2" id="displayname-2-label"></label></td>
                                                </tr>
                                                <tr>
                                                    <td class="FieldInput MiddleName"><input type="radio" name="DisplayName" id="displayname-3" value="" class="displayname" /><label for="displayname-3" id="displayname-3-label"></label></td>
                                                </tr>
                                                <tr>
                                                    <td class="FieldInput MiddleName"><input type="radio" name="DisplayName" id="displayname-4" value="" class="displayname" /><label for="displayname-4" id="displayname-4-label"></label></td>
                                                </tr>
                                                <tr>
                                                    <td class="FieldInput"><input type="radio" name="DisplayName" id="displayname-5" value="" class="displayname" checked="checked" /><label for="displayname-5" id="displayname-5-label"></label></td>
                                                </tr>
                                                <tr>
                                                    <td class="FieldInput"><input type="radio" name="DisplayName" id="displayname-6" value="" class="displayname" /><label for="displayname-6" id="displayname-6-label"></label></td>
                                                </tr>
                                                <tr>
                                                    <td class="FieldInput" nowrap="nowrap"><input type="radio" name="DisplayName" id="displayname-7" class="displayname" value="" /><input type="text" name="displaynamecustom" id="displaynamecustom" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <input type="button" id="frmSubmit" value="Register" />
                </td>
                <input type="hidden" name="Method" value="Register" />
                </form>
            </tr>
		</table>
	</div>
	<div id="ContentRight" class="Wide">
		<h2>Already have an account?</h2>
		<p>
		If you already have an account with us you can login by clicking below.
		</p>
		<p>
		<a href="<cfoutput>#myself#</cfoutput>Main.Login" class="LearnMore">Member Login</a>
		</p>
	</div>
</div>