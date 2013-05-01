###!
* FORM STATE MANAGEMENT
###

App.module "Components.FormState", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
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

  @on "before:start", ->
    App.logInfo "starting: #{Self.moduleName}"

  @on "start", (IsSaved) ->
    $(document).ready ()->
      _init(IsSaved)
      App.logInfo "started: #{Self.moduleName}"
      return
    return
  @on "stop", ->
    App.logInfo "stopped: #{Self.moduleName}"
    $form.unbind()
    $form.empty()
    $.each CKEDITOR.instances, (i,val) ->
      if (CKEDITOR.instances[i]) 
        CKEDITOR.instances[i].destroy()

      return
    #$form.remove()
    
    return
  _init = (IsSaved) ->
    App.logDebug "binding formstate"
    $form = $('.js-formstate')
    $el = $('<div class="ViewSectionButtons control-group">
            <div class="controls">
              <input type="submit" value="Save Now" name="btnSave" class="btn btn-primary js-btn-save" /> 
              <input style="display:none;" type="reset" value="Discard" name="btnDiscard" class="btn js-btn-discard" /> 
              <span class="SaveInfo js-save-info"></span>
            </div>
          </div>')
    $changedFields = $('<input type="text" class="js-changed-fields hide" name="ChangedFields" value="" />')
    $changedValues = $('<input type="text" class="js-changed-values hide" name="ChangedValues" value="" />')
    $saveButton = $el.find('.js-btn-save')
    $discardButton = $el.find('.js-btn-discard')
    $saveInfo = $el.find('.js-save-info');
    $form.append($el)

    $saveButton.val("Saved").attr('disabled',true);
    $saveInfo.text("Last saved " + lastSavedDate);
    $form.append($changedFields)
    $form.append($changedValues)

    $form.find("input,textarea").keyup ->
      App.logInfo "formstate: input.keyup!"
      Self.Unsaved()
      Self.AddChange $(this).attr('name'), $(this).attr("value")
      return
    $form.find("button").click ->

      return false

    $form.find(".DatePicker").datepicker
      showOn: "button"
      buttonImage: "/admin/_images/icons/calendar.png"
      buttonImageOnly: true
      showButtonPanel: true
      changeMonth: true
      changeYear: true
      onSelect: ->
        Self.Unsaved()
        Self.AddChange $("label[for='" + @id + "']").html(), $(this).val()

    $form.find("select").on "change", ->
      App.logInfo "formstate: select.change!"
      if @id isnt "AuthLevel" and @id isnt "StatusChanger" and @id isnt "CatAdder"
        Self.Unsaved()
        Self.AddChange $("label[for='" + @id + "']").html(), $(this).selectedTexts()
      return

    $form.find("input[type='checkbox']").on "change", ->
      App.logInfo "formstate: checkbox.check!"
      Self.Unsaved()
      Self.AddChange $(this).attr("name"), $(this).attr("id")
      return

    $form.find("input[type='radio']").on "click", ->
      App.logInfo "formstate: radio.click!"
      Self.Unsaved()
      AddChange $(this).attr("name"), $("label[for='" + @id + "']").html()
      return

    $discardButton.click ->
      $saveButton.attr("disabled", true).val "Saved"
      IsSaved = true
      $.each CKEDITOR.instances, (i,val) ->
        #App.logDebug i
        $elem = $("#" + i)
        #App.logDebug $elem
        fieldName = $elem.attr('name');
        #App.logDebug fieldName
        #App.logDebug editor
        CKEDITOR.instances[i].setData $elem.val()
        return
      Self.ClearChanges()
      $(this).hide()
      return true

    $form.find(".js-ckeditor").each ->
      id = $(this).attr('id')
      console.log id
      CKEDITOR.replace id,
        on:
          blur: (evt) ->
            $editor = $(@container.$)
            $editor.find(".cke_top").addClass "hide"

          focus: (evt) ->
            $editor = $(@container.$)
            $editor.find(".cke_top").removeClass "hide"

          instanceReady: (evt) ->
            $editor = $(@container.$)
            $editor.find(".cke_top").addClass "hide"

      

    $.each CKEDITOR.instances, (i,val) ->
      #App.logDebug i
      $elem = $("#" + i)
      #App.logDebug $elem
      fieldName = $elem.attr('name');
      #App.logDebug fieldName
      #App.logDebug editor
      CKEDITOR.instances[i].on "instanceReady", () ->
        #Set keyup event
        this.document.on "keyup", updateValue
        #Set paste event
        this.document.on "paste", updateValue

        return
      updateValue = ->
        CKEDITOR.instances[i].updateElement();
        $elem.trigger('keyup')
        return
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
            #updatePublishState() if isPublishArea
            #App.Activity.updateAll()
            Self.ClearChanges()
            IsSaved = true
            addMessage "Activity Details saved!", 250, 6000, 4000
          return
      false

    question232 = $("#question232")
    TheLink = ""
    $(".PageStandard").hide()
    # $("#HeaderNav a,#HeaderSubNav a,#Breadcrumbs a,a.LeaveLink").bind "click", this, ->
    #   TheLink = @href
    #   unless IsSaved
    #     #$.extend $.blockUI.defaults.overlayCSS,
    #     #  backgroundColor: "#000"

    #     # $.blockUI
    #     #   message: question232
    #     #   width: "275px"

    #     false

    # $("#yes").click ->
    #   #$.unblockUI()
    #   window.location = TheLink
    #   return

    # $("#no").click $.unblockUI
    # $("a.button").unbind "click"
    # return
  Self.Unsaved = Unsaved = ->
    App.logInfo "formstate: Unsaved called!"
    App.logInfo "isSaved already? #{IsSaved}"
    if IsSaved
      $saveButton.attr("disabled", false).val "Save Now"
      $discardButton.show()
    
    #AutoSave();
    IsSaved = false
    return

  Self.AddChange = AddChange = (sField, sValue) ->
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

  # App.logInfo(ChangedFields + ' ' + ChangedValues);
  Self.ClearChanges = ClearChanges = ->
    ChangedFields = ""
    ChangedValues = ""
    $changedFields.val ""
    $changedValues.val ""
    IsSaved = true
    return

  pub =
    init: _init
