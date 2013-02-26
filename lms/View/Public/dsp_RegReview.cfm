<script>
function showResponse(responseText, statusText) {
	
}

function pageScroll() {
    	frmRegistration.scrollBy(100,15); // horizontal and vertical scroll increments
    	scrolldelay = setTimeout('pageScroll()',100); // scrolls every 100 milliseconds
}


$(document).ready(function() {
	$("#frmRegistration").load(function() {
		//console.log(parent.frames[0].location.href);
	});
	
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
			sMessage = sMessage + "You must enter an email address.<br>";
			$("#email1").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#email1").removeClass("FieldInputErr");
		}
		
		if($("#email1").val() != $("#email2").val()) {
			sMessage = sMessage + "Your email address and retyped email do not match.<br>";
			$("#email1,#email2").addClass("FieldInputErr");
			TotalError++;
		} else if($("#email1").val() != '') {
			$("#email1,#email2").removeClass("FieldInputErr");
		}
		
		if($("#firstname").val() == '') {
			sMessage = sMessage + "You must enter your first name.<br>";
			$("#firstname").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#firstname").removeClass("FieldInputErr");
		}
		
		if($("#lastname").val() == '') {
			sMessage = sMessage + "You must enter your last name.<br>";
			$("#lastname").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#lastname").removeClass("FieldInputErr");
		}
		
		if($("#date1").val() == '') {
			sMessage = sMessage + "You must enter a valid birthdate.<br>";
			$("#date1").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#date1").removeClass("FieldInputErr");
		}
		
		if($("#ssn").val() == '') {
			sMessage = sMessage + "You must enter a valid last 4 ssn.<br>";
			$("#ssn").addClass("FieldInputErr");
			TotalError++;
		} else {
			$("#ssn").removeClass("FieldInputErr");
		}
		
		if (sMessage != '') {
			$("#ErrorP").show();
			$("#ErrorDump").html(sMessage);
			
			return false;
		} else {
			$("#RegistrationDialog").dialog("open");
			$("#frmRegistration").attr({ scrollTop: 1000 });
		}
	});
});
</script>
<div class="ContentBlock">
	<h3>Sign-up</h3>
    <p>If you are already a member, click here to login.</p>
    <p id="ErrorP" style="display:none;"><strong>ERRORS:</strong><br>
    	<div id="ErrorDump"></div>
    </p>
	<p>
		<form name="emaillookup" id="RegisterForm" method="post" target="frmRegistration" action="https://webcentral.uc.edu/admin/components/prod/userregistration/validatenewuserstep1.cfc">
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
				<td width="343" class="FieldInput"><input name="emailaddress" id="email1" type="text" size="20" style="width:200px;" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">Retype Email</td>
				<td class="FieldInput"><input name="emailaddress2" id="email2" type="text" size="20" style="width:200px;" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">Birthdate<br />
				<span>(mm/dd/yyyy)</span></td>
				<td class="FieldInput"><input name="birthdate" id="date1" type="text" size="20" style="width:94px;" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">UC  Affiliated?<br />
					<span>(Univ. of Cincinnati)</span></td>
				<td class="FieldInput"><input name="ucflag" id="ucflag" type="radio" value="1" />
					Yes<input name="ucflag" type="radio" value="2" />
					No</td>
			</tr>
			<tr>
				<td class="FieldLabel">Last 4 SSN<br />
					<span>(Social Security Number)</span></td>
				<td class="FieldInput"><input name="SSN" id="ssn" type="text" size="4" /></td>
			</tr>
		</table>
		<input type="hidden" name="action" value="Submit" class="submitButton"><input type="submit" value="Continue" /><input type="Hidden" name="method" value="validatenewuser">
		</form>
	</p>
</div>
<div id="RegistrationDialog">
	<iframe src="" name="frmRegistration" id="frmRegistration" frameborder="0" height="700" scrolling="no" width="700"></iframe>
</div>