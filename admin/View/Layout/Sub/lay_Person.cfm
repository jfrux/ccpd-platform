<cfparam name="Request.MultiFormTitle" default="">
<cfparam name="Request.MultiFormContent" default="">
<cfparam name="Request.MultiFormRight" default="">
<cfparam name="Request.MultiFormLabels" default="">
<cfparam name="Request.MultiFormFuseactions" default="">
<cfparam name="Request.MultiSubTabFlag" default="N">
<cfparam name="Request.MultiFormQS" default="">
<cfparam name="Request.MultiFormEditLabel" default="">
<cfparam name="Request.MultiFormEditLink" default="">
<cfparam name="Attributes.UCID" default="">
<script>
<cfoutput>
nPerson = #Attributes.PersonID#;
sPersonName = '#replace(Attributes.FirstName, "'", "\'", "ALL")# #replace(Attributes.LastName, "'", "\'", "ALL")#';
nAccount = #Attributes.AccountID#;
</cfoutput>

App.Person.start({
  'id':nPerson,
  'account_id':nAccount,
  'name':sPersonName
});
</script>

<cfoutput>
<div class="person profile">
<cfif PersonBean.getFirstName() EQ "" AND PersonBean.getLastName() EQ "" AND PersonBean.getBirthdate() EQ "" AND PersonBean.getSSN() EQ "">
	<div class="ContentTitle">THIS PERSON NO LONGER EXISTS</div>
<cfelse>
    <div class="profile-bg">
    <div class="profile-bg-inner"></div>
  </div>
  <div class="row">
    <div class="span5">
      <cfoutput>
      <div class="projectbar js-projectbar">
        <div class="box">
          <div class="thumbnail">
          <img src="http://placehold.it/182x113">
          </div>
        </div>
        <div class="box js-profile-menu">
          <cf_ce_profilemenu type="person" typeid="#attributes.personid#" settings="#request.tabSettings#" current="#Attributes.Fuseaction#">
        </div>
      </div>
      </cfoutput>
    </div>
    <div class="span19">
      <div class="titlebar">
        <div class="row-fluid">
          <div class="span16">
            <div class="ContentTitle">
              <span title="#HTMLSafe(PersonBean.getCertName())#">#HTMLSafe(PersonBean.getCertName())#</span>
            </div>
          </div>
          <div class="span8">
            <div class="action-buttons pull-right">
              <div class="btn-group">
                <a class="btn" id="CredentialsDialogLink" href="javascript:void(0);" data-tooltip-title="Login Credentials"><i class="icon-lock"></i></a>
                <a class="btn" href="#Myself#Person.VCard?PersonID=#Attributes.PersonID#" data-tooltip-title="Download vCard"><i class="icon-info-sign"></i></a>
              </div>
              <div class="btn-group">
                <a class="btn js-toggle-infobar" title="Toggle Infobar"><i class="icon-info"></i></a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="span19">
      <div class="content js-profile-content">
        <cfoutput>
        <div class="row-fluid">
          <div class="span18 js-content-toggle">
            <div class="row-fluid">
              <div class="content-title">
                <h3>#request.tabSettings.tabs[lcase(attributes.fuseaction)].title#</h3>
              </div>
            </div>
            <div class="MultiFormContent content-inner">
              <div id="js-#replace(request.tabSettings.tabs[lcase(attributes.fuseaction)].event,'.','-')#">
              <cfif structKeyExists(variables,'multiformright')>
                <div class="toolbar">
                  #multiformright#
                </div>
              </cfif>
              <cfif structKeyExists(variables,'multiformcontent')>
                #multiformcontent#
              </cfif>
              </div>
            </div>
          </div>
          <div class="span6 js-infobar-outer">
            <div class="InfoBar infobar js-infobar">
              <cfset qStatuses = Application.Com.StatusGateway.getByAttributes(OrderBy="Name")>
          
            	<cfif Session.Account.getAuthorityID() EQ 3>
                <div id="Authority">
                    <h3><i class="fg fg-lock"></i> Authority Level</h3>
                    <div class="box">
                      <cfset qAuthLevels = Application.List.AuthLevels>
                      <select name="AuthLevel" id="AuthLevel" class="span24">
                      	<option value="0">None</option>
                      	<cfloop query="qAuthLevels">
                          <option value="#Trim(qAuthLevels.AuthID)#"<cfif Attributes.AuthorityID EQ qAuthLevels.AuthID> SELECTED</cfif>>#qAuthLevels.Name#</option>
                          </cfloop>
                      </select>
                    </div>
                </div>
                </cfif>
                <div id="Status">
                  <h3>Person Status</h3>
                  <div class="box">
                    <div class="project-status person-status js-person-status">
                      <select name="StatusChanger" id="StatusChanger" class="span24">
                        <option value="">No Status</option>
                        <cfloop query="qStatuses">
                        <option value="#qStatuses.StatusID#"<cfif PersonBean.getStatusID() EQ qStatuses.StatusID> selected</cfif>>#qStatuses.Name#</option>
                        </cfloop>
                      </select>
                    </div>
                  </div>
                </div>
               </div>
          </div>
        </div>
        </cfoutput>
      </div>
    </div>
  </div>
  <div id="CredentialsContainer" style="display: none;">
  </div>
</cfif>
</cfoutput>
