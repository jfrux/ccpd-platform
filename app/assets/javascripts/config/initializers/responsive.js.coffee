App.respond = {
  mobile: false
  large:window.matchMedia("(min-width: 768px)")
  medium:window.matchMedia("(max-width: 767px)")
  small:window.matchMedia("(max-width: 360px)")
  tiny:window.matchMedia("(max-width: 300px)")
  test:
    large: ->
      largeDo()
      console.log App.respond.large.matches
      return App.respond.large.matches
    medium: ->
      mediumDo()
      console.log App.respond.medium.matches
      return App.respond.medium.matches
    small: ->
      smallDo()
      console.log App.respond.small.matches
      return App.respond.small.matches
    tiny: ->
      tinyDo()
      console.log App.respond.tiny.matches
      return App.respond.tiny.matches
}

oldOpen = $.ui.dialog.prototype.open

$.ui.dialog.prototype.open = ->
  console.log this
  console.log $(window).width()
  oldOpen.apply(this,arguments);

  if(App.respond.mobile)
    this.uiDialog.css
      width:'100%'

largeDo = () ->

  mql = App.respond.large
  if mql.matches
    $("body").addClass("desktop screen-large");
  else
    $("body").removeClass("desktop screen-large");

mediumDo = () ->
  mql = App.respond.medium
  if mql.matches
    $("body").addClass("mobile screen-medium");
  else
    $("body").removeClass("mobile screen-medium");

smallDo = () ->
  mql = App.respond.small
  if mql.matches
    $("body").addClass("mobile screen-small");
  else
    $("body").removeClass("mobile screen-small");

tinyDo = () ->
  mql = App.respond.tiny
  if mql.matches
    $("body").addClass("mobile screen-small");
  else
    $("body").removeClass("mobile screen-small");

App.respond.medium.addListener mediumDo
App.respond.small.addListener smallDo
App.respond.tiny.addListener tinyDo

$(document).ready ->
  App.respond.test.large()
  App.respond.test.medium()
  App.respond.test.small()
  App.respond.test.tiny()