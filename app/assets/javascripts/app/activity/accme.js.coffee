###!
* ACTIVITY > ACCME
###
App.module "Activity.ACCME", (Self, App, Backbone, Marionette, $) ->
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

  _init = (defaults) ->
    #App.logInfo "init: accme"
