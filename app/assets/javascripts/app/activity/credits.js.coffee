###!
* ACTIVITY > CREDITS
###
App.activity.credits = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: credits"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init