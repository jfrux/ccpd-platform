###
* ACTIVITY > HISTORY
###
App.module "Activity.History", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
  @on "before:start", ->
    App.logInfo "starting: Activity.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Activity.#{Self.moduleName}"
    return
  @on "stop", ->
    App.logInfo "stopped: Activity.#{Self.moduleName}"
    return

  _init = () ->
    @feed = new App.Components.NewsFeed
      el:'#js-activity-history .js-newsfeed'
      defaultMode:'activityTo'
      hub:'activity'
      modes:[
        "activityAll"
      ]
      queryParams:
        activityTo:App.Activity.model.get('id')
    return

  