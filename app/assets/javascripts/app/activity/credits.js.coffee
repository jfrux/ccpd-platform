###!
* ACTIVITY > CREDITS
###
App.module "Activity.Credits", (Self, App, Backbone, Marionette, $) ->
  $saveButton = null
  $form = null
  _init = (defaults) ->
    console.log "init: credits"
    $form = $(".js-form-credits")
    $saveButton = $(".js-credits-save")

    $saveButton.click ->
      $form.submit()
      return false

    $form.submit ->
      $(this).ajaxSubmit
        type: "get"
        beforeSubmit: ->
          $saveButton.val("Saving...").attr "disabled", true
          return
        success: (responseText, statusText) ->
          d = new Date()
          if responseText.STATUS is "false"
            $.each responseText.ERRORS, (i, item) ->
              addError item.MESSAGE, 250, 6000, 4000

            $saveButton.val("Save Now").attr "disabled", false
            #IsSaved = false
          else
            $saveButton.val("Saved").attr "disabled", true
            $discardButton.hide()
            $saveInfo.text "Last saved at " + d.getHours() + ":" + d.getMinutes() + " "
            updatePublishState() if isPublishArea
            updateAll()
            ClearChanges()
            #IsSaved = true
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

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init