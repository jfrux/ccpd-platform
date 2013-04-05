###
* ACTIVITY > COMMITTEE
###
App.module "Activity.Committee", (Self, App, Backbone, Marionette, $) ->
  _init = (defaults) ->
    $(".linkbar a").one "click",->
      Self.stop()
      return true

  # OTHER FUNCTIONS GO BELOW HERE

  pub =
    init: _init