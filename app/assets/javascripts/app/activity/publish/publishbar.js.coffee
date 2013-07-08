###!
* ACTIVITY > PUBLISH > GENERAL INFO
###
App.module "Activity.Publish.Bar", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
  @on "before:start", ->
    App.logInfo "starting: Publish.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init Self.data
      App.logInfo "started: Publish.#{Self.moduleName}"
    return
  @on "stop", ->
    App.logInfo "stopped: Publish.#{Self.moduleName}"
    $.each Self.submodules, (i,module) ->
      module.stop()
      return
    return

  _init = (data) ->
    # UPDATE THE PROGRESS BAR FILLER
    $(".js-progress-info-bar-fill").css(
      "width": data.nFillPercent + "%", 
      "background-color": "#" + data.sFillColor 
    );

    # DETERMINE IF THE ACTIVITY IS PUBLISHED
    if data.publishState is 'Y'
      $('.js-publishactivity-btn').hide()
    else
      $('.js-unpublishactivity-btn').hide()

    $('.js-publishactivity-btn, js-unpublishactivity-btn').attr 'disabled', 'disabled' unless data.nFillPercent is 100

    # ACTIVITY PUBLISH FUNCTIONALITY
    publishActivity = (published) ->
      $.ajax(
        url: sRootPath + "/_com/AJAX_Activity.cfc", 
        dataType:'json',
        type:'post',
        data: {
          method: "publishActivity", 
          ActivityID: nActivity, 
          returnFormat: "plain"
        },
        success: (data) ->
          if data.STATUS
            addMessage data.STATUSMSG, 250, 6000, 4000

            if published
              $(".js-publishactivity-btn").hide()
              $(".js-unpublishactivity-btn").show()
            else
              $(".js-unpublishactivity-btn").hide()
              $(".js-publishactivity-btn").show()

            updatePublishState
          else
            addError data.STATUSMSG, 250, 6000, 4000
      );


    $(".js-publishactivity-btn, .js-unpublishactivity-btn").tooltip
      placement: 'top'
      trigger:'hover focus'
      title: (e)->
        $(this).attr('data-tooltip-title')
      container: 'body'

    # PUBLISH ACTIVITY
      $(".js-publishactivity-btn").on "click", ->
        unless $(".js-publishactivity-btn").attr("disabled")
          publishActivity true
        else
          addError 'More progress is required.  See Progress dropdown for more information.'

    # UNPUBLISH ACTIVITY
      $(".js-unpublishactivity-btn").on "click", ->
        unless $(".js-unpublishactivity-btn").attr("disabled")
          publishActivity false
        else
          addError 'More progress is required.  See Progress dropdown for more information.'
