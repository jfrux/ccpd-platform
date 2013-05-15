<cfoutput>
<span>
  <a href="#myself#activity.create" class="btn btn-small" style="position: absolute; z-index: 1; padding: 3px 13px; top: 90px; right: 0px;">New Activity</a>
</span>
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
      <form name="frmSearch" class="js-search-adv form-inline" method="post" action="#myself#activity.home">
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
        <input type="hidden" name="Search" value="0" />
      </form>
    </div>
  </div>
</div>
</cfoutput>