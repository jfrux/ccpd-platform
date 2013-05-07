<cfsilent>
<cfsetting enablecfoutputonly="true" />
<cfcontent type="text/x-vCard">
<cfheader name="Content-Disposition" value="inline;filename=#Attributes.LastName#-#Attributes.FirstName#.vcf">
</cfsilent>
<cfoutput>
BEGIN:VCARD
VERSION:3.0
N:#Attributes.LastName#;#Attributes.FirstName#
FN:#Attributes.FirstName# #Attributes.LastName#
<cfloop query="AddressList">
<cfif AddressList.AddressTypeID EQ 2>
TEL;TYPE=HOME,VOICE:#AddressList.Phone1#
<cfif AddressList.Phone2 NEQ "">
TEL;TYPE=HOME,VOICE:#AddressList.Phone2#
</cfif>
ADR;TYPE=HOME:;;#AddressList.Address1# #AddressList.Address2#;#AddressList.City#;#AddressList.State#;#AddressList.ZipCode#;#AddressList.Country#
<cfelse>
<cfif AddressList.CompanyName NEQ "">
ORG:#AddressList.CompanyName#
</cfif>
<cfif AddressList.CompanyPosition NEQ "">
TITLE:#AddressList.CompanyPosition#
</cfif>
TEL;TYPE=WORK,VOICE:#AddressList.Phone1#
<cfif AddressList.Phone2 NEQ "">
TEL;TYPE=WORK,VOICE:#AddressList.Phone2#
</cfif>
ADR;TYPE=WORK:;;#AddressList.StreetLine1# #AddressList.StreetLine2#;#AddressList.City#;#AddressList.StateName#;#AddressList.PostalCode#;#AddressList.CountryName#
</cfif>
</cfloop>
EMAIL;TYPE=PREF,INTERNET:#Attributes.Email#
END:VCARD
</cfoutput>
