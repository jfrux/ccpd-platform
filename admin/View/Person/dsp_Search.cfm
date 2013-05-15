<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.PersonID" default="">

<script>
App.User.PersonSearch.start();
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
    
    $("#PhotoUpload").dialog({ 
      title:"Upload Photo",
      modal: false, 
      autoOpen: false,
      height:120,
      width:450,
      resizable: false,
      open:function() {
        $("#PhotoUpload").show();
      }
    });
    
    $("img.PersonPhoto").click(function() {
      var nCurrPerson = $.Replace(this.id,"Photo","","ALL");
      $("#frmUpload").attr("src",sMyself + "Person.PhotoUpload?PersonID=" + nCurrPerson + "&ElementID=" + this.id);
      $("#PhotoUpload").dialog("open");
    });
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
  <div class="search<cfif attributes.fuseaction EQ 'Person.Finder'> finder</cfif> span18">
    <cfif Attributes.Fuseaction NEQ "Person.Home">
      <span>
          <a href="#myself#Person.Create?Instance=#Attributes.Instance#&Mode=Insert&ActivityID=#Attributes.ActivityID#" class="btn btn-small" style="position: absolute; z-index: 1; padding: 3px 13px; top: 90px; right: 0px;">New Person</a>
      </span>
    </cfif>
    <cfif isDefined("qPeople") AND qPeople.RecordCount GT 0>
      <cfif PeoplePager.getTotalNumberOfPages() GT 1><div style="row-fluid"><cfoutput>#PeoplePager.getRenderedHTML()#</cfoutput></div></cfif>
      <table class="ViewSectionGrid table table-condensed">
        <tbody>
          <cfoutput query="qPeople" startrow="#PeoplePager.getStartRow()#" maxrows="#PeoplePager.getMaxRows()#">
            <tr>
              <td class="span1"><a href="javascript:void(0);" class="js-person-add PersonAdder btn" id="#PersonID#|#LastName#, #FirstName# #MiddleName#"><i class="icon-plus"></i></a></td>
              <td>
                 <a href="#myself#person.detail?personid=#personid#" style="font-weight: normal; font-size: 12px; position: relative; line-height: 24px;">
                #LastName#, #FirstName# #MiddleName# <span style="font-size:12px;color:##888;">(#DisplayName#)</span>
                </a>
                <cfif Email NEQ "">#Email#<cfelse>&nbsp;</cfif>
                <cfif Birthdate NEQ "">#DateFormat(Birthdate,"mm/dd/yyyy")#</cfif>
              </td>
            </tr>
          </cfoutput>
        </tbody>
      </table>
      <cfif PeoplePager.getTotalNumberOfPages() GT 1><div><cfoutput>#PeoplePager.getRenderedHTML()#</cfoutput></div></cfif>
    <cfelse>
      <!--- RECENTLY USED PEOPLE --->
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
      <h3>Your Recent Persons</h3>
      <table class="ViewSectionGrid table table-condensed">
        <tbody>
          <cfloop query="qList">
            <tr>
              <td class="span1"><a href="javascript:void(0);" class="js-person-add PersonAdder btn" id="#qList.PersonID#|#LastName#, #FirstName# #MiddleName#"><i class="icon-plus"></i></a></td>
              <td>
                 <a href="#myself#person.detail?personid=#qList.personid#" style="font-weight: normal; font-size: 12px; display: block; position: relative; line-height: 24px;">
                #LastName#, #FirstName# #MiddleName# <span style="font-size:12px;color:##888;">(#DisplayName#)</span>
                </a>
              </td>
            </tr>
          </cfloop>
        </tbody>
      </table>
      </cfoutput>
    </cfif>
      
  
  </div>
  <div class="span6">
    <div class="SearchBar searchbar js-searchbar">
      <cfinclude template="infobar/searchFilters.cfm" />
    </div>
  </div>
</div>
</cfoutput>