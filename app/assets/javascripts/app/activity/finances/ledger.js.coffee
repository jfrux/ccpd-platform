###!
* ACTIVITY > FINANCES > LEDGER
###
App.activity.finledger = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: finances > ledger"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init