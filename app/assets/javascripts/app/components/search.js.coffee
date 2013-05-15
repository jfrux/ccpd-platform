###!
* SEARCH CLASS
###
class App.Components.Search
  constructor: (@settings) ->
    App.logInfo "New Search: #{@settings.el}"
    @$base = $(@settings.el)
    Self = @
    Self = _.extend(Self,Backbone.Events)
    @$formEasy = @$base.find(".js-search-easy")
    @$formAdv = @$base.find(".js-search-adv")
    $tooltips = @$base.find("[data-tooltip-title]")
    
    @on "search",->
      App.logInfo "search: searched!"
      return

    @on "result",->
      App.logInfo "search: results!"
      return

    @on "ready",->
      App.logInfo "search: Ready!"
      return

    $tooltips.tooltip
      placement: 'top'
      html: 'true'
      trigger: 'hover focus'
      title: (e)->
        $(this).attr('data-tooltip-title')
      container: 'body'

    @$formEasy.submit ->
      $(this).ajaxSubmit
        type: "post"
        dataType: "json"
        beforeSubmit: ->
          #$saveButton.text(config.buttons.saving).removeClass('btn-primary').addClass('disabled').attr "disabled", true
          return
        success: (responseText, statusText) ->
          if !responseText.STATUS
            $.each responseText.ERRORS, (i, item) ->
              addError item.MESSAGE, 250, 6000, 4000

            # $saveButton.text(config.buttons.save).removeClass('disabled').attr "disabled", false
            # IsSaved = false
          else
            Self.trigger('search')
          return
      false

    @$formAdv.submit ->
      $(this).ajaxSubmit
        type: "post"
        dataType: "json"
        beforeSubmit: ->
          #$saveButton.text(config.buttons.saving).removeClass('btn-primary').addClass('disabled').attr "disabled", true
          return
        success: (responseText, statusText) ->
          if !responseText.STATUS
            $.each responseText.ERRORS, (i, item) ->
              addError item.MESSAGE, 250, 6000, 4000

            # $saveButton.text(config.buttons.save).removeClass('disabled').attr "disabled", false
            # IsSaved = false
          else
            Self.trigger('search')
          return
      false

    Self.trigger('ready')

    return Self