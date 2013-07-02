###!
* ACTIVITY > PUBLISH > CATEGORIES
###
App.module "Activity.Publish.Categories", (Self, App, Backbone, Marionette, $) ->
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
      el:'#js-activity-pubcategory .js-formstate'
      saved: true