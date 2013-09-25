App.addInitializer ->
  App.jPanelMenu = $.jPanelMenu
    menu: $(".jpanel-nav"),
    trigger: 'a.navbar-toggle'
    excludedPanelContent:'#fb-root,script,uvOverlay1,.modal'
    before: ->
      console.log "test"
    afterOpen: ->
    afterClose: ->