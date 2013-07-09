###!
* ACTIVITY > CREDITS
###
App.module "Activity.Credits", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
  @on "before:start", ->
    App.logInfo "starting: #{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: #{Self.moduleName}"
    return
  @on "stop", ->
    App.logInfo "stopped: #{Self.moduleName}"
    return

  $saveButton = null
  $form = null

  _init = (defaults) ->
    App.logInfo "init: credits"
    $form = $(".js-form-credits")
    $saveButton = $(".js-credits-save")

    $saveButton.click ->
      $form.submit()
      return false

    $form.submit ->
      $(this).ajaxSubmit
        type: "get"
        dataType: 'json'
        beforeSubmit: ->
          $saveButton.text("Saving...").attr "disabled", true
          return
        success: (responseText, statusText) ->
          d = new Date()
          if responseText.STATUS
            $saveButton.text("Save Credits").attr "disabled", false
            addMessage "Saved credits successfully.", 250, 2000, 2000
            #$discardButton.hide()
            #$saveInfo.text "Last saved at " + d.getHours() + ":" + d.getMinutes() + " "
            #updatePublishState() if isPublishArea
            #updateAll()
            #ClearChanges()
            #IsSaved = true
          else
            $.each responseText.ERRORS, (i, item) ->
              addError item.MESSAGE, 250, 6000, 4000

            $saveButton.text("Save Now").attr "disabled", false
            #IsSaved = false
          return
      false

    $(".CreditBox").each ->
      nCreditID = $.Replace(@id, "Credits", "", "ALL")
      if $(this).attr("checked")
        $("#CreditAmount" + nCreditID).attr "disabled", false
        $("#ReferenceNo" + nCreditID).attr "disabled", false
      else
        $("#CreditAmount" + nCreditID).attr "disabled", true
        $("#ReferenceNo" + nCreditID).attr "disabled", true

    $(".CreditBox").click ->
      nCreditID = $.Replace(@id, "Credits", "", "ALL")
      if $(this).attr("checked")
        $("#CreditAmount" + nCreditID).attr "disabled", false
        $("#ReferenceNo" + nCreditID).attr "disabled", false
      else
        $("#CreditAmount" + nCreditID).attr "disabled", true
        $("#ReferenceNo" + nCreditID).attr "disabled", true
