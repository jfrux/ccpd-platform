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

# READY FUNCTION 
$ ->
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
