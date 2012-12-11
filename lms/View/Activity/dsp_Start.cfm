<cfparam name="Attributes.CardName" default="">
<cfparam name="Attributes.CardType" default="">
<cfparam name="Attributes.CardNumber" default="">
<cfparam name="Attributes.CardCode" default="">
<cfparam name="Attributes.BillPhone" default="">
<cfparam name="Attributes.BillAddr1" default="">
<cfparam name="Attributes.BillAddr2" default="">
<cfparam name="Attributes.BillCity" default="">
<cfparam name="Attributes.BillState" default="">
<cfparam name="Attributes.BillZip" default="">
<cfparam name="Attributes.BillCountry" default="">
<cfoutput>
<script>
	$(document).ready(function() {
		$(".DegreeID").bind("change", this, function() {
			$("##DegreeID").val($(this).val());
		});
	});
</script>

    <h3>#Attributes.Title#</h3>
    <cfswitch expression="#Attributes.Mode#">
    	<cfcase value="Degree">
            <cfquery name="qDegrees" datasource="#Application.Settings.DSN#">
                SELECT DegreeID,Name,Abbrev
                FROM ce_Sys_Degree
                ORDER BY Sort
            </cfquery>
            
            <form name="formStartActivity" id="formStartActivity" method="post" action="#Myself#Activity.Start?ActivityID=#Attributes.ActivityID#&Mode=#Attributes.Mode#&Submitted=1">
            	<div>
                	<h4>Please select your profession</h4>
                    <div id="ProfOptions" style="clear:both;overflow:auto;">
					<cfloop query="qDegrees">
                    <div class="CheckboxOption"><input id="Degree#qDegrees.DegreeID#" type="radio" name="DegreeID" class="DegreeID" value="#qDegrees.DegreeID#" /> <label for="Degree#qDegrees.DegreeID#">#qDegrees.Name#</label></div>
                    </cfloop>
					</div>
                    <p>&nbsp;</p>
                    <p>**NOTE: For you to receive a certificate, you must select your profession.</p>
                </div>
            </form>
        </cfcase>
    	<cfcase value="Payment">
            <form name="formStartActivity" id="formStartActivity" method="post" action="#Myself#Activity.Start?ActivityID=#Attributes.ActivityID#&Mode=#Attributes.Mode#&Submitted=1">
            	<div>
                	<p>Payment is required before taking this activity.</p>
                    <p>Please use the SECURE form below to make your payment and continue...</p>
                    <p class="error" id="CCError" style="color:##FF0000; background-color:##FFE1E1;border:1px solid ##FF0000; padding:5px;display:none;"></p>
					<fieldset>
						<legend>Contact Information</legend>
						<div class="required">
							<label for="Phone">Phone</label>
							<input name="Phone" type="text" class="inputText" id="BillPhone" value="#Attributes.BillPhone#" size="10" maxlength="100" />
						</div>
						<div class="required">
							<label for="Address1">Address</label>
							<input type="text" name="BillAddr1" id="BillAddr1" class="inputText" size="10" maxlength="100" value="#Attributes.BillAddr1#" />
							<input type="text" name="BillAddr2" id="BillAddr2" class="inputText" size="10" maxlength="100" value="#Attributes.BillAddr2#" />
						</div>
						<div class="required">
							<label for="city">City</label>
							<input type="text" name="BillCity" id="BillCity" class="inputText" size="10" maxlength="100" value="#Attributes.BillCity#" />
						</div>
						<div class="required">
							<label for="State">State</label>
							<select name="BillState" id="BillState" class="selectOne">
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
							<input type="text" name="BillZip" id="BillZip" class="inputText" size="10" maxlength="50" value="#Attributes.BillZip#" />
						</div>
					</fieldset>
					<fieldset id="BillingArea">
						<legend>Credit Card Information</legend>
						<div class="required">
							<label for="CardName">Amount</label>
							<!-- 
							PREVIEW ONLY:
							ALTERING THIS FIELD WILL NOT CHANGE THE BILLED AMOUNT.
							-->
							<input type="text" name="AmountPreview" id="AmountPreview" class="inputText" size="10" maxlength="100" value="#LSCurrencyFormat(ActivityPubGeneral.getPaymentFee())#" style="width:65px;" disabled />
						</div>
						<div class="required">
							<label for="CardName">Name On Card</label>
							<input type="text" name="CardName" id="CardName" class="inputText" size="10" maxlength="100" value="#Attributes.CardName#" />
						</div>
						<div class="required">
							<label for="CardNumber">Card Number</label>
							<input type="text" name="CardNumber" id="CardNumber" class="inputText" size="16" maxlength="16" value="#Attributes.CardNumber#" />
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
						<!---<div class="required">
							<label for="CardCode">Security Code</label>
							<input type="text" name="CardCode" id="CardCode" class="inputText" size="10" maxlength="4" value="#Attributes.CardCode#" style="width:50px;" />
						</div>--->
					</fieldset>
                </div>
            </form>
        </cfcase>
    	<cfcase value="Terms">
            <form name="formStartActivity" id="formStartActivity" method="post" action="#Myself#Activity.Start?ActivityID=#Attributes.ActivityID#&Mode=#Attributes.Mode#&Submitted=1">
            	<div>
                	<p>#Attributes.TermsText#</p>
                    <p>&nbsp;</p>
                    <p>**NOTE: By clicking the "Accept" button, I agree to the Activity Terms.</p>
                </div>
            </form>
        </cfcase>
    </cfswitch>

</cfoutput>