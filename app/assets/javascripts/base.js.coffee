root = this

root.App = new Backbone.Marionette.Application();

_init = () ->
  console.log "test"

App.addInitializer (options)->
  _init

App.on "start", ->
  console.log "started: application"

App.addRegions
  navbar: ".navbar:first"
  mainContent: "#Content"

App.start()