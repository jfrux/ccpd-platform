# App.addInitializer (options)->
#   jRes = jRespond([
#     {
#       label: "desktop"
#       enter: 768
#     }
#     ,
#     {
#       label: "mobile-sm"
#       enter: 0
#       exit: 360
#     }
#     ,
#     {
#       label: "mobile"
#       enter: 361
#       exit: 767
#     }
#   ])
# jRes.addFunc
#     breakpoint: "mobile"
#     enter: ->
#       #log "mobile: on"
#       #$("body").addClass('mobile')
#       return
#     exit: ->
#       #log "mobile: off"
#       #$("body").removeClass('mobile')
      
#       return
#   jRes.addFunc
#     breakpoint: "mobile"
#     enter: ->
#       #log "mobile: on"
#       #$("body").addClass('mobile')
#       return
#     exit: ->
#       #log "mobile: off"
#       #$("body").removeClass('mobile')
      
#       return
#   jRes.addFunc
#     breakpoint: "mobile-sm"
#     enter: ->
#       #log "mobile-sm: on"
#       #$("body").addClass('mobile mobile-sm');
      
#       return
#     exit: ->
#       #log "mobile-sm: off"
#       #$("body").removeClass('mobile mobile-sm');
#       return