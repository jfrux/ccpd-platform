<cfparam name="Attributes.CertName" default="" />
<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveJS.cfm" />
<!--- <cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveInfo.cfm" /> --->
<script>
<cfoutput>
var sCertName = "#Attributes.CertName#";
var sEmail = "#Attributes.Email#";
</cfoutput>
App.Person.GeneralInfo.start();
</script>
<cfoutput>
<form class="js-formstate formstate form-horizontal" action="#Application.Settings.RootPath#/_com/AJAX_Person.cfc" method="post" name="frmEditActivity">
  <input type="hidden" name="method" id="method" value="savePerson" />
  <input type="hidden" name="personid" id="user-personid" value="#Attributes.PersonID#" />
  <input type="hidden" name="password" id="user-password" value="<!--- THIS IS NOT THAT RELEVANT --->" />
  <input type="hidden" name="email" id="user-email" value="#attributes.email#" tabindex="8" />
  <input type="hidden" name="returnformat" id="returnformat" value="plain" tabindex="8" />
  <input type="text" name="certname" id="user-certname"  value="#Attributes.CertName#" tabindex="15" class="hide" />
  <input type="hidden" name="ssn" id="user-ssn" value="#Attributes.SSN#" tabindex="6" />
  <cfset BirthDate = DateFormat(Attributes.birthdate, "MM/DD/YYYY")>
  <div class="control-groupset" data-trigger-text="Update Personal Information (Full name, Gender, Birthdate)" data-default-state="1">
    <div class="groupset-title">
      Personal Information
    </div>
    <div class="control-group full-name">
      <label class="control-label" for="user-firstname">Full Name</label>
      <div class="controls">
        <input name="firstname" id="user-firstname" placeholder="First Name" class="input-small js-suggest-input" type="text" value="#Attributes.firstname#" tabindex="1" />
        <input name="middlename" id="user-middlename" placeholder="Middle Name" class="input-small js-suggest-input" type="text" value="#Attributes.middlename#" tabindex="2"  />
        <input name="lastname" id="user-lastname" placeholder="Last Name" class="input-small js-suggest-input" type="text" value="#Attributes.lastname#" tabindex="3"  />
        <input name="suffix" id="user-suffix" placeholder="Suffix" class="input-mini js-suggest-input" type="text" value="#Attributes.suffix#" tabindex="4"  />
      </div>
    </div>

    <div class="control-group">
      <label class="control-label" for="user-gender">Gender</label>
      <div class="controls">
        <select name="gender" id="user-gender" tabindex="5">
          <option value="">Select One...</option>
          <option value="M"<cfif Attributes.Gender EQ "M"> Selected</cfif>>Male</option>
          <option value="F"<cfif Attributes.Gender EQ "F"> Selected</cfif>>Female</option>
        </select>
      </div>
    </div>
    <!-- deprecated 
    <div class="control-group hide">
      <label class="control-label" for="user-ssn">Last 4 SSN</label>
      <div class="controls">
        
      </div>
    </div>-->
    <div class="control-group">
      <label class="control-label" for="user-birthdate">Birth Date</label>
      <div class="controls">
        <input id="user-birthdate" class="input-small" name="birthdate" type="text" value="#BirthDate#" tabindex="7" />
      </div>
    </div>
  </div>
  <div class="control-groupset" data-trigger-text="Customize name display" data-default-state="1">
    <div class="groupset-title">
      How should we display this name?
    </div>
    <div class="control-group">
      <label class="control-label" for="displayname">Display Name</label>
      
      <div class="controls">
        <input type="text" name="displayname" class="displayname js-displayname-input" id="user-displayname" tabindex="14" value="#Attributes.DisplayName#" style="width:230px;" data-tooltip-title="How your name should be displayed on certificates, transcripts, etc." />
        <div class="input-suggestions">
          <h4>Other certificate name suggestions...</h4>
          <div class="suggest-list js-suggestions-list"></div>
        </div>
      </div>
    </div>
  </div>
</form>
</cfoutput>