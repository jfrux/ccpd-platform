App.respond = {
  mobile: false
  medium:window.matchMedia("(max-width: 767px)")
  small:window.matchMedia("(max-width: 360px)")
  tiny:window.matchMedia("(max-width: 300px)")
  test:
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

dialogFixer = () ->
  $dialogs = $(".ui-dialog:visible")
  dialogSizer = (dialog) ->
    content = dialog.find(".ui-dialog-content")
    iframe = content.find("iframe")

    winHeight = $(window).height();
    winWidth = $(window).width();

    dialog.height(winHeight)
    dialog.width(winWidth)
    contentHeight = winHeight-95
    contentWidth = winWidth-28
    content.height(contentHeight)
    content.width(contentWidth)

  if $dialogs.length
    $dialogs.each ->
      thisDialog = $(this)
      content = thisDialog.find('.ui-dialog-content')
      iframe = content.find('iframe')

      if App.respond.medium.matches
        thisDialog.addClass('is-mobile')
        
        if iframe.length
          iframe.height(content.height())
          iframe.width('100%')
        thisDialog.css
          width:'100%'
          top:0
          left:0

        dialogSizer(thisDialog)
      else
        thisDialog.removeClass('is-mobile')
        orig = thisDialog.data('myOrig')
        thisDialog.height(orig.height)
        thisDialog.width(orig.width)
        thisDialog.css('left',orig.left)
        thisDialog.css('top',orig.top)
        content.height(orig.contentHeight)

oldOpen = $.ui.dialog.prototype.open

$.ui.dialog.prototype.open = ->
  oldOpen.apply(this,arguments);
  myOrig = {
    height: this.uiDialog.height()
    width: this.uiDialog.width()
    left: this.uiDialog.css('left')
    top: this.uiDialog.css('top')
    contentHeight: this.uiDialog.find('.ui-dialog-content').height()
  }
  this.uiDialog.data('myOrig',myOrig)
  dialogFixer()
  return

mediumDo = () ->
  mql = App.respond.medium

  if mql.matches
    $(window).on "resize", dialogFixer
    $(window).on "orientationchange", dialogFixer
    dialogFixer()
    App.jPanelMenu.on()
    $("body").addClass("mobile screen-medium");
  else
    $(window).off "resize", dialogFixer
    $(window).off "orientationchange", dialogFixer
    dialogFixer()
    App.jPanelMenu.off()
    $("body").removeClass("mobile screen-medium");

smallDo = () ->
  mql = App.respond.small
  if mql.matches
    $("body").addClass("screen-small");
  else
    $("body").removeClass("screen-small");

tinyDo = () ->
  mql = App.respond.tiny
  if mql.matches
    $("body").addClass("screen-tiny");
  else
    $("body").removeClass("screen-tiny");

App.respond.medium.addListener mediumDo
App.respond.small.addListener smallDo
App.respond.tiny.addListener tinyDo

$(document).ready ->
  App.respond.test.medium()
  App.respond.test.small()
  App.respond.test.tiny()
