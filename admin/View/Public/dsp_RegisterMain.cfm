<cfparam name="Attributes.CardName" default="" />
<cfparam name="Attributes.CardNumber" default="" />
<cfparam name="Attributes.CardCode" default="" />
<cfparam name="Attributes.CardType" default="" />
<cfparam name="Attributes.CardExpireMonth" default="" />
<cfparam name="Attributes.CardExpireYear" default="" />
<cfparam name="Attributes.Phone" default="" />
<cfparam name="Attributes.RegAddress1" default="" />
<cfparam name="Attributes.RegAddress2" default="" />
<cfparam name="Attributes.RegCity" default="" />
<cfparam name="Attributes.RegState" default="" />
<cfparam name="Attributes.RegZip" default="" />
<cfparam name="Attributes.RegCountry" default="" />
<cfparam name="Attributes.FirstName" default="" />
<cfparam name="Attributes.MiddleName" default="" />
<cfparam name="Attributes.LastName" default="" />
<cfparam name="Attributes.Profession" default="" />
<cfparam name="Attributes.DOB" default="" />
<cfparam name="Attributes.Last4SSN" default="" />
<cfparam name="Attributes.Email" default="" />
<cfparam name="Attributes.Email2" default="" />
<script>

function setProfession(sProfession) {
	if(sProfession == 'Physician') {
		$('#AmountPreview').val('$50.00');
		$('#BillingArea').show();
		$('#Finish-PayNow').show();
		$('#Finish-Submit').hide();
	} else if ( sProfession == 'Nurse') {
		$('#AmountPreview').val('$25.00');
		$('#BillingArea').show();
		$('#Finish-PayNow').show();
		$('#Finish-Submit').hide();
	} else {
		$('#AmountPreview').val('$0.00');
		$('#BillingArea').hide();
		$('#Finish-PayNow').hide();
		$('#Finish-Submit').show();
	}
}
$(document).ready(function() {
	<cfoutput>setProfession("#Attributes.Profession#");</cfoutput>
	
	$("#Profession").change(function() {
		setProfession($(this).val());
	});
	$("#DOB").mask("99/99/9999");
	$("#Phone").mask("(999) 999-9999");
	$("#Last4SSN").mask("9999");
	
	<cfif Attributes.Profession NEQ "">
	$("#Profession").val("<cfoutput>#Attributes.Profession#</cfoutput>");
	</cfif>
	<cfif Attributes.RegState NEQ "">
	$("#RegState").val("<cfoutput>#Attributes.RegState#</cfoutput>");
	</cfif>
	<cfif Attributes.RegCountry NEQ "">
	$("#RegCountry").val("<cfoutput>#Attributes.RegCountry#</cfoutput>");
	</cfif>
	<cfif Attributes.CardType NEQ "">
	$("#CardType").val("<cfoutput>#Attributes.CardType#</cfoutput>");
	</cfif>
	<cfif Attributes.CardExpireMonth NEQ "">
	$("#CardExpireMonth").val("<cfoutput>#Attributes.CardExpireMonth#</cfoutput>");
	</cfif>
	<cfif Attributes.CardExpireYear NEQ "">
	$("#CardExpireYear").val("<cfoutput>#Attributes.CardExpireYear#</cfoutput>");
	</cfif>
});
</script>

<cfoutput>
<cfif Errors NEQ "">
	<font color="##FF0000" style="font-size:18px;"><b>ERRORS:</b><br />
	<cfloop list="#Errors#" delimiters="|" index="err">
	- #err#<br />
	</cfloop>
	</font>
