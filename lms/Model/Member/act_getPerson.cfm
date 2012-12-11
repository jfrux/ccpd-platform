<!--- Attributes.Submitted is used to prevent Edit pages from overwriting user input --->
<cfparam name="Attributes.Submitted" default="">

<cftry>
    <cfset PersonBean = CreateObject("component","#Application.Settings.Com#Person.Person").init(PersonID=Session.PersonID)>
    <cfset PersonBean = Application.Com.PersonDAO.Read(PersonBean)>
    
    <cfset Attributes.FirstName = PersonBean.getFirstName()>
    <cfset Attributes.LastName = PersonBean.getLastName()>
    <cfset Attributes.DisplayDegree = PersonBean.getDisplayDegree()>
    <!---<cfset Attributes.BirthCountryID = PersonBean.getBirthCountryID()>
    <cfset Attributes.BirthDate = PersonBean.getBirthDate()>
    <cfset Attributes.CampusID = PersonBean.getCampusID()>
    <cfset Attributes.CellPhone = PersonBean.getCellPhone()>
    <cfset Attributes.CitzenshipCountryID = PersonBean.getCitzenshipCountryID()>
    <cfset Attributes.Comment = PersonBean.getComment()>
    <cfset Attributes.CreationDate = PersonBean.getCreationDate()>
    <cfset Attributes.Deathdate = PersonBean.getDeathdate()>
    <cfset Attributes.Email1 = PersonBean.getEmail1()>
    <cfset Attributes.Email2 = PersonBean.getEmail2()>
    <cfset Attributes.Email3 = PersonBean.getEmail3()>
    <cfset Attributes.EthnicityID = PersonBean.getEthnicityID()>
    <cfset Attributes.ExternalSourceFlag = PersonBean.getExternalSourceFlag()>
    <cfset Attributes.Gender = PersonBean.getGender()>
    <cfset Attributes.HomeDivisionID = PersonBean.getHomeDivisionID()>
    <cfset Attributes.ISO = PersonBean.getISO()>
    <cfset Attributes.LastUpdate = PersonBean.getLastUpdate()>
    <cfset Attributes.MaritalStatusID = PersonBean.getMaritalStatusID()>
    <cfset Attributes.MiddleName = PersonBean.getMiddleName()>
    <cfset Attributes.NameSuffix = PersonBean.getNameSuffix()>
    <cfset Attributes.NativeLanguageID = PersonBean.getNativeLanguageID()>
    <cfset Attributes.OMBEthnicityID = PersonBean.getOMBEthnicityID()>
    <cfset Attributes.PagerPhone = PersonBean.getPagerPhone()>
    <cfset Attributes.PersonStatusID = PersonBean.getPersonStatusID()>
    <cfset Attributes.PreferredName = PersonBean.getPreferredName()>
    <cfset Attributes.ReligiousAffiliationID = PersonBean.getReligiousAffiliationID()>
    <cfset Attributes.SalutationID = PersonBean.getSalutationID()>
    <cfset Attributes.SortName = PersonBean.getSortName()>
    <cfset Attributes.SpouseID = PersonBean.getSpouseID()>
    <cfset Attributes.SpouseName = PersonBean.getSpouseName()>
    <cfset Attributes.SSN = PersonBean.getSSN()>
    <cfset Attributes.SystemID = PersonBean.getSystemID()>
    <cfset Attributes.UCFlag = PersonBean.getUCFlag()>
    <cfset Attributes.UCID = PersonBean.getUCID()>
    <cfset Attributes.UPI = PersonBean.getUPI()>--->
    
    <!--- CREATE FIRST AND LAST NAME IF THEY ARE BLANK --->
    <cfif Attributes.FirstName EQ "" AND Attributes.LastName EQ "" AND Attributes.SSN NEQ "" AND Attributes.Birthdate NEQ "">
        <cfset Attributes.FirstName = "Unknown">
        <cfset Attributes.LastName = "Name">
    </cfif>
<cfcatch type="any">
    <cfset Attributes.BirthCountryID = "">
    <cfset Attributes.BirthDate = "">
    <cfset Attributes.CampusID = "">
    <cfset Attributes.CellPhone = "">
    <cfset Attributes.CitzenshipCountryID = "">
    <cfset Attributes.Comment = "">
    <cfset Attributes.CreationDate = "">
    <cfset Attributes.Deathdate = "">
    <cfset Attributes.DisplayDegree = "">
    <cfset Attributes.Email1 = "">
    <cfset Attributes.Email2 = "">
    <cfset Attributes.Email3 = "">
    <cfset Attributes.EthnicityID = "">
    <cfset Attributes.ExternalSourceFlag = "">
    <cfset Attributes.FirstName = "">
    <cfset Attributes.Gender = "">
    <cfset Attributes.HomeDivisionID = "">
    <cfset Attributes.ISO = "">
    <cfset Attributes.LastName = "">
    <cfset Attributes.LastUpdate = "">
    <cfset Attributes.MaritalStatusID = "">
    <cfset Attributes.MiddleName = "">
    <cfset Attributes.NameSuffix = "">
    <cfset Attributes.NativeLanguageID = "">
    <cfset Attributes.OMBEthnicityID = "">
    <cfset Attributes.PagerPhone = "">
    <cfset Attributes.PersonStatusID = "">
    <cfset Attributes.PreferredName = "">
    <cfset Attributes.ReligiousAffiliationID = "">
    <cfset Attributes.SalutationID = "">
    <cfset Attributes.SortName = "">
    <cfset Attributes.SpouseID = "">
    <cfset Attributes.SpouseName = "">
    <cfset Attributes.SSN = "">
    <cfset Attributes.SystemID = "">
    <cfset Attributes.UCFlag = "">
    <cfset Attributes.UCID = "">
    <cfset Attributes.UPI = "">
    <cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Invalid PersonID, please try again.","|")>
</cfcatch>
</cftry>
