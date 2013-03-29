###
* ACTIVITY
###
App.profile = do ({App,$,Backbone} = window) ->
  $(document).ready ->
    $(".btn-toolbar a").tooltip
      placement: "bottom"
      html: "true"
      trigger: "hover focus"
      container: "body"
  return
