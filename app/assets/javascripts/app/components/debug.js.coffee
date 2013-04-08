###!
* Debug
###

App.module "Components.Debug", ((Self, App, Backbone, Marionette, $, _, wndw) ->
  @startWithParent = false

  exec_callback = (args) ->
    callback_func.apply window, args  if callback_func and (callback_force or not con or not con.log)
  
  is_level = (level) ->
    (if log_level > 0 then log_level > level else log_methods.length + log_level <= level)
  window = wndw
  aps = Array::slice
  con = window.console
  that = {}
  callback_func = undefined
  callback_force = undefined
  log_level = 9
  log_methods = ["error", "warn", "info", "debug", "log"]
  pass_methods = "assert clear count dir dirxml exception group groupCollapsed groupEnd profile profileEnd table time timeEnd trace".split(" ")
  idx = pass_methods.length
  logs = []
  while --idx >= 0
    ((method) ->
      self[method] = ->
        log_level isnt 0 and con and con[method] and con[method].apply(con, arguments)
    ) pass_methods[idx]
  idx = log_methods.length
  while --idx >= 0
    ((idx, level) ->
      Self[level] = ->
        args = aps.call(arguments)
        log_arr = [level].concat(args)
        logs.push log_arr
        exec_callback log_arr
        return  if not con or not is_level(idx)
        (if con.firebug then con[level].apply(window, args) else (if con[level] then con[level](args) else con.log(args)))
    ) idx, log_methods[idx]
  
  @setLevel = (level) ->
    log_level = (if typeof level is "number" then level else 9)
    
  @setCallback = ->
    args = aps.call(arguments)
    max = logs.length
    i = max
    callback_func = args.shift() or null
    callback_force = (if typeof args[0] is "boolean" then args.shift() else false)
    i -= (if typeof args[0] is "number" then args.shift() else max)
    exec_callback logs[i++]  while i < max
), window

App.Components.Debug.start()
App.log = App.Components.Debug.log
App.logInfo = App.Components.Debug.info
App.logError = App.Components.Debug.error
App.logWarn = App.Components.Debug.warn
App.logDebug = App.Components.Debug.debug