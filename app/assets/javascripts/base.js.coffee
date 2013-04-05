root = this

app = do({$,Backbone} = window) ->
    _init = ->
      App.status.init()
      App.trigger('init')
      return
      
    _.extend({
      init: _init
      components:{}
    },Backbone.Events)
root.App = root.App || app
App.on "init", ->
  console.log("init: application")