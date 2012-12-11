<cfparam name="Attributes.AddressID" default="0">
<cfparam name="Attributes.AddressTypeID" default="">
<cfparam name="Attributes.Address1" default="">
<cfparam name="Attributes.Address1" default="">
<cfparam name="Attributes.City" default="">
<cfparam name="Attributes.State" default="">
<cfparam name="Attributes.Country" default="">
<cfparam name="Attributes.Province" default="">
<cfparam name="Attributes.ZipCode" default="">
<cfparam name="Attributes.Phone1" default="">
<cfparam name="Attributes.Phone1ext" default="">
<cfparam name="Attributes.Phone2" default="">
<cfparam name="Attributes.Phone2ext" default="">
<cfparam name="Attributes.Phone3" default="">
<cfparam name="Attributes.Phone3ext" default="">

<script>

function updateStateProvince(sCountry) {
	if(sCountry  == "United States of America") {
		$(".canada").hide();
		$(".unitedstates").show();
	} else if(sCountry == "Canada") {
		$(".unitedstates").hide();
		$(".canada").show();
	} else {
		$(".unitedstates").hide();
		$(".canada").hide();
	}
}

$(document).ready(function() {
	updateStateProvince($("#Country").val());
	var maskUS = "(999) 999-9999";
	
	<cfif len(trim(attributes.phone1)) LTE 10>
	$("#Phone1").mask(maskUS);
	<cfelse>
	$("#Phone1mask").attr('checked',true);
	</cfif>
	<cfif len(trim(attributes.phone2)) LTE 10>
	$("#Phone2").mask(maskUS);
	<cfelse>
	$("#Phone2mask").attr('checked',true);
	</cfif>
	<cfif len(trim(attributes.phone3)) LTE 10>
	$("#Phone3").mask(maskUS);
	<cfelse>
	$("#Phone3mask").attr('checked',true);
	</cfif>
	
	$("#Country").bind("change", this, function() {
		updateStateProvince($(this).val());
	});
	
	$('.phoneMask').change(function() {
		if($(this).is(':checked')) {
			$("#" + $(this).attr('id').replace('mask','')).unmask(maskUS);
		} else {
			$("#" + $(this).attr('id').replace('mask','')).mask(maskUS);
		}
	});
});
</script>

<cfoutput>
<input type="hidden" value="#Attributes.AddressID#" id="AddressID" name="AddressID" />
<div class="ViewSection">
<!---Used to switch out the content based on the tab number in the querystring --->
<table cellspacing="2" cellpadding="3" border="0" width="100%">
	<tr>
		<td class="FieldLabel">Address Type:</td>
		<td class="FieldInput">
			<select id="AddressTypeID" name="AddressTypeID" tabindex="1">
				<option value="">Select one...</option>
				<cfloop query="Application.List.AddressTypes">
					<option value="#Application.List.AddressTypes.AddressTypeID#"<cfif Attributes.AddressTypeID EQ Application.List.AddressTypes.AddressTypeID OR isDefined("cookie.address_type") AND cookie.address_type EQ Application.List.AddressTypes.AddressTypeID> SELECTED</cfif>>#Description#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<tr>
		<td class="FieldLabel">Primary Address?:</td>
		<td class="FieldInput">
			<select id="PrimaryFlag" name="PrimaryFlag" tabindex="2">
				<option value="">Select one...</option>
				<option value="N"<cfif NOT isPrimaryAddress> Selected</cfif>>No</option>
				<option value="Y"<cfif isPrimaryAddress> Selected</cfif>>Yes</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="FieldLabel">Streetline 1:</td>
		<td class="FieldInput">
				<input id="Address1" name="Address1" type="text" class="inputText" value="#Attributes.Address1#" style="width:400px;" tabindex="3"  />
		</td>
	</tr>
	<tr>
		<td class="FieldLabel">Streetline 2:</td>
		<td class="FieldInput">
				<input id="Address2" name="Address2" type="text" class="inputText" value="#Attributes.Address2#" style="width:400px;" tabindex="4" />
		</td>
	</tr>
	<tr>
		<td class="FieldLabel">City:</td>
		<td class="FieldInput">
			
				<input id="City" name="City" type="text" class="inputText" value="#Attributes.City#" tabindex="5"  />
		</td>
	</tr>
	<tr class="unitedstates">
		<td class="FieldLabel">State</td>
		<td class="FieldInput">
				<select id="State" name="State" tabindex="6">
					<option value="">Select one...</option>
					<cfloop query="Application.List.States">
						<option value="#Application.List.States.Code#"<cfif Attributes.State EQ Application.List.States.Code> Selected</cfif>>#Name#</option>
					</cfloop>
				</select>
		</td>
	</tr>
	<tr>
		<td class="FieldLabel">Country:</td>
		<td class="FieldInput">
				<select id="Country" name="Country" tabindex="7">
					<option value="0">Select one...</option>
					<cfloop query="Application.List.Countries">
						<option value="#Application.List.Countries.Name#"<cfif Attributes.Country EQ Application.List.Countries.Name OR Attributes.Country EQ "" AND Application.List.Countries.Name EQ "United States of America"> Selected</cfif>>#Name#</option>
					</cfloop>
				</select>
		</td>
	</tr>
	<tr>
		<td class="FieldLabel">Postal Code:</td>
		<td class="FieldInput">
				<input id="Zipcode" name="Zipcode" type="text" class="inputText" value="#Attributes.Zipcode#" tabindex="8" />
		</td>
	</tr>
	<tr class="canada">
		<td class="FieldLabel">Province:</td>
		<td class="FieldInput">
				<input id="Province" name="Province" type="text" class="inputText" value="#Attributes.Province#" tabindex="9" />
		</td>
	</tr>
	<tr>
    	<td colspan="2" align="center"><strong>**Note: Do not format phone ##'s and faxes, they will be formatted upon saving.**</strong></td>
    </tr>
	<tr>
		<td class="FieldLabel">Phone 1:</td>
		<td class="FieldInput">
				<input id="Phone1" name="Phone1" type="text" class="inputText" value="#Attributes.Phone1#" tabindex="10" />
                ext.<input type="text" id="Phone1ext" name="Phone1ext" class="inputText" value="#Attributes.Phone1ext#" tabindex="11" />
                <input type="checkbox" id="Phone1mask" class="phoneMask" /><label for="phone1mask">International?</label>
		</td>
	</tr>
	<tr>
		<td class="FieldLabel">Phone 2:</td>
		<td class="FieldInput">
				<input id="Phone2" name="Phone2" type="text" class="inputText" value="#Attributes.Phone2#" tabindex="12" /> 
                ext.<input type="text" id="Phone2ext" name="Phone2ext" class="inputText" value="#Attributes.Phone2ext#" tabindex="13" />
                <input type="checkbox" id="Phone2mask" class="phoneMask" /><label for="phone2mask">International?</label>
		</td>
	</tr>
	<tr>
		<td class="FieldLabel">Fax:</td>
		<td class="FieldInput">
				<input id="Phone3" name="Phone3" type="text" class="inputText" value="#Attributes.Phone3#" tabindex="14" /> 
                ext.<input type="text" id="Phone3ext" name="Phone3ext" class="inputText" value="#Attributes.Phone3ext#" tabindex="15" />
                <input type="checkbox" id="Phone3mask" class="phoneMask" /><label for="phone3mask">International?</label>
		</td>
	</tr>
</table>
</cfoutput>
</div>