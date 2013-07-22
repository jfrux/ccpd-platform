###!
* USER
###
App.module "Main",
  startWithParent: false
  define: (Main, App, Backbone, Marionette, $) ->
    cShowInfobar = null
    $profile = null
    $projectBar = null
    $contentArea = null
    $infoBar = null
    $infoBarToggler = null
    $contentToggleSpan = null
    $infoBarToggleSpan = null
    $statusChanger = null
    $statusIcon = null
    $titlebar = null
    $statusBox = null
    $menuBar = null
    defaultFolders = null

    Main.on "before:start", ->
      App.logInfo "starting: #{Main.moduleName}"
      return

    Main.on "start", (options) ->
      $(document).ready ->
        _init(options)
        App.logInfo "started: #{Main.moduleName}"
      return

    Main.on "stop", ->
      App.logInfo "stopped: #{Main.moduleName}"
      return
    class Model extends Backbone.Model
      url: '/api/'

    class InfobarView extends App.Views.HubInfobarView

    class LinkbarView extends App.Views.HubLinkbarView

    class MainView extends App.Views.HubView
      el: ".hub .main"
      type:'main'
      InfobarView:InfobarView
      LinkbarView:LinkbarView
      initialize: ->
        _.bindAll @
        super

    Main._init = _init = (settings) ->
      model = Main.model = new Model(settings.model)
      @hubView = new MainView
        model:model
        linkbarCollection:new App.Collections.LinkbarCollection(settings.linkbarSettings.tabArray)
        el:'.hub'
      $profile = $(".profile")
      $titlebar = $profile.find(".titlebar .ContentTitle span")
      $infoBar = $(".js-infobar")
      $projectBar = $(".js-projectbar")
      $menuBar = $(".js-profile-menu > div > div > ul")
      $contentArea = $(".js-profile-content")
      $contentToggleSpan = $(".js-content-toggle")
      $infoBarToggleSpan = $(".js-infobar-outer")
      $menuLinks = $menuBar.find('a')

      return
    return