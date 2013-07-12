###
* PERSON HUB VIEW
###
App.module "Views",(Views,App,Backbone,Marionette) ->
  class Views.PersonView extends Views.HubView
    el: ".hub .person"
    initialize: ->
  return