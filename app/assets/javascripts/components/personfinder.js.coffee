###!
* Components > PersonFinder
###
App.module "Components.PersonFinder", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
  class @PersonFinder extends Backbone.View
    constructor:(options) ->
      options = options || {}
      @options = options

      super

    el: ""
    events:
      "click .dialog-content": "clickTest"

    clickTest: ->
      alert "click"

    loadMarkup: (callback) ->
      cb = callback
      $.ajax
        url:@options.url
        type:'get'
        data:
          instance:@options.instance
          activity:@options.activityid
        success:(data) ->
          cb(data)
    render: ->
      loadMarkup (data)->
        @$el.html($(data))
        
      this

    initialize: ->