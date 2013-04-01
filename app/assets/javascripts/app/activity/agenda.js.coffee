###!
* ACTIVITY > AGENDA
###
App.activity.agenda = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: agenda"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init