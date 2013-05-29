<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!-- vMain -->
<circuit access="internal">

  <fuseaction name="Welcome">
    <include template="dsp_Welcome" />
  </fuseaction>
  
  <fuseaction name="reports">
    <include template="./Report/dsp_Home" />
  </fuseaction>

  <fuseaction name="activities">
    <include template="./Activity/dsp_Search" />
  </fuseaction>

  <fuseaction name="people">
    <include template="./Person/dsp_Search" />
  </fuseaction>

  <fuseaction name="Login">
    <include template="dsp_Login" />
  </fuseaction>

  <fuseaction name="BlankTest">
    <include template="dsp_BlankTest" />
  </fuseaction>

  <fuseaction name="Search">
    <include template="dsp_Search" />
  </fuseaction>

  <fuseaction name="SearchResults">
    <include template="dsp_SearchResults" />
  </fuseaction>

</circuit>
