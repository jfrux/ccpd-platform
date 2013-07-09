###!
* ACTIVITY > PUBLISH > SPECIALTIES
###
App.module "Activity.Publish.Specialties", (Self, App, Backbone, Marionette, $) ->
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
    #FormState.stop();
    FormState = null
    return

  _init = (defaults) ->
    FormState = new App.Components.FormState
      el:'#js-activity-pubspecialty .js-formstate'
      saved: true
