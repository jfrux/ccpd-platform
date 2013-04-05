###!
* ACTIVITY > FINANCES > BUDGET
###
App.module "Activity.Finances.Budget", (Self, App, Backbone, Marionette, $) ->
  _init = (defaults) ->
    console.log "init: finances > budget"

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init