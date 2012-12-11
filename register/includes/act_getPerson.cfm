<!--- Attributes.Submitted is used to prevent Edit pages from overwriting user input --->
<cfif isDefined("Session.PersonID")>
	<cfset PersonBean = CreateObject('component','_com.Person.Person').init(PersonID=Session.PersonID)>
    <cfset PersonBean = Application.Com.PersonDAO.Read(PersonBean)>
    
    <cfset Attributes.BirthDate = PersonBean.getBirthDate()>
    <cfset Attributes.CreationDate = PersonBean.getCreated()>
    <cfset Attributes.CreatedBy = PersonBean.getCreatedBy()>
    <cfset Attributes.Email = PersonBean.getEmail()>
    <cfset Attributes.EthnicityID = PersonBean.getEthnicityID()>
    <cfset Attributes.FirstName = PersonBean.getFirstName()>
    <cfset Attributes.Gender = PersonBean.getGender()>
    <cfset Attributes.LastName = PersonBean.getLastName()>
    <cfset Attributes.LastUpdate = PersonBean.getUpdated()>
    <cfset Attributes.UpdatedBy = PersonBean.getUpdatedBy()>
    <cfset Attributes.MiddleName = PersonBean.getMiddleName()>
    <cfset Attributes.NameSuffix = PersonBean.getSuffix()>
    <cfset Attributes.PersonStatusID = PersonBean.getStatusID()>
    <cfset Attributes.PreferredName = PersonBean.getDisplayName()>
    <cfset Attributes.SSN = PersonBean.getSSN()>
<cfelse>
	<cflocation url="/stdptc/login.cfm" addtoken="no" />
</cfif>