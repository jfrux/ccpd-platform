###
* ACTIVITY > FOLDERS
###
App.module "Activity.Stats", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
  @on "before:start", ->
    console.log "loaded: #{Self.moduleName}"
    return
  @on "start", ()->
    $(document).ready ->
      _init()
      console.log "started: #{Self.moduleName}"
      return
    return

  _init = () ->
    $stats = $("#ActivityStats")
    $statsContainer = $("#stats-container")
    $statsLoading = $("#stats-loading")
    $icon = $('<i class="icon-refresh"></i>')
    $refreshLink = $("<a></a>")
      .addClass('btn stats-refresher js-stats-refresher')
      .html($icon)
    $refreshLink.appendTo $stats
    $refreshLink.click ->
      $statsContainer.css('color','#EEE')
      #$statsLoading.show()
      $icon.addClass('icon-spin')
      $.ajax
        url: "/admin/_com/scripts/statFixer.cfc"
        type: "post"
        async: false
        dataType: "json"
        data:
          method: "run"
          returnFormat: "plain"
          mode: "manual"
          activityId: nActivity

        success: (data) ->
          if data.STATUS
            addMessage data.STATUSMSG, 250, 6000, 4000
            App.Activity.updateStats()
            $icon.removeClass('icon-spin')
            $statsContainer.css('color','#333')
      
            Self.stop()
          else
            $statsLoading.hide()
            $("#stats-container").show()
            addError data.STATUSMSG, 250, 6000, 4000



  pub =
    init: _init