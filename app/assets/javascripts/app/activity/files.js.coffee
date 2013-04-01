###
* ACTIVITY > FILES & DOCS
###
App.activity.files = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: files & docs"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init