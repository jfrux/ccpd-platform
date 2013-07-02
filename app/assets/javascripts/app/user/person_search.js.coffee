###!
* PERSON > SEARCH
###
App.module "User.PersonSearch", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
  @on "before:start", ->
    App.logInfo "starting: Person.#{Self.moduleName}"
    return

  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Person.#{Self.moduleName}"
    return

  @on "stop", ->
    App.logInfo "stopped: Person.#{Self.moduleName}"
    return
  
  _init =  (defaults) ->
    return