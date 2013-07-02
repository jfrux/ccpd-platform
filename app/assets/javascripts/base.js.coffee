root = this

root.App = new Backbone.Marionette.Application()

_init = () ->
  #Backbone.history.start({pushState: true, root: "/admin/event/"})
  #console.log "test"


App.addInitializer (options)->
  _init()

App.on "start", ->
  console.info "started: Application"

App.addRegions
  navbar: ".navbar:first"
  mainContent: "#Content"

App.start()