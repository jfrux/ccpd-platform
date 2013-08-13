###
* HUB VIEW (Represents top level sections of the app such as 'Activity' and 'Person')
###
class App.Views.HubView extends Marionette.ItemView
  #template: 'hub'
  el: ".hub"
  LinkbarView:App.Views.HubLinkbarView
  InfobarView:App.Views.HubInfobarView
  type: "undefined"
  hasKey: ->
    return true if @model.get('id')
  
  showInfobar: ->
    $spanDiv = @infobar.$el.parent()
    App.setCookie 'prefInfoBar',true,
      path:'/'
      expires:7
    console.log "infobar cookie: #{App.getCookie('prefInfoBar')}"
    @ui.infobarToggle.addClass('active')
    @$el.removeClass('infobar-inactive').addClass('infobar-active')
    return

  hideInfobar: ->    
    @ui.infobarToggle.removeClass('active')
    App.setCookie 'prefInfoBar',false,
      path:'/'
      expires:7
    console.log "infobar cookie: #{App.getCookie('prefInfoBar')}"
    $spanDiv = @infobar.$el.parent()    
    @$el.removeClass('infobar-active').addClass('infobar-inactive')
    return

  enableSwipe: ->
    @linkbar.$el.swipeThis
      'fillContainer': false
      'multiple': true
      'itemWidth': 92
      'itemHeight': 80
      'marginRight': 12
  disableSwipe: ->
    $linkbar = @linkbar.$el
    $linkbar.swipeThis('destroy')

  initialize: ->
    super
    hub = @
    @ui = 
      titlebar:@$(".hub-body .titlebar .title-text")
      contentTitlebar:@$(".hub-content .content-title h3")
      infobarToggle: @$(".js-toggle-infobar")
      actionButtons: @$(".action-buttons a.btn, .action-buttons button.btn")

    @linkbar = new @LinkbarView
      collection:@options.linkbarCollection
      itemViewOptions:
        'hub': hub
    @infobar = new @InfobarView

    @linkbar.on "collection:rendered",->
      #console.log "rendered linkbar!"
    
    @linkbar.render()
    
    $(document).on 'pjax:send',(xhr,options) ->
      $clickedLink = $(xhr.relatedTarget)
      $parent = $clickedLink.parent()
      $parent.addClass('loading')
      return

    $(document).on 'pjax:timeout', (e) ->
      e.preventDefault()
      return

    $(document).on 'pjax:complete',(xhr, options, textStatus) ->
      $clickedLink = $(xhr.relatedTarget)
      $pageTitle = $clickedLink.data('pjax-title')
      $contentArea = $(xhr.target)
      $contentTitle = hub.ui.contentTitlebar
      $contentTitle.text($pageTitle)
      #hub.ui.titlebar.text($pageTitle)
      $parent = $clickedLink.parent()
      document.title = "#{$pageTitle}";
      $parent.find('.active').removeClass('active')
      $parent.siblings().removeClass('active')
      $clickedLink.children().removeClass('active')
      $parent.addClass('active')
      $parent.removeClass('loading')
      #$menuLoader.spin(false)
      return

    @ui.infobarToggle.on "click",(e) ->
      $btn = $(this)
      if $btn.hasClass('active')
        hub.hideInfobar()
      else
        hub.showInfobar()
      return

    if !Modernizr.touch
      @ui.titlebar.tooltip
        placement: 'bottom'
        trigger:'hover focus'
        container: 'body'
        title: (e)->
          $(this).text()
      @ui.actionButtons.tooltip
        placement: 'bottom'
        trigger: 'hover focus'
        container: 'body'

    if App.getCookie('prefInfoBar')
      @showInfobar()
    else
      @hideInfobar()
    
    if App.respond.test.medium()
      @enableSwipe()
    App.respond.medium.addListener ->
      mql = App.respond.medium

      if mql.matches
        hub.enableSwipe()
      else
        hub.disableSwipe()