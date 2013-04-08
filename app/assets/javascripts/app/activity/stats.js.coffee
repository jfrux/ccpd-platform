###
* ACTIVITY > FOLDERS
###
App.module "Activity.Stats", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = true
  
  @on "before:start", ->
    console.log "starting: #{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      console.log "started: #{Self.moduleName}"
    return
  @on "stop", ->
    console.log "stopped: #{Self.moduleName}"
    return

  $stats = null
  $statsContainer = null
  $statsLoading = null
  $icon = null
  $refreshLink = null
  
  refresh = Self.refresh = (callback) ->
    cb = callback
    $.post sMyself + "Activity.Stats",
      ActivityID: nActivity
    , (data) ->
      $stats.html data
      Self.trigger('refresh.complete')
      cb(true)
    return

  @on "refresh.complete",->
    $stats.append($refreshLink)
    $stats.css('color','#333')
    $icon.removeClass('icon-spin')

    $refreshLink.click ->
      recalculate()
    return
  @on "recalculate.start", ->
    $icon.addClass('icon-spin')
    $stats.css('color','#EEE')
    return

  @on "recalculate.end", ->
    refresh ->

    return
  
  recalculate = Self.recalc = () ->
    Self.trigger('recalculate.start')
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
          #addMessage data.STATUSMSG, 250, 6000, 4000
          
          $statsContainer.css('color','#333')
      
          Self.trigger('recalculate.end')
        else
          $statsLoading.hide()
          $statsContainer.show()
          Self.trigger('recalculate.end')
          #addError data.STATUSMSG, 250, 6000, 4000
    return

  _init = () ->
    $stats = $("#ActivityStats")
    $statsContainer = $("#stats-container")
    $statsLoading = $("#stats-loading")
    $icon = $('<i class="icon-refresh"></i>')
    $refreshLink = $("<a></a>")
      .addClass('btn stats-refresher js-stats-refresher')
      .html($icon)
    
    
    refresh ->
    
    return