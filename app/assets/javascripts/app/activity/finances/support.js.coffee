###!
* ACTIVITY > FINANCES > SUPPORT
###
App.module "Activity.Finances.Support", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
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
 
  _init = (defaults) ->
    #console.log "init: finances > support"
