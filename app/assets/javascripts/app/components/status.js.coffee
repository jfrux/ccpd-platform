###!
* STATUS MANAGER
###
App.module "Components.Status", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
  @addInitializer ->
    $(document).ready ()->
      _init()
      return
    return
  @on "before:start", ->
    console.log "loaded: #{@moduleName}"
    return
  @on "start", ->
    console.log "started: #{@moduleName}"
    return

  _init = () ->
    return

  Self.addMessage = (message,fadein,fadeto,fadeout) ->
    console.log "adding status message: '#{message}'"
    $.jGrowl message,
      life: fadeto
      openDuration: fadein
      closeDuration: fadeout
      themeState: 'normal'
    return
  Self.addError = (message,fadein,fadeto,fadeout) ->
    console.log "adding error message: '#{message}'"
    $.jGrowl message
      header: 'ERROR!'
      life: fadeto
      openDuration: fadein
      closeDuration: fadeout
      themeState: 'error'
    return