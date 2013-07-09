###!
* PERSON > NOTES
###
App.module "Person.Notes", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  $noteContent = null
  $notes = null
  $notebox = null
  $notebody = null
  $notelist = null
  $notedummy = null
  $noteAddBtn = null
  noteMarkup = '<div class="divider">
                  <hr>
                </div>
                <div class="post-row row-fluid" data-key="<%=id%>">
                  <div class="post-item span24">
                    <div class="post-author">
                      <a href="/admin/event/Person.Detail?PersonID=<%=author.id%>" title="View Profile"><%=author.name%></a>
                    </div>
                    <div class="post-body">
                       <%=body%>
                    </div>
                    <div class="post-meta">
                      <i class="icon-calendar"></i> <%=timestamp%>
                      <a href="javascript://" class="js-notedelete"><i class="icon-trash"></i></a>
                    </div>
                  </div>
                </div>'

  note = _.template(noteMarkup);

  @on "before:start", ->
    App.logInfo "starting: Person.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Person.#{Self.moduleName}"
    return
  @on "stop", ->
    $noteContent.empty()
    App.logInfo "stopped: Person.#{Self.moduleName}"
    return

  @on "noteDeleted", (n) ->
    App.logInfo "Deleted Note: #{n}"
    $deleteNote = $notes.filter("[data-key='" + n + "']")
    $deleteNote.prev().remove();
    $deleteNote.remove();
    return
  Self.resetForm = resetForm = ->
    $notebody.val('')
    $notebody.blur()
    return

  _init = (defaults) ->
    $noteContent = $("#js-person-notes");
    $notebox = $noteContent.find(".js-notebox")
    $notebody = $noteContent.find(".js-note-body")
    $notelist = $noteContent.find(".posts-list");
    $notes = $notelist.find('.post-item')
    $notedummy = $noteContent.find(".js-dummynote")
    $noteAddBtn = $noteContent.find(".js-note-actions .addNote")
    App.logDebug $notelist
    $notebody.autosize()

    $notedummy.on "click", ->
      $notebox.addClass "activated"
      $notebody.focus()
      return

    $notebody.on "focus", ->
      $notebox.addClass "focused"
      return

    #$noteAddBtn.removeClass('disabled').attr('disabled',false);
    $notebody.on "blur", ->
      if $(this).val() is ""
        $notebox.removeClass "activated focused"
      else
        $notebox.removeClass "focused"
      return

    $noteAddBtn.on "click", (e) ->
      sBody = $notebody.val()
      sBody = sBody.replace /\n/g, '<br />'
      #sBody.replace /\n/g, "<br />"
      #ADD AJAX NOTES
      $.ajax
        url: sRootPath + "/_com/AJAX_Person.cfc"
        type: "post"
        dataType: "json"
        data:
          method: "saveNote"
          PersonID: nPerson
          NoteBody: sBody
          returnFormat: "plain"

        success: (data) ->
          if data.STATUS
            addMessage data.STATUSMSG, 250, 2500, 2500
            payLoad = data.PAYLOAD;
            $newNoteRow = $(note(payLoad))
            $newNote = $newNoteRow.find('.post-item')
            $newNote.find(".js-notedelete").on "click",->
              deleteNote $newNote
              return
            $notelist.prepend $newNoteRow
            resetForm()
          #window.location = sMyself + "Person.Notes?PersonID=" + nPerson;
          else
            addError data.STATUSMSG, 250, 2500, 2500
      e.preventDefault()

    $notes.each ->
      $note = $(this)
      $noteDelete = $note.find('.js-notedelete')
      $noteRow = $note.parents('.post-row')
      $noteDivider = $noteRow.prev()
      note_id = $noteRow.data('key')
      $noteDelete.on "click", (e) ->
        deleteNote $note
        e.preventDefault()
    return

  deleteNote = ($el) ->
    $note = $el
    $row = $el.parents('.post-row')
    console.log $note
    console.log $row
    note_id = $row.data('key')
    if confirm("Are you sure you want to delete this note?")
      #DELETE AJAX NOTE
      $.ajax 
        url:sRootPath + "/_com/AJAX_Person.cfc"
        dataType:'json'
        type:'post'
        data:
          method: "deleteNote"
          noteid: note_id
          returnFormat: "plain"
        success:(data) ->
          if data.STATUS
            $row.prev().remove()
            $row.remove()
            parent.addMessage data.STATUSMSG, 250, 2500, 2500
          else
            parent.addError data.STATUSMSG, 250, 2500, 2500
          return
