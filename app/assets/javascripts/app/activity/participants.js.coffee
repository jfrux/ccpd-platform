###
* ACTIVITY > Participants
###
App.module "Activity.Participants", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  Self.el = {}
  $container = Self.el.$container = null
  $loading = Self.el.$loading = null
  selectedCount = 0
  selected = ""
  @on "before:start", ->
    App.logInfo "starting: #{Self.moduleName}"
    return
  
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: #{Self.moduleName}"
    return
  
  @on "stop", ->
    Self.Ahah.stop()
    App.logInfo "stopped: #{Self.moduleName}"
    return

  @on "refreshStart", ->
    #stop AHAH module
    Self.Ahah.stop()
    return

  @on "refreshEnd", ->
    Self.Ahah.start()
    return

  updateSelectedCount = Self.updateSelectedCount = (nAmount) ->
    App.logInfo "Count is currently " + parseInt(selectedCount)
    App.logInfo "Updating Count by " + parseInt(nAmount)
    selectedCount = parseInt(selectedCount) + parseInt(nAmount)
    if selectedCount < 0
      selectedCount = 0
    App.logInfo "Count is now " + selectedCount


    $("#CheckedCount,.js-status-selected-count").html "" + selectedCount + ""
    if selectedCount > 0
      $(".js-selected-actions").find(".btn").removeClass "disabled"
    else
      $(".js-selected-actions").find(".btn").addClass "disabled"
    return

  clearSelected = ->
    selected = ""
    updateSelectedCount(selectedCount*-1)
    $(".js-status-selected-count").html "0"
    return

  getSelected = Self.getSelected = ->
    return selected.split(',')
    
  addSelected = Self.addSelected = (id) ->
    if !$.ListFind(selected, id, ",")
      selected = $.ListAppend(selected, id, ",")
      updateSelectedCount 1
    App.logDebug selected
    return

  removeSelected = Self.removeSelected = (id) ->
    if id and id > 0
      if $.ListFind(selected, id, ",")
        selected = $.ListDeleteAt(selected, $.ListFind(selected, id)) 
        updateSelectedCount -1
    App.logDebug selected
    return

  saveAttendee = Self.save = ->
    $.blockUI message: "<h1>Adding Attendee...</h1>"
    $.post sRootPath + "/_com/AJAX_Activity.cfc",
      method: "saveAttendee"
      PersonID: $("#AttendeeID").val()
      ActivityID: nActivity
      returnFormat: "plain"
    , (returnData) ->
      cleanData = $.trim(returnData)
      status = $.ListGetAt(cleanData, 1, "|")
      statusMsg = $.ListGetAt(cleanData, 2, "|")
      if status is "Success"
        refresh nId, nStatus
        addMessage statusMsg, 250, 6000, 4000
        $.unblockUI()
      else if status is "Fail"
        addError statusMsg, 250, 6000, 4000
        $.unblockUI()
        $("#AttendeeName").val "Click To Add Attendee"

    $("#AttendeeID").val ""
    $("#AttendeeName").val "Click To Add Attendee"
    return
  setAddlPartic = (nPartic) ->
    App.logInfo("setting addl participants")
    $.post sRootPath + "/_com/AJAX_Activity.cfc",
      method: "updateAddlAttendees"
      ActivityID: nActivity
      AddlAttendees: nPartic
      returnFormat: "plain"
    , (returnData) ->
      cleanData = $.trim(returnData)
      status = $.ListGetAt(cleanData, 1, "|")
      statusMsg = $.ListGetAt(cleanData, 2, "|")
      if status is "Success"
        addMessage statusMsg, 250, 6000, 4000
        addlAttendeesUnsaved = false
      else
        addError statusMsg, 250, 6000, 4000
      return
    return
  cancelButton = ->
    $("#CreditsDialog").dialog "close"
    return

  updateStatusDate = ($Attendee, $Type) ->
    unless $Type is ""
      $.ajax
        url: sRootPath + "/_com/AJAX_Activity.cfc"
        type:'post'
        data:
          method: "getAttendeeDate"
          AttendeeId: $Attendee
          type: $Type
          returnFormat: "plain"
        success: (data) ->
          cleanData = $.Trim(data)
          $("#datefill-" + $Attendee).html cleanData
          $("#editdatelink-" + $Attendee).show()
    else
      $("#datefill-" + $Attendee).html ""
      $("#editdatelink-" + $Attendee).hide()
    return

  resetAttendee = (nA, nP, sP) ->
    $.ajax
      url: sRootPath + "/_com/AJAX_Activity.cfc"
      data:
        method: "resetAttendee"
        attendeeId: nP
        ActivityID: nA
        PaymentFlag: sP
        returnFormat: "plain"
      success: (data) ->
        if data.STATUS
          addMessage data.STATUSMSG, 250, 6000, 4000
          updateActions()
          updateStats()
          refresh()
        else
          addError data.STATUSMSG, 250, 6000, 4000
        return
    return
    
  checkmarkMember = (id) ->
    if id and id > 0
      if $.ListFind(selectedAttendees, id, ",")
        $("#Checked-" + id).attr "checked", true
        $("#attendeeRow-" + id).css "background-color", "#FFD"

  refresh = Self.refresh = () ->
    Self.trigger('refreshStart')
    # Self.el.$loading.show()
    # Self.el.$container.empty()
    $.ajax
      url: sMyself + "Activity.AttendeesAHAH" 
      type:'get'
      data: 
        ActivityID: nActivity
      success: (data) ->
        Self.el.$container.html(data)
        Self.el.$loading.hide()
        
        setDefaults = ->
          $(".js-status-selected-count").text(selectedCount)
          if selectedCount && selectedCount > 0
            $(".js-selected-actions .btn").removeClass('disabled')

          $(".js-select-all-rows").each ->
            $row = $(this)
            $checkBox = $row.find(".MemberCheckbox")
            id = $row.data('key')

            if $.ListFind(selected,id)
              $checkBox.attr 'checked',true
        setDefaults()
        Self.trigger('refreshEnd')
        return

    return

  _init = () ->
    Self.el.$container = $container =  $("#ParticipantsContainer")
    Self.el.$loading = $loading = $("#ParticipantsLoading")
    #refresh()
    $("#ParticipantList").ajaxForm()
    $addlAttendeesMenu = $container.find(".js-addl-attendees-menu")
    
    $addlAttendeesMenu.find('form').on "click",(e) ->
      e.stopPropagation();
      return
    #App.logInfo CookieAttendeeStatus
    if parseInt(CookieAttendeeStatus) > 0
      statusText = $("#attendees-" + CookieAttendeeStatus).text()
      #App.logInfo statusText
      $(".js-attendee-filter-button").find("span:first").text statusText
    # CHANGE ATTENDEE STATAUS START
    $('.toolbar .dropdown-menu').find('form').click (e)->
      e.stopPropagation()
      return
    
    setCheckedStatuses = (nStatus) ->
      #$.blockUI message: "<h1>Updating information...</h1>"
      result = ""
      cleanData = ""
      nActivityRole = $("#ActivityRoles").val()
      $(".MemberCheckbox:checked").each ->
        result = $.ListAppend(result, $(this).val(), ",")

      $.ajax
        url: sRootPath + "/_com/AJAX_Activity.cfc"
        type: "post"
        data:
          method: "updateAttendeeStatuses"
          AttendeeList: result
          ActivityID: nActivity
          StatusID: nStatus
          returnFormat: "plain"

        dataType: "json"
        success: (returnData) ->
          status = returnData.STATUS
          statusMsg = returnData.STATUSMSG
          if status
            addMessage statusMsg, 250, 6000, 4000
            #$.unblockUI()
            updateActions()
            updateStats()
            clearSelectedMembers()
            refresh nId, nStatus
          else
            addError statusMsg, 250, 6000, 4000
            #$.unblockUI()
      return

    if parseInt(CookieAttendeePageActivity) is parseInt(nActivity)
      if parseInt(CookieAttendeeStatusActivity) is parseInt(nActivity)
        refresh parseInt(CookieAttendeePage), parseInt(CookieAttendeeStatus)
      else
        refresh parseInt(CookieAttendeePage), parseInt(nStatus)
    else
      refresh nId, nStatus
    # MaxRegistrants = $("#MaxRegistrants").val()
    # AddlAttendees = $("#AddlAttendees").val()
    # NoChange = 0
    
    ###
    PAGINATION BINDING
    ###
    $("a.page,a.first,a.last,a.next,a.previous").live "click", ->
      nPageNo = $.Mid(@href, $.Find("page=", @href) + 5, $.Len(@href) - $.Find("page=", @href) + 4)
      $.post sRootPath + "/_com/UserSettings.cfc",
        method: "setAttendeePage"
        ActivityID: nActivity
        Page: nPageNo

      refresh nPageNo, nStatus
      false

    ###
    ATTENDEE STATUS FILTER BINDING
    ###
    $(".attendees-filter li").live "click", ->
      $this = $(this)
      $this.parents(".btn-group").find(".btn span:first").text $this.text()
      nStatus = $.ListGetAt(@id, 2, "-")
      $("#ParticipantsContainer").html ""
      $("#ParticipantsLoading").show()
      $.post sRootPath + "/_com/UserSettings.cfc",
        method: "setAttendeeStatus"
        ActivityID: nActivity
        status: nStatus
      , (data) ->
        refresh 1, nStatus


    $("#btnStatusSubmit").bind "click", ->
      setCheckedStatuses $("#StatusID").val()
      return
    
    # ADDITIONAL SETTINGS
    $("#AddlAttendees").keyup ->
      App.logInfo "attempting to set addl registrants"
      $this = $(this)
      addlAttendeesUnsaved = true
      delay (->
        if addlAttendeesUnsaved
          App.logInfo "waited 2500ms now setting addl registrants"
          setAddlPartic($this.val())
      ), 2500
      return

    $("#AddlAttendees").bind "blur",->
      $this = $(this)
      if addlAttendeesUnsaved
        setAddlPartic($this.val())
      return
    
    # REMOVE ONLY CHECKED 
    $("#RemoveChecked").bind "click", ->
      if confirm("Are you sure you want to remove the checked attendees from this activity?")
        cleanData = ""
        $.ajax
          url: sRootPath + "/_com/AJAX_Activity.cfc"
          type: "post"
          data:
            method: "removeCheckedAttendees"
            AttendeeList: selected
            ActivityID: nActivity
            returnFormat: "plain"
          dataType: "json"
          success: (data) ->
            if data.STATUS
              addMessage data.STATUSMSG, 250, 6000, 4000
              clearSelected()
            else
              addError data.STATUSMSG, 250, 6000, 4000
            #updateActions()
            #updateStats()
            refresh nId, nStatus

  # REMOVE ALL PEOPLE FROM Activity 
    $("#RemoveAll").bind "click", ->
      if confirm("WARNING!\nYou are about to remove ALL attendees from this Activity!\nAre you sure you wish to continue?")
        cleanData = ""
        #$.blockUI message: "<h1>Removing All Attendees...</h1>"
        $.ajax
          url: sRootPath + "/_com/AJAX_Activity.cfc"
          type: "post"
          data:
            method: "removeAllAttendees"
            ActivityID: nActivity
            returnFormat: "plain"

          dataType: "json"
          success: (data) ->
            if data.STATUS
              addMessage data.STATUSMSG, 250, 6000, 4000
              updateActions()
              updateStats()
              #$.unblockUI()
              clearSelectedMembers()
              refresh nId, nStatus
            else
              addError data.STATUSMSG, 250, 6000, 4000
              updateActions()
              updateStats()
              #$.unblockUI()
              refresh()


    
    # PRINT SELECTED ONLY START 
    $("#PrintCMECert").bind "click", this, -> #CME CERTS
      if $("#PrintSelected").attr("checked") is "checked"
        window.open "http://www.getmycme.com/activities/" + nActivity + "/certificates?attendees=" + selectedAttendees
      else
        window.open sMyself + "Report.CMECert?ActivityID=" + nActivity + "&ReportID=5"

    $("#PrintCNECert").bind "click", this, -> #CNE CERTS
      if $("#PrintSelected").attr("checked") is "checked" #CHECK IF PRINTSELECTED IS CHECKED
        unless selectedAttendees is ""
          window.open sMyself + "Report.CNECert?ActivityID=' nActivity + '&ReportID=6&selectedAttendees=" + selectedAttendees
        else
          addError "You must select registrants", 250, 6000, 4000
      else
        window.open sMyself + "Report.CNECert?ActivityID=" + nActivity + "&ReportID=6"

    $(".PrintSigninSheet").bind "click", this, -> #CME CERTS
      if $("#PrintSelected").attr("checked") is "checked" #CHECK IF PRINTSELECTED IS CHECKED
        unless selectedAttendees is ""
          if $.ListGetAt(@id, 2, "|") is "Y"
            window.open sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=1&ReportID=12&selectedAttendees=" + selectedAttendees
          else
            window.open sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=0&ReportID=12&selectedAttendees=" + selectedAttendees
        else
          addError "You must select registrants", 250, 6000, 4000
      else
        if $.ListGetAt(@id, 2, "|") is "Y"
          window.open sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=1&ReportID=12"
        else
          window.open sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=0&ReportID=12"

    $("#PrintMailingLabels").bind "click", this, -> #MAILING LABELS
      if $("#PrintSelected").attr("checked") is "checked" #CHECK IF PRINTSELECTED IS CHECKED
        unless selectedMembers is ""
          window.open sMyself + "Report.MailingLabels?ActivityID=" + nActivity + "&ReportID=3&Print=1&selectedAttendees=" + selectedAttendees
        else
          addError "You must select registrants", 250, 6000, 4000
      else
        window.open sMyself + "Report.MailingLabels?ActivityID=" + nActivity + "&ReportID=3&Print=1"

    $("#PrintNameBadges").bind "click", this, -> #NAME BADGES
      if $("#PrintSelected").attr("checked") is "checked" #CHECK IF PRINTSELECTED IS CHECKED
        unless selectedMembers is ""
          window.open sMyself + "Report.NameBadges?ActivityID=" + nActivity + "&selectedMembers=" + selectedMembers
        else
          addError "You must select registrants", 250, 6000, 4000
      else
        window.open sMyself + "Report.NameBadges?ActivityID=" + nActivity + ""

    $(".importDialog").dialog
      title: "Batch Attendee Import"
      modal: false
      autoOpen: false
      height: 200
      width: 500
      buttons:
        Done: ->
          refresh()
          $(".importDialog").find("iframe").attr "src", sMyself + "activity.import?activityid=" + nActivity
          $(".importDialog").dialog "close"

    $(".newImportDialog").dialog
      title: "Batch Attendee Import"
      modal: false
      autoOpen: false
      height: 550
      width: 670
      buttons:
        Done: ->
          refresh()
          $(".newImportDialog").find("iframe").attr "src", "<cfoutput>#Application.Settings.apiUrl#</cfoutput>/imports?importable_id=" + nActivity
          $(".newImportDialog").dialog "close"

    $(".batchLink").click ->
      $(".newImportDialog").dialog "open"

    


    $(".deleteLink").one "click", ->
      $row = $(this).parents(".personRow")
      attendee = $row.find(".attendeeId").val()
      $.ajax
        type: "post"
        dataType: "json"
        url: "/admin/_com/ajax_activity.cfc"
        data:
          method: "removeAttendeeByID"
          attendeeId: attendee

        async: false
        success: (data) ->
          $row.remove()  if data.STATUS

    

    $(".PersonLink").click ->
      nPersonID = $.ListGetAt(@id, 2, "|")
      sPersonName = $.ListGetAt(@id, 3, "|")
      $("#PersonDetail").dialog "open"
      false

    # EDIT REGISTRATION DATE FIELD
    $(".EditCheckinLink").bind "click", this, ->
      nPersonID = $.Replace(@id, "Checkin", "")
      
      # HIDE ALL EDIT FIELDS
      $(".CheckinEdit").hide()
      $(".CheckinOutput").show()
      
      # REVEAL CURRENT EDIT FIELD
      $("#CheckinOutput" + nPersonID).hide()
      $("#CheckinEdit" + nPersonID).show()

    $(".AttendeeStatusID").change ->
      $Attendee = $.ListGetAt(@id, 2, "-")
      $Type = $(this).val()
      updateStatusDate $Attendee, $Type

    $(".EditStatusDate").bind "click", this, ->
      CurrID = @id
      nAttendee = $.ListGetAt(@id, 2, "-")
      dtCurrDate = $.Trim($("#datefill-" + nAttendee).html())
      sDate = $.ListGetAt(dtCurrDate, 1, " ")
      sTime = $.ListGetAt(dtCurrDate, 2, " ")
      nHour = $.ListGetAt(sTime, 1, ":")
      if $.Len(nHour) is 1
        nHour = "0" + nHour
        dtCurrDate = sDate + " " + nHour + ":" + $.ListGetAt(sTime, 2, ":")
      $("#CurrStatusDate-" + nAttendee).val dtCurrDate
      $("#EditDateField-" + nAttendee).val dtCurrDate
      $("#editdatelink-" + nAttendee).hide()
      $("#datefill-" + nAttendee).hide()
      $("#editdatecontainer-" + nAttendee).show()

    $(".EditDateField").keydown ->
      dtStatusMask = $(this).val()  if $.Len($(this).val()) > 0

    $(".SaveDateEdit").bind "click", this, ->
      CurrID = @id
      nAttendee = $.ListGetAt(@id, 2, "-")
      nType = $("#AttendeeStatus-" + nAttendee).val()
      dtDate = $("#EditDateField-" + nAttendee).val()
      if nType isnt "" and $.Len(dtDate) > 0
        $.post sRootPath + "/_com/AJAX_Activity.cfc",
          method: "saveAttendeeDate"
          attendeeId: nAttendee
          DateValue: dtDate
          Type: nType
          returnFormat: "plain"
        , (data) ->
          cleanData = $.Trim(data)
          Status = $.ListGetAt(cleanData, 1, "|")
          statusMsg = $.ListGetAt(cleanData, 2, "|")
          if Status is "Success"
            addMessage statusMsg, 250, 6000, 4000
            refresh nId
          else
            addError statusMsg, 250, 6000, 4000
            $("#editdatecontainer-" + nAttendee).hide()
            $("#datefill-" + nAttendee).show()
            $("#editdatelink-" + nAttendee).show()

      else
        addError "You must provide full date and time.", 250, 6000, 4000
        $("#EditDateField-" + nAttendee).focus()
        $("#EditDateField-" + nAttendee).val dtStatusMask

    App.trigger("activity.participants.load")
    return