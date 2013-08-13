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
    
    #App.logDebug link.data('pjax-container')
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