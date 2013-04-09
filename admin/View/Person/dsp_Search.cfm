<cfparam name="Attributes.ActivityID" default="">
<cfparam name="Attributes.PersonID" default="">

<script>
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
  <cfif Attributes.Fuseaction NEQ "Person.Home"><span style="padding:4px;"><a href="#myself#Person.Create?Instance=#Attributes.Instance#&Mode=Insert&ActivityID=#Attributes.ActivityID#">Create a person</a></span></cfif>
      
  <div class="search <cfif attributes.fuseaction EQ 'Person.Finder'> finder</cfif>">
    <div class="span6">
      <div class="filters">
        <h3>Search Criteria</h3>
        <div class="box">
          <div class="row-fluid">
          <form name="frmSearch" class="form-inline" method="post" action="#myself##xfa.SearchSubmit#">
              <input type="text" name="LastName" id="LastName" class="span24" placeholder="Last Name" value="#Attributes.LastName#" />
            
              <input type="text" name="FirstName" id="FirstName" class="span24" placeholder="First Name" value="#Attributes.FirstName#" />
            
              <!--- <input type="text" name="SSN" id="SSN" class="input-small" placeholder="Last 4 SSN" value="#Attributes.SSN#" />
             --->
              <input type="text" name="Birthdate" id="Birthdate" class="span24" placeholder="Date of Birth" value="#Attributes.Birthdate#" />
            
              <input type="text" name="Email" id="Email" class="span24" placeholder="Email Address" value="#Attributes.Email#" />
              
              <input type="submit" name="Submit" value="Search" class="btn" />
            
            <input type="hidden" name="ActivityID" value="#Attributes.ActivityID#" />
            <input type="hidden" name="Search" value="1" />
            <input type="hidden" name="Instance" value="#Attributes.Instance#" />

          </form>
          </div>
          </div>
      </div>
    </div>
    <div class="span18">
      <div class="content">
        <div class="ContentBody">
          <div class="ViewSection">
            <cfif isDefined("qPeople") AND qPeople.RecordCount GT 0>
                <!--- SEARCH RESULTS --->
                <cfif PeoplePager.getTotalNumberOfPages() GT 1><div><cfoutput>#PeoplePager.getRenderedHTML()#</cfoutput></div></cfif>
                
                <table class="ViewSectionGrid table table-condensed table-bordered">
                  <tbody>
                    <cfoutput query="qPeople" startrow="#PeoplePager.getStartRow()#" maxrows="#PeoplePager.getMaxRows()#">
                      <tr>
                        <td>
                          <a href="javascript:void(0);" 
                              class="PersonAdder btn" 
                              id="#qPeople.PersonID#|#LastName#, #FirstName# #MiddleName#">
                            <i class="icon-add"></i>
                          </a>
                        </td>
                        <td>
                          <a href="#myself#Person.Detail?PersonID=#PersonID#">
                          #LastName#, #FirstName# #MiddleName# <span style="font-size:12px;color:##888;">(#DisplayName#)</span>
                          </a>
                        </td>

                        <td><cfif Email NEQ "">#Email#<cfelse>&nbsp;</cfif></td>
                        <td><cfif Birthdate NEQ "">#DateFormat(Birthdate,"mm/dd/yyyy")#</cfif></td>
                        <td class="details">
                          <a href="#myself#Person.Detail?PersonID=#PersonID#">#LastName#, #FirstName# #MiddleName# <span style="font-size:12px;color:##888;">(#DisplayName#)</span></a>
                          
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
                  ) SELECT * FROM CTE_MostRecent M INNER JOIN ce_Person A  ON A.PersonID=M.ToPersonId
                  WHERE A.DeletedFlag='N'
                  ORDER BY M.MaxCreated DESC
                </cfquery>
                <cfoutput>
                <h3>Your Recent Persons</h3>
                <table class="ViewSectionGrid table table-condensed table-bordered">
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
        </div>
      </div>
    </div>
    
  </div>
</div>
</cfoutput>