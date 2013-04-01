###!
* ACTIVITY > FINANCES > FEES
###
App.activity.finfees = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: finances > fees"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init