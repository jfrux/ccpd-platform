###!
* ACTIVITY > ACCME
###
App.activity.accme = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: accme"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init