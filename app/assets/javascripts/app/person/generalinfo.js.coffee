###
* PERSON > GENERAL INFORMATION
###
App.module "Person.GeneralInfo", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false

  FormState = null

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
    #FormState.stop()
    FormState = null
    return

  _init = () ->
    # $(".linkbar a").one "click",->
    #   Self.stop()
    #   return true
    FormState = new App.Components.FormState
      el:'#js-person-detail .js-formstate'
      saved: true
    return