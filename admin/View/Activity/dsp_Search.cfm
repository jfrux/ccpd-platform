<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.PersonID" default="">


<script>
<cfoutput>
var searchSettings = {};
searchSettings.liveOptions = "<option value=\"0\">Any Grouping</option>" + <cfloop query="qLiveGroupings">"<option value=\"#qLiveGroupings.GroupingID#\"<cfif qLiveGroupings.GroupingID EQ Attributes.GroupingID> SELECTED</cfif>>#qLiveGroupings.Name#</option>"<cfif qLiveGroupings.RecordCount NEQ qLiveGroupings.CurrentRow> + </cfif></cfloop>;
searchSettings.emOptions = "<option value=\"0\">Any Grouping</option>" + <cfloop query="qEMGroupings">"<option value=\"#qEMGroupings.GroupingID#\"<cfif qEMGroupings.GroupingID EQ Attributes.GroupingID> SELECTED</cfif>>#qEMGroupings.Name#</option>"<cfif qEMGroupings.RecordCount NEQ qEMGroupings.CurrentRow> + </cfif></cfloop>;
searchSettings.noOptions = "<option value=\"0\">Any Grouping</option>";
</cfoutput>
App.Activity.Search.start(searchSettings);
</script>
<cfif Attributes.Fuseaction EQ "Person.Finder">
  <!--- person finder specific styles --->
  <style type="text/css">
    .headerTop { display:none; }
    h1 { display:none; }
  </style>
</cfif>

<cfoutput>
<div class="row-fluid">
  <span>
  <a href="#myself#activity.create" class="btn btn-small" style="position: absolute; z-index: 1; padding: 3px 13px; top: 90px; right: 0px;">New Activity</a>
  </span>
  <div class="search">
    <div class="span24">
      <div class="filters">
        <h3><a class="js-filter" data-type="easy">Easy Search</a></h3>
        <div class="box">
          <div class="row-fluid">
            <form name="frmSearch" class="js-search-easy form-inline" method="post" action="#myself#activity.search">
              <input type="text" name="q" class="span24" placeholder="Type to search" data-tooltip-title="Start typing names, emails, birthdates, etc." value="#attributes.q#" />
            </form>
          </div>
        </div>
        <h3><a class="js-filter" data-type="advanced">Advanced Criteria</a></h3>
        <div class="js-filter-form box">
          <div class="row-fluid">
            <form name="frmSearch" class="js-search-adv form-inline" method="post" action="#myself#activity.search">
              <input type="text" name="Title" id="Title" class="input-medium" placeholder="Title of activity" value="#Attributes.Title#" />
              <input type="text" name="StartDate" id="ReleaseDate" placeholder="Start Date" class="input-mini" value="#DateFormat(Attributes.StartDate,'MM/DD/YYYY')#" />
              <select name="ActivityTypeID" id="ActivityTypeID" class="input-small">
                <option value="0">Any Type</option>
                <cfloop query="qActivityTypeList">
                  <option value="#qActivityTypeList.ActivityTypeID#"<cfif Attributes.ActivityTypeID EQ qActivityTypeList.ActivityTypeID> Selected</cfif>>#qActivityTypeList.Name#</option>
                </cfloop>
              </select>

              <select name="GroupingID" id="Grouping" disabled="true" class="input-small">

              </select>
              
              <input type="text" name="CategoryID" id="CategoryID" placeholder="Folder" class="js-typeahead-folder input-small" />
              <button class="btn"><i class="icon-search"></i></button>
              <input type="hidden" name="Search" value="1" />
            </form>
          </div>
        </div>
      </div>
    </div>
    <div class="span24">
      <div class="content">
      <cfif isDefined("qActivities") AND qActivities.RecordCount GT 0>
          <!--- SEARCH RESULTS --->
          <h3>Search Results (#qActivities.RecordCount#)</h3>
          
          <cfif ActivityPager.getTotalNumberOfPages() GT 1><div style="row-fluid"><cfoutput>#ActivityPager.getRenderedHTML()#</cfoutput></div></cfif>
          <div class="result-list">
            <cfoutput query="qActivities" startrow="#ActivityPager.getStartRow()#" maxrows="#ActivityPager.getMaxRows()#"> 
            <div class="result-item">
              <a href="#myself#person.detail?personid=#personid#" style="font-weight: normal; font-size: 12px; position: relative; line-height: 24px;">
              #LastName#, #FirstName# #MiddleName# <span style="font-size:12px;color:##888;">(#DisplayName#)</span>
              </a>
              <cfif Email NEQ "">#Email#<cfelse>&nbsp;</cfif>
              <cfif Birthdate NEQ "">#DateFormat(Birthdate,"mm/dd/yyyy")#</cfif>
            </div>
            </cfoutput>
          </div>
          <cfif ActivityPager.getTotalNumberOfPages() GT 1><div><cfoutput>#ActivityPager.getRenderedHTML()#</cfoutput></div></cfif>
        <cfelse>
          <!--- RECENTLY TOUCHED --->
          <cfquery name="qList" datasource="#application.settings.dsn#">
            /* MOST RECENTLY MODIFIED ACTIVITIES */
            WITH CTE_MostRecent AS (
            SELECT H.ToPersonID,MAX(H.Created) As MaxCreated
            FROM ce_History H
            WHERE H.FromPersonID=<cfqueryparam value="#session.personid#" cfsqltype="cf_sql_integer" /> AND isNull(H.ToPersonID,0) <> 0
            GROUP BY H.ToPersonID
            ) SELECT TOP 7 * FROM CTE_MostRecent M INNER JOIN ce_Person A  ON A.PersonID=M.ToPersonId
            WHERE A.DeletedFlag='N'
            ORDER BY M.MaxCreated DESC
          </cfquery>
          <cfoutput>

          <div class="result-list">
            <cfloop query="qList">
            <div class="result-item">
              <a href="#myself#person.detail?personid=#qList.personid#">
              #LastName#, #FirstName# #MiddleName# <span>(#DisplayName#)</span>
              </a>
            </div>
            </cfloop>
          </div>
          </cfoutput>
      </cfif>
      </div>
    </div>
    
  </div>
</div>
</cfoutput>