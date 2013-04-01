root = this

app = do({$,Backbone} = window) ->
    _init = ->
      console.log "init: application"
      App.status.init()

    _.extend({
      init: _init
      components:{}
    },Backbone.Events)
root.App = root.App || app