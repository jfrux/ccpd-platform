###!
* STATUS MANAGER
###
App.module "Components.Status", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false

  @on "before:start", ->
    console.log "starting: #{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      console.log "started: #{Self.moduleName}"
    return
  @on "stop", ->
    console.log "stopped: #{Self.moduleName}"
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