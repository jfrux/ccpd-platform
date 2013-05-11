###!
* USER > NEWSFEED
###
App.module "User.NewsFeed", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  Self = @
  getListAuto = null

  @on "before:start", ->
    App.logInfo "starting: User.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: User.#{Self.moduleName}"
    return
  @on "stop", ->
    App.logInfo "stopped: User.#{Self.moduleName}"
    return

  _init = () ->
    Self.feed = new App.Components.NewsFeed
      el:'#js-main-welcome .js-newsfeed'
      defaultMode:'personTo'
      hub:'user'
      modes:[
        "personTo"
        "personFrom"
      ]
      queryParams:
        personTo:App.User.model.get('id')
        personFrom:App.User.model.get('id')

    
    getListAuto = Self.getListAuto = () ->
      currTime = Math.round(new Date().getTime() / 1000)
      Self.feed.lister.getList(false,currTime,'prepend')

    setInterval("App.User.NewsFeed.getListAuto()",5000);
    return  