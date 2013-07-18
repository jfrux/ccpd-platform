App.addInitializer ->
  $(document).ready ->
    App.jPanelMenu = $.jPanelMenu
      menu: $(".jpanel-nav"),
      trigger: 'a.navbar-toggle'
      excludedPanelContent:'#fb-root,script,uvOverlay1,.modal'
      before: ->
      afterOpen: ->
      afterClose: ->