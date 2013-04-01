###!
* ACTIVITY > NOTES
###
App.activity.notes = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: notes"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init