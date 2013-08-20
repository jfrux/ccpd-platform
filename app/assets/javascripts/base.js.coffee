Backbone.Marionette.Renderer.render = (template, data) ->
  throw "Template '" + template + "' not found!"  unless JST[template]
  JST[template] data

root = this

root.App = new Backbone.Marionette.Application()
App.Views = {}
App.Collections = {}
App.Models = {}

App.addInitializer (options)->
  socketIOScript = App.config.get('realtimeUrl') + "socket.io/socket.io.js"
  $.getScript socketIOScript,(script,textStatus,jqXHR) ->
    App.rt = io.connect(App.config.get('realtimeUrl'));
    currentUrl = $("<a></a>").attr('href',window.location.href)
    console.log currentUrl
    settings = 
      channel: App.Main.model.get('id') + "_" + $.cookie("CFID") + "_" + $.cookie("CFTOKEN")
    App.rt.on "ready",() ->
      App.rt.emit('boot',settings);
      
  
  
App.on "start", ->
  console.info "started: Application"
  

App.addRegions
  header: "#header"
  navbar: "#header > .navbar"
  content: "#content > .container > .content-inner"
  footer: "#footer"
  mainContent: "#Content"
