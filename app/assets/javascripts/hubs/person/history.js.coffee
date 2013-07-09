###
* PERSON > HISTORY
###
App.module "Person.History", (Self, App, Backbone, Marionette, $) ->
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

  _init = () ->
    @feed = new App.Components.NewsFeed
      el:'#js-person-history .js-newsfeed'
      defaultMode:'personAll'
      hub:'person'
      modes:[
        "personAll"
        "personFrom"
        "personTo"
      ]
      queryParams:
        personFrom:App.Person.model.get('id')
        personTo:App.Person.model.get('id')
    return

  