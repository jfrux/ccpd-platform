###!
* STATUS MANAGER
###
App.status = do ({App,$,Backbone} = window) ->
  _init = () ->
    console.log "init: app_status"

  _addMessage = (message,fadein,fadeto,fadeout) ->
    console.log "adding status message: '#{message}'"
    $.jGrowl message,
      life: fadeto
      openDuration: fadein
      closeDuration: fadeout
      themeState: 'normal'
  _addError = (message,fadein,fadeto,fadeout) ->
    console.log "adding error message: '#{message}'"
    $.jGrowl message
      header: 'ERROR!'
      life: fadeto
      openDuration: fadein
      closeDuration: fadeout
      themeState: 'error'

  pub =
    init: _init
    addMessage: _addMessage
    addError: _addError