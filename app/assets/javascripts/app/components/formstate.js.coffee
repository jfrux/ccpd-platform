###!
* FORM STATE MANAGEMENT
###

App.components.formstate = do ({App,$,Backbone} = window) ->
  $el = null
  $form = null
  $saveButton = null
  $discardButton = null
  $saveInfo = null
  IsSaved = true
  isPublishArea = false # USED TO DETERMINE IF PUBLISH BAR IS UPDATED
  ChangedFields = ""
  ChangedValues = ""
  $changedFields = null
  $changedValues = null

  _init = (IsSaved) ->
    console.log "init: formstate component"
    $form = $('#EditForm')
    $el = $('<div class="ViewSectionButtons control-group">
            <div class="controls">
              <input type="submit" value="Save Now" name="btnSave" class="btn btn-primary js-btn-save" /> 
              <input style="display:none;" type="reset" value="Discard" name="btnDiscard" class="btn js-btn-discard" /> 
              <span class="SaveInfo js-save-info"></span>
            </div>
          </div>')
    $changedFields = $('<input type="text" class="js-changed-fields hide" name="ChangedFields" value="Location" />')
    $changedValues = $('<input type="text" class="js-changed-values hide" name="ChangedValues" value="asdf" />')
    $saveButton = $el.find('.js-btn-save')
    $discardButton = $el.find('.js-btn-discard')
    $saveInfo = $el.find('.js-save-info');
    $form.append($el)

    $saveButton.val("Saved").attr('disabled',true);
    $saveInfo.text("Last saved " + lastSavedDate);
    $form.append($changedFields)
    $form.append($changedValues)

    $form.find("input,textarea").keyup ->
      console.log "formstate: input.keyup!"
      Unsaved()
      AddChange $("label[for='" + @id + "']").html(), $(this).attr("value")
      return

    $form.find("select").on "change", ->
      console.log "formstate: select.change!"
      if @id isnt "AuthLevel" and @id isnt "StatusChanger" and @id isnt "CatAdder"
        Unsaved()
        AddChange $("label[for='" + @id + "']").html(), $(this).selectedTexts()
      return

    $form.find("input[type='checkbox']").on "change", ->
      console.log "formstate: checkbox.check!"
      Unsaved()
      AddChange $(this).attr("name"), $(this).attr("id")
      return

    $form.find("input[type='radio']").on "click", ->
      console.log "formstate: radio.click!"
      Unsaved()
      AddChange $(this).attr("name"), $("label[for='" + @id + "']").html()
      return

    $discardButton.click ->
      $saveButton.attr("disabled", true).val "Saved"
      IsSaved = true
      ClearChanges()
      $(this).hide()
      return

    $form.submit ->
      $(this).ajaxSubmit
        type: "post"
        dataType: "json"
        beforeSubmit: ->
          $saveButton.val("Saving...").attr "disabled", true
          return
        success: (responseText, statusText) ->
          d = new Date()
          if responseText.STATUS is "false"
            $.each responseText.ERRORS, (i, item) ->
              addError item.MESSAGE, 250, 6000, 4000

            $saveButton.val("Save Now").attr "disabled", false
            IsSaved = false
          else
            $saveButton.val("Saved").attr "disabled", true
            $discardButton.hide()
            $saveInfo.text "Last saved at " + d.getHours() + ":" + d.getMinutes() + " "
            updatePublishState() if isPublishArea
            updateAll()
            ClearChanges()
            IsSaved = true
          return
      false

    question232 = $("#question232")
    TheLink = ""
    $(".PageStandard").hide()
    $(".TabControl a,#HeaderNav a,#HeaderSubNav a,#Breadcrumbs a,a.LeaveLink").bind "click", this, ->
      TheLink = @href
      unless IsSaved
        $.extend $.blockUI.defaults.overlayCSS,
          backgroundColor: "#000"

        $.blockUI
          message: question232
          width: "275px"

        false

    $("#yes").click ->
      $.unblockUI()
      window.location = TheLink
      return

    $("#no").click $.unblockUI
    $("a.button").unbind "click"
    return

  FCKeditor_OnComplete = (editorInstance) ->
    if document.all
      # IE
      editorInstance.EditorDocument.attachEvent "onkeyup", Unsaved
    else
      # other browser
      editorInstance.EditorDocument.addEventListener "keyup", Unsaved, true
    return
  Unsaved = ->
    console.log "formstate: Unsaved called!"
    console.log "isSaved already? #{IsSaved}"
    if IsSaved
      $saveButton.attr("disabled", false).val "Save Now"
      $discardButton.show()
    
    #AutoSave();
    IsSaved = false
    return

  AddChange = (sField, sValue) ->
    sValue = "%20"  if sValue is ""
    unless $.ListFind(ChangedFields, sField, "|")
      ChangedFields = $.ListAppend(ChangedFields, sField, "|")
      ChangedValues = $.ListAppend(ChangedValues, sValue, "|")
    else
      nLocation = $.ListFind(ChangedFields, sField, "|")
      ChangedValues = $.ListSetAt(ChangedValues, nLocation, sValue, "|")
    $changedFields.val ChangedFields
    $changedValues.val ChangedValues
    return

  # console.log(ChangedFields + ' ' + ChangedValues);
  ClearChanges = ->
    ChangedFields = ""
    ChangedValues = ""
    $changedFields.val ""
    $changedValues.val ""
    IsSaved = true
    return

  pub =
    init: _init
