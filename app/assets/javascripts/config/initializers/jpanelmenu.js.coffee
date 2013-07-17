App.addInitializer ->
  $(document).ready ->
    jPM = $.jPanelMenu
      menu: $(".jpanel-nav"),
      trigger: 'a.navbar-toggle'
      excludedPanelContent:'#fb-root,script,uvOverlay1,.modal'
      before: ->
      afterOpen: ->
      afterClose: ->
    jPM.on()