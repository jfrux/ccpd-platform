<cfparam name="Attributes.NoteBody" default="">

<script>
<cfoutput>
nPerson = #Attributes.PersonID#;
</cfoutput>
App.Person.Notes.start();
</script>
<cfoutput>
<div class="notes">
  <div class="js-notebox note-adder clearfix">
    <div class="span24 well">
      <form name="frmCreateNote" accept-charset="UTF-8" class="MainForm" action="" method="POST">
          <input type="text" placeholder="What's going on?" class="js-dummynote dummy-note-body span24" />
          <textarea class="span24 js-autospand note-body js-note-body" id="NoteBody" name="NoteBody" placeholder="What's going on?"></textarea>
          <div class="js-note-actions note-actions"><a id="AddNote" class="addNote btn btn-info">Post Note</a></div>
      </form>
    </div>
  </div>
  <cfif qPersonNotes.RecordCount GT 0>
  <div class="posts-list">
    <cfloop query="qPersonNotes">
      <div class="divider">
        <hr>
      </div>
      <div class="post-row row-fluid" data-key="#qPersonNotes.NoteId#">
        <div class="post-item span24">
          <div class="post-author">
            <a href="#myself#Person.Detail?PersonID=#qPersonNotes.CreatedBy#" target="_parent" title="View Profile">#qPersonNotes.CreatedByFName# #Left(qPersonNotes.CreatedByLName, 1)#</a>
          </div>
          <div class="post-body">
            #qPersonNotes.Body#
          </div>
          <div class="post-meta">
            <i class="icon-calendar"></i> #DateFormat(qPersonNotes.Created,"MMM DD, YYYY")# at #TimeFormat(qPersonNotes.Created,"h:mm TT")#
            <a href="javascript://"><i class="icon-trash"></i></a>
          </div>
        </div>
      </div>
      
    </cfloop>
  </div>
  <cfelse>
    <p>No Notes Exist</p>
  </cfif>
</div>
</cfoutput>
