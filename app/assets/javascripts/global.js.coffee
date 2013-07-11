announcer = (data) ->
  return

stopDefibrillator = ->
  defibrillator.stop()
defibrillate = (thedata) ->
  announcer thedata
crashCart = ->
  $.ajax 
    url: "/admin/defibrillator.cfc?method=shock&yell=clear"
    type:'get'
    dataType:'json'
    success: (data) ->
      defibrillate data
  return

startDefibrillator = ->
  defibrillator = $.PeriodicalUpdater("/admin/_com/defibrillator.cfc",
    method: "get" # method; get or post
    data: # array of values to be passed to the page - e.g. {name: "John", greeting: "hello"}
      method: "shock"
      yell: "clear"
    minTimeout: 2000 # starting value for the timeout in milliseconds
    maxTimeout: 16000 # maximum length of time between requests
    multiplier: 2 # if set to 2, timerInterval will double each time the response hasn't changed (up to maxTimeout)
    type: "json" # response type - text, xml, json, etc.  See $.ajax config options
    maxCalls: 25 # maximum number of calls. 0 = no limit.
    autoStop: 0 # automatically stop requests after this many returns of the same data. 0 = disabled.
  , (data) ->
    defibrillate data
  )


delay = (->
  timer = 0
  (callback, ms) ->
    clearTimeout timer
    timer = setTimeout(callback, ms)
)()

defibrillator = ""



fluidDialog = ->
  $visible = $(".ui-dialog:visible")
  
  # each open dialog
  $visible.each ->
    $this = $(this)
    dialog = $this.find(".ui-dialog-content").data("dialog")
    
    # if fluid option == true
    if dialog.options.maxWidth and dialog.options.width
      
      # fix maxWidth bug
      $this.css "max-width", dialog.options.maxWidth
      
      #reposition dialog
      dialog.option "position", dialog.options.position
    if dialog.options.fluid
      
      # namespace window resize
      $(window).on "resize.responsive", ->
        wWidth = $(window).width()
        
        # check window width against dialog width
        
        # keep dialog from filling entire screen
        $this.css "width", "90%"  if wWidth < dialog.options.maxWidth + 50
        
        #reposition dialog
        dialog.option "position", dialog.options.position

# READY FUNCTION 
$ ->
  # $(document).on "dialogopen", ".ui-dialog", (event, ui) ->
  #   fluidDialog()

  # $(document).on "dialogclose", ".ui-dialog", (event, ui) ->
  #   $(window).off "resize.responsive"

  $("*").bind "touchend", (e) ->
    if $(e.target).attr("rel") isnt "tooltip" and ($("div.tooltip.in").length > 0)
      $("[rel=tooltip]").mouseleave()
      e.stopPropagation()
    else
      $(e.target).mouseenter()
    return
  # $.extend $.ui.dialog.prototype.options,
  #   modal: true
  #   resizable: false
  #   draggable: false
  #   open: (event,ui) ->
  #     log "test"
  #     $(this).wrapInner('<div class="ui-dialog-inner"></div>')
  $("input").keydown (e) ->
    if e.keyCode is 13
      $(this).parents("form").submit()
      false

  startDefibrillator()  if typeof (loggedIn) is "boolean" and loggedIn
