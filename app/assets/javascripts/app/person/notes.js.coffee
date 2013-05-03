###!
* PERSON > NOTES
###
App.module "Person.Notes", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  $noteContent = null
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
                      <a href="javascript://"><i class="icon-trash"></i></a>
                    </div>
                  </div>
                </div>'

  note = _.template(noteMarkup);

  @on "before:start", ->
    App.logInfo "starting: #{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: #{Self.moduleName}"
    return
  @on "stop", ->
    $noteContent.empty()
    App.logInfo "stopped: #{Self.moduleName}"
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
            $notelist.prepend note(payLoad)
            resetForm()
          #window.location = sMyself + "Person.Notes?PersonID=" + nPerson;
          else
            addError data.STATUSMSG, 250, 2500, 2500
      e.preventDefault()

    $("a.DeleteNote").on "click", (e) ->
      if confirm("Are you sure you want to delete this note?")
        #$.blockUI({message: '<h2>Deleting note...</h2>'});
        nNoteID = $.Replace(@id, "Note", "")
        
        #DELETE AJAX NOTES
        $.getJSON sRootPath + "/_com/AJAX_Person.cfc",
          method: "deleteNote"
          NoteID: nNoteID
          returnFormat: "plain"
        , (data) ->
          if data.STATUS
            parent.addMessage data.STATUSMSG, 250, 2500, 2500
            $("#Note" + nNoteID).hide()
          
          #$.unblockUI();
          else
            parent.addError data.STATUSMSG, 250, 2500, 2500
      e.preventDefault()
    return
