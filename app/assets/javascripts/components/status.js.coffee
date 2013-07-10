###!
* STATUS MANAGER
###
App.module "Components.Status", (Self, App, Backbone, Marionette, $) ->
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

  _init = () ->
    return

  Self.addMessage = (message,fadein,fadeto,fadeout) ->
    App.logInfo "adding status message: '#{message}'"
    $.jGrowl message,
      life: fadeto
      openDuration: fadein
      closeDuration: 100
      themeState: 'normal'
    return

  Self.addError = (message,fadein,fadeto,fadeout) ->
    App.logInfo "adding error message: '#{message}'"
    $.jGrowl message,
      header: 'ERROR!'
      life: fadeto
      openDuration: fadein
      closeDuration: 100
      themeState: 'error'
    return
  return