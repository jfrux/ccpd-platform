<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Person -->
<circuit access="public">
  <prefuseaction callsuper="true">
    <set name="Request.NavItem" value="2" />
    
    <if condition="structKeyExists(attributes,'personid')">
      <true>
        <set name="Request.MultiFormEditLabel" value="Edit this activity" />
        <do action="mPerson.getPerson" />
        <do action="mPerson.TabControl" />
        <set name="Request.ActionsLimit" value="4" />
        <set name="Request.Page.Title" value="#PersonBean.getCertname()#" />
        <set name="request.page.action" value="#listLast(attributes.fuseaction,'.')#" />
        <set name="Request.MultiFormEditLink" value="#myself#person.detail?personid=#Attributes.personid#" />
      </true>
    </if>
  </prefuseaction>
  <postfuseaction>
    <if condition="#structKeyExists(attributes,'personid')# AND attributes.personid GT 0">
      <true>
        <do action="mPerson.getPerson" />
      </true>
    </if>
    <if condition="isPjax()">
      <true>
        <if condition="#structKeyExists(attributes,'personid')# AND attributes.personid GT 0">
          <true>
            <if condition="#request.currentTab.hasToolbar#">
              <true>
                <invoke object="myFusebox" 
                        methodcall="do('vPerson.#request.page.action#right','multiformright')" />
              </true>
            </if>
            <invoke object="myFusebox" 
                    methodcall="do('vPerson.#request.page.action#','multiformcontent')" />
          </true>
        </if>
        <do action="vLayout.Blank" />
      </true>
       <false>
          <if condition="isAjax()">
            <true>
              <do action="vLayout.Blank" />
            </true>
            <false>
                <if condition="#structKeyExists(attributes,'personid')# AND attributes.personid GT 0">
                  <true>
                    <if condition="#request.currentTab.hasToolbar#">
                      <true>
                        <invoke object="myFusebox" 
                                methodcall="do('vPerson.#request.page.action#right','multiformright')" />
                      </true>
                    </if>
                    <invoke object="myFusebox" 
                            methodcall="do('vPerson.#request.page.action#','multiformcontent')" />
                    <do action="vLayout.Sub_Person" contentvariable="request.page.body" />
                  </true>
                </if>
               
               <do action="vLayout.Default" />
            </false>
          </if>
      </false>
    </if>
  </postfuseaction>

  <fuseaction name="Activities">
    <do action="mPerson.getActivities" />
  </fuseaction>
  
  <fuseaction name="Address">
    
  </fuseaction>
  
  <fuseaction name="AddressAHAH">
    <do action="mPerson.getAddresses" />
    <do action="vPerson.AddressAHAH" contentvariable="request.page.body" />
  </fuseaction>
  
  <fuseaction name="Create">
    <do action="mPerson.Create" />

    <set name="Request.Page.Title" value="Create Person" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home,Create Person|Person.Create" />

    <do action="mPage.ParseCrumbs" />
    
    <xfa name="FrmSubmit" value="Person.Create" />
    
    <switch expression="#Attributes.Mode#">
      <case value="Default">
        <do action="vPerson.CreateRight" contentvariable="Request.MultiFormRight" />
        <do action="vPerson.CreatePerson" contentvariable="Request.MultiFormContent" />
        <do action="vLayout.Sub_MultiForm" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
      </case>
      <case value="Insert">
        <do action="vPerson.CreatePerson" contentvariable="Request.Page.Body" />
        <do action="vLayout.None" />
      </case>
    </switch>
  </fuseaction>
  
  <fuseaction name="Credentials">
    <do action="mPerson.getCredentials" />
    <do action="vPerson.credentials" contentvariable="request.page.body" />
  </fuseaction>

  <fuseaction name="Detail">
    <xfa name="FrmSubmit" value="Person.Detail" />
  </fuseaction>
  
  <fuseaction name="EditAddress">
    <do action="mPerson.getAddress" />
    
    <xfa name="FrmSubmit" value="Person.EditAddress" />

    <do action="vPerson.EditAddress" contentvariable="request.page.body" />
  </fuseaction>

  <fuseaction name="Email">
    
  </fuseaction>
  
  <fuseaction name="EmailAHAH">
    <do action="mPerson.getEmails" />
    <do action="vPerson.EmailAHAH" contentvariable="request.page.body" />
  </fuseaction>
  
  <fuseaction name="Home">
    <xfa name="SearchSubmit" value="Person.Home" />
    <do action="mPerson.Search" />
        
    <set name="Request.Page.Title" value="Search People" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home" />
        
    <do action="mPage.ParseCrumbs" />
    
    <xfa name="FrmSubmit" value="person.home" />
    <do action="vPerson.Search" contentvariable="Request.Page.Body" />
        <do action="vLayout.Default" />
  </fuseaction>
  
  <fuseaction name="Finder">
    <xfa name="SearchSubmit" value="Person.Finder" />
    <do action="mPerson.Search" />
        
    <set name="Request.Page.Title" value="Search People" />
        <set name="Request.Page.Breadcrumbs" value="People|Person.Home" />
        
    <do action="mPage.ParseCrumbs" />
    
    <xfa name="FrmSubmit" value="Person.Home" />
    <do action="vPerson.Search" contentvariable="Request.Page.Body" />
        
    <do action="vLayout.None" />
  </fuseaction>
  
  <fuseaction name="Notes">
    <do action="mPerson.getNotes" />
  </fuseaction>
  
  <fuseaction name="PhotoUpload">
    <do action="mPerson.PhotoUpload" />
    <do action="vPerson.PhotoUpload" contentvariable="Request.Page.Body" />
    <do action="vLayout.None" />
  </fuseaction>
  
  <fuseaction name="Preferences">
    <do action="mPerson.getPersonDegree" />
  </fuseaction>
  
  <fuseaction name="history">
    
  </fuseaction>
  
  <fuseaction name="vCard">
    <do action="mPerson.getAddresses" />
  </fuseaction>
</circuit>