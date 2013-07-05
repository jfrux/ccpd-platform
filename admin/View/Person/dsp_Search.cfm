<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.PersonID" default="">

<script>
//App.User.PersonSearch.start();
$(document).ready(function() {
  <cfif Attributes.PersonID NEQ "">
  <cfoutput>
  var nPerson = #Attributes.PersonID#;
  </cfoutput>
  </cfif>
  $("input").unbind("keyup");
  $("select").unbind("change");
  $("#LastName").focus();
  
  $(".PersonAdder").click(function() {
    parent.setPerson<cfoutput>#Attributes.Instance#</cfoutput>(this.id);
  });
  
  $("#KeepOpen").click(function() {
    if($("#KeepOpen").attr('checked')) {
      $.post(sRootPath + "/_com/UserSettings.cfc?method=setPersonFinderOpen&KeepOpen=true");
    } else {
      $.post(sRootPath + "/_com/UserSettings.cfc?method=setPersonFinderOpen&KeepOpen=false");
    }
  });
  
  <cfif Attributes.PersonID NEQ "">
    parent.setPerson<cfoutput>#Attributes.Instance#</cfoutput>(nPerson);
  </cfif>
});
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
  <div class="search<cfif attributes.fuseaction EQ 'person.finder'> finder</cfif> span18">
    <cfif isDefined("qPeople") AND qPeople.RecordCount GT 0>
      <cfif PeoplePager.getTotalNumberOfPages() GT 1><div style="row-fluid"><cfoutput>#PeoplePager.getRenderedHTML()#</cfoutput></div></cfif>
      <div class="result-list">
        <cfoutput query="qPeople" startrow="#PeoplePager.getStartRow()#" maxrows="#PeoplePager.getMaxRows()#">
        <div class="divider"><hr /></div>
        <div class="person-result result-item" data-key="#personid#">
          <div class="result-image" style="background-image:url(#imageUrl('default_photo/person_m_i.png')#);"></div>
          <div class="result-body">
            #linkTo(controller="person",action="detail",params="personid=#personid#",text='#LastName#, #FirstName# #MiddleName# <span class="result-alias">#DisplayName#</span>',class="result-link")#
            <div class="result-meta">
              <a href="##"><i class="icon-user"></i>#qPeople.displayname#</a>
              <cfif !_.isEmpty(Email)>
                <span class="meta-middot">&middot;</span>
                <i class="icon-mail-alt"></i>#Email#</cfif>
              <cfif _.isDate(Birthdate)><span class="meta-middot">&middot;</span><i class="icon-calendar"></i>#DateFormat(Birthdate,"mm/dd/yyyy")#</cfif>
            </div>
          </div>
          <div class="result-actions btn-group">
            #linkTo(href="javascript:void(0);",id="#PersonID#|#LastName#, #FirstName# #MiddleName#",params="personid=#personid#",text='<i class="icon-plus"></i>',class="js-person-add PersonAdder btn btn-person-adder")#
          </div>
        </div>
        </cfoutput>
      </div>
      <cfif PeoplePager.getTotalNumberOfPages() GT 1><div><cfoutput>#PeoplePager.getRenderedHTML()#</cfoutput></div></cfif>
    <cfelse>
      <!--- RECENTLY USED PEOPLE --->
      <cfquery name="qPeople" datasource="#application.settings.dsn#">
        /* MOST RECENTLY MODIFIED ACTIVITIES */
        WITH CTE_MostRecent AS (
        SELECT H.ToPersonID,MAX(H.Created) As MaxCreated
        FROM ce_History H
        WHERE H.FromPersonID=<cfqueryparam value="#session.personid#" cfsqltype="cf_sql_integer" /> AND isNull(H.ToPersonID,0) <> 0
        GROUP BY H.ToPersonID
        ) SELECT TOP 5 * FROM CTE_MostRecent M INNER JOIN ce_Person A  ON A.PersonID=M.ToPersonId
        WHERE A.DeletedFlag='N'
        ORDER BY M.MaxCreated DESC
      </cfquery>
      <div class="result-list">
        <cfoutput query="qPeople">
          <div class="divider"><hr /></div>
          <div class="person-result result-item" data-key="#personid#">
            <div class="result-image" style="background-image:url(#imageUrl('default_photo/person_m_i.png')#);"></div>
            <div class="result-body">
              #linkTo(controller="person",action="detail",params="personid=#personid#",text='#LastName#, #FirstName# #MiddleName# <span class="result-alias">#DisplayName#</span>',class="result-link")#
              <div class="result-meta">
                <a href="##"><i class="icon-user"></i>#qPeople.displayname#</a>
                <cfif !_.isEmpty(Email)>
                  <span class="meta-middot">&middot;</span>
                  <i class="icon-mail-alt"></i>#Email#</cfif>
                <cfif _.isDate(Birthdate)><span class="meta-middot">&middot;</span><i class="icon-calendar"></i>#DateFormat(Birthdate,"mm/dd/yyyy")#</cfif>
              </div>
            </div>
            <div class="result-actions btn-group">
              #linkTo(href="javascript:void(0);",id="#PersonID#|#LastName#, #FirstName# #MiddleName#",params="personid=#personid#",text='<i class="icon-plus"></i>',class="js-person-add PersonAdder btn btn-person-adder")#
            </div>
          </div>
          </cfoutput>
        </div>
    </cfif>
  </div>
  <div class="searchbar span6">
    <div class="SearchBar js-searchbar">
      <cfinclude template="infobar/searchFilters.cfm" />
    </div>
  </div>
</div>
</cfoutput>