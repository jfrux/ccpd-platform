###
* HUB VIEW (Represents top level sections of the app such as 'Activity' and 'Person')
###
App.module "Views",(Views,App,Backbone,Marionette) ->
  class Views.HubInfobarView extends Marionette.ItemView
    template: 'hub/infobar_view'
  
  class Views.HubLinkbarItemView extends Marionette.ItemView
    template: 'hub/linkbar_item_view'
  
  class Views.HubLinkbarView extends Marionette.CollectionView
    template: 'hub/linkbar_view'
    itemView: Views.HubLinkbarItemView

  class Views.HubView extends Marionette.ItemView
    #template: 'hub'
    el: ".hub"
    ui:
      picture: ".hub-bar .profile-picture"
      linkbar: ".hub-bar .linkbar .linkbar-inner"
    initialize: ->
