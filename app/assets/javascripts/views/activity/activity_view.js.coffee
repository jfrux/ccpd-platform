###
* ACTIVITY HUB VIEW
*=require ../hub_view
###
App.module "Views",(Views,App,Backbone,Marionette) ->
  class Views.ActivityView extends Views.HubView
    el: ".hub .activity"
    initialize: ->
  return