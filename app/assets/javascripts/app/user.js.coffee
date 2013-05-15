###!
* USER
###
App.module "User",
  startWithParent: false
  define: (Self, App, Backbone, Marionette, $) ->
    cShowInfobar = null
    $profile = null
    $projectBar = null
    $contentArea = null
    $infoBar = null
    $infoBarToggler = null
    $contentToggleSpan = null
    $infoBarToggleSpan = null
    $statusChanger = null
    $statusIcon = null
    $titlebar = null
    $statusBox = null
    $menuBar = null
    defaultFolders = null

    Self.on "before:start", ->
      App.logInfo "starting: #{Self.moduleName}"
      return

    Self.on "start", (options) ->
      $(document).ready ->
        _init(options)
        App.logInfo "started: #{Self.moduleName}"
      return

    Self.on "stop", ->
      App.logInfo "stopped: #{Self.moduleName}"
      return
    
    Self.on "linkbar.click", (link,e) ->
      excludedModules = "".split(',')
      
      $.each Self.submodules, (i,module) ->
        if excludedModules.indexOf(i) == -1
          module.stop()
        return

      container = link.data('pjax-container')

      $(".content-inner").wrapInner("<div id='#{container.replace('#','')}'></div>")
      $.pjax.click(e, {container: container})
      
      return

    Self._init = _init = (settings) ->
      Self.model = new App.Models.Person(settings.model)
      
      $profile = $(".profile")
      $titlebar = $profile.find(".titlebar .ContentTitle span")
      $infoBar = $(".js-infobar")
      $projectBar = $(".js-projectbar")
      $menuBar = $(".js-profile-menu > div > div > ul")
      $contentArea = $(".js-profile-content")
      $contentToggleSpan = $(".js-content-toggle")
      $infoBarToggleSpan = $(".js-infobar-outer")
      $menuLinks = $menuBar.find('a')

      $(document).on 'pjax:send',(xhr,options) ->
        return
      
      $(document).on 'pjax:timeout', (e) ->
        e.preventDefault()
        return

      $(document).on 'pjax:complete',(xhr, options, textStatus) ->
        $clickedLink = $(xhr.relatedTarget)
        $pageTitle = $clickedLink.data('pjax-title')
        $contentArea = $(xhr.target)
        $contentTitle = $contentArea.parents('.js-profile-content').find('.content-title > h3')
        $contentTitle.text($pageTitle)
        $titlebar.text($pageTitle)
        $parent = $clickedLink.parent()
        $parent.find('.active').removeClass('active')
        $parent.siblings().removeClass('active')
        $clickedLink.children().removeClass('active')
        $parent.addClass('active')
        return

      App.logInfo "InfoBar: #{cShowInfobar}"

      
      $(".ContentTitle span").tooltip
        placement: 'bottom'
        trigger:'hover focus'
        container: 'body'
      
      $menuLinks.on "click", (e) ->
        $link = $(this)
        Self.trigger('linkbar.click',$link,e)
        return

      $menuLinks.tooltip
        placement: 'right'
        html: 'true'
        trigger: 'hover focus'
        title: (e)->
          $(this).attr('data-tooltip-title')
        container: 'body'
      
      $(".action-buttons a.btn, .action-buttons button.btn").tooltip
        placement: 'bottom'
        trigger: 'hover focus'
        container: 'body'
      return
    return