<script>
$(document).ready(function() {
  $("#PersonDetail").dialog({ 
      title: "Person Detail",
      modal: true, 
      autoOpen: false,
      height:550,
      width:855,
      resizable: false,
      dragStop: function(ev,ui) {
        
      },
      open:function() {
        $("#frameDetail").attr('src',sMyself + 'Person.Detail?PersonID=' + nPersonID + '&Mini=1');
      },
      close:function() {
        
      },
      resizeStop:function(ev,ui) {
      }
    });
    
    
  $(".PersonLink").click(function() {
    nPersonID = $.ListGetAt(this.id,2,"|");
    sPersonName = $.ListGetAt(this.id,3,"|");

    $("#PersonDetail").dialog("open");
    return false;
  });
  
  /* NOTES DIALOG */
  $("#FileUploader").dialog({ 
    title:"Upload File",
    modal: false, 
    autoOpen: false,
    height:320,
    width:350,
    resizable: false,
    stack: false,
    buttons: { 
      Save:function() {
        $("#frmFileUpload").ajaxSubmit({
          beforeSubmit:  function() {   // pre-submit callback 
            $("#Section" + CurrPersonID).html("<img src=\"/admin/_images/ajax-loader.gif\"/><br />Please wait...");
          }, 
          url: sMyself + "File.Upload&Mode=Person&ModeID=" + CurrPersonID + "&ActivityID=" + nActivity + "&Submitted=1",
          type: "post",
          success: function() {     // post-submit callback 
            $("#FileUploader").html("");
            addMessage("File uploaded successfully.",250,6000,4000);
            $("#FileUploader").dialog("close");
          }
        }); 
      },
      Cancel:function() {
        $(this).dialog("close");
        updateFaculty();
      }
    },
    open:function() {
      $.post(sMyself + "File.Upload", { Mode: "Person", ModeID: CurrPersonID, ActivityID: nActivity }, function(data) {
        $("#FileUploader").html(data);
      });
    },
    close:function() {
      updateFaculty();
      //updateActions();
    }
  });
  
  $(".UploadFile").click(function() {
    CurrPersonID = $.ListGetAt(this.id,2,'|');
    $("#FileUploader").dialog("open");
  });
  /* // END NOTES DIALOG */
  
  /* PHOTO UPLOAD DIALOG */
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
    var nPersonID = $.Replace(this.id,"Photo","","ALL");
    $("#frmUpload").attr("src",sMyself + "Person.PhotoUpload?PersonID=" + nPersonID + "&ElementID=" + this.id);
    $("#PhotoUpload").dialog("open");
  });
  /* // END PHOTO UPLOAD DIALOG */
    
  /* FACULTY FILE APPROVAL */
  $(".approveFile").click(function() {
    var sApprovalType = $.ListGetAt(this.id, 1, "|");
    var sFileType = $.ListGetAt(this.id, 2, "|");
    var nPersonID = $.ListGetAt(this.id, 3, "|");
    
    $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", { method: "approveFacultyFile", ActivityID: nActivity, PersonID: nPersonID, FileType: sFileType, Mode: sApprovalType, returnFormat: "plain" },
    function(data) {      
      if(data.STATUS) {
        updateFaculty();
        addMessage(data.STATUSMSG,250,6000,4000);
      } else {
        updateFaculty();
        addError(data.STATUSMSG,250,6000,4000);
      }
    });
  });
    
  $("#CheckAll").click(function() {
    if($("#CheckAll").attr("checked")) {
      $(".MemberCheckbox").each(function() {
        $(this).attr("checked",true);
        
        $(".AllFaculty").css("background-color","#FFD");
      });
    } else {
      $(".MemberCheckbox").each(function() {
        $(this).attr("checked",false);
        
        $(".AllFaculty").css("background-color","#FFF");
      });
    }
  }); 
  
  $(".MemberCheckbox").bind("click", this, function() {
    if($(this).attr("checked")) {
      var nPersonID = $.Replace(this.id,"Checked","","ALL");
      $("#PersonRow" + nPersonID).css("background-color","#FFD");
    } else {
      var nPersonID = $.Replace(this.id,"Checked","","ALL");
      $("#PersonRow" + nPersonID).css("background-color","#FFF");
    }
  });
});
</script>
<cfoutput>
<cfif qActivityFacultyList.RecordCount GT 0>
  <form name="FacultyList" method="post" id="MembersList">
  <table class="ViewSectionGrid DetailView table table-condensed table-bordered">
    <thead>
      <tr>
        <th width="15"><input type="checkbox" name="CheckAll" id="CheckAll" /></th>
        <th width="85%">Information</th>
        <th>Role</th>
      </tr>
    </thead>
    <tbody>
      <cfloop query="qActivityFacultyList">
        <tr id="PersonRow#PersonID#" class="AllFaculty">
          <td>
            <input type="checkbox" name="Checked" class="MemberCheckbox" id="Checked#PersonID#" value="#PersonID#" />
          </td>
          <td>
            <!--- <div style="float:left; width:21%; border:0px solid ##070;"><cfif FileExists(ExpandPath(".\_uploads\PersonPhotos\#PersonID#.jpg"))><img src="/_uploads/PersonPhotos/#PersonID#.jpg" id="Photo#PersonID#" class="PersonPhoto" /><cfelse><img src="#Application.Settings.RootPath#/_images/icon_<cfif Gender EQ "F">female<cfelse>male</cfif>.gif" id="Photo#PersonID#" class="PersonPhoto" /></cfif></div> --->
            <div><a href="#myself#Person.Detail?PersonID=#PersonID#" class="PersonLink" id="PERSON|#PersonID#|#LastName#, #FirstName#" title="View person profile of #FirstName# #LastName#">#FirstName# #LastName#</a></div>
            <div id="Section#qActivityFacultyList.PersonID#">
            <cfset FileCount = 0>

            <div class="row-fluid">
              <div class="CVBox span12" id="CVBox#PersonID#">
                <cfif qActivityFacultyList.CVFileID NEQ "">
                  <cfif qActivityFacultyList.CVApproveFlag EQ "N">
                      <cfset CVFileApproval = "Approved">
                    <cfelse>
                      <cfset CVFileApproval = "Unapprove">
                    </cfif>
                    
                    <a class="btn" href="#Myself#File.Download?Mode=Person&ModeID=#qActivityFacultyList.PersonID#&ID=#qActivityFacultyList.CVFileID#" title="Download the CV of #FirstName# #LastName#"><i class="icon-download"></i> Download CV</a>  <span style="color: <cfif qActivityFacultyList.CVApproveFlag EQ "Y">##070;<cfelseif DateDiff("yyyy",Now(),qActivityFacultyList.CVCreatedDate) LTE -3>##F00;</cfif>"> <span style="font-size:10px;">(#DateFormat(qActivityFacultyList.CVCreatedDate,"MM/DD/YYYY")#)</span></span><br />
                    <cfif qActivityFacultyList.CVApproveFlag EQ "N">
                      <a class="btn" href="javascript:void(0);" id="Approve|CV|#qActivityFacultyList.PersonID#" class="approveFile" title="Mark the CV of #FirstName# #LastName# as Approved"><i class="icon-clock"></i> Mark Approved</a>
                    <cfelse>
                      <i class="icon-tick"></i> Approved <a href="javascript:void(0);" id="Unapprove|CV|#qActivityFacultyList.PersonID#" class="approveFile" title="Remove the Approved status from the CV of #FirstName# #LastName#">(remove)</a>
                    </cfif>
                    <br />
                    <cfset FileCount = FileCount + 1>
                </cfif>
                <a href="javascript:void(0);" class="UploadFile btn btn-mini" id="File|#qActivityFacultyList.PersonID#" title="Upload a new file"><i class="icon-upload-alt"></i> Upload New CV</a>
              </div>
              <div class="DislosureBox span12" id="DislosureBox#PersonID#">
                <cfif qActivityFacultyList.DisclosureFileID NEQ "">
                  <cfif qActivityFacultyList.DisclosureApproveFlag EQ "N">
                    <cfset DisclosureFileApproval = "Approve">
                  <cfelse>
                    <cfset DisclosureFileApproval = "Unapprove">
                  </cfif>
                  
                  <a href="#Myself#File.Download?Mode=Person&ModeID=#qActivityFacultyList.PersonID#&ID=#qActivityFacultyList.DisclosureFileID#" title="Download the Disclosure of #FirstName# #LastName#"><i class="icon-download"></i> Download Disclosure</a> <span style="color: <cfif qActivityFacultyList.DisclosureApproveFlag EQ "Y">##070;<cfelseif DateDiff("yyyy",Now(),qActivityFacultyList.DisclosureCreatedDate) LTE -1>##F00;</cfif>"> <span style="font-size:10px;">(#DateFormat(qActivityFacultyList.DisclosureCreatedDate,"MM/DD/YYYY")#)</span></span><br /> 
                  <cfif qActivityFacultyList.DisclosureApproveFlag EQ "N">
                    <a href="javascript:void(0);" id="Approve|Disclosure|#qActivityFacultyList.PersonID#" class="approveFile" title="Mark the Disclosure of #FirstName# #LastName# as Approved"><i class="icon-clock"></i> Mark Approved</a>
                  <cfelse>
                    <i class="icon-tick"></i> Approved <a href="javascript:void(0);" id="Unapprove|Disclosure|#qActivityFacultyList.PersonID#" class="approveFile" title="Remove the Approved Status from the Disclosure of #FirstName# #LastName#">(remove)</a>
                  </cfif>
                  <br />
                  <cfset FileCount = FileCount + 1>
                </cfif>
                <a href="javascript:void(0);" class="UploadFile btn btn-mini" id="File|#qActivityFacultyList.PersonID#" title="Upload a new file"><i class="icon-upload-alt"></i> Upload New Disclosure</a>
              </div>
            </div>
            </div>
          </td>
          <td>
            <div style="float:left; border:0px solid ##000;">#qActivityFacultyList.RoleName#</div>
          </td>
        </tr>
      </cfloop>
    </tbody>
  </table>
  </form>
<cfelse>
  <div class="alert alert-info">
    You have not added any faculty / speakers.<br />
    Please click '<a class="btn"><i class="icon-plus"></i></a> on the right to begin.
  </div>
</cfif>
</cfoutput>