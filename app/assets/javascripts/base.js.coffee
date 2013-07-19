Backbone.Marionette.Renderer.render = (template, data) ->
  throw "Template '" + template + "' not found!"  unless JST[template]
  JST[template] data

root = this

root.App = new Backbone.Marionette.Application()
App.Views = {}
App.Collections = {}
App.Models = {}

_init = () ->
  #Backbone.history.start({pushState: true, root: "/admin/event/"})
  #console.log "test"


App.addInitializer (options)->
  _init()

App.on "start", ->
  console.info "started: Application"

App.addRegions
  header: "#header"
  navbar: "#header > .navbar"
  content: "#content > .container > .content-inner"
  footer: "#footer"
  mainContent: "#Content"

App.start()