</cfif>
<form name="frmRegistration" id="frmRegistration" method="post" action="">
	<input type="hidden" name="Submitted" value="1" />
	<fieldset>
		<legend>Personal Information</legend>
		<div class="notes">
			<h4>Personal Information</h4>
			<p class="last">This information is required so that we can easily identify you in our records.  We are always striving to serve you better by eliminating duplicate information and to safely and easily generate transcript records upon request.</p>
		</div>
		<div class="required">
			<label for="FirstName">First Name</label>
			<input type="text" name="FirstName" id="FirstName" class="inputText" size="10" maxlength="100" value="#Attributes.FirstName#" />
		</div>
		<div class="required">
			<label for="MiddleName">Middle Name</label>
			<input type="text" name="MiddleName" id="MiddleName" class="inputText" size="10" maxlength="100" value="#Attributes.MiddleName#" />
		</div>
		<div class="required">
			<label for="LastName">Last Name</label>
			<input type="text" name="LastName" id="LastName" class="inputText" size="10" maxlength="100" value="#Attributes.LastName#" />
		</div>
		<div class="required">
			<label for="DOB">Date of Birth</label>
			<input type="text" name="DOB" id="DOB" class="inputText" size="10" maxlength="100" style="width:100px;" value="#Attributes.DOB#" />
		</div>
		<div class="required">
			<label for="Last4SSN">Last 4 SSN</label>
			<input type="text" name="Last4SSN" id="Last4SSN" class="inputText" size="10" maxlength="4" style="width:45px;" value="#Attributes.Last4SSN#" />
		</div>
		<div class="required">
			<label for="Last4SSN">Profession</label>
			<select name="Profession" id="Profession">
				<option value="">-- select ---</option>
				<option value="Physician">Physician</option>
				<option value="Nurse">Nurse</option>
				<option value="UCP and house staff">UCP and house Staff</option>
			</select>
		</div>
	</fieldset>
	<fieldset>
		<legend>Contact Information</legend>
		<div class="notes">
			<h4>Contact Information</h4>
			<p class="last">We will not solicate to you or sell your information to outside parties.<br /><br />
			IMPORTANT!<br />
			Please use the address for the billing information on your credit card.</p>
		</div>
		<div class="required">
			<label for="Email">Email</label>
			<input type="text" name="Email" id="Email" class="inputText" size="10" maxlength="100" value="#Attributes.Email#" />
		</div>
		<div class="required">
			<label for="Email2">Retype Email</label>
			<input name="Email2" type="text" class="inputText" id="Email2" value="#Attributes.Email2#" size="10" maxlength="100" />
		</div>
		<div class="required">
			<label for="Phone">Phone</label>
			<input name="Phone" type="text" class="inputText" id="Phone" value="#Attributes.Phone#" size="10" maxlength="100" />
		</div>
		<div class="required">
			<label for="Address1">Address</label>
			<input type="text" name="RegAddress1" id="RegAddress1" class="inputText" size="10" maxlength="100" value="#Attributes.RegAddress1#" />
			<input type="text" name="RegAddress2" id="RegAddress2" class="inputText" size="10" maxlength="100" value="#Attributes.RegAddress2#" />
		</div>
		<div class="required">
			<label for="city">City</label>
			<input type="text" name="RegCity" id="RegCity" class="inputText" size="10" maxlength="100" value="#Attributes.RegCity#" />
		</div>
		<div class="required">
			<label for="State">State</label>
			<select name="RegState" id="RegState" class="selectOne">
				<option value="">Select a State/Province</option>
				<option value="">---------------</option>
				<option value="AL">AL - Alabama</option>
				<option value="AK">AK - Alaska</option>
				<option value="AZ">AZ - Arizona</option>
				<option value="AR">AR - Arkansas</option>
				<option value="CA">CA - California</option>
				<option value="CO">CO - Colorado</option>
				<option value="CT">CT - Connecticut</option>
				<option value="DE">DE - Delaware</option>
				<option value="DC">DC - District of Columbia</option>
				<option value="FL">FL - Florida</option>
				<option value="GA">GA - Georgia</option>
				<option value="HI">HI - Hawaii</option>
				<option value="ID">ID - Idaho</option>
				<option value="IL">IL - Illinois</option>
				<option value="IN">IN - Indiana</option>
				<option value="IA">IA - Iowa</option>
				<option value="KS">KS - Kansas</option>
				<option value="KY">KY - Kentucky</option>
				<option value="LA">LA - Louisiana</option>
				<option value="ME">ME - Maine</option>
				<option value="MD">MD - Maryland</option>
				<option value="MA">MA - Massachusetts</option>
				<option value="MI">MI - Michigan</option>
				<option value="MN">MN - Minnesota</option>
				<option value="MS">MS - Mississippi</option>
				<option value="MO">MO - Missouri</option>
				<option value="MT">MT - Montana</option>
				<option value="NE">NE - Nebraska</option>
				<option value="NV">NV - Nevada</option>
				<option value="NH">NH - New Hampshire</option>
				<option value="NJ">NJ - New Jersey</option>
				<option value="NM">NM - New Mexico</option>
				<option value="NY">NY - New York</option>
				<option value="NC">NC - North Carolina</option>
				<option value="ND">ND - North Dakota</option>
				<option value="OH">OH - Ohio</option>
				<option value="OK">OK - Oklahoma</option>
				<option value="OR">OR - Oregon</option>
				<option value="PA">PA - Pennsylvania</option>
				<option value="RI">RI - Rhode Island</option>
				<option value="SC">SC - South Carolina</option>
				<option value="SD">SD - South Dakota</option>
				<option value="TN">TN - Tennessee</option>
				<option value="TX">TX - Texas</option>
				<option value="UT">UT - Utah</option>
				<option value="VT">VT - Vermont</option>
				<option value="VA">VA - Virginia</option>
				<option value="WA">WA - Washington</option>
				<option value="WV">WV - West Virginia</option>
				<option value="WI">WI - Wisconsin</option>
				<option value="WY">WY - Wyoming</option>
				<option value="">---------------</option>
				<option value="AE">AE - Armed Forces Africa</option>
				<option value="AA">AA - Armed Forces Americas (except Canada)</option>
				<option value="AE">AE - Armed Forces Canada</option>
				<option value="AE">AE - Armed Forces Europe</option>
				<option value="AE">AE - Armed Forces Middle East</option>
				<option value="AP">AP - Armed Forces Pacific</option>
				<option value="">---------------</option>
				<option value="AB">AB - Alberta</option>
				<option value="BC">BC - British Columbia</option>
				<option value="MB">MB - Manitoba</option>
				<option value="NB">NB - New Brunswick</option>
				<option value="NL">NL - Newfoundland and Labrador</option>
				<option value="NT">NT - Northwest Territories</option>
				<option value="NS">NS - Nova Scotia</option>
				<option value="NU">NU - Nunavut</option>
				<option value="ON">ON - Ontario</option>
				<option value="PE">PE - Prince Edward Island</option>
				<option value="QC">QC - Quebec</option>
				<option value="SK">SK - Saskatchewan</option>
				<option value="YT">YT - Yukon</option>
				<option value="">---------------</option>
				<option value="AS">AS - American Samoa</option>
				<option value="FM">FM - Federated States of Micronesia</option>
				<option value="GU">GU - Guam</option>
				<option value="MH">MH - Marshall Islands</option>
				<option value="MP">MP - Northern Mariana Islands</option>
				<option value="PW">PW - Palau</option>
				<option value="PR">PR - Puerto Rico</option>
				<option value="VI">VI - Virgin Islands</option>
				<option value="">---------------</option>
				<option value="XX">XX - Other State/Province/Territory</option>
			</select>
		</div>
		<div class="required">
			<label for="postal">Zip/Postal Code</label>
			<input type="text" name="RegZip" id="RegZip" class="inputText" size="10" maxlength="50" value="#Attributes.RegZip#" />
		</div>
		<div class="required">
			<label for="country">Country</label>
			<select name="RegCountry" id="RegCountry" class="selectOne">
				<option value="Select a Country">Select a Country</option>
				<option value="">---------------</option>
				<option value="United States" selected="selected">US - United States</option>
				<option value="Canada">CA - Canada</option>
				<option value="">---------------</option>
				<option value="Afghanistan">AF - Afghanistan</option>
				<option value="Albania">AL - Albania</option>
				<option value="Algeria">DZ - Algeria</option>
				<option value="American Samoa">AS - American Samoa</option>
				<option value="Andorra">AD - Andorra</option>
				<option value="Angola">AO - Angola</option>
				<option value="Anguilla">AI - Anguilla</option>
				<option value="Antarctica">AQ - Antarctica</option>
				<option value="Antigua and Barbuda">AG - Antigua and Barbuda</option>
				<option value="Argentina">AR - Argentina</option>
				<option value="Armenia">AM - Armenia</option>
				<option value="Aruba">AW - Aruba</option>
				<option value="Australia">AU - Australia</option>
				<option value="Austria">AT - Austria</option>
				<option value="Azerbaijan">AZ - Azerbaijan</option>
				<option value="Bahamas">BS - Bahamas</option>
				<option value="Bahrain">BH - Bahrain</option>
				<option value="Bangladesh">BD - Bangladesh</option>
				<option value="Barbados">BB - Barbados</option>
				<option value="Belarus">BY - Belarus</option>
				<option value="Belgium">BE - Belgium</option>
				<option value="Belize">BZ - Belize</option>
				<option value="Benin">BJ - Benin</option>
				<option value="Bermuda">BM - Bermuda</option>
				<option value="Bhutan">BT - Bhutan</option>
				<option value="Bolivia">BO - Bolivia</option>
				<option value="Bosnia and Herzegovina">BA - Bosnia and Herzegovina</option>
				<option value="Botswana">BW - Botswana</option>
				<option value="Bouvet Island">BV - Bouvet Island</option>
				<option value="Brazil">BR - Brazil</option>
				<option value="British Indian Ocean Territory">IO - British Indian Ocean Territory</option>
				<option value="Brunei Darussalam">BN - Brunei Darussalam</option>
				<option value="Bulgaria">BG - Bulgaria</option>
				<option value="Burkina Faso">BF - Burkina Faso</option>
				<option value="Burundi">BI - Burundi</option>
				<option value="Cambodia">KH - Cambodia</option>
				<option value="Cameroon">CM - Cameroon</option>
				<option value="Cape Verde">CV - Cape Verde</option>
				<option value="Cayman Islands">KY - Cayman Islands</option>
				<option value="Central African Republic">CF - Central African Republic</option>
				<option value="Chad">TD - Chad</option>
				<option value="Chile">CL - Chile</option>
				<option value="China">CN - China</option>
				<option value="Christmas Island">CX - Christmas Island</option>
				<option value="Cocos (Keeling) Islands">CC - Cocos (Keeling) Islands</option>
				<option value="Colombia">CO - Colombia</option>
				<option value="Comoros">KM - Comoros</option>
				<option value="Congo">CG - Congo</option>
				<option value="Congo, Democratic Republic of the">CD - Congo, Democratic Republic of the</option>
				<option value="Cook Islands">CK - Cook Islands</option>
				<option value="Costa Rica">CR - Costa Rica</option>
				<option value="Cote d'Ivoire">CI - Cote d'Ivoire</option>
				<option value="Croatia">HR - Croatia</option>
				<option value="Cuba">CU - Cuba</option>
				<option value="Cyprus">CY - Cyprus</option>
				<option value="Czech Republic">CZ - Czech Republic</option>
				<option value="Denmark">DK - Denmark</option>
				<option value="Djibouti">DJ - Djibouti</option>
				<option value="Dominica">DM - Dominica</option>
				<option value="Dominican Republic">DO - Dominican Republic</option>
				<option value="East Timor">TP - East Timor</option>
				<option value="Ecuador">EC - Ecuador</option>
				<option value="Egypt">EG - Egypt</option>
				<option value="El Salvador">SV - El Salvador</option>
				<option value="Equatorial Guinea">GQ - Equatorial Guinea</option>
				<option value="Eritrea">ER - Eritrea</option>
				<option value="Estonia">EE - Estonia</option>
				<option value="Ethiopia">ET - Ethiopia</option>
				<option value="Falkland Islands (Malvinas)">FK - Falkland Islands (Malvinas)</option>
				<option value="Faroe Islands">FO - Faroe Islands</option>
				<option value="Fiji">FJ - Fiji</option>
				<option value="Finland">FI - Finland</option>
				<option value="France">FR - France</option>
				<option value="French Guiana">GF - French Guiana</option>
				<option value="French Polynesia">PF - French Polynesia</option>
				<option value="French Southern Territories">TF - French Southern Territories</option>
				<option value="Gabon">GA - Gabon</option>
				<option value="Gambia">GM - Gambia</option>
				<option value="Georgia">GE - Georgia</option>
				<option value="Germany">DE - Germany</option>
				<option value="Ghana">GH - Ghana</option>
				<option value="Gibraltar">GI - Gibraltar</option>
				<option value="Greece">GR - Greece</option>
				<option value="Greenland">GL - Greenland</option>
				<option value="Grenada">GD - Grenada</option>
				<option value="Guadeloupe">GP - Guadeloupe</option>
				<option value="Guam">GU - Guam</option>
				<option value="Guatemala">GT - Guatemala</option>
				<option value="Guinea">GN - Guinea</option>
				<option value="Guinea-Bissau">GW - Guinea-Bissau</option>
				<option value="Guyana">GY - Guyana</option>
				<option value="Haiti">HT - Haiti</option>
				<option value="Heard Island and McDonald Islands">HM - Heard Island and McDonald Islands</option>
				<option value="Holy See (Vatican City)">VA - Holy See (Vatican City)</option>
				<option value="Honduras">HN - Honduras</option>
				<option value="Hong Kong">HK - Hong Kong</option>
				<option value="Hungary">HU - Hungary</option>
				<option value="Iceland">IS - Iceland</option>
				<option value="India">IN - India</option>
				<option value="Indonesia">ID - Indonesia</option>
				<option value="Iran, Islamic Republic of">IR - Iran, Islamic Republic of</option>
				<option value="Iraq">IQ - Iraq</option>
				<option value="Ireland">IE - Ireland</option>
				<option value="Israel">IL - Israel</option>
				<option value="Italy">IT - Italy</option>
				<option value="Jamaica">JM - Jamaica</option>
				<option value="Japan">JP - Japan</option>
				<option value="Jordan">JO - Jordan</option>
				<option value="Kazakstan">KZ - Kazakstan</option>
				<option value="Kenya">KE - Kenya</option>
				<option value="Kiribati">KI - Kiribati</option>
				<option value="Korea, Democratic People's Republic of">KP - Korea, Democratic People's Republic of</option>
				<option value="Korea, Republic of">KR - Korea, Republic of</option>
				<option value="Kuwait">KW - Kuwait</option>
				<option value="Kyrgyzstan">KG - Kyrgyzstan</option>
				<option value="Lao People's Democratic Republic">LA - Lao People's Democratic Republic</option>
				<option value="Latvia">LV - Latvia</option>
				<option value="Lebanon">LB - Lebanon</option>
				<option value="Lesotho">LS - Lesotho</option>
				<option value="Liberia">LR - Liberia</option>
				<option value="Libyan Arab Jamahiriya">LY - Libyan Arab Jamahiriya</option>
				<option value="Liechtenstein">LI - Liechtenstein</option>
				<option value="Lithuania">LT - Lithuania</option>
				<option value="Luxembourg">LU - Luxembourg</option>
				<option value="Macau">MO - Macau</option>
				<option value="Macedonia, The Former Yugoslav Republic of">MK - Macedonia, The Former Yugoslav Republic of</option>
				<option value="Madagascar">MG - Madagascar</option>
				<option value="Malawi">MW - Malawi</option>
				<option value="Malaysia">MY - Malaysia</option>
				<option value="Maldives">MV - Maldives</option>
				<option value="Mali">ML - Mali</option>
				<option value="Malta">MT - Malta</option>
				<option value="Marshall Islands">MH - Marshall Islands</option>
				<option value="Martinique">MQ - Martinique</option>
				<option value="Mauritania">MR - Mauritania</option>
				<option value="Mauritius">MU - Mauritius</option>
				<option value="Mayotte">YT - Mayotte</option>
				<option value="Mexico">MX - Mexico</option>
				<option value="Micronesia, Federated States of">FM - Micronesia, Federated States of</option>
				<option value="Moldova, Republic of">MD - Moldova, Republic of</option>
				<option value="Monaco">MC - Monaco</option>
				<option value="Mongolia">MN - Mongolia</option>
				<option value="Montserrat">MS - Montserrat</option>
				<option value="Morocco">MA - Morocco</option>
				<option value="Mozambique">MZ - Mozambique</option>
				<option value="Myanmar">MM - Myanmar</option>
				<option value="Namibia">NA - Namibia</option>
				<option value="Nauru">NR - Nauru</option>
				<option value="Nepal">NP - Nepal</option>
				<option value="Netherlands">NL - Netherlands</option>
				<option value="Netherlands Antilles">AN - Netherlands Antilles</option>
				<option value="New Caledonia">NC - New Caledonia</option>
				<option value="New Zealand">NZ - New Zealand</option>
				<option value="Nicaragua">NI - Nicaragua</option>
				<option value="Niger">NE - Niger</option>
				<option value="Nigeria">NG - Nigeria</option>
				<option value="Niue">NU - Niue</option>
				<option value="Norfolk Island">NF - Norfolk Island</option>
				<option value="Northern Mariana Islands">MP - Northern Mariana Islands</option>
				<option value="Norway">NO - Norway</option>
				<option value="Oman">OM - Oman</option>
				<option value="Pakistan">PK - Pakistan</option>
				<option value="Palau">PW - Palau</option>
				<option value="Palestinian Territory, Occupied">PS - Palestinian Territory, Occupied</option>
				<option value="PANAMA">PA - PANAMA</option>
				<option value="Papua New Guinea">PG - Papua New Guinea</option>
				<option value="Paraguay">PY - Paraguay</option>
				<option value="Peru">PE - Peru</option>
				<option value="Philippines">PH - Philippines</option>
				<option value="Pitcairn">PN - Pitcairn</option>
				<option value="Poland">PL - Poland</option>
				<option value="Portugal">PT - Portugal</option>
				<option value="Puerto Rico">PR - Puerto Rico</option>
				<option value="Qatar">QA - Qatar</option>
				<option value="Reunion">RE - Reunion</option>
				<option value="R  omania">RO - R  omania</option>
				<option value="Russian Federation">RU - Russian Federation</option>
				<option value="Rwanda">RW - Rwanda</option>
				<option value="Saint Helena">SH - Saint Helena</option>
				<option value="Saint Kitts and Nevis">KN - Saint Kitts and Nevis</option>
				<option value="Saint Lucia">LC - Saint Lucia</option>
				<option value="Saint Pierre and Miquelon">PM - Saint Pierre and Miquelon</option>
				<option value="Saint Vincent and the Grenadines">VC - Saint Vincent and the Grenadines</option>
				<option value="Samoa">WS - Samoa</option>
				<option value="San Marino">SM - San Marino</option>
				<option value="Sao Tome and Principe">ST - Sao Tome and Principe</option>
				<option value="Saudi Arabia">SA - Saudi Arabia</option>
				<option value="Senegal">SN - Senegal</option>
				<option value="Seychelles">SC - Seychelles</option>
				<option value="Sierra Leone">SL - Sierra Leone</option>
				<option value="Singapore">SG - Singapore</option>
				<option value="Slovakia">SK - Slovakia</option>
				<option value="Slovenia">SI - Slovenia</option>
				<option value="Solomon Islands">SB - Solomon Islands</option>
				<option value="Somalia">SO - Somalia</option>
				<option value="South Africa">ZA - South Africa</option>
				<option value="South Georgia and the South Sandwich Islands">GS - South Georgia and the South Sandwich Islands</option>
				<option value="Spain">ES - Spain</option>
				<option value="Sri Lanka">LK - Sri Lanka</option>
				<option value="Sudan">SD - Sudan</option>
				<option value="Suriname">SR - Suriname</option>
				<option value="Svalbard and Jan Mayen">SJ - Svalbard and Jan Mayen</option>
				<option value="Swaziland">SZ - Swaziland</option>
				<option value="Sweden">SE - Sweden</option>
				<option value="Switzerland">CH - Switzerland</option>
				<option value="Syrian Arab Republic">SY - Syrian Arab Republic</option>
				<option value="Taiwan, Province of China">TW - Taiwan, Province of China</option>
				<option value="Tajikistan">TJ - Tajikistan</option>
				<option value="Tanzania, United Republic of">TZ - Tanzania, United Republic of</option>
				<option value="Thailand">TH - Thailand</option>
				<option value="Togo">TG - Togo</option>
				<option value="Tokelau">TK - Tokelau</option>
				<option value="Tonga">TO - Tonga</option>
				<option value="Trinidad and Tobago">TT - Trinidad and Tobago</option>
				<option value="Tunisia">TN - Tunisia</option>
				<option value="Turkey">TR - Turkey</option>
				<option value="Turkmenistan">TM - Turkmenistan</option>
				<option value="Turks and Caicos Islands">TC - Turks and Caicos Islands</option>
				<option value="Tuvalu">TV - Tuvalu</option>
				<option value="Uganda">UG - Uganda</option>
				<option value="Ukraine">UA - Ukraine</option>
				<option value="United Arab Emirates">AE - United Arab Emirates</option>
				<option value="United Kingdom">GB - United Kingdom</option>
				<option value="United States Minor Outlying Islands">UM - United States Minor Outlying Islands</option>
				<option value="Uruguay">UY - Uruguay</option>
				<option value="Uzbekistan">UZ - Uzbekistan</option>
				<option value="Vanuatu">VU - Vanuatu</option>
				<option value="Venezuela">VE - Venezuela</option>
				<option value="Viet Nam">VN - Viet Nam</option>
				<option value="Virgin Islands, British">VG - Virgin Islands, British</option>
				<option value="Virgin Islands, U.S.">VI - Virgin Islands, U.S.</option>
				<option value="Wallis and Futuna">WF - Wallis and Futuna</option>
				<option value="Western Sahara">EH - Western Sahara</option>
				<option value="Yemen">YE - Yemen</option>
				<option value="Yugoslavia">YU - Yugoslavia</option>
				<option value="Zambia">ZM - Zambia</option>
				<option value="Zimbabwe">ZW - Zimbabwe</option>
			</select>
		</div>
	</fieldset>
	<fieldset id="BillingArea">
		<legend>Billing Information</legend>
		<div class="notes">
			<h4>Billing Information</h4>
			<p class="last">This information is safe and secure.  We do not store your information in our systems and it is not accessible to anyone.<br /><br />
			Where is Security Code?<br />
			Last 3 to 4 digits found on the back of your card.</p>
		</div>
		<div class="required">
			<label for="CardName">Amount</label>
			<!-- 
			PREVIEW ONLY:
			ALTERING THIS FIELD WILL NOT CHANGE THE BILLED AMOUNT.
			-->
			<input type="text" name="AmountPreview" id="AmountPreview" class="inputText" size="10" maxlength="100" value="$0.00" style="width:65px;" disabled />
		</div>
		<div class="required">
			<label for="CardName">Name On Card</label>
			<input type="text" name="CardName" id="CardName" class="inputText" size="10" maxlength="100" value="#Attributes.CardName#" />
		</div>
		<div class="required">
			<label for="CardNumber">Card Number</label>
			<input type="text" name="CardNumber" id="CardNumber" class="inputText" size="10" maxlength="16" value="#Attributes.CardNumber#" />
		</div>
		<div class="required">
			<label for="CardType">Card Type</label>
			<select name="CardType" id="CardType">
				<option value="MasterCard">MasterCard</option>
				<option value="VISA">VISA</option>
			</select>
		</div>
		<div class="required">
			<label for="CardExpireMonth">Expiration</label>
			<select name="CardExpireMonth" id="CardExpireMonth" style="width:55px;">
				<cfloop from="1" to="12" index="i">
				<option value="#NumberFormat(i,'00')#">#NumberFormat(i,'00')#</option>
				</cfloop>
			</select>
			<select name="CardExpireYear" id="CardExpireYear" style="width:70px;">
				<cfloop from="#Year(now())#" to="#Year(now())+10#" index="i">
				<option value="#NumberFormat(i,'0000')#">#NumberFormat(i,'0000')#</option>
				</cfloop>
			</select>
		</div>
		<div class="required">
			<label for="CardCode">Security Code</label>
			<input type="text" name="CardCode" id="CardCode" class="inputText" size="10" maxlength="4" value="#Attributes.CardCode#" style="width:50px;" />
		</div>
	</fieldset>
	<fieldset id="Finish-PayNow">
		<legend>Finish Payment</legend>
		By pressing 'Pay Now' your credit card will be charged and you will be registered for this activity.
		<input type="submit" value="Pay Now" name="Submit" />
	</fieldset>
	<fieldset id="Finish-Submit">
		<legend>Finish Registration</legend>
		By pressing 'Complete Registration' you will be registered for this activity.
		<input type="submit" value="Complete Registration" name="Submit2" />
	</fieldset>
</form>

</cfoutput>