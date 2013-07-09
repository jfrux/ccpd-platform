###!
* ACTIVITY > PUBLISH
###
App.module "Activity.Publish", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  #FormState = null
  
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
    $.each Self.submodules, (i,module) ->
      module.stop()
      return
    #FormState.stop();
    return

  _init = (defaults) ->

    return