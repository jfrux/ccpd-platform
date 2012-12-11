<script>
function updateAddresses() {
	$.post(sMyself + "Person.AddressAHAH", { PersonID: nPerson },
		function(data) {
			$("#AddressesContainer").html(data);
			$("#AddressesLoading").hide();
			
	});
}

$(document).ready(function() {
	updateAddresses();
	
	$(".address-add").live("click", this, function() {
		$.post(sMyself + "Person.EditAddress", { PersonID: nPerson },
			function(data) {
			$("#address-info").html(data);
				
		});
		
		$("#address-info").dialog("open");
	});
	
	$("#address-info").dialog({ 
			title: "Address Information",
			modal: true, 
			autoOpen: false,
			position:[40,40],
			height:320,
			width:600,
			resizable: false,
			buttons: {
				"Save": function() {
					var nError = 0;
					var nAddress = $("#AddressID").val();
					var nAddressType = $("#AddressTypeID").val();
					var sPrimaryFlag = $("#PrimaryFlag").val();
					var sAddress1 = $("#Address1").val();
					var sAddress2 = $("#Address2").val();
					var sCity = $("#City").val();
					var sState = $("#State").val();
					var sCountry = $("#Country").val();
					var sProvince = $("#Province").val();
					var nZipcode = $("#Zipcode").val();
					var sPhone1 = $("#Phone1").val();
					var sPhone1ext = $("#Phone1ext").val();
					var sPhone2 = $("#Phone2").val();
					var sPhone2ext = $("#Phone2ext").val();
					var sPhone3 = $("#Phone3").val();
					var sPhone3ext = $("#Phone3ext").val();
					
					if(nAddressType == "") {
						nError = nError + 1;
						addError("Please select an Address Type.",250,6000,4000);
					}
					
					if(sPrimaryFlag == "") {
						nError = nError + 1;
						addError("Please select if Primary Address.",250,6000,4000);
					}
					
					<!---if(sAddress1 == "") {
						nError = nError + 1;
						addError("Please enter information for Streetline 1.",250,6000,4000);
					}
					
					if(sCity == "") {
						nError = nError + 1;
						addError("Please enter information for City.",250,6000,4000);
					}
					
					if(sCountry == "") {
						nError = nError + 1;
						addError("Please select a Country.",250,6000,4000);
					} else {
						if(sCountry == "Canada" && sProvince == "") {
							nError = nError + 1;
							addError("Please enter a Province.",250,6000,4000);
						} else if(sCountry == "United States of America" && sState == "") {
							nError = nError + 1;
							addError("Please select a State.",250,6000,4000);
						}
					}--->
					
					if(nError > 0) {
						return false;
					}
					
					$.getJSON(sRootPath + "/_com/AJAX_Person.cfc", { method: "saveAddress", AddressID: nAddress, PersonID: nPerson, AddressTypeID: nAddressType, PrimaryFlag: sPrimaryFlag, Address1: sAddress1, Address2: sAddress2, City: sCity, State: sState, Country: sCountry, Province: sProvince, ZipCode: nZipcode, Phone1: sPhone1, Phone1ext: sPhone1ext, Phone2: sPhone2, Phone2ext: sPhone2ext,  Phone3: sPhone3,Phone3ext: sPhone3ext, returnFormat: "plain" },
						function(data) {
							if(data.STATUS) {
								addMessage(data.STATUSMSG,250,6000,4000);
								$("#address-info").dialog("close");
								updateAddresses();
							} else {
								addError(data.STATUSMSG,250,6000,4000);
							}
					});
				},
				"Cancel": function() {
					$("#address-info").dialog("close");
				}
			},
			open:function() {
			},
			close:function() {
				$("#address-info").html("");
			}
		});
});
</script>

<div class="ViewSection">
	<h3>Contact Details</h3>
	<div id="AddressesContainer"></div>
	<div id="AddressesLoading" class="Loading"><img src="<cfoutput>#Application.Settings.RootPath#</cfoutput>/_images/ajax-loader.gif" />
	<div>Please Wait</div>
	</div>
</div>
<div id="address-info">
</div>