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

<cfoutput>
<form name="formAddress" class="form-horizontal" method="post" action="/admin/_com/AJAX_Person.cfc">
  <input type="hidden" name="returnformat" value="plain" />
  <input type="hidden" name="method" value="saveAddress" />
  <input type="hidden" name="personid" value="#attributes.personid#" />
  <input type="hidden" value="#Attributes.AddressID#" id="editaddress-addressid" name="addressid" />
  <input type="hidden" name="primaryflag" value="<cfif isPrimary>Y<cfelse>N</cfif>" />
  <!---Used to switch out the content based on the tab number in the querystring --->
  
  <div class="control-group">
    <label class="control-label" for="editaddress-addresstypeid">Address Type</label>
    <div class="controls">
      <select id="editaddress-addresstypeid" name="addressTypeID" tabindex="1">
        <option value="">Select one...</option>
        <cfloop query="Application.List.AddressTypes">
          <option value="#Application.List.AddressTypes.AddressTypeID#"<cfif Attributes.AddressTypeID EQ Application.List.AddressTypes.AddressTypeID OR isDefined("cookie.address_type") AND cookie.address_type EQ Application.List.AddressTypes.AddressTypeID> SELECTED</cfif>>#Description#</option>
        </cfloop>
      </select>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="editaddress-address1">Streetline 1</label>
    <div class="controls">
        <input id="editaddress-address1" name="address1" type="text" value="#Attributes.Address1#" tabindex="3"  />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="editaddress-address2">Streetline 2</label>
    <div class="controls">
        <input id="editaddress-address2" name="address2" type="text" value="#Attributes.Address2#" tabindex="4" />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="editaddress-address2">Location</label>
    <div class="controls">
        <input id="editaddress-geonameid" class="js-typeahead-city" placeholder="City, State, Region, etc." name="geonameid" type="text" value="" tabindex="4" />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="editaddress-city">Location</label>
    <div class="controls">
      <input id="editaddress-city" name="city" class="input-small" type="text" placeholder="City" value="#Attributes.City#" tabindex="5"  />
      <select id="editaddress-state" class="input-small unitedstates" name="stateid" tabindex="6">
        <option value="0">Select one...</option>
        <cfloop query="Application.List.States">
        <option value="#Application.List.States.stateid#"<cfif Attributes.stateid EQ Application.List.States.stateid> selected</cfif>>#Name#</option>
        </cfloop>
      </select>
      <input id="editaddress-province" class="canada input-small" name="Province" placeholder="Province" type="text" value="#Attributes.Province#" tabindex="9" />
      <select id="editaddress-country" class="input-medium" name="countryid" tabindex="7">
        <option value="0">Select one...</option>
        <cfloop query="Application.List.Countries">
          <option value="#Application.List.Countries.countryid#"<cfif Attributes.CountryId EQ Application.List.Countries.CountryId OR Attributes.CountryId EQ 0 AND Application.List.Countries.Name EQ "United States of America"> Selected</cfif>>#Name#</option>
        </cfloop>
      </select>
      
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">Postal Code</label>
    <div class="controls">
        <input id="editaddress-zipcode" name="Zipcode" type="text" value="#Attributes.Zipcode#" tabindex="8" />
    </div>
  </div>
  <div class="control-group canada">
    <label class="control-label">Province</label>
    <div class="controls">
        
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">Phone 1</label>
    <div class="controls">
      <input id="editaddress-phone1" name="phone1" type="text" value="#Attributes.Phone1#" tabindex="10" />
      <div class="input-prepend">
        <span class="add-on">Ext.</span>
        <input type="text" id="editaddress-phone1ext" name="phone1ext" class="input-small" value="#Attributes.Phone1ext#" tabindex="11" />
      </div>
      <label class="checkbox hide" for="editaddress-phone1mask"><input type="checkbox" id="editaddress-phone1mask" class="phoneMask" /> International?</label>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">Phone 2</label>
    <div class="controls">
      <input id="editaddress-Phone2" name="phone2" type="text" value="#Attributes.Phone2#" tabindex="12" /> 
      <div class="input-prepend">
        <span class="add-on">Ext.</span>
        <input type="text" id="editaddress-phone2ext" name="phone2ext" class="input-small" value="#Attributes.Phone2ext#" tabindex="12" />
      </div>
      <label class="checkbox hide" for="editaddress-phone2mask"><input type="checkbox" id="editaddress-phone2mask" class="phoneMask" /> International?</label>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">Fax</label>
    <div class="controls">
      <input id="editaddress-Phone3" name="phone3" type="text" value="#Attributes.Phone3#" tabindex="14" /> 
      <div class="input-prepend">
        <span class="add-on">Ext.</span>
        <input type="text" id="editaddress-phone3ext" name="phone3ext" class="input-small" value="#attributes.phone3ext#" tabindex="12" />
      </div>
      <label class="checkbox hide" for="editaddress-phone3mask"><input type="checkbox" id="editaddress-phone3mask" class="phoneMask" /> International?</label>
    </div>
  </div>
  <input type="submit" value="Submit Form" class="hide" />
</form>
</cfoutput>
</div>