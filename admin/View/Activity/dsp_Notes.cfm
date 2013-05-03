<cfparam name="Attributes.NoteBody" default="">

<script>
<cfoutput>
nActivity = #Attributes.ActivityID#;
</cfoutput>
$(document).ready(function() {
  $("a.DeleteNote").bind("click",this,function() {
    if(confirm('Are you sure you want to delete this note?')) {
      //$.blockUI({message: '<h2>Deleting note...</h2>'});
      var nNoteID = $.Replace(this.id,'Note','');
      
      //DELETE AJAX NOTES
      $.getJSON(sRootPath + "/_com/AJAX_Activity.cfc", { method: 'deleteNote', NoteID: nNoteID, returnFormat: 'plain'},
        function(data) {
          if(data.STATUS) {
            parent.addMessage(data.STATUSMSG,250,2500,2500);
            $("#Note" + nNoteID).hide();
            //$.unblockUI();
          } else {
            parent.addError(data.STATUSMSG,250,2500,2500);
            //$.unblockUI();
          } //END IF STATUS
      }); //END AJAX GET
    } // END IF CONFIRM
  }); 
  
  $(".js-note-body").autosize();

  $notebox = $(".js-notebox");
  $notebody = $(".js-note-body");
  $notedummy = $(".js-dummynote");
  $noteAddBtn = $(".js-note-actions .addNote");

  $notedummy.on("click",function() {
    $notebox.addClass('activated');
    $notebody.focus();
  });

  $notebody.on("focus",function() {
    $notebox.addClass('focused');

    //$noteAddBtn.removeClass('disabled').attr('disabled',false);
  });

  $notebody.on("blur",function() {
    if ($(this).val() == "") {
      $notebox.removeClass('activated focused');
    } else {
      $notebox.removeClass('focused');
    }
    //$noteAddBtn.addClass('disabled').attr('disabled',true);
  });

  $(".addNote").on("click", function() {
    var sBody = $("#NoteBody").val();
    //$.blockUI({message: '<h2>Adding note...</h2>'});
    
    //ADD AJAX NOTES
    $.ajax({
      url:sRootPath + "/_com/AJAX_Activity.cfc", 
      type:'post',
      dataType:'json',
      data: { 
        method: 'saveNote', 
        ActivityID: nActivity, 
        NoteBody: sBody, 
        returnFormat: 'plain'
      },
      success: function(data) {
          if(data.STATUS) {
            parent.addMessage(data.STATUSMSG,250,2500,2500);
            //window.location = sMyself + "Activity.Notes?ActivityID=" + nActivity;
          } else {
            $("#NoteBody").val("");
            parent.addError(data.STATUSMSG,250,2500,2500);
            //$.unblockUI();
          } //END IF STATUS
      }
    }); //END AJAX GET
  });
});
</script>
<cfoutput>
<div class="notes">
  <div class="js-notebox note-adder">
    <div class="span24 well">
      <form name="frmCreateNote" accept-charset="UTF-8" class="MainForm" action="" method="POST">
          <input type="text" placeholder="What's going on?" class="js-dummynote dummy-note-body span24" />
          <textarea class="span24 js-autospand note-body js-note-body" id="NoteBody" name="NoteBody" placeholder="What's going on?"></textarea>
          <div class="js-note-actions note-actions"><input name="AddNote" id="AddNote" class="addNote btn btn-info" type="submit" value="Post Note"></div>
      </form>
    </div>
  </div>
  <cfif qActivityNotes.RecordCount GT 0>
  <div class="posts-list">
    <cfloop query="qActivityNotes">
      <div class="post-row row-fluid" id="Note#qActivityNotes.NoteID#">
        <div class="span24 well">
          <p>
            #qActivityNotes.Body#
          </p>
          <p><a href="##">Read more</a></p>
          <p>
            <i class="icon-user"></i> <a href="#myself#Person.Detail?PersonID=#qActivityNotes.CreatedBy#" target="_parent" title="View Profile">#qActivityNotes.CreatedByFName# #Left(qActivityNotes.CreatedByLName, 1)#</a>
            | <i class="icon-calendar"></i> #DateFormat(qActivityNotes.Created,"MMM DD, YYYY")# at #TimeFormat(qActivityNotes.Created,"h:mm TT")#
            | <a href="javascript://" class="btn btn-mini"><i class="icon-trash"></i></a>
          </p>
        </div>
      </div>
      <div class="divider">
      <hr>
      </div>
    </cfloop>
  </div>
  <cfelse>
    <p>No Notes Exist</p>
  </cfif>
</div>
</cfoutput>
