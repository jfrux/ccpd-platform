root = this

root.App = do({$,Backbone} = window) ->
    _init = ->
      console.log("init: application")

    _.extend({
      init: _init
    },Backbone.Events)