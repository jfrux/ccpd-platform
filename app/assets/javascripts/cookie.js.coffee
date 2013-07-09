App.setCookie = (c_name, value, exdays) ->
  exdate = new Date()
  exdate.setDate exdate.getDate() + exdays
  c_value = escape(value) + ((if (not (exdays?)) then "" else "; expires=" + exdate.toUTCString()))
  document.cookie = "uc_#{c_name}=#{c_value}"
  return

App.getCookie = (c_name) ->
  c_value = document.cookie
  c_start = c_value.indexOf(" uc_#{c_name}=")
  c_start = c_value.indexOf(c_name + "=") if c_start is -1
  if c_start is -1
    c_value = null
  else
    c_start = c_value.indexOf("=", c_start) + 1
    c_end = c_value.indexOf(";", c_start)
    c_end = c_value.length  if c_end is -1
    c_value = unescape(c_value.substring(c_start, c_end))
  c_value