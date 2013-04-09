###
* ACTIVITY > FACULTY
###
App.module "Activity.Faculty", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  Self.el = {}
  $container = Self.el.$container = null
  $loading = Self.el.$loading = null

  @on "before:start", ->
    App.logInfo "starting: #{Self.moduleName}"
    return
  
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: #{Self.moduleName}"
    return
  
  @on "stop", ->
    App.logInfo "stopped: #{Self.moduleName}"
    return

  @on "refreshStart", ->
    #stop AHAH module
    Self.Ahah.stop()
    return

  @on "refreshEnd", ->
    Self.Ahah.start()
    return

  
  _init = (defaults) ->
    Self.el.$container = $container =  $("#FacultyContainer")
    Self.el.$loading = $loading = $("#FacultyLoading")
    refresh()
    
    $("#FacultyList").ajaxForm()

    # REMOVE ONLY CHECKED 
    $("#RemoveChecked").bind "click", ->
      if confirm("Are you sure you want to remove the checked people from this Activity?")
        result = ""
        cleanData = ""
        $(".MemberCheckbox:checked").each ->
          result = $.ListAppend(result, $(this).val(), ",")

        $.blockUI message: "<h1>Removing Selected Faculty Members...</h1>"
        $.getJSON sRootPath + "/_com/AJAX_Activity.cfc",
          method: "removeCheckedFaculty"
          PersonList: result
          ActivityID: nActivity
          returnFormat: "plain"
        , (data) ->
          if data.STATUS
            addMessage data.STATUSMSG, 250, 6000, 4000
          else
            addError data.STATUSMSG, 250, 6000, 4000
          refresh()
          
          #updateActions();
          $.unblockUI()



    # REMOVE ALL PEOPLE FROM Activity 
    $("#RemoveAll").bind "click", ->
      if confirm("WARNING!\nYou are about to remove ALL people from this Activity!\nAre you sure you wish to continue?")
        cleanData = ""
        #$.blockUI message: "<h1>Removing All Faculty Members...</h1>"
        $.getJSON sRootPath + "/_com/AJAX_Activity.cfc",
          method: "removeAllFaculty"
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



    # CHANGE FACULTY ROLE START 
    $("#btnRoleSubmit").bind "click", ->
      result = ""
      nActivityRole = $("#ActivityRoles").val()
      #$.blockUI message: "<h1>Updating information...</h1>"
      $(".MemberCheckbox:checked").each ->
        result = $.ListAppend(result, $(this).val(), ",")
        return

      $.ajax
        url: sRootPath + "/_com/AJAX_Activity.cfc"
        type:'get'
        dataType:'json'
        data: 
          method: "changeFacultyRoles"
          PersonList: result
          ActivityID: nActivity
          RoleID: $("#RoleID").val()
          returnFormat: "plain"
        success: (data) ->
          if data.STATUS
            addMessage data.STATUSMSG, 250, 6000, 4000
            #$.unblockUI()
            refresh()
          else
            addError data.STATUSMSG, 250, 6000, 4000
            #$.unblockUI()
          return
      return



    # CHANGE FACULTY ROLE END 
    #App.logInfo "init: faculty"

  saveFacultyMember = Self.save = () ->
    #$.blockUI({ message: '<h1>Adding Faculty Member...</h1>'});
    $.ajax
      url:sRootPath + "/_com/AJAX_Activity.cfc"
      type:'post'
      data:
        method: "saveFacultyMember"
        PersonID: $("#FacultyID").val()
        ActivityID: nActivity
        returnFormat: "plain"
      success: (returnData) ->
        cleanData = $.trim(returnData);
        status = $.ListGetAt(cleanData,1,"|");
        statusMsg = $.ListGetAt(cleanData,2,"|");

        if status is 'Success'
          refresh();
          #updateActions();
          addMessage(statusMsg,250,6000,4000);
          #$.unblockUI();
        else if status is 'Fail'
          addError(statusMsg,250,6000,4000);
          #$.unblockUI();
          $("#FacultyName").val("Click Here to Search")

        return
    
    $("#PersonActivityID").val('')
    $("#PersonActivityName").val('Click Here To Search')
    return
  
  refresh = Self.refresh = () ->
    Self.trigger('refreshStart')
    Self.el.$loading.show()
    $.ajax
      url: sMyself + "Activity.FacultyAHAH" 
      type:'get'
      data: 
        ActivityID: nActivity
      success: (data) ->
        Self.el.$container.html(data)
        Self.el.$loading.hide()
        Self.trigger('refreshEnd')
        return
    return
  