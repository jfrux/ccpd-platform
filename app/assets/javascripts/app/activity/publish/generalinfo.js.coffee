###!
* ACTIVITY > PUBLISH > GENERAL INFO
###
App.module "Activity.Publish.General", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  FormState = null
  
  @on "before:start", ->
    App.logInfo "starting: Publish.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Publish.#{Self.moduleName}"
    return
  @on "stop", ->
    App.logInfo "stopped: Publish.#{Self.moduleName}"
    $.each Self.submodules, (i,module) ->
      module.stop()
      return
    #FormState.stop();
    return

  _init = (defaults) ->
    FormState = new App.Components.FormState
      el:'.js-form-publish'
      saved: true
