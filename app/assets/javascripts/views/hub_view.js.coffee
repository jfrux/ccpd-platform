###
* HUB VIEW (Represents top level sections of the app such as 'Activity' and 'Person')
###
class App.Views.HubInfobarView extends Marionette.ItemView
  template: 'hub/infobar_view'

class App.Views.HubLinkbarItemView extends Marionette.ItemView
  tagName:'li'
  template:'hub/linkbar_item_view'
  ui:
    link:'a'
  events:
    'click a':'linkClicked'
  
  linkClicked: (e) ->
    link = $(e.currentTarget)
    excludedModules = "Folders,Stats".split(',')
    $.each App[@options.hub.type.capitalize()].submodules, (i,module) ->
      if excludedModules.indexOf(i) == -1
        module.stop()
      return
    
    #if key, add it to the url
    if @options.hub.hasKey()
      link.attr('href',"#{link.attr('href')}?#{@options.hub.type}id=#{@options.hub.model.get('id')}")
    App.logDebug link.data('pjax-container')
    container = link.data('pjax-container')
    $(".content-inner").wrapInner("<div id='#{container.replace('#','')}'></div>")
    $.pjax.click(e, {container: container})
    
  onRender: ->
    console.log "rendered link"
    console.log @ui.link
    @ui.link = @ui.link
    @ui.link.on "click", (e) ->
      $link = $(this)
      
      e.preventDefault()

    if !Modernizr.touch
      @ui.link.tooltip
        placement:'right'
        html:true
        title: (e)->
          $(this).attr('data-tooltip-title')
        container: 'body'

class App.Views.HubLinkbarView extends Marionette.CollectionView
  el:".hub .js-hub-menu ul.nav"
  buildItemView: (item, ItemViewType, itemViewOptions) ->
    # build the final list of options for the item view type
    options = _.extend({model: item}, itemViewOptions)
    
    # create the item view instance
    view = new App.Views.HubLinkbarItemView(options)
    
    # return it
    return view
  triggers:
    "click a": "linkbar:clicked"
  itemView:App.Views.HubLinkbarItemView

class App.Views.HubView extends Marionette.ItemView
  #template: 'hub'
  el: ".hub"
  LinkbarView:App.Views.HubLinkbarView
  InfobarView:App.Views.HubInfobarView
  type: "undefined"
  hasKey: ->
    return true if @model.get('id')
  initialize: ->
    super
    hub = @
    
    @linkbar = new @LinkbarView
      collection:@options.linkbarCollection
      itemViewOptions:
        'hub': hub
    @infobar = new @InfobarView

    console.log "Hub View Initialized!"

    @linkbar.on "collection:rendered",->
      console.log "rendered linkbar!"
    
    @linkbar.render()
    console.log @linkbar