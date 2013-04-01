###
* ACTIVITY > COMMITTEE
###
App.activity.committee = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: committee"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init