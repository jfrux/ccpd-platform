###
* HUB VIEW (Represents top level sections of the app such as 'Activity' and 'Person')
###
App.module "Views",(Views,App,Backbone,Marionette) ->
  class Views.HubView extends Marionette.ItemView
    template: 'hub'

    initialize: ->