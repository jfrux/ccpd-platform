prettyDate = (time) ->
  date = new Date((time or "").replace(/-/g, "/").replace(/[TZ]/g, " "))
  diff = (((new Date()).getTime() - date.getTime()) / 1000)
  day_diff = Math.floor(diff / 86400)
  return $.DateFormat(date, "mmm dd, yyyy")  if isNaN(day_diff) or day_diff < 0 or day_diff >= 31
  day_diff is 0 and (diff < 60 and "just now" or diff < 120 and "1 minute ago" or diff < 3600 and Math.floor(diff / 60) + " minutes ago" or diff < 7200 and "1 hour ago" or diff < 86400 and Math.floor(diff / 3600) + " hours ago") or day_diff is 1 and "Yesterday" or day_diff < 7 and day_diff + " days ago" or day_diff < 31 and Math.ceil(day_diff / 7) + " weeks ago"
unless typeof jQuery is "undefined"
  jQuery.fn.prettyDate = ->
    @each ->
      date = prettyDate(@title)
      jQuery(this).text date  if date