App.setCookie = (c_name,c_value,params) ->
  $.cookie "uc_#{c_name}",c_value,
    params
  return

App.getCookie = (c_name) ->
  c_value = $.cookie "uc_#{c_name}"
  c_value
  