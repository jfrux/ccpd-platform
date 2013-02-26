<script>
$(document).ready(function() {
	$(".address-edit").bind("click", this, function() {
		var nAddress = $.ListGetAt(this.id, 3, "-");
		
		$.post(sMyself + "Person.EditAddress", { PersonID: nPerson, AddressID: nAddress },
			function(data) {
			$("#address-info").html(data);
				
		});
		
		$("#address-info").dialog("open");
	});
	
	$(".address-delete").bind("click", this, function() {
		var nAddress = $.ListGetAt(this.id, 3, "-");
		var ConfirmDelete = confirm("Are you sure you want to delete this address?");
		
		if(ConfirmDelete) {
			$.getJSON(sRootPath + "/_com/AJAX_Person.cfc", { method: "deleteAddress", PersonID: nPerson, AddressID: nAddress, returnFormat: "plain" },
				function(data) {							
					if(data.STATUS) {
						addMessage(data.STATUSMSG,250,6000,4000);
						updateAddresses();
					} else {
						addError(data.STATUSMSG,250,6000,4000);
					}
			});
		}
	});
});
</script>
<cfoutput>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ViewSectionGrid">
	<tbody>
		<cfif AddressList.RecordCount NEQ 0>
			<cfloop query="AddressList">
				<tr>
					<td>
                        #AddressTypeName#
                        <cfif Attributes.PrimaryAddressID EQ AddressList.AddressID><br /><em style="color:##555; font-size:10px;">Primary</em></cfif>
                    </td>
					<td>
                        <strong>#Address1#</strong><br />
                        <cfif Address2 NEQ "">#Address2#<br /></cfif>
                        <cfif AddressList.Country NEQ "United States of America" AND len(trim(AddressList.Country)) GT 0>
                            <cfif City NEQ "">#City#</cfif><cfif AddressList.City NEQ "" And AddressList.Province NEQ "">, </cfif><cfif AddressList.Province NEQ "">#Province#</cfif><br />
                            #Country#<cfif Zipcode NEQ ""> #Zipcode#</cfif><br />
                        <cfelseif AddressList.Province NEQ "">
                            <cfif City NEQ "">#City#, </cfif>#Province#
                            #Country#<br /><cfif Zipcode NEQ "">, #Zipcode#</cfif><br />
                        <cfelse>
                            <cfif City NEQ "">#City#, </cfif>#State#<cfif Zipcode NEQ "">, #Zipcode#</cfif><br />
                        </cfif>
					</td>
					<td>
                    	<cfif Phone1 NEQ "">
                            <cfif len(phone1) EQ 10>
                            	P1: (#Left(Phone1, 3)#) #Mid(Phone1, 4, 3)# - #Mid(Phone1, 7, 4)#
                            <cfelse>
                            	P1: #Phone1#
                            </cfif>
                            <cfif Phone1ext NEQ "">
                            x#Phone1Ext#
                            </cfif>
                        </cfif>
                        <cfif Phone2 NEQ "">
                            <cfif len(phone2) EQ 10>
                            	<br />P2: (#Left(Phone2, 3)#) #Mid(Phone2, 4, 3)# - #Mid(Phone2, 7, 4)#
                            <cfelse>
                            	<br />P2: #Phone2#
                            </cfif>
                            <cfif Phone2ext NEQ "">
                            x#Phone2Ext#
                            </cfif>
                        </cfif>
                        <cfif Phone3 NEQ "">
                            <cfif len(phone3) EQ 10>
                            	<br />F: (#Left(Phone3, 3)#) #Mid(Phone3, 4, 3)# - #Mid(Phone3, 7, 4)#
                            <cfelse>
                            	<br />F: #Phone3#
							</cfif>
                            <cfif Phone3ext NEQ "">
                            x#Phone3Ext#
                            </cfif>
                        </cfif>
					</td>
					<td>
                    	<a href="javascript://" class="address-edit" id="address-edit-#AddressID#">Edit this address</a><br />
                        <a href="javascript://" class="address-delete" id="address-delete-#AddressID#">Delete this address</a>
                    </td>
				</tr>
			</cfloop>
		<cfelse>
			<tr>
				<td colspan="9">There are no address records for #Attributes.FirstName# #Attributes.LastName#.  <a href="javascript://" class="address-add">Click here</a> to add one.</td>
			</tr>
		</cfif>
	</tbody>
</table>
</cfoutput>