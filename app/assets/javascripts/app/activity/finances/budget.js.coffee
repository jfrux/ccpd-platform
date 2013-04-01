###!
* ACTIVITY > FINANCES > BUDGET
###
App.activity.finbudget = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: finances > budget"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init