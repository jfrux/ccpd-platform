###
* ACTIVITY > COMMITTEE
###
App.module "Activity.Committee", (Self, App, Backbone, Marionette, $) ->
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
    
  addSelected = Self.addSelected = (params) ->
    settings = $.extend({}, params)
    if settings.person and settings.person > 0
      if !$.ListFind(selected, settings.person, ",")
        selected = $.ListAppend(selected, settings.person, ",")
        updateSelectedCount 1
    App.logDebug selected
    return

  removeSelected = Self.removeSelected = (params) ->
    settings = $.extend({}, params)
    if settings.person and settings.person > 0
      if $.ListFind(selected, settings.person, ",")
        selected = $.ListDeleteAt(selected, $.ListFind(selected, settings.person))  if settings.person and settings.person > 0
        updateSelectedCount -1
    App.logDebug selected
    return

  setRole = Self.setRole = (persons,role) ->
    $.ajax
      url: sRootPath + "/_com/AJAX_Activity.cfc"
      type:'post'
      dataType:'json'
      data: 
        method: "changeCommitteeRoles"
        PersonList: persons
        ActivityID: nActivity
        RoleID: role
        returnFormat: "plain"
      success: (data) ->
        if data.STATUS
          addMessage data.STATUSMSG, 250, 6000, 4000
          #$.unblockUI()
          #
        else
          addError data.STATUSMSG, 250, 6000, 4000
          #$.unblockUI()
        return refresh()
    return

  refresh = Self.refresh = () ->
    Self.trigger('refreshStart')
    # Self.el.$loading.show()
    # Self.el.$container.empty()
    $.ajax
      url: sMyself + "Activity.CommitteeAHAH" 
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
            nPerson = $row.data('key')

            if $.ListFind(selected,nPerson)
              $checkBox.attr 'checked',true
        setDefaults()
        Self.trigger('refreshEnd')
        return

    return

  saveCommitteeMember = Self.save = () ->
    #$.blockUI({ message: '<h1>Adding Committee Member...</h1>'});
    nCommittee = $("#CommitteeID").val()
    $.ajax
      url:sRootPath + "/_com/AJAX_Activity.cfc"
      type:'post'
      data:
        method: "saveCommitteeMember"
        PersonID: nCommittee
        ActivityID: nActivity
        returnFormat: "plain"
      success: (returnData) ->
        cleanData = $.trim(returnData);
        status = $.ListGetAt(cleanData,1,"|");
        statusMsg = $.ListGetAt(cleanData,2,"|");

        if status is 'Success'
          #SETUP DEFAULT ROLE
          setRole(nCommittee,1)
          refresh();
          $("#PersonWindowCommittee").dialog("close")
          #updateActions();
          addMessage(statusMsg,250,6000,4000);
          #$.unblockUI();
        else if status is 'Fail'
          refresh();
          $("#PersonWindowCommittee").dialog("close")
          addError(statusMsg,250,6000,4000);
          #$.unblockUI();
          #$("#CommitteeName").val("Click Here to Search")

        return
    
    $("#PersonActivityID").val('')
    #$("#PersonActivityName").val('Click Here To Search')
    return
  _init = (defaults) ->
    Self.el.$container = $container =  $("#CommitteeContainer")
    Self.el.$loading = $loading = $("#CommitteeLoading")
    refresh()
    $("#CommitteeList").ajaxForm()

    # REMOVE ONLY CHECKED 
    $("#RemoveChecked").on "click", ->
      if confirm("Are you sure you want to remove the checked people from this Activity?")
        result = ""
        cleanData = ""
        $(".MemberCheckbox:checked").each ->
          result = $.ListAppend(result, $(this).val(), ",")
          return
        #$.blockUI message: "<h1>Removing Selected Committee Members...</h1>"
        $.ajax 
          url: sRootPath + "/_com/AJAX_Activity.cfc"
          dataType:'json'
          data:
            method: "removeCheckedCommittee"
            PersonList: result
            ActivityID: nActivity
            returnFormat: "plain"
          success: (data) ->
            if data.STATUS
              clearSelected()
              addMessage data.STATUSMSG, 250, 6000, 4000
            else
              addError data.STATUSMSG, 250, 6000, 4000
            refresh()
            return



    # REMOVE ALL PEOPLE FROM Activity 
    $("#RemoveAll").on "click", ->
      if confirm("WARNING!\nYou are about to remove ALL people from this Activity!\nAre you sure you wish to continue?")
        cleanData = ""
        #$.blockUI message: "<h1>Removing All Committee Members...</h1>"
        $.getJSON sRootPath + "/_com/AJAX_Activity.cfc",
          method: "removeAllCommittee"
          ActivityID: nActivity
          returnFormat: "plain"
        , (data) ->
          if data.STATUS
            addMessage data.STATUSMSG, 250, 6000, 4000
          else
            addError data.STATUSMSG, 250, 6000, 4000
          refresh()
          
          #updateActions();
          #$.unblockUI()
    # $(".linkbar a").one "click",->
    #   Self.stop()
    #   return true
    # CHANGE FACULTY ROLE START 
    $(".js-change-type").on "click", (e) ->
      nActivityRole = $(this).data('roleid')
      result = ""
      #$.blockUI message: "<h1>Updating information...</h1>"
      $(".MemberCheckbox:checked").each ->
        result = $.ListAppend(result, $(this).val(), ",")
        return

      setRole result,nActivityRole

      e.preventDefault()
      return
    return
  # OTHER FUNCTIONS GO BELOW HERE