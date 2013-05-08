<cfcomponent extends="ajax">
  <cffunction name="init" access="public" output="false" returntype="any">
    
    <cfset SUPER.init({
      model: 'person'
    }) />

    <cfreturn this />
  </cffunction>

  <cffunction name="createPerson" access="Remote" output="false" returntype="string">
    <cfargument name="PersonID" type="numeric" required="yes">
    <cfargument name="Birthdate" type="string" required="no">
    <cfargument name="FirstName" type="string" required="yes">
    <cfargument name="MiddleName" type="string" required="no" default="">
    <cfargument name="LastName" type="string" required="yes">
    <cfargument name="CertName" type="string" required="no" default="#Arguments.FirstName# #Arguments.LastName#">
    <cfargument name="CertNameCustom" type="string" required="no" default="">
    <cfargument name="DisplayName" type="string" required="no" default="#Arguments.FirstName# #Arguments.LastName#">
    <cfargument name="Suffix" type="string" required="no" default="">
    <cfargument name="Email" type="string" required="yes">
    <cfargument name="Gender" type="string" required="no" default="">
    <cfargument name="SSN" type="string" required="yes">
    <cfargument name="Password" type="string" required="yes">
    <cfargument name="DegreeID" type="numeric" required="yes">
    <cfargument name="SkipDuplicates" type="string" required="no" default="N">
    <cfargument name="ChangedFields" type="string" required="no" default="">
    <cfargument name="ChangedValues" type="string" required="no" default="">
    
    <cfset var Status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access create function for person information.")>
    
    <cfset Status = Application.Person.savePerson(
              PersonID=Arguments.PersonID,
              Birthdate=Arguments.Birthdate,
              FirstName=Arguments.FirstName,
              MiddleName=Arguments.MiddleName,
              LastName=Arguments.LastName,
              CertName=Arguments.CertName,
              CertNameCustom=Arguments.CertNameCustom,
              DisplayName=Arguments.DisplayName,
              Suffix=Arguments.Suffix,
              Email=Arguments.Email,
              Gender=Arguments.Gender,
              SSN=Arguments.SSN,
              Password=Arguments.Password,
              SkipDuplicates=Arguments.SkipDuplicates,
              ChangedFields=Arguments.ChangedFields,
              ChangedValues=Arguments.ChangedValues)>
              
    <cfif status.getStatus()>
      <cfset Application.Person.saveDegree(status.getStatusMsg(),Arguments.DegreeID)>
    </cfif>
    
    <cfreturn Status.getJSON() />
  </cffunction>
  
  <cffunction name="deleteAddress" access="remote" output="false" returnFormat="plain">
    <cfargument name="AddressID" type="numeric" required="yes">
    <cfargument name="PersonID" type="numeric" required="yes">
    
    <cfset var Status = createObject("component", "#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot delete address for unknown reasons.")>
    
    <cfset status = Application.Person.deleteAddress(Arguments.AddressID,Arguments.PersonID)>
    
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="deleteEmail" access="remote" output="false" returnFormat="plain">
    <cfargument name="email_id" type="numeric" required="yes">
    <cfargument name="person_id" type="numeric" required="yes">
    
    <cfset var Status = createObject("component", "#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot delete email address for unknown reasons.")>
    
    <cfset status = Application.Person.deleteEmail(Arguments.email_id,Arguments.person_id)>
    
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="deleteNote" access="remote" output="true" returnFormat="plain">
    <cfargument name="NoteID" type="numeric" required="true">
    
    <cfset var status = createObject("component", "#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access delete function for notes.")>
    
    <cfset status = Application.Person.deleteNote(Arguments.NoteID)>
  
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="deletePerson" access="remote" output="true" returntype="string">
    <cfargument name="PersonID" type="numeric" required="true">
    <cfargument name="Reason" type="string" required="true">
    
    <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>

    <cfcontent type="text/javascript" />

    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access delete function for people.")>
    
    <cfset status = Application.Person.deletePerson(Arguments.PersonID,Arguments.Reason)>
  
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="getNameByID" access="remote" output="no" returntype="string">
    <cfargument name="PersonID" type="numeric" required="yes">
    
    <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    <cfset var fullName = "">
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access person name by ID functionality.")>
    
    <cfset fullName = Application.Person.getNameByID1(Arguments.PersonID)>
    
    <cfif isArray(fullName)>
      <cfset status.setData(fullName)>
      <cfset status.setStatus(true)>
      <cfset status.setStatusMsg("Person Name retrieved.")>
    </cfif>
    
    <cfreturn Status.getJSON() />
  </cffunction>
  
  <cffunction name="getPersonSpecialties" access="remote" output="no" returntype="string">
    <cfargument name="personId" type="numeric" required="yes">
    
    <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("There are no specialties selected for this person.")>
    
    <cfset aPersonSpecialties = Application.Person.getPersonSpecialties(arguments.PersonID)>
    
    <cfif arrayLen(aPersonSpecialties) GT 0>
      <cfset status.setData(aPersonSpecialties)>
    </cfif>
    
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="moveActivities" access="remote" output="no" returntype="string">
    <cfargument name="MoveFromPersonID" type="numeric" required="true" />
    <cfargument name="MoveFromName" type="string" required="true" />
    <cfargument name="MoveToPersonID" type="numeric" required="true" />
    <cfargument name="MoveToName" type="string" required="true" />
    
    <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access the activity move functionality.")>
    
    <cfset Status = Application.Person.moveActivities(Arguments.MoveFromPersonID,Arguments.MoveFromName,Arguments.MoveToPersonID,Arguments.MoveToName)>
    
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="requestPassword" access="remote" returntype="string">
    <cfargument name="Email" type="string" required="yes">
    
    <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access the activity move functionality.")>
    
    <cfset status = Application.Person.requestPassword(Arguments.Email)>
    
    <cfreturn status.getJSON() />
  </cffunction>
    
  <cffunction name="saveAddress" access="remote" output="false" returnFormat="plain">
    <cfargument name="AddressID" type="numeric" required="yes">
    <cfargument name="PersonID" type="numeric" required="yes">
    <cfargument name="AddressTypeID" type="numeric" required="yes">
    <cfargument name="PrimaryFlag" type="string" required="yes">
    <cfargument name="Address1" type="string" required="yes">
    <cfargument name="Address2" type="string" required="yes">
    <cfargument name="City" type="string" required="yes">
    <cfargument name="State" type="string" required="no" default="">
    <cfargument name="stateid" type="numeric" required="no" default="0">
    <cfargument name="Province" type="string" required="yes">
    <cfargument name="country" type="string" required="no" default="">
    <cfargument name="countryid" type="numeric" required="no" default="0">
    <cfargument name="Zipcode" type="string" required="yes">
    <cfargument name="Phone1" type="string" required="yes">
    <cfargument name="Phone1ext" type="string" required="yes">
    <cfargument name="Phone2" type="string" required="yes">
    <cfargument name="Phone2ext" type="string" required="yes">
    <cfargument name="Phone3" type="string" required="yes">
    <cfargument name="Phone3ext" type="string" required="yes">
    
    <cfset var Status = createObject("component", "#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access save function for address information.")>
    
    <cfset status = Application.Person.saveAddress(argumentCollection=arguments)>
    
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="saveCredentials" hint="" access="remote" output="false" returnFormat="plain">
    <cfargument name="PersonID" type="numeric" required="yes">
    <cfargument name="Pass" type="string" required="yes">
    <cfargument name="ConPass" type="string" required="yes">
    
    <cfset var Status = createObject("component", "#Application.settings.com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access save function for credentials.")>
    
    <cfset Status = Application.Person.saveCredentials(PersonId=Arguments.PersonID,Pass=Arguments.Pass,ConPass=Arguments.ConPass)>
  
    <cfreturn Status.getJSON() />
  </cffunction>
  
  <cffunction name="saveDegree" hint="New Person Degree Info - saves using new degree information." access="remote" output="false" returntype="string">
    <cfargument name="PersonID" type="numeric" required="yes">
    <cfargument name="DegreeID" type="numeric" required="yes">
    
    <cfset var Status = createObject("component", "#Application.settings.com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access save function for education information.")>
    
    <cfset status = Application.Person.saveDegree(Arguments.PersonID,Arguments.DegreeID)>
  
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="saveEmail" access="remote" output="false" returntype="string">
    <cfargument name="email_id" type="numeric" required="yes">
    <cfargument name="person_id" type="numeric" required="yes">
    <cfargument name="allow_login" type="numeric" required="yes">
    <cfargument name="email_address" type="string" required="yes">
    <cfargument name="is_primary" type="numeric" required="yes">
    <cfargument name="is_verified" type="numeric" required="yes">
    
    <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <!---<cfcontent type="text/javascript">--->
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access save function for email addresses.")>
    
    <cfset status = application.person.saveEmail(
                          arguments.email_id,
                          arguments.person_id,
                          arguments.allow_login,
                          arguments.email_address,
                          arguments.is_primary,
                          arguments.is_verified)>
    
    <cfreturn status.getJSON() />
  </cffunction>

  <cffunction name="saveNote" access="remote" output="no" returnFormat="plain">
    <cfargument name="PersonID" type="numeric" required="true">
    <cfargument name="NoteBody" type="string" required="true">
    <cfargument name="NoteID" type="numeric" required="false" default="0">
    
    <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript">
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access save function for notes.")>
    
    <cfset status = Application.Person.saveNote(Arguments.PersonID,Arguments.NoteBody,Arguments.NoteID)>
    
    <cfreturn status.getJSON() />
  </cffunction>
  

  <cffunction name="setPrimaryAddress" access="Remote" output="false" returnformat="plain">
    <cfargument name="address_id" type="numeric" required="yes" />
    <cfargument name="person_id" type="numeric" required="yes" />
    
    <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript">
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access save function for person information.")>
    
    <cfset Status = application.person.setPrimaryAddress(argumentCollection=arguments) />
    
    <cfreturn Status.getJSON() />
  </cffunction>
  <cffunction name="savePersonSpecialties" access="remote" output="false" description="Saves specialties for provided person." returnFormat="plain">
    <cfargument name="PersonID" type="numeric" required="yes">
    <cfargument name="Specialties" type="string" required="yes">
    
    <cfset var Status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access save function for person specialties.")>
    
    <cfset Status = Application.Person.saveSpecialties(Arguments.PersonID,Arguments.Specialties)>
    
    <cfreturn Status.getJSON() />
  </cffunction>
  
  <cffunction name="sendVerificationEmail" hint="Sends an email to verify email address." access="remote" output="false" returntype="string">
    <cfargument name="email_id" type="numeric" required="yes">
    
    <cfset var status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access send verification email function.")>
    
    <cfset Status = Application.Person.sendVerificationEmail(Arguments.email_id)>
    
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="setAuthLevel" access="remote" output="false" description="Set Authority Level" returntype="string">
    <cfargument name="AccountID" type="numeric" required="yes" />
    <cfargument name="AuthorityID" type="numeric" required="yes" />
    
    <cfset var Status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("You do not have permission to administer this feature.")>
    
    <cfset status = Application.Person.setAuthLevel(Arguments.AccountID,Arguments.AuthorityID)>
    
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="setPrimaryEmail" access="remote" output="false" description="Set Authority Level" returntype="string">
    <cfargument name="email_id" type="numeric" required="yes" />
    <cfargument name="person_id" type="numeric" required="yes" />
    
    <cfset var Status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Cannot access the primary email update functionality.")>
    
    <cfset status = Application.Person.setPrimaryEmail(email_id=Arguments.email_id,person_id=arguments.person_id)>
    
    <cfreturn status.getJSON() />
  </cffunction>

  <cffunction name="setAllowLogin" access="remote" output="false" description="Set Allow Login for Email" returntype="string">
    <cfargument name="email_id" type="numeric" required="yes" />
    <cfargument name="value" type="numeric" required="yes" />
    
    <cfset var Status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("Failed to save 'Allow Login' due to unknown reason.")>
    
    <cfquery name="qEmail" datasource="#application.settings.dsn#">
      SELECT email_address FROM user_emails
      WHERE email_id=<cfqueryparam value="#arguments.email_id#" cfsqltype="cf_sql_integer" />   
    </cfquery>
    <cfquery name="qSaveLogin" datasource="#application.settings.dsn#">
      UPDATE user_emails
      SET allow_login = <cfqueryparam value="#arguments.value#" cfsqltype="cf_sql_integer" />
      WHERE email_id = <cfqueryparam value="#arguments.email_id#" cfsqltype="cf_sql_integer" />    
    </cfquery>

    <cfif arguments.value EQ 1>
      <cfset statusMsg = "Successfully ENABLED '#qEmail.email_address#' for authentication." />
    <cfelse>
      <cfset statusMsg = "Successfully DISABLED '#qEmail.email_address#' for authentication." />
    </cfif>
    <cfset status.setStatus(true) />
    <cfset status.setStatusMsg(statusMsg) />
    <cfreturn status.getJSON() />
  </cffunction>
  
  <cffunction name="setStatus" access="remote" output="no" displayname="Set Activity Status" returntype="string">
    <cfargument name="PersonID" type="numeric" required="yes" />
    <cfargument name="StatusID" type="numeric" required="yes" />
    
    <cfset var Status = createObject("component","#Application.Settings.Com#returnData.buildStruct").init()>
    
    <cfcontent type="text/javascript" />
    
    <cfset status.setStatus(false)>
    <cfset status.setStatusMsg("You do not have permission to administer this feature.")>
    
    <cfset status = Application.Person.setStatus(Arguments.PersonID,Arguments.StatusID)>
    
    <cfreturn status.getJSON() />
  </cffunction>
</cfcomponent>