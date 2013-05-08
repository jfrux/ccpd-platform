###!
* FORM STATE MANAGEMENT
###
class App.Components.FormState
  constructor: (@settings) ->
    App.logInfo "New FormState: #{settings.el}"
    Self = @
    Self = _.extend(Self,Backbone.Events)
    $form = $(@settings.el)
    $toolbar = $('<div class="toolbar btn-toolbar test"></div>')
    $toolbar.prependTo($form.parents('.content-inner :first'))

    $actions = $('<div class="ViewSectionButtons btn-group"></div>')
    $saveInfo = $('<div class="SaveInfo js-save-info"></div>')
    $saveButton = $('<a href="javascript://" class="btn btn-mini js-btn-save">Save Now</a>')
    $discardButton = $('<a class="btn btn-mini js-btn-discard">Cancel</a>')
    $saveButton.appendTo($actions)
    $inputs = $form.find(':input')
    $ckeditors = $form.find(".js-ckeditor")
    $saveInfo.appendTo($toolbar)
    $actions.appendTo($toolbar)
    $toolbar.removeClass('hide')
    $tooltips = $inputs.filter('[data-tooltip-title]')
    console.log $tooltips
    $changedFields = $('<input type="text" class="js-changed-fields hide" name="ChangedFields" value="" />')
    $changedValues = $('<input type="text" class="js-changed-values hide" name="ChangedValues" value="" />')
    $form.append($changedFields)
    $form.append($changedValues)
    $form.addClass('js-formstate formstate')
    ###!
    GROUPSETS SETUP / BINDING
    ###
    $groupsets = $form.find(".control-groupset")
    $groupsets.each ->
      $groupset = $(this)
      $groupsetTitle = $groupset.find('.groupset-title')
      $groupsetLink = $('<a></a>')
      
      $groupset.activate = ->
        $groupset.addClass('activated')
        return
      
      $groupset.deactivate = ->
        $groupset.removeClass('activated')
        return

      config = _.defaults $groupset.data(),
        'triggerText':"Edit #{$groupsetTitle.text()}" || "Edit"
        'defaultState':1
      
      $groupsetLink
        .attr('href','#')
        .addClass('js-groupset-link groupset-link')
        .text(config.triggerText)
        .appendTo($groupset)
        .on("click",->
          $groupset.activate()
          return
        )
      
      if config.defaultState
        $groupset.addClass('activated')
      else
        $groupset.removeClass('activated')
      return

    ###!
    TAB INDEX OVERRIDES
    ###
    $inputs.each (i,el) ->
      $el = $(el)
      $el.attr('tabindex',i+1)
      return

    @config = config =
      "buttons":
        "save":"Save Now"
        "saved":"Saved"
        "saving":"Saving..."

    @on "reset",->
      App.logInfo "formstate: reset!"

      return

    @on "beforeSave",->
      App.logInfo "formstate: beforeSave!"
      return

    @on "save",->
      App.logInfo "formstate: saved!"
      d = new Date()
      
      setInitialState()
      disableSave()
      $saveInfo.text "Last saved at " + d.getHours() + ":" + d.getMinutes() + " "
      Self.ClearChanges()
      IsSaved = true
      addMessage "Information saved!", 250, 6000, 4000
      return

    @on "ready",->
      App.logInfo "formstate: Ready!"
      return

    @on "change", (eventName,changePair) ->
      App.logInfo "formstate: change: #{eventName}"

      if isDirty()
        Self.AddChange changePair.field, changePair.value
        Unsaved()
      else
        resetForm()
      return

    IsSaved = @settings.saved || true
    isPublishArea = false # USED TO DETERMINE IF PUBLISH BAR IS UPDATED

    ChangedFields = ""
    ChangedValues = ""

    $tooltips.tooltip
      placement: 'right'
      html: 'true'
      trigger: 'hover focus'
      title: (e)->
        $(this).attr('data-tooltip-title')
      container: 'body'
    $saveInfo.html("Last saved " + lastSavedDate);

    $form.append($changedFields)
    $form.append($changedValues)

    $form.find("input,textarea").keyup ->
      change = 
        'field':$(this).attr('name')
        'value':$(this).val()
      
      Self.trigger('change','input.keyup!',change)
      return

    $form.find(".DatePicker").datepicker
      showOn: "button"
      buttonImage: "/admin/_images/icons/calendar.png"
      buttonImageOnly: true
      showButtonPanel: true
      changeMonth: true
      changeYear: true
      onSelect: ->
        change = 
          'field':$(this).attr('name')
          'value':$(this).val()
        
        Self.trigger('change','date.chosen!',change)
        return

    $form.find("select").on "change", ->
      change = 
        'field':$(this).attr('name')
        'value':$(this).selectedTexts()
      
      Self.trigger('change','select.change!',change)
      return

    $form.find("input[type='checkbox']").on "click", ->
      $this = $(this)
      value = '';
      if $this.attr('checked')
        value = $this.data('initialState')

      change = 
        'field':$(this).attr('name')
        'value':value
      
      Self.trigger('change','checkbox.checked!',change)
      return

    $form.find("input[type='radio']").on "click", ->
      change = 
        'field':$(this).attr('name')
        'value':$(this).val()
      
      Self.trigger('change','radio.checked!',change)
      return

    $discardButton.click ->
      resetForm()
      return true

    Self.setupCKEDITOR = setupCKEDITOR = ($input) ->
      $elem = $input
      id = $elem.attr('id')

      CKEDITOR.replace id,
        on:
          blur: (evt) ->
            $editor = $(@container.$)
            #$editor.find(".cke_top").addClass "hide"
            $editor.find(".cke_top").css 'display':''

          focus: (evt) ->
            $editor = $(@container.$)
            $editor.find(".cke_top").css 'display':'block'

          instanceReady: (evt) ->
            $editor = $(@container.$)
            #$editor.find(".cke_top").addClass "hide"
            #Set keyup event
            @document.on "keyup", updateValue
            #Set paste event
            @document.on "paste", updateValue
      updateValue = ->
        CKEDITOR.instances[id].updateElement();
        $elem.trigger('keyup')
        return
    $ckeditors.each ->
      setupCKEDITOR($(this))
      #console.log id
      
      return

    $form.submit ->
      $(this).ajaxSubmit
        type: "post"
        dataType: "json"
        beforeSubmit: ->
          $saveButton.text(config.buttons.saving).removeClass('btn-primary').addClass('disabled').attr "disabled", true
          return
        success: (responseText, statusText) ->
          if !responseText.STATUS
            $.each responseText.ERRORS, (i, item) ->
              addError item.MESSAGE, 250, 6000, 4000

            $saveButton.text(config.buttons.save).removeClass('disabled').attr "disabled", false
            IsSaved = false
          else
            Self.trigger('save')

          return
      false

    Self.isDirty = isDirty = ->
      _.some $inputs, (i) ->
        input = $(i);

        if input.val() != input.data('initialState')
          true
        else
          false
        

    Self.resetForm = resetForm = ->
      IsSaved = true
      
      $ckeditors.each ->
        $elem = $(this)
        id = $elem.attr('id')
        CKEDITOR.instances[id].destroy()

        setupCKEDITOR($elem)
        return
      # $.each CKEDITOR.instances, (i,val) ->
      #   #App.logDebug i
      #   $elem = $("#" + i)
      #   #App.logDebug $elem
      #   fieldName = $elem.attr('name');
      #   #App.logDebug fieldName
      #   #App.logDebug editor
      #   CKEDITOR.instances[i].setData $elem.val()
      #   return

      Self.ClearChanges()

      $inputs.each (i, elem) ->
        input = $(elem);
        input.val input.data('initialState')
        return

      disableSave()
      $discardButton.detach()

      Self.trigger('reset')
      return

    Self.disableSave = disableSave = ->
      $saveButton
        .removeClass('btn-primary')
        .attr("disabled", true)
        .addClass('disabled')
        .text(config.buttons.saved)
        .off()
      $discardButton.detach()
      return

    Self.enableSave = enableSave = ->
      $saveButton
        .attr("disabled", false)
        .removeClass('disabled')
        .text(config.buttons.save)
        .addClass('btn-primary')
        .on "click",(e) ->
          Self.trigger("beforeSave")
          $form.submit()
          e.preventDefault()
          return
      $discardButton.appendTo($actions)
      return

    Self.Unsaved = Unsaved = ->
      #App.logInfo "formstate: Unsaved!"
      #App.logInfo "isSaved already? #{IsSaved}"
      if IsSaved
        enableSave()
      App.logInfo "formstate: dirty: #{Self.isDirty()}"
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

    Self.setInitialState = setInitialState = ->
      $inputs.each (i, elem) ->
        input = $(elem);
        value = input.val();
        if input.attr('type') == 'checkbox'
          if input.attr('checked')
            value = true
          else
            value = false
        input.data('initialState', value);
      return

    Self.activateAllGroupsets = showAllGroupsets = ->
      $groupsets.each ->
        $(this).addClass('activated')
    
    Self.deactivateAllGroupsets = showAllGroupsets = ->
      $groupsets.each ->
        $(this).removeClass('activated')
    
    disableSave()
    #setup initial state
    setInitialState()
    Self.trigger('ready')

    return Self