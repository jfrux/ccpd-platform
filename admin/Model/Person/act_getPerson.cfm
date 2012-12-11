<!--- Attributes.Submitted is used to prevent Edit pages from overwriting user input --->
<cfparam name="Attributes.Submitted" default="">
<cfset IsEditable = true>
<cfif Attributes.Submitted NEQ 1>
	<cftry>
		<cfset PersonBean = CreateObject('component','#Application.Settings.Com#Person.Person').init(PersonID=Attributes.PersonID)>
		<cfset PersonExists = Application.Com.PersonDAO.Exists(PersonBean)>
        
        <cfif PersonExists>
			<cfset PersonBean = Application.Com.PersonDAO.Read(PersonBean)>

            <cfset Attributes.BirthDate = PersonBean.getBirthDate()>
            <cfset Attributes.Email = PersonBean.getEmail()>
            <cfset Attributes.EthnicityID = PersonBean.getEthnicityID()>
            <cfset Attributes.FirstName = PersonBean.getFirstName()>
            <cfset Attributes.MiddleName = PersonBean.getMiddleName()>
            <cfset Attributes.LastName = PersonBean.getLastName()>
            <cfset Attributes.CertName = PersonBean.getCertName()>
            <cfset Attributes.DisplayName = PersonBean.getDisplayName()>
            <cfset Attributes.Gender = PersonBean.getGender()>
            <cfset Attributes.SSN = PersonBean.getSSN()>
            <cfset Attributes.Suffix = PersonBean.getSuffix()>
            <cfset Attributes.PersonStatusID = PersonBean.getStatusID()>
            <cfset Attributes.CreationDate = PersonBean.getCreated()>
            <cfset Attributes.UpdatedDate = PersonBean.getUpdated()>
            <cfset Attributes.PrimaryAddressID = PersonBean.getPrimaryAddressID()>
            
            <cfif PersonBean.getUpdated() NEQ "">
            	<cfset attributes.thisUpdated = PersonBean.getUpdated()>
            <cfelse>
            	<cfset attributes.thisUpdated = PersonBean.getCreated()>
            </cfif>
            
            <cfif Session.Account.getAuthorityID() EQ 3>
                <cfset Attributes.Authority = Application.Person.getAuthorityInfo(Attributes.PersonID)>
                <cfset Attributes.AccountID = getToken(Attributes.Authority, 1, "|")>
                <cfset Attributes.AuthorityID = getToken(Attributes.Authority, 2, "|")>
            </cfif>
            
            <!--- CREATE FIRST AND LAST NAME IF THEY ARE BLANK --->
            <cfif Attributes.FirstName EQ "" AND Attributes.LastName EQ "" AND Attributes.SSN NEQ "" AND Attributes.Birthdate NEQ "">
                <cfset Attributes.FirstName = "Unknown">
                <cfset Attributes.LastName = "Name">
            </cfif>
        <cfelse>
        	<!--- PERSON DOESNT EXIST / IS DELETED --->
			<cfset Attributes.BirthDate = "">
            <cfset Attributes.Email = "">
            <cfset Attributes.EthnicityID = "">
            <cfset Attributes.FirstName = "">
            <cfset Attributes.MiddleName = "">
            <cfset Attributes.LastName = "">
            <cfset Attributes.DisplayName = "">
            <cfset Attributes.Gender = "">
            <cfset Attributes.SSN = "">
            <cfset Attributes.Suffix = "">
            <cfset Attributes.PersonStatusID = "">
            <cfset Attributes.CreationDate = "">
            <cfset Attributes.ThisUpdated = "">
            <cfset Attributes.PrimaryAddressID = "">
            <cfset Attributes.AuthorityID = 0>
            <cfset Attributes.AccountID = 0>
        </cfif>
	<cfcatch type="any">
		<cfset Attributes.BirthDate = "">
		<cfset Attributes.Email = "">
		<cfset Attributes.EthnicityID = "">
		<cfset Attributes.FirstName = "">
		<cfset Attributes.MiddleName = "">
		<cfset Attributes.LastName = "">
		<cfset Attributes.DisplayName = "">
		<cfset Attributes.Gender = "">
        <cfset Attributes.SSN = "">
		<cfset Attributes.Suffix = "">
		<cfset Attributes.PersonStatusID = "">
		<cfset Attributes.CreationDate = "">
		<cfset Attributes.ThisUpdated = "">
        <cfset Attributes.PrimaryAddressID = "">
		<cfif Session.Account.getAuthorityID() EQ 3>
			<cfset Attributes.AuthorityID = 0>
        </cfif>
		<cfset Request.Status.Errors = ListAppend(Request.Status.Errors,"Invalid PersonID, please try again.","|")>
	</cfcatch>
	</cftry>
<cfelse>
	<cfset PersonBean = CreateObject('component','#Application.Settings.Com#Person.Person').init(PersonID=Attributes.PersonID)>
	<cfset PersonBean = Application.Com.PersonDAO.Read(PersonBean)>
	
	<cfset Attributes.FirstName = PersonBean.getFirstName()>
	<cfset Attributes.MiddleName = PersonBean.getMiddleName()>
	<cfset Attributes.LastName = PersonBean.getLastName()>
	<cfset Attributes.DisplayName = PersonBean.getDisplayName()>
</cfif>