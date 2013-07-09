class DialogRegion extends Marionette.Region
    el: "#RegionDialog"

    constructor: ->
        _.bindAll this
        Backbone.Marionette.Region::constructor.apply this, arguments
        @on 'view:show', @showDialog, this

    getEl: (selector) ->
        $el = $(selector)
        $el.dialog
        $el.on "hidden", @close
        $el

    showDialog: (view) ->
        view.on "close", @hideDialog, this
        @$el.dialog "show"

    hideDialog: ->
        @$el.dialog "hide"


App.addRegions
  dialog: DialogRegion