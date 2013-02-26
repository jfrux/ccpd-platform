<style>
.FieldLabel { font-size:16px; font-weight:bold; }
.FieldLabel span { font-size:10px; font-weight:normal; }
.FieldInput input,textarea,select { font-size:19px; padding:3px; border:1px solid #CCC; }
input.FieldInputErr,textarea.FieldInputErr,select.FieldInputErr { font-size:19px; padding:3px; border:1px solid #FF0000; background-color:#ffe6e6; }

</style>
<script>
function showResponse(responseText, statusText) {
	
}

function pageScroll() {
    	frmRegistration.scrollBy(100,15); // horizontal and vertical scroll increments
    	scrolldelay = setTimeout('pageScroll()',100); // scrolls every 100 milliseconds
}


$(document).ready(function() {
	$("#date1").mask("99/99/9999");
	$("#RegistrationDialog").dialog({ 
		title:"Registration: Optional Information",
		modal: true, 
		autoOpen: false,
		height:530,
		width:730,
		position:'top',
		resizable: true,
		open:function() {
			$("#RegistrationDialog").show();
			
		},
		close:function() {
			$("#RegistrationDialog").hide();
		}
	});
	$("#RegisterForm").submit(function() {
		var sMessage = "";
		var TotalError = 0;
		
		if($("#email1").val() == '') {
			sMessage = sMessage + ",You must enter an email address.";
			$("#email1").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#email1").removeClass("FieldInputErr");
		}
		
		if($("#email1").val() != $("#email2").val()) {
			sMessage = sMessage + ",Your email address and retyped email do not match.";
			$("#email1,#email2").addClass("FieldInputErr");
			TotalError++;
		} else if($("#email1").val() != '') {
			$("#email1,#email2").removeClass("FieldInputErr");
		}
		
		if($("#firstname").val() == '') {
			sMessage = sMessage + ",You must enter your first name.";
			$("#firstname").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#firstname").removeClass("FieldInputErr");
		}
		
		if($("#lastname").val() == '') {
			sMessage = sMessage + ",You must enter your last name.";
			$("#lastname").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#lastname").removeClass("FieldInputErr");
		}
		
		if($("#date1").val() == '') {
			sMessage = sMessage + ",You must enter a valid birthdate.";
			$("#date1").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#date1").removeClass("FieldInputErr");
		}
		
		if($("#ssn").val() == '') {
			sMessage = sMessage + ",You must enter a valid last 4 ssn.";
			$("#ssn").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#ssn").removeClass("FieldInputErr");
		}
		
		if (sMessage != '') {
			for(var i=1; i<TotalError+1; i++) {
				
			}
			
		} else {
			$(this).ajaxSubmit({
				success:function(responseText,statusText) {
					responseText = $.Trim(responseText);
					statusMsg = $.ListGetAt(responseText,1,'|');
					username = $.ListGetAt(responseText,3,'|');
					password = $.ListGetAt(responseText,4,'|');
					if(statusMsg == 'success') {
						$.post(sRootPath + "/_com/API.cfc",
								{ 
									method:'RegisterAuth',
									returnFormat:'plain',
									uname:username,
									pword:password
								}
								,function(data) {
								responseText = $.Trim(data);
								var status = $.ListGetAt(responseText,1,'|');
								var firstname = '';
								var middlename = '';
								var lastname = '';
								var birthdate = '';
								var last4ssn = '';
								var email = '';
								var phone = '';
								var address1 = '';
								var address2 = '';
								var city = '';
								var stateid = '';
								var zipcode = '';
								var countryid = '';
								
								if(status == 'success') {
									personid = $.ListGetAt(responseText,2,'|');
									firstname = $.ListGetAt(responseText,3,'|');
									middlename = $.ListGetAt(responseText,4,'|');
									lastname = $.ListGetAt(responseText,5,'|');
									birthdate = $.ListGetAt(responseText,6,'|');
									last4ssn = $.ListGetAt(responseText,7,'|');
									email = $.ListGetAt(responseText,8,'|');
									phone = $.ListGetAt(responseText,9,'|');
									address1 = $.ListGetAt(responseText,10,'|');
									address2 = $.ListGetAt(responseText,11,'|');
									city = $.ListGetAt(responseText,12,'|');
									stateid = $.ListGetAt(responseText,13,'|');
									zipcode = $.ListGetAt(responseText,14,'|');
									countryid = $.ListGetAt(responseText,15,'|');
									
									$("#AuthBox").html("Welcome " + firstname + "!");
									
									$("#PersonID").val(personid);
									$("#FirstName").val(firstname);
									$("#MiddleName").val(middlename);
									$("#LastName").val(lastname);
									$("#DOB").val(birthdate);
									$("#Last4SSN").val(last4ssn);
									
									$("#Email").val(email);
									$("#Email2").val(email);
									$("#Phone").val(phone);
									$("#RegAddress1").val(address1);
									$("#RegAddress2").val(address2);
									$("#RegCity").val(city);
									$("#RegState").val(stateid);
									$("#RegZip").val(zipcode);
									$("#RegCountry").val(countryid);
								} else {
									
								}
							$("#RegisterBox").html("").hide().expose().close();
							
						});
					} else if(statusMsg == 'failed') {
						$("#RegisterBox").html("<h1>Already Exists!</h1><p>We have detected that you already have an account with us and an email has been sent to the email address on file.</p><p>Once you receive this email use the credentials inside of it to login.</p><p><a href=\"javascript:void(0);\" class=\"CloseRegBox\">Close and return to registration.</a>");
					
						$(".CloseRegBox").click(function() {
							$("#RegisterBox").html("").hide().expose().close();
						});
					}
										
					
				}	
			});
		}
		
		return false;
	});
});
</script>
<div class="ContentBlock">
	<h1>Sign-up</h1>
	<p>
		<form name="emaillookup" id="RegisterForm" method="post" action="/admin/index.cfm/event/Public.Signup">
		<table width="500" cellspacing="1" cellpadding="3" border="0">
			<tr>
				<td class="FieldLabel">First Name</td>
				<td class="FieldInput"><input name="firstname" id="firstname" type="text" size="20" style="width:150px;" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">Last Name</td>
				<td class="FieldInput"><input name="lastname" id="lastname" type="text" size="20" style="width:150px;" /></td>
			</tr>
			<tr>
				<td width="142" class="FieldLabel">Email Address</td>
				<td width="343" class="FieldInput"><input name="email" id="email1" type="text" size="20" style="width:200px;" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">Retype Email</td>
				<td class="FieldInput"><input name="email2" id="email2" type="text" size="20" style="width:200px;" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">Birthdate<br />
				<span>(mm/dd/yyyy)</span></td>
				<td class="FieldInput"><input name="birthdate" id="date1" type="text" size="20" style="width:94px;" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">Last 4 SSN<br />
					<span>(Social Security Number)</span></td>
				<td class="FieldInput"><input name="SSN" id="ssn" type="text" size="4" /></td>
			</tr>
		</table>
		<input type="hidden" name="Submitted" value="1" /><input type="hidden" name="action" value="Submit" class="submitButton"><input type="submit" value="Sign-up" />
		<a href="javascript:void(0);" onClick="$('#RegisterBox').html('').hide().expose().close();">Cancel</a>
		</form>
	</p>
</div>