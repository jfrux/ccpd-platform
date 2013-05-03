<cfparam name="Attributes.CertName" default="" />
<cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveJS.cfm" />
<!--- <cfinclude template="#Application.Settings.RootPath#/View/Includes/SaveInfo.cfm" /> --->
<script>
<cfoutput>
var sCertName = "#Attributes.CertName#";
var sEmail = "#Attributes.Email#";
</cfoutput>
App.Person.GeneralInfo.start();

function updateCertName() {
  // RADIO VALUES
  $("#certname-1").val($("#firstname").val() + " " + $("#middlename").val() + " " + $("#lastname").val());
  $("#certname-2").val($("#firstname").val() + " " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
  $("#certname-3").val($.Left($("#firstname").val(),1) + ". " + $("#middlename").val() + " " + $("#lastname").val());
  $("#certname-4").val($.Left($("#firstname").val(),1) + ". " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
  $("#certname-5").val($("#firstname").val() + " " + $("#lastname").val());
  $("#certname-6").val($.Left($("#firstname").val(),1) + ". " + $("#lastname").val());

  // TEXT DISPLAY
  $("#certname-1-label > span").html($("#firstname").val() + " " + $("#middlename").val() + " " + $("#lastname").val());
  $("#certname-2-label > span").html($("#firstname").val() + " " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
  $("#certname-3-label > span").html($.Left($("#firstname").val(),1) + ". " + $("#middlename").val() + " " + $("#lastname").val());
  $("#certname-4-label > span").html($.Left($("#firstname").val(),1) + ". " + $.Left($("#middlename").val(),1) + ". " + $("#lastname").val());
  $("#certname-5-label > span").html($("#firstname").val() + " " + $("#lastname").val());
  $("#certname-6-label > span").html($.Left($("#firstname").val(),1) + ". " + $("#lastname").val());
}

function updateCertNameValue(sName) {
  $("#certnamecustom").val(sName);
  $("#certname-7").val(sName);
}

$(document).ready(function() {
  updateCertName();
  
  // TRIES TO FIND A MATCHING DISPLAYNAME OPTION FOR THE CURRENTLY SELECTED DISPLAY NAME
  $(".certname").each(function() {
    if(sCertName == $(this).val()) {
      $(this).attr("checked",true);
    }
  });
  
  $(".certname").click(function() {
    updateCertNameValue($(this).val());
  });
  
  $("#certnamecustom").keyup(function() {
    updateCertNameValue($(this).val());
  });
  
  // MAKES SURE THE DISPLAY NAME FIELD IS SELECTED ONTO AN OPTION
  if($(".certname").attr("checked") == false && sCertName != "") {
    $("#certnamecustom").val(sCertName);
    $("#certname-7").attr("checked",true);
  }
  
  // KEEPS DISPLAYNAME OPTIONS UP TO DATE
  $("#firstname, #middlename, #lastname").keyup(function() {
    updateCertName();
  });
});
</script>

<div class="ViewSection">
<cfoutput>
<form class="js-formstate form-horizontal" action="#Application.Settings.RootPath#/_com/AJAX_Person.cfc" method="post" name="frmEditActivity">
  <input type="hidden" name="method" id="method" value="savePerson" />
  <input type="hidden" name="PersonID" id="PersonID" value="#Attributes.PersonID#" />
  <input type="hidden" name="Password" id="Password" value="<!--- THIS IS JUST A PLACEHOLDER AND DOES NOT MATTER BUT IS REQUIRED FOR FUNCTIONALITY --->" />
  <input type="hidden" name="returnformat" id="returnformat" value="plain" />
    
  <cfset BirthDate = DateFormat(Attributes.birthdate, "MM/DD/YYYY")>
  <div class="control-group">
    <label class="control-label" for="firstname">First Name</label>
    <div class="controls"><input id="firstname" name="firstname" type="text" class="inputText" value="#Attributes.firstname#" tabindex="1" style="width:250px;"  />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="middlename">Middle Name</label>
    <div class="controls"><input id="middlename" name="middlename" type="text" class="inputText" value="#Attributes.middlename#" tabindex="2" style="width:250px;"  />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="lastname">Last Name</label>
    <div class="controls"><input id="lastname" name="lastname" type="text" class="inputText" value="#Attributes.lastname#" tabindex="3" style="width:250px;"  />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="namesuffix">Name Suffix</label>
    <div class="controls"><input id="suffix" name="suffix" type="text" class="inputText" value="#Attributes.suffix#" tabindex="4"  />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="gender">Gender</label>
    <div class="controls">
      <select name="Gender" id="Gender" tabindex="5">
        <option value="">Select One...</option>
        <option value="M"<cfif Attributes.Gender EQ "M"> Selected</cfif>>Male</option>
        <option value="F"<cfif Attributes.Gender EQ "F"> Selected</cfif>>Female</option>
      </select>
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="namesuffix">Last 4 SSN</label>
    <div class="controls">
      <input id="SSN" name="SSN" type="text" class="inputText" value="#Attributes.SSN#" tabindex="6" />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label" for="birthdate">Birth Date</label>
    <div class="controls"><input id="date1" name="birthdate" type="text" class="inputText" value="#BirthDate#" tabindex="7" />
    </div>
  </div>

  <div class="control-group">
    <label class="control-label">Display Name</label>
    <em>Used for displaying other than Certificates and Transcripts (CME website)</em>
    <div class="controls">
    <input type="text" name="displayname" id="displayname" tabindex="17" value="#Attributes.DisplayName#" style="width:230px;" />
    </div>
  </div>
  <div class="control-group">
    <label class="control-label">Certificate Name</label>
          <em>Used on Certificates and Transcripts</em>
    <div class="controls">
      <label for="certname-1" id="certname-1-label" class="radio">
        <span></span>
        <input type="radio" name="CertName" id="certname-1" value="" class="certname" tabindex="9" />
      </label>
      <label for="certname-2" id="certname-2-label" class="radio">
        <span></span>
        <input type="radio" name="CertName" id="certname-2" value="" class="certname" tabindex="10" />
      </label>
      <label for="certname-3" id="certname-3-label" class="radio">
        <span></span>
        <input type="radio" name="CertName" id="certname-3" value="" class="certname" tabindex="11" />
      </label>
      <label for="certname-4" id="certname-4-label" class="radio">
        <span></span>
        <input type="radio" name="CertName" id="certname-4" value="" class="certname" tabindex="12" />
      </label>
      <label for="certname-5" id="certname-5-label" class="radio">
        <span></span>
        <input type="radio" name="CertName" id="certname-5" value="" class="certname" tabindex="13" />
      </label>
      <label for="certname-6" id="certname-6-label" class="radio">
        <span></span>
        <input type="radio" name="CertName" id="certname-6" value="" class="certname" tabindex="14" />
      </label>
      <input type="radio" name="CertName" id="certname-7" class="certname" value="#Attributes.CertName#" tabindex="15" />
      <input type="text" name="certnamecustom" id="certnamecustom" tabindex="16" value="#Attributes.CertName#" />
    </div>
  </div>
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
            </table>
        </td>
    </tr>
</table>
</fieldset>
<input id="Email" name="Email" type="hidden" class="inputText" value="#Attributes.Email#" tabindex="8" style="width:250px;" />
</form>
</cfoutput>
</div>