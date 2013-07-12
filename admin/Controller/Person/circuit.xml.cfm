<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- Person -->
<circuit access="public">
  <prefuseaction callsuper="true">
    <set name="Request.NavItem" value="2" />
    <set name="layout_exceptions" value="person.create" />
    <if condition="structKeyExists(attributes,'personid') AND attributes.personid GT 0">
      <true>
        <set name="Request.MultiFormEditLabel" value="Edit this activity" />
        <do action="mPerson.getPerson" />
        <do action="mPerson.TabControl" />
        <set name="Request.ActionsLimit" value="4" />
        <set name="request.page.title" value="#PersonBean.getCertname()#" />
        <set name="request.page.action" value="#listLast(attributes.fuseaction,'.')#" />
        <set name="Request.MultiFormEditLink" value="#myself#person.detail?personid=#Attributes.personid#" />
      </true>
    </if>
  </prefuseaction>
  <postfuseaction>
    <if condition="#NOT listFindNoCase(layout_exceptions,attributes.fuseaction)#">
      <true>
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
                   
                   <if condition="structKeyExists(variables,'layout') AND len(trim(layout)) GT 0">
                      <true>
                        <invoke object="myFusebox" 
                          methodcall="do('vLayout.#layout#')" />
                      </true>
                      <false>
                        <do action="vLayout.Default" />
                      </false>
                    </if>
                </false>
              </if>
          </false>
        </if>
      </true>
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
    <set name="request.page.title" value="Create Person" />
  
    <xfa name="FrmSubmit" value="Person.Create" />

    <switch expression="#Attributes.Mode#">
      <case value="Default">
        <do action="vPerson.CreateRight" contentvariable="multiformright" />
        <do action="vPerson.CreatePerson" contentvariable="multiformcontent" />
        <do action="vLayout.sub_slim" contentvariable="request.page.body" />
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
    <do action="mMain.TabControl" />
    <set name="request.page.title" value="Search People" />
    <xfa name="FrmSubmit" value="person.home" />
    <do action="vPerson.Search" contentvariable="multiformcontent" />
    <do action="vLayout.Sub_User" contentvariable="request.page.body" />
  </fuseaction>
  
  <fuseaction name="Finder">
    <set name="layout" value="none" />
    <xfa name="SearchSubmit" value="Person.Finder" />
    <do action="mPerson.Search" />
    <set name="request.page.title" value="Search People" />
    <xfa name="FrmSubmit" value="Person.Home" />
    <do action="vPerson.Search" contentvariable="Request.Page.Body" />
  </fuseaction>
  
  <fuseaction name="Notes">
    <do action="mPerson.getNotes" />
  </fuseaction>
  
  <fuseaction name="PhotoUpload">
    <do action="vPerson.PhotoUpload" contentvariable="Request.Page.Body" />
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