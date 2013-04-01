###!
* ACTIVITY > CHECKLIST
###
App.activity.checklist = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: checklist"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init