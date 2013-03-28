###
* ACTIVITY > PARTICIPANTS
###
ce.activity.participants = do ($) ->
  updateRegistrants = (nPage, nStatus) ->
    $("#RegistrantsLoading").show()
    $.get sMyself + "Activity.AttendeesAHAH",
      ActivityID: nActivity
      status: nStatus
      page: nPage
    , (data) ->
      $("#RegistrantsContainer").html data
      $("#RegistrantsLoading").hide()
      $(".AllAttendees").unbind()
      $(".AllAttendees").isPerson()
      
      # CHECK IF ATTENDEE HAS BEEN MARKED AS SELECTED 
      $(".AllAttendees").each ->
        $row = $(this)
        $checkBox = $row.find(".MemberCheckbox")
        nPerson = $row.find(".personId").val()
        nAttendee = $row.find(".attendeeId").val()
        $checkBox.click ->
          if $(this).attr("checked")
            $("#attendeeRow-" + nAttendee).css "background-color", "#FFD"
            
            # ADD CURRENT MEMBER TO SELECTEDMEMBERS LIST
            addSelectedAttendee
              person: nPerson
              attendee: nAttendee

          else
            $("#attendeeRow-" + nAttendee).css "background-color", "#FFF"
            
            # REMOVE CURRENT MEMBER FROM SELECTEDMEMBERS LIST
            removeSelectedPerson
              person: nPerson
              attendee: nAttendee





  #checkmarkMember({
  #           person:nPerson,
  #           attendee:nAttendee
  #         });
  clearSelectedMembers = ->
    SelectedAttendees = ""
    SelectedMembers = ""
    SelectedCount = 0
    $("#CheckedCount").html "(0)"
    return

  updateSelectedCount = (nAmount) ->
    console.log "Count is currently " + SelectedCount
    console.log "Updating Count by " + nAmount
    SelectedCount = parseInt(SelectedCount) + parseInt(nAmount)
    console.log "Count is now " + SelectedCount
    $("#CheckedCount,.js-attendee-status-selected-count").html "" + SelectedCount + ""
    if SelectedCount > 0
      $(".js-partic-actions").find(".btn").removeClass "disabled"
    else
      $(".js-partic-actions").find(".btn").addClass "disabled"

    return

  addSelectedAttendee = (params) ->
    settings = $.extend({}, params)
    SelectedMembers = $.ListAppend(SelectedMembers, settings.person, ",")  unless $.ListFind(SelectedMembers, settings.person, ",")  if settings.person and settings.person > 0
    SelectedAttendees = $.ListAppend(SelectedAttendees, settings.attendee, ",")  unless $.ListFind(SelectedAttendees, settings.attendee, ",")  if settings.attendee and settings.attendee > 0
    updateSelectedCount 1
    return

  removeSelectedPerson = (params) ->
    settings = $.extend({}, params)
    SelectedMembers = $.ListDeleteAt(SelectedMembers, $.ListFind(SelectedMembers, settings.person))  if settings.person and settings.person > 0
    SelectedAttendees = $.ListDeleteAt(SelectedAttendees, $.ListFind(SelectedAttendees, settings.attendee))  if settings.attendee and settings.attendee > 0
    updateSelectedCount -1
    return

  saveAttendee = ->
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
        updateRegistrants nId, nStatus
        addMessage statusMsg, 250, 6000, 4000
        $.unblockUI()
      else if status is "Fail"
        addError statusMsg, 250, 6000, 4000
        $.unblockUI()
        $("#AttendeeName").val "Click To Add Attendee"

    $("#AttendeeID").val ""
    $("#AttendeeName").val "Click To Add Attendee"
    return

  cancelButton = ->
    $("#CreditsDialog").dialog "close"
    return

  updateStatusDate = ($Attendee, $Type) ->
    unless $Type is ""
      $.post sRootPath + "/_com/AJAX_Activity.cfc",
        method: "getAttendeeDate"
        AttendeeId: $Attendee
        type: $Type
        returnFormat: "plain"
      , (data) ->
        cleanData = $.Trim(data)
        $("#datefill-" + $Attendee).html cleanData
        $("#editdatelink-" + $Attendee).show()

    else
      $("#datefill-" + $Attendee).html ""
      $("#editdatelink-" + $Attendee).hide()
  resetAttendee = (nA, nP, sP) ->
    $.getJSON sRootPath + "/_com/AJAX_Activity.cfc",
      method: "resetAttendee"
      attendeeId: nP
      ActivityID: nA
      PaymentFlag: sP
      returnFormat: "plain"
    , (data) ->
      if data.STATUS
        addMessage data.STATUSMSG, 250, 6000, 4000
        updateActions()
        updateStats()
        updateRegistrants()
      else
        addError data.STATUSMSG, 250, 6000, 4000

  checkmarkMember = (params) ->
    
    #if(settings.person && settings.person > 0) {
    #   if($.ListFind(SelectedMembers, settings.person, ",")) {
    #     $("#Checked" + settings.person).attr("checked",true);
    #     $("#PersonRow" + settings.person).css("background-color","#FFD");
    #   }
    # }
    if settings.attendee and settings.attendee > 0
      if $.ListFind(SelectedAttendees, settings.attendee, ",")
        $("#Checked-" + settings.attendee).attr "checked", true
        $("#attendeeRow-" + settings.attendee).css "background-color", "#FFD"

  _init = () ->
    console.log('init: participants\Selected Count: ' + SelectedCount);
    # CHANGE ATTENDEE STATAUS START 
    setCheckedStatuses = (nStatus) ->
      $.blockUI message: "<h1>Updating information...</h1>"
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
            $.unblockUI()
            updateActions()
            updateStats()
            clearSelectedMembers()
            updateRegistrants nId, nStatus
          else
            addError statusMsg, 250, 6000, 4000
            $.unblockUI()

    if parseInt(CookieAttendeePageActivity) is parseInt(nActivity)
      if parseInt(CookieAttendeeStatusActivity) is parseInt(nActivity)
        updateRegistrants parseInt(CookieAttendeePage), parseInt(CookieAttendeeStatus)
      else
        updateRegistrants parseInt(CookieAttendeePage), parseInt(nStatus)
    else
      updateRegistrants nId, nStatus
    MaxRegistrants = $("#MaxRegistrants").val()
    AddlAttendees = $("#AddlAttendees").val()
    NoChange = 0
    $("a.page,a.first,a.last,a.next,a.previous").live "click", ->
      nPageNo = $.Mid(@href, $.Find("page=", @href) + 5, $.Len(@href) - $.Find("page=", @href) + 4)
      $.post sRootPath + "/_com/UserSettings.cfc",
        method: "setAttendeePage"
        ActivityID: nActivity
        Page: nPageNo

      updateRegistrants nPageNo, nStatus
      false

    $(".attendees-filter li").live "click", ->
      $this = $(this)
      $this.parents(".btn-group").find(".btn span:first").text $this.text()
      nStatus = $.ListGetAt(@id, 2, "-")
      $("#RegistrantsContainer").html ""
      $("#RegistrantsLoading").show()
      $.post sRootPath + "/_com/UserSettings.cfc",
        method: "setAttendeeStatus"
        ActivityID: nActivity
        status: nStatus
      , (data) ->
        updateRegistrants 1, nStatus


    $("#btnStatusSubmit").bind "click", ->
      setCheckedStatuses $("#StatusID").val()

    
    # CHANGE ATTENDEE STATAUS END 
    
    # REGISTRANTS AND ATTENDEE TEXTBOX START 
    $("#MaxRegistrants,#AddlAttendees").bind "blur", ->
      unless MaxRegistrants is $("#MaxRegistrants").val() # CHECK IF THE VALUE OF MAXREGISTRANTS CHANGED
        $.post sRootPath + "/_com/AJAX_Activity.cfc",
          method: "updateMaxRegistrants"
          ActivityID: nActivity
          MaxRegistrants: $("#MaxRegistrants").val()
          returnFormat: "plain"
        , (returnData) ->
          cleanData = $.trim(returnData)
          status = $.ListGetAt(cleanData, 1, "|")
          statusMsg = $.ListGetAt(cleanData, 2, "|")
          if status is "Success"
            addMessage statusMsg, 250, 6000, 4000
          else
            addError statusMsg, 250, 6000, 4000

        MaxRegistrants = $("#MaxRegistrants").val() # UPDATE MAXREGISTRANTS VALUE
      else
        NoChange = NoChange + 1
      unless AddlAttendees is $("#AddlAttendees").val() # CHECK IF THE VALUE OF ADDLATTENDEES CHANGED
        $.post sRootPath + "/_com/AJAX_Activity.cfc",
          method: "updateAddlAttendees"
          ActivityID: nActivity
          AddlAttendees: $("#AddlAttendees").val()
          returnFormat: "plain"
        , (returnData) ->
          cleanData = $.trim(returnData)
          status = $.ListGetAt(cleanData, 1, "|")
          statusMsg = $.ListGetAt(cleanData, 2, "|")
          if status is "Success"
            addMessage statusMsg, 250, 6000, 4000
          else
            addError statusMsg, 250, 6000, 4000

        AddlAttendees = $("#AddlAttendees").val() # UPDATE ADDLATTENDEES VALUE
      else
        NoChange = NoChange + 1
      if NoChange is 2
        addError "Please adjust the value you want to update and try again.", 250, 6000, 4000
        NoChange = 0
      else NoChange = 0  if NoChange > 0

    
    # REGISTRANTS AND ATTENDEE TEXTBOX START 
    
    # REMOVE ONLY CHECKED 
    $("#RemoveChecked").bind "click", ->
      if confirm("Are you sure you want to remove the checked attendees from this activity?")
        cleanData = ""
        $.blockUI message: "<h1>Removing Selected Attendees...</h1>"
        $.ajax
          url: sRootPath + "/_com/AJAX_Activity.cfc"
          type: "post"
          data:
            method: "removeCheckedAttendees"
            PersonList: SelectedMembers
          AttendeeList: SelectedAttendees
          ActivityID: nActivity
          returnFormat: "plain"

        dataType: "json"
        success: (data) ->
          if data.STATUS
            addMessage data.STATUSMSG, 250, 6000, 4000
            clearSelectedMembers()
          else
            addError data.STATUSMSG, 250, 6000, 4000
          updateActions()
          updateStats()
          $.unblockUI()
          updateRegistrants nId, nStatus


  
  # REMOVE ALL PEOPLE FROM Activity 
    $("#RemoveAll").bind "click", ->
      if confirm("WARNING!\nYou are about to remove ALL attendees from this Activity!\nAre you sure you wish to continue?")
        cleanData = ""
        $.blockUI message: "<h1>Removing All Attendees...</h1>"
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
              $.unblockUI()
              clearSelectedMembers()
              updateRegistrants nId, nStatus
            else
              addError data.STATUSMSG, 250, 6000, 4000
              updateActions()
              updateStats()
              $.unblockUI()
              updateRegistrants()


    
    # PRINT SELECTED ONLY START 
    $("#PrintCMECert").bind "click", this, -> #CME CERTS
      if $("#PrintSelected").attr("checked") is "checked"
        window.open "http://www.getmycme.com/activities/" + nActivity + "/certificates?attendees=" + SelectedAttendees
      else
        window.open sMyself + "Report.CMECert?ActivityID=" + nActivity + "&ReportID=5"

    $("#PrintCNECert").bind "click", this, -> #CNE CERTS
      if $("#PrintSelected").attr("checked") is "checked" #CHECK IF PRINTSELECTED IS CHECKED
        unless SelectedAttendees is ""
          window.open sMyself + "Report.CNECert?ActivityID=' nActivity + '&ReportID=6&SelectedAttendees=" + SelectedAttendees
        else
          addError "You must select registrants", 250, 6000, 4000
      else
        window.open sMyself + "Report.CNECert?ActivityID=" + nActivity + "&ReportID=6"

    $(".PrintSigninSheet").bind "click", this, -> #CME CERTS
      if $("#PrintSelected").attr("checked") is "checked" #CHECK IF PRINTSELECTED IS CHECKED
        unless SelectedAttendees is ""
          if $.ListGetAt(@id, 2, "|") is "Y"
            window.open sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=1&ReportID=12&SelectedAttendees=" + SelectedAttendees
          else
            window.open sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=0&ReportID=12&SelectedAttendees=" + SelectedAttendees
        else
          addError "You must select registrants", 250, 6000, 4000
      else
        if $.ListGetAt(@id, 2, "|") is "Y"
          window.open sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=1&ReportID=12"
        else
          window.open sMyself + "Report.SigninSheet?ActivityID=" + nActivity + "&ssn=0&ReportID=12"

    $("#PrintMailingLabels").bind "click", this, -> #MAILING LABELS
      if $("#PrintSelected").attr("checked") is "checked" #CHECK IF PRINTSELECTED IS CHECKED
        unless SelectedMembers is ""
          window.open sMyself + "Report.MailingLabels?ActivityID=" + nActivity + "&ReportID=3&Print=1&SelectedAttendees=" + SelectedAttendees
        else
          addError "You must select registrants", 250, 6000, 4000
      else
        window.open sMyself + "Report.MailingLabels?ActivityID=" + nActivity + "&ReportID=3&Print=1"

    $("#PrintNameBadges").bind "click", this, -> #NAME BADGES
      if $("#PrintSelected").attr("checked") is "checked" #CHECK IF PRINTSELECTED IS CHECKED
        unless SelectedMembers is ""
          window.open sMyself + "Report.NameBadges?ActivityID=" + nActivity + "&SelectedMembers=" + SelectedMembers
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
          updateRegistrants()
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
          updateRegistrants()
          $(".newImportDialog").find("iframe").attr "src", "<cfoutput>#Application.Settings.apiUrl#</cfoutput>/imports?importable_id=" + nActivity
          $(".newImportDialog").dialog "close"

    $(".batchLink").click ->
      $(".newImportDialog").dialog "open"

    # UPDATED SELECTED MEMBER COUNT
    $("#CheckedCount,#label-status-selected").html "" + SelectedCount + ""
    $(".EditDateField").mask "99/99/9999 99:99aa"

    # CHECK/UNCHECK ALL CHECKBOXES 
    $("#CheckAll").click ->
      if $("#CheckAll").attr("checked")
        $(".AllAttendees").each ->
          $row = $(this)
          $checkBox = $row.find(".MemberCheckbox")
          nPerson = $row.find(".personId").val()
          nAttendee = $row.find(".attendeeId").val()
          
          # ADD CURRENT MEMBER TO SELECTEDMEMBERS LIST
          addSelectedAttendee
            person: nPerson
            attendee: nAttendee

          $checkBox.attr "checked", true
          
          # CHANGE BACKGROUND COLOR OF PERSONROW
          $row.css "background-color", "#FFD"

      else
        $(".AllAttendees").each ->
          $row = $(this)
          $checkBox = $row.find(".MemberCheckbox")
          nPerson = $row.find(".personId").val()
          nAttendee = $row.find(".attendeeId").val()
          
          # ADD CURRENT MEMBER TO SELECTEDMEMBERS LIST
          removeSelectedPerson
            person: nPerson
            attendee: nAttendee

          $checkBox.attr "checked", false
          
          # CHANGE BACKGROUND COLOR OF PERSONROW
          $row.css "background-color", "#FFF"


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


    $("#PersonDetail").dialog
      title: "Person Detail"
      modal: true
      autoOpen: false
      height: 550
      width: 855
      position: [100, 100]
      resizable: false
      dragStop: (ev, ui) ->

      open: ->
        $("#frameDetail").attr "src", sMyself + "Person.Detail?PersonID=" + nPersonID + "&Mini=1"

      close: ->

      resizeStop: (ev, ui) ->

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
            updateRegistrants nId
          else
            addError statusMsg, 250, 6000, 4000
            $("#editdatecontainer-" + nAttendee).hide()
            $("#datefill-" + nAttendee).show()
            $("#editdatelink-" + nAttendee).show()

      else
        addError "You must provide full date and time.", 250, 6000, 4000
        $("#EditDateField-" + nAttendee).focus()
        $("#EditDateField-" + nAttendee).val dtStatusMask
    return
  pub =
    init: _init