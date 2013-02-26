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
	<h3>Payment</h3>
    <div style="height:10px;"></div>
<table width="750" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="44%" valign="top" id="RegisterLeft">
			<div class="PageContentSubTitle">Payment Information</div>
			<div class="PageContentBody">
			<table class="table_main" cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td width="16%" class="FormLabel">Name On Card</td>
				  <td width="84%" class="FormField"><input type="text" name="CardName" id="CardName" size="20" maxlength="100" value="#Register.CardName#" style="width:150px;"></td>
				</tr>
				<tr>
					<td nowrap="nowrap" class="FormLabel">Credit Card Number<br>
						<span style="font-size:10px;">(no spaces)</span></td>
					<td class="FormField"><input type="text" autocomplete="off" name="CardNumber" id="CardNumber" size="20" maxlength="20" value="#Register.CardNumber#" style="width:150px;"></td>
				</tr>
				<tr>
					<td class="FormLabel">Credit Card V-Code<br>
						</td>
					<td class="FormField"><input type="text" autocomplete="off" name="CardCode" id="CardCode" size="5" maxlength="10" value="#Register.CardCode#" style="width:150px;"><br />
			<span style="font-size:10px;">(3 or 4 digits on back of card)</span>					</td>
				</tr>
				<tr>
					<td class="FormLabel">Card Type</td>
					<td class="FormField">
						<select size="1" name="CardType" id="CardType" style="width:156px;">
							<option value="MasterCard">MasterCard</option>
							<option value="VISA" selected>VISA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="FormLabel">Expiration Date</td>
					<td class="FormField">
						<select size="1" name="CardExpireMonth" id="CardExpireMonth" style="width:76px;">
							<option value="">MONTH</option>
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
						<select size="1" name="CardExpireYear" id="CardExpireYear" style="width:75px;">
							<option value="" selected>YEAR</option>
							<option value="2006">2006</option>
							<option value="2007">2007</option>
							<option value="2008">2008</option>
							<option value="2009">2009</option>
							<option value="2010">2010</option>
							<option value="2011">2011</option>
							<option value="2012">2012</option>
							<option value="2013">2013</option>
							<option value="2014">2014</option>
							<option value="2015">2015</option>
							<option value="2016">2016</option>
						</select>
					</td>
				</tr>
			</table>
			<img src="../images/visa.gif" width="60" height="36" alt="Visa" border="1" align="absmiddle">&nbsp;<img src="../images/mastercard.jpg" width="60" height="39" alt="MasterCard" align="absmiddle"><script src=https://seal.verisign.com/getseal?host_name=webcentral.uc.edu&size=L&use_flash=YES&use_transparent=YES&lang=en></script>
			</div>
		</td>
		<td width="56%" valign="top" id="RegisterRight">
			<div class="PageContentSubTitle">Review Registration</div>
			<div class="PageContentBody">
				<p>Once you have completed filling out all required information press Continue below to review and finalize your registration.</p>
				<p>
				<input type="submit" name="fldSubmit" id="fldSubmit" value="Continue">
				<input type="hidden" name="fldSubmitted" id="fldSubmitted" value="1"></p>
			</div>
		</td>
	</tr>
</table>
	</p>
</div>
<div id="RegistrationDialog">
	<iframe src="" name="frmRegistration" id="frmRegistration" frameborder="0" height="700" scrolling="no" width="700"></iframe>
</div>