<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.PersonID" default="">


<script>
<cfoutput>
var searchSettings = {};
searchSettings.liveOptions = "<option value=\"0\">Any Grouping</option>" + <cfloop query="qLiveGroupings">"<option value=\"#qLiveGroupings.GroupingID#\"<cfif qLiveGroupings.GroupingID EQ Attributes.GroupingID> SELECTED</cfif>>#qLiveGroupings.Name#</option>"<cfif qLiveGroupings.RecordCount NEQ qLiveGroupings.CurrentRow> + </cfif></cfloop>;
searchSettings.emOptions = "<option value=\"0\">Any Grouping</option>" + <cfloop query="qEMGroupings">"<option value=\"#qEMGroupings.GroupingID#\"<cfif qEMGroupings.GroupingID EQ Attributes.GroupingID> SELECTED</cfif>>#qEMGroupings.Name#</option>"<cfif qEMGroupings.RecordCount NEQ qEMGroupings.CurrentRow> + </cfif></cfloop>;
searchSettings.noOptions = "<option value=\"0\">Any Grouping</option>";
</cfoutput>
App.User.ActivitySearch.start(searchSettings);
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
  <div class="search span18">
  <cfif isDefined("qActivities") AND qActivities.RecordCount GT 0>
    <!--- SEARCH RESULTS --->
    <!--- <cfif ActivityPager.getTotalNumberOfPages() GT 1>
      <cfoutput>#ActivityPager.getRenderedHTML()#</cfoutput>
    </cfif> --->
    <div class="result-list">
      <cfoutput query="qActivities" startrow="#ActivityPager.getStartRow()#" maxrows="#ActivityPager.getMaxRows()#"> 
      <cfset statusIcon = statusIcons[qActivities.statusid] />
      <div class="divider"><hr /></div>
      <div class="activity-result result-item">
        <div class="result-image" style="background-image:url(#imageUrl('default_photo/activity_i.png')#);"></div>
        <div class="result-body">
          #linkTo(controller="activity",action="detail",params="activityid=#activityid#",text=qActivities.Title,class="result-link")#
          <div class="result-meta">
            <span>
            <i class="icon-circle status-#lcase(qActivities.StatusName)#"></i> #qActivities.StatusName#
            </span>
            <cfif _.isNumber(qActivities.CreatedBy)>
              <span class="meta-middot">&middot;</span>
              <span>
              #linkTo(controller="person",action="detail",params="personid=#createdBy#",text='<i class="icon-user"></i> #CreatedByName#')#
              </span>
            </cfif>

            <cfsavecontent variable="tags">
              <span class="meta-middot">&middot;</span>
              <span>
              <cfif len(ActivityTypeName & " " & GroupingName) GT 15>
                #left(ActivityTypeName & " " & GroupingName,'15')#... 
              <cfelse>
                  #ActivityTypeName & " " & GroupingName#
              </cfif>
              
              </span>
            </cfsavecontent>
            <cfsavecontent variable="addlInfo">
              <cfif _.isDate(qActivities.Created)>
                Created: #DateFormat(qActivities.Created,'M/DD/YYYY')#
              </cfif>
            </cfsavecontent>
            <span class="meta-middot">&middot;</span>
            <span>
              <a href="##" data-tooltip-title="#dateRangeFormat(StartDate,EndDate,"long")#">
                <i class="icon-calendar"></i>
              </a>
            </span>
            <span class="meta-middot">&middot;</span>
            <span>
              <cfif !_.isEmpty(addlInfo)>
                <a href="##" data-tooltip-title="#addlInfo#"><i class="icon-info-circle"></i></a>
              </cfif>
            </span>
            <cfif !_.isEmpty(tags)>
              #tags#
            </cfif>
          </div><!-- // div.result-meta -->
        </div><!-- // div.result-body -->
      </div><!-- // div.result-item -->
      </cfoutput>
    </div>
  </cfif>
  </div>
  <div class="searchbar span6">
    <div class="SearchBar js-searchbar">
      <cfinclude template="infobar/dsp_searchFilters.cfm" />
    </div>
  </div>
</div>
</cfoutput>