<cfoutput>
<div class="address-list listinator">
  <cfif AddressList.RecordCount NEQ 0>
  <cfloop query="AddressList">
    <cfif Attributes.PrimaryAddressID EQ AddressList.AddressID>
      <cfset isPrimary = true />
    <cfelse>
      <cfset isPrimary = false />
    </cfif>

    <div class="address-row list-row js-list-row<cfif isPrimary> is-primary</cfif>" data-key="#addresslist.addressid#">
      <div class="address span16">
        <span class="label address-type">#trim(replace(AddressTypeName,'address',''))#</span>
        <cfif Address1 NEQ "">
          #Address1#
          <cfif Address2 NEQ "">#Address2#</cfif>
            <cfif AddressList.country_iso NEQ "US" AND len(trim(AddressList.country_iso)) GT 0>
                <cfif AddressList.City NEQ "" And AddressList.Province NEQ "">, </cfif><cfif AddressList.Province NEQ "">#Province#</cfif>
                <span class="js-country-code">#country_iso#</span><cfif Zipcode NEQ ""> #Zipcode#</cfif>
            <cfelseif AddressList.Province NEQ "">
                <cfif City NEQ "">#City#, </cfif>#Province#
                <span class="js-country-code">#country_iso#</span><cfif Zipcode NEQ "">,<br />#Zipcode#</cfif>
            <cfelse>
                #arrayToList(arrayFilter([City, (stateid NEQ "" ? application.List.States.code[stateid] : ""), Zipcode], function(elem) { if(elem NEQ "") { return true; } else { return false; } }), ", ")# <span class="js-country-code">#country_iso#</span><br />
            </cfif>
        <cfelseif Address1 EQ "" AND (Phone1 NEQ "" OR Phone3 NEQ "")>
            #(Phone1 NEQ "" ? "Ph1: " & Phone1 : "Fax: " & Phone3)#
        </cfif>
        <!--- <cfloop from="1" to="3" index="i">
          #phoneOutput(evaluate("phone#i#"),evaluate("phone#i#ext"))#
        </cfloop> --->
      </div>
      <div class="row-status span8">
        <ul class="status-group">
          <li>
            <i></i>
          </li>
          <li class="address-makeprimary">
            <i class="icon-star"></i>
          </li>
          <li>
            <i></i>
          </li>
        </ul>
      </div>
      <div class="row-actions span8">
        <div class="btn-group">
          <a href="javascript://" class="address-edit btn" data-tooltip-title="Edit Address"><i class="icon-pencil"></i></a>
          <a href="javascript://" class="address-makeprimary<cfif isPrimary> disabled</cfif> btn" data-tooltip-title="<cfif isPrimary>This is the primary address.<cfelse>Mark address as primary</cfif>"><i class="icon-star"></i></a>
        </div>
        <div class="btn-group">
          <a href="javascript://" class="address-delete btn" data-tooltip-title="Delete Address"><i class="icon-trash"></i></a>
        </div>
      </div>
    </div>
			</cfloop>
		<cfelse>
			There are no address records for #Attributes.FirstName# #Attributes.LastName#.  <a href="javascript://" class="address-add">Click here</a> to add one.
		</cfif>
</div>
<cffunction name="phoneOutput" returntype="string">
  <cfargument name="phone" type="string" required="no" default="" />
  <cfargument name="phoneext" type="string" required="no" default="" />
  
  <cfset returnVar = "" />
  <cfif phone NEQ "">
    <cfset returnVar = phone />
  </cfif>
  <cfset returnVar = '<span class="js-phonenumber">#returnVar#</span>' />


  <cfif phoneext NEQ "">
    <cfset returnVar &= '<span class="js-phoneext">x#phoneext#</span>' />
  </cfif>

  <cfset returnVar = '<div class="js-phone">#returnVar#</div>' />

  <cfreturn returnVar />
</cffunction>
</cfoutput>