###!
* ACTIVITY
###
App.activity = do ({App,$,Backbone} = window) ->
  activityContainer = null
  $profile = null;
  $projectBar = null;
  $contentArea = null;
  $infoBar = null;
  $infoBarToggler = null;
  $contentToggleSpan = null;
  $infoBarToggleSpan = null;
  $menuBar = null;
  
  App.on "activity.init", ->
    console.log("init: activity")
  App.on "activity.containers.load",->
    console.log "containers loaded!"
    return
    
  continueCopy = ->
    sNewActivityTitle = $("#NewActivityTitle").val()
    nNewActivityType = $("#NewActivityType").val()
    nNewGrouping = $("#NewGrouping").val()
    nCopyChoice = $(".CopyChoice:checked").val()
    nError = 0
    if nNewActivityType is "" and nCopyChoice is 1
      addError "Please select an activity type.", 250, 6000, 4000
      nError = nError + 1
    if sNewActivityTitle is ""
      addError "Please enter an activity title.", 250, 6000, 4000
      nError = nError + 1
    return false  if nError > 0
    nNewGrouping = 0  if nNewGrouping is ""
    $.getJSON sRootPath + "/_com/AJAX_Activity.cfc",
      method: "CopyPaste"
      Mode: nCopyChoice
      NewActivityTitle: sNewActivityTitle
      NewActivityTypeID: nNewActivityType
      NewGroupingID: nNewGrouping
      ActivityID: nActivity
      ReturnFormat: "plain"
    , (data) ->
      if data.STATUS
        window.location = sMyself + "Activity.Detail?ActivityID=" + data.DATASET[0].activityid + "&Message=" + data.STATUSMSG
      else
        addError data.STATUSMSG, 250, 6000, 4000
    return

  cancelCopy = ->
    return

  setCurrActivityType = (nID) ->
    $("#NewActivityType").val nID
    getGroupingList nID
    return
  getGroupingList = (nID) ->
    $("#NewGrouping").removeOption ""
    $("#NewGrouping").removeOption /./
    $("#NewGrouping").ajaxAddOption sRootPath + "/_com/AJAX_Activity.cfc",
      method: "getGroupings"
      ATID: nID
      returnFormat: "plain"
    , false, (data) ->
      unless $("#NewGrouping").val() is ""
        $("#NewGrouping").val nGrouping
        $("#NewGroupingSelect").show()
      else
        $("#NewGrouping").val 0
        $("#NewGroupingSelect").hide()
    return

  showInfobar = ->
    $spanDiv = $infoBar.parent()
    $.cookie 'USER_ACTSHOWINFOBAR', 'true',
      path: '/'
    $infoBarToggler.find('i').attr('class','fg-application-sidebar-expand')
    $infoBarToggler.addClass('active')
    $infoBar.removeClass('hide')
    $profile.removeClass('infobar-inactive').addClass('infobar-active')
    $contentToggleSpan.removeClass('span24').addClass('span18')
    $infoBarToggleSpan.addClass('span6')
    return

  hideInfobar = ->    
    $infoBarToggler.removeClass('active')
    $.cookie 'USER_ACTSHOWINFOBAR', 'false',
      path: '/'
    $spanDiv = $infoBar.parent()    
    $infoBarToggler.find('i').attr('class','fg-application-sidebar-collapse')
    $profile.removeClass('infobar-active').addClass('infobar-inactive')
    $contentToggleSpan.removeClass('span18').addClass('span24')
    $infoBar.addClass('hide')
    $infoBarToggleSpan.removeClass('span6')
    return
  updateAll = ->
    updateStats()
    
    #updateActions();
    updateContainers()
    updateActivityList()
    return
  updateStats = ->
    $.post sMyself + "Activity.Stats",
      ActivityID: nActivity
    , (data) ->
      $("#ActivityStats").html data
    return

  updateActions = ->
    #$.post(sMyself + "Activity.ActionsShort", { ActivityID: nActivity }, 
    #    function(data) {
    #      $("#LatestActions").html(data);
    #  });
    return
  updateContainers = ->
    $.post sMyself + "Activity.Container",
      ActivityID: nActivity
    , (data) ->
      $("#Containers").html data
    return

  updateActivityList = ->
    $.post sMyself + "Activity.ActivityList",
      ActivityID: nActivity
    , (data) ->
      $("#ActivityList").html data
    return

  updateNoteCount = ->
    $.post sRootPath + "/_com/AJAX_Activity.cfc",
      method: "getNoteCount"
      ActivityID: nActivity
      returnFormat: "plain"
    , (data) ->
      nNoteCount = $.ListGetAt($.Trim(data), 1, ".")
      $("#NoteCount").html "(" + nNoteCount + ")"
    return


  _init = ->
    $profile = $(".profile")
    $infoBar = $(".js-infobar")
    $projectBar = $(".js-projectbar")
    $menuBar = $(".js-profile-menu > div > div > ul")
    $contentArea = $(".js-profile-content")
    $infoBarToggler = $(".js-toggle-infobar")
    $contentToggleSpan = $(".js-content-toggle")
    $infoBarToggleSpan = $(".js-infobar-outer")

    $(document).pjax('.js-profile-menu > div > div > ul a', '.content-inner')
    $(document).on 'pjax:send', ->
      #console.log arguments

    $(document).on 'pjax:complete',(xhr, options, textStatus) ->
      console.log xhr
      # console.log textStatus
      # console.log options
      $clickedLink = $(xhr.relatedTarget)
      $pageTitle = $clickedLink.attr('data-pjax-title')
      console.log($clickedLink)
      $contentArea = $(xhr.target)
      $contentTitle = $contentArea.parents('.js-profile-content').find('.content-title > h3')
      $contentTitle.text($pageTitle)

      $parent = $clickedLink.parent()
      $parent.siblings().removeClass('active')
      $parent.addClass('active')


    $infoBarToggler.on "click.button.data-api",(e) ->
      #console.log(e);
      $btn = $(e.target);
      if $btn.hasClass('active')
        showInfobar()
      else
        hideInfobar()
    #updateActions();
    updateContainers()
    updateStats()
    updateNoteCount()

    if cActShowInfobar
      showInfobar()
    else
      hideInfobar()

    $(".ContentTitle span").tooltip
      placement: 'bottom'
      trigger:'hover focus'
      container: 'body'
    

    $(".linkbar a").tooltip
      placement: 'right'
      html: 'true'
      trigger: 'hover focus'
      title: (e)->
        $(this).attr('data-title')
      container: 'body'
    

    $(".action-buttons a.btn, .action-buttons button.btn").tooltip
      placement: 'bottom'
      trigger: 'hover focus'
      container: 'body'
    

    # STATUS CHANGER 
    $("#StatusChanger").change ->
      nStatus = $(this).val()
      if nStatus is ""
        addError "You must select a status.", 250, 6000, 4000
        return false
      $.post sRootPath + "/_com/AJAX_Activity.cfc",
        method: "updateActivityStatus"
        ActivityID: nActivity
        StatusID: nStatus
        returnFormat: "plain"
      , (data) ->
        cleanData = $.trim(data)
        updateActions()
        updatePublishState()  if $.ListFind("Activity.Publish,Activity.PubGeneral,Activity.PubSites,Activity.PubBuilder,Activity.PubCategory,Activity.PubSpecialty", fuseaction)
        addMessage "Activity status changed successfully!", 250, 6000, 4000

      $("#StatusIcon").attr "src", sRootPath + "/admin/_images/icons/Status" + $(this).val() + ".png"

    
    # // END STATUS CHANGER 
    
    # DIALOG WINDOWS 
    
    # ACTIVITY DIALOG 
    $("#ActivityList").dialog
      title: "Activity List"
      modal: false
      autoOpen: cActListOpen
      height: cActListHeight
      width: cActListWidth
      position: [cActListPosX, cActListPosY]
      resizable: true
      dragStop: (ev, ui) ->
        $.post sRootPath + "/_com/UserSettings.cfc",
          method: "setActListPos"
          position: ui.position.left + "," + ui.position.top


      open: ->
        updateActivityList()
        $("#ActivityList").show()
        $.post sRootPath + "/_com/UserSettings.cfc",
          method: "setActListOpen"
          IsOpen: "true"

        $("#ActivityDialogLink").fadeOut()

      close: ->
        $("#ActivityList").html ""
        $("#ActivityDialogLink").fadeIn()
        $.post sRootPath + "/_com/UserSettings.cfc",
          method: "setActListOpen"
          IsOpen: "false"


      resizeStop: (ev, ui) ->
        $.post sRootPath + "/_com/UserSettings.cfc",
          method: "setActListSize"
          Size: ui.size.width + "," + ui.size.height


    $("#ActivityDialogLink").click ->
      $("#ActivityList").dialog "open"

    
    # // END ACTIVITY DIALOG 
    
    # MOVE DIALOG 
    $("#MoveDialog").dialog
      title: "Move Activity"
      modal: true
      autoOpen: false
      buttons:
        Continue: ->
          $.post sRootPath + "/_com/AJAX_Activity.cfc",
            method: "Move"
            FromActivityID: nActivity
            ToActivityID: $("#ToActivity").val()
          , (data) ->
            window.location = sMyself + "Activity.Detail?ActivityID=" + nActivity + "&Message=Activity successfully moved."


        Cancel: ->
          $("#MoveDialog").dialog "close"

      height: 400
      width: 450
      resizable: false
      draggable: false
      open: ->
        $("#MoveDialog").show()

      close: ->

    $("#MoveLink").click ->
      $("#MoveDialog").dialog "open"

    
    # // END MOVE DIALOG 
    
    # COPY AND PASTE DIALOG 
    $("#CopyDialog").dialog
      title: "Copy &amp; Paste Activity"
      modal: true
      autoOpen: false
      overlay:
        opacity: 0.5
        background: "black"

      buttons:
        Continue: ->
          continueCopy()

        Cancel: ->
          cancelCopy()
          $("#CopyDialog").dialog "close"

      height: 400
      width: 400
      resizable: false
      draggable: false
      open: ->
        $("#CopyDialog").show()

      close: ->
        cancelCopy()

    $("#CopyLink").click ->
      setCurrActivityType nActivityType
      $("#CopyDialog").dialog "open"
      $("#NewActivityTitle").val "Copy of " + sActivityTitle
      $("#NewActivityTitle").focus()
      $("#NewActivityTitle").select()

    $(".CopyChoice").change ->
      sID = $.Replace(@id, "CopyChoice", "")
      if sID is 2
        $("#ParentActivityOptions").hide()
      else
        $("#ParentActivityOptions").show()

    $("#NewActivityType").bind "change", this, ->
      nID = $(this).val()
      unless nID is ""
        getGroupingList nID
      else
        $("#NewGroupingSelect").hide()
        $("#NewGrouping").val ""

    
    # // END COPY AND PASTE DIALOG 
    
    # // END NOTES DIALOG 
    
    # OVERVIEW DIALOG 
    $("#OverviewList").dialog
      title: "Activity Overview"
      modal: false
      autoOpen: false
      height: 550
      width: 740
      resizable: true
      open: ->
        $.post sMyself + "Activity.Overview",
          ActivityID: nActivity
        , (data) ->
          $("#OverviewList").html data


      close: ->
        $("#OverviewDialogLink").fadeIn()
        $("#OverviewList").html ""

      buttons:
        Print: ->
          $("#OverviewList").printArea()

        Close: ->
          $("#OverviewList").dialog "close"

    $("#OverviewDialogLink").click ->
      $("#OverviewList").dialog "open"

    
    # // END OVERVIEW DIALOG 
    
    # START DELETE ACTIVITY 
    $("#DeleteActivityLink").bind "click", this, ->
      sReason = prompt("Do you really want to delete '" + sActivityTitle + "'?  What is the reason?", "")
      if sReason? and sReason isnt ""
        $.getJSON sRootPath + "/_com/AJAX_Activity.cfc",
          method: "deleteActivity"
          ActivityID: nActivity
          Reason: sReason
          returnFormat: "plain"
        , (data) ->
          if data.STATUS
            window.location = sMyself + "Activity.Home?Message=" + data.STATUSMSG
          else
            addError data.STATUSMSG, 250, 6000, 4000

      else
        addError "Please provide a reason.", 250, 6000, 4000
    
    # END DELETE ACTIVITY 
    
    # PROCESS QUEUES DIALOG 
    $("#ProcessQueueDialog").dialog
      title: "Process Queues"
      modal: true
      autoOpen: false
      overlay:
        opacity: 0.5
        background: "black"

      buttons:
        Continue: ->
          frmProcessQueue.addToQueue()

        Cancel: ->
          $("#ProcessSelect").val ""
          $(this).dialog "close"

      height: 400
      width: 560
      resizable: false
      open: ->
        $("#ProcessQueueDialog").show()

    $("#ProcessSelect").change ->
      $("#frmProcessQueue").attr "src", sMyself + "Process.AddToQueue?ActivityID=" + nActivity + "&ProcessID=" + $(this).val()
      $("#ProcessQueueDialog").dialog "open"

    $("#ProcessSelect").val ""

    App.trigger('activity.init')

    return

  pub =
    init: _init