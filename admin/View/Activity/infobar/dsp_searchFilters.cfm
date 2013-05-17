<cfoutput>
<span>
  <a class="btn btn-create" href="/admin/event/activity.create"><i class="icon-edit icon-large"></i> Create Activity</a>
</span>
<div class="filters">
  <!--- <h3><a class="js-filter" data-type="easy">Easy Search</a></h3>
  <div class="box">
    <div class="row-fluid">
      <form name="frmSearch" class="js-search-easy form-inline" method="post" action="#myself#activity.search">
        <input type="text" name="q" class="span24" placeholder="Type to search" data-tooltip-title="Start typing names, emails, birthdates, etc." value="#attributes.q#" />
      </form>
    </div>
  </div> --->
  <h3><a class="js-filter" data-type="advanced">Search Criteria</a></h3>
  <div class="js-filter-form box">
    <div class="row-fluid">
      <form name="frmSearch" class="js-search-adv form-search-filters" method="get" action="#myself#main.activities">
        <input type="text" name="Title" id="Title" class="input-block-level" placeholder="Title of activity" value="#Attributes.Title#" />
        <input type="text" name="StartDate" id="ReleaseDate" placeholder="Start Date" class="input-block-level" value="#DateFormat(Attributes.StartDate,'MM/DD/YYYY')#" />
        <select name="ActivityTypeID" id="ActivityTypeID" class="input-block-level">
          <option value="0">Any Type</option>
          <cfloop query="qActivityTypeList">
            <option value="#qActivityTypeList.ActivityTypeID#"<cfif Attributes.ActivityTypeID EQ qActivityTypeList.ActivityTypeID> Selected</cfif>>#qActivityTypeList.Name#</option>
          </cfloop>
        </select>
        <select name="GroupingID" id="Grouping" disabled="true" class="input-block-level">
        </select>
        <cfset qCategories = Application.Com.CategoryGateway.getByAttributes(OrderBy="Name")>
        <cfset qPersonalCats = Application.Com.CategoryGateway.getByCookie(TheList=Cookie.USER_Containers,OrderBy="Name")>

        <select name="CategoryID" id="CategoryID" class="input-block-level">
          <option value="0">Any Container</option>
          <cfif qPersonalCats.RecordCount GT 0>
          <option value="0">---- Your Containers ----</option>
            <cfloop query="qPersonalCats">
            <option value="#qPersonalCats.CategoryID#"<cfif Attributes.CategoryID EQ qPersonalCats.CategoryID> Selected</cfif>>#qPersonalCats.Name#</option>
            </cfloop>
          <option value="0">--- All Other Containers ----</option>
          </cfif>
          
          <cfloop query="qCategories">
            <cfif NOT ListFind(Cookie.USER_Containers,qCategories.CategoryID,",")>
            <option value="#qCategories.CategoryID#"<cfif Attributes.CategoryID EQ qCategories.CategoryID> Selected</cfif>>#qCategories.Name#</option>
            </cfif>
          </cfloop>
        </select>
        <button class="btn"><i class="icon-search"></i></button>
        <input type="hidden" name="Search" value="0" />
      </form>
    </div>
  </div>
</div>
</cfoutput>