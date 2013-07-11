App.module "Models",(Models,App,Backbone,Marionette) ->
  class Models.Person extends Backbone.Model
    url: '/api/person/getPerson'