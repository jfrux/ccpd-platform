App.module "Models",(Models,App,Backbone,Marionette) ->
  class Models.Activity extends Backbone.Model
    url: '/api/activity/getActivity'