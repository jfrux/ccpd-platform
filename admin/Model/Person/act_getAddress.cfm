<cfparam name="Attributes.Submitted" default="">
<cfparam name="Attributes.AddressID" default="0">

<cfif Attributes.Submitted EQ "">
  <cfset AddressBean = CreateObject('component','#Application.Settings.Com#PersonAddress.PersonAddress').init(AddressID=Attributes.AddressID)>
  <cfset AddressExists = Application.Com.PersonAddressDAO.Exists(AddressBean)>
  
  <cfif AddressExists>
    <cfset AddressBean = Application.Com.PersonAddressDAO.Read(AddressBean)>
    
    <cfset Attributes.AddressTypeID = AddressBean.getAddressTypeID()>
    <cfset Attributes.Address1 = AddressBean.getAddress1()>
    <cfset Attributes.Address2 = AddressBean.getAddress2()>
    <cfset Attributes.City = AddressBean.getCity()>
    <cfset Attributes.State = AddressBean.getState()>
    <cfset Attributes.StateId = AddressBean.getStateId()>
    <cfset Attributes.Country = AddressBean.getCountry()>
    <cfset Attributes.CountryId = AddressBean.getCountryId()>
    <cfset Attributes.Province = AddressBean.getProvince()>
    <cfset Attributes.Phone1 = AddressBean.getPhone1()>
    <cfset Attributes.Phone1ext = AddressBean.getPhone1ext()>
    <cfset Attributes.Phone2 = AddressBean.getPhone2()>
    <cfset Attributes.Phone2ext = AddressBean.getPhone2ext()>
    <cfset Attributes.Phone3 = AddressBean.getPhone3()>
    <cfset Attributes.Phone3ext = AddressBean.getPhone3ext()>
    <cfset Attributes.ZipCode = AddressBean.getZipCode()>
    <cfset isPrimaryAddress = Application.Person.isPrimaryAddress(AddressBean.getAddressID(),Attributes.PersonID)>
  <cfelse>
    <cfset Attributes.AddressID = 0>
    <cfset Attributes.AddressTypeID = "">
    <cfset Attributes.Address1 = "">
    <cfset Attributes.Address2 = "">
    <cfset Attributes.City = "">
    <cfset Attributes.State = "">
    <cfset Attributes.StateId = 0>
    <cfset Attributes.Country = "">
    <cfset Attributes.CountryId = "0">
    <cfset Attributes.Province = "">
    <cfset Attributes.Phone1 = "">
    <cfset Attributes.Phone1ext = "">
    <cfset Attributes.Phone2 = "">
    <cfset Attributes.Phone2ext = "">
    <cfset Attributes.Phone3 = "">
    <cfset Attributes.Phone3ext = "">
    <cfset Attributes.ZipCode = "">
    <cfset isPrimaryAddress = true>
  </cfif>

  <cfif attributes.primaryaddressid EQ attributes.addressid>
    <cfset isPrimary = true />
  <cfelse>
    <cfset isPrimary = false />
  </cfif>
</cfif>