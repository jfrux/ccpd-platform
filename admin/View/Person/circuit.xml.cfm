<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- vPerson -->
<circuit access="internal">
  <fuseaction name="Actions">
    <include template="dsp_Actions" />
  </fuseaction>

  <fuseaction name="ActionsRight">
    <include template="dsp_ActionsRight" />
  </fuseaction>

  <fuseaction name="Activities">
    <include template="dsp_Activities" />
  </fuseaction>

  <fuseaction name="Address">
    <include template="dsp_Address" />
  </fuseaction>

  <fuseaction name="CreatePerson">
    <include template="dsp_New" />
  </fuseaction>

  <fuseaction name="Docs">
    <include template="dsp_Docs" />
  </fuseaction>

  <fuseaction name="Detail">
    <include template="dsp_Edit" />
  </fuseaction>

  <fuseaction name="Email">
    <include template="dsp_Email" />
  </fuseaction>

  <fuseaction name="FormList">
    <include template="dsp_FormList" />
  </fuseaction>

  <fuseaction name="Notes">
    <include template="dsp_Notes" />
  </fuseaction>

  <fuseaction name="history">
    <include template="dsp_history" />
  </fuseaction>

  <fuseaction name="PhotoUpload">
    <include template="dsp_PhotoUpload" />
  </fuseaction>

  <fuseaction name="Preferences">
    <include template="dsp_Preferences" />
  </fuseaction>


  <fuseaction name="Search">
    <include template="dsp_Search" />
  </fuseaction>

  <!-- DIALOG SCREENS -->
  <fuseaction name="Credentials">
    <include template="dialogs/dsp_Credentials" />
  </fuseaction>

  <fuseaction name="VCard">
    <include template="dialogs/dsp_VCard" />
  </fuseaction>

  <fuseaction name="EditAddress">
    <include template="dialogs/dsp_EditAddress" />
  </fuseaction>
  
  <!-- AHAH PAGES -->
  <fuseaction name="AddressAHAH">
    <include template="ahah/dsp_AddressAHAH" />
  </fuseaction>
  
  <fuseaction name="DocsAHAH">
    <include template="ahah/dsp_DocsAHAH" />
  </fuseaction>
  
  <fuseaction name="EmailAHAH">
    <include template="ahah/dsp_EmailAHAH" />
  </fuseaction>

  <fuseaction name="PreferencesAHAH">
    <include template="ahah/dsp_PreferencesAHAH" />
  </fuseaction>

  <!-- TOOLBARS -->
  <fuseaction name="ActivitiesRight">
    <include template="toolbar/dsp_ActivitiesRight" />
  </fuseaction>
  <fuseaction name="AddressRight">
    <include template="toolbar/dsp_AddressRight" />
  </fuseaction>
  <fuseaction name="CreateRight">
    <include template="toolbar/dsp_CreateRight" />
  </fuseaction>
  <fuseaction name="DocsRight">
    <include template="toolbar/dsp_DocsRight" />
  </fuseaction>
  <fuseaction name="EditRight">
    <include template="toolbar/dsp_EditRight" />
  </fuseaction>
  <fuseaction name="EmailRight">
    <include template="toolbar/dsp_EmailRight" />
  </fuseaction>
  <fuseaction name="PreferencesRight">
    <include template="toolbar/dsp_PreferencesRight" />
  </fuseaction>
  <fuseaction name="SearchRight">
    <include template="toolbar/dsp_SearchRight" />
  </fuseaction>
</circuit>
