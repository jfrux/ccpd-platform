###
* ACTIVITY > FACULTY
###
App.module "Activity.Faculty.Ahah", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false

  @on "before:start", ->
    App.logInfo "starting: Activity.Faculty.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Activity.Faculty.#{Self.moduleName}"
    return
  @on "stop", ->
    _destroy()
    App.logInfo "stopped: Activity.Faculty.#{Self.moduleName}"
    return

  $disclosureBoxes = null
  $disclosureButtons = null
  $cvBoxes = null

  _destroy = ->
    $(".js-cv-box").tooltip 'hide'
    $(".js-disclosure-box").tooltip 'hide'
    $("#FacultyContainer *").unbind()

    return
  _init = (defaults) ->
    $(".js-cv-box").tooltip
      placement: 'bottom'
      trigger:'hover focus'
      container: 'body'
      title: ->
        $(this).attr('data-tooltip-title')

    $(".js-disclosure-btn").tooltip
      placement: 'bottom'
      trigger:'hover focus'
      container: 'body'
      title: ->
        $(this).attr('data-tooltip-title')

    $("#PersonDetail").dialog
      title: "Person Detail"
      modal: true
      autoOpen: false
      height: 550
      width: 855
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


    # NOTES DIALOG 
    $("#FileUploader").dialog
      title: "Upload File"
      modal: false
      autoOpen: false
      height: 320
      width: 350
      resizable: false
      stack: false
      buttons:
        Save: ->
          $("#frmFileUpload").ajaxSubmit
            beforeSubmit: -> # pre-submit callback
              $("#Section" + CurrPersonID).html "<img src=\"/admin/_images/ajax-loader.gif\"/><br />Please wait..."

            url: sMyself + "File.Upload&Mode=Person&ModeID=" + CurrPersonID + "&ActivityID=" + nActivity + "&Submitted=1"
            type: "post"
            success: -> # post-submit callback
              $("#FileUploader").html ""
              addMessage "File uploaded successfully.", 250, 6000, 4000
              $("#FileUploader").dialog "close"


        Cancel: ->
          $(this).dialog "close"
          App.Activity.Faculty.refresh()

      open: ->
        $.post sMyself + "File.Upload",
          Mode: "Person"
          ModeID: CurrPersonID
          ActivityID: nActivity
        , (data) ->
          $("#FileUploader").html data


      close: ->
        App.Activity.Faculty.refresh()


    #updateActions();
    $(".UploadFile").click ->
      CurrPersonID = $.ListGetAt(@id, 2, "|")
      $("#FileUploader").dialog "open"


    # // END NOTES DIALOG 

    # PHOTO UPLOAD DIALOG 
    $("#PhotoUpload").dialog
      title: "Upload Photo"
      modal: false
      autoOpen: false
      height: 120
      width: 450
      resizable: false
      open: ->
        $("#PhotoUpload").show()

    $("img.PersonPhoto").click ->
      nPersonID = $.Replace(@id, "Photo", "", "ALL")
      $("#frmUpload").attr "src", sMyself + "Person.PhotoUpload?PersonID=" + nPersonID + "&ElementID=" + @id
      $("#PhotoUpload").dialog "open"


    # // END PHOTO UPLOAD DIALOG 

    # FACULTY FILE APPROVAL 
    $(".approveFile").click ->
      sApprovalType = $.ListGetAt(@id, 1, "|")
      sFileType = $.ListGetAt(@id, 2, "|")
      nPersonID = $.ListGetAt(@id, 3, "|")
      $.ajax
        url: sRootPath + "/_com/AJAX_Activity.cfc"
        type:'post'
        data:
          method: "approveFacultyFile"
          ActivityID: nActivity
          PersonID: nPersonID
          FileType: sFileType
          Mode: sApprovalType
          returnFormat: "plain"
        success: (data) ->
          if data.STATUS
            #App.Activity.Faculty.refresh()
            addMessage data.STATUSMSG, 250, 6000, 4000
          else
            #App.Activity.Faculty.refresh()
            addError data.STATUSMSG, 250, 6000, 4000


    $("#CheckAll").click ->
      if $("#CheckAll").attr("checked")
        $(".MemberCheckbox").each ->
          $(this).attr "checked", true
          $(".AllFaculty").css "background-color", "#FFD"

      else
        $(".MemberCheckbox").each ->
          $(this).attr "checked", false
          $(".AllFaculty").css "background-color", "#FFF"


    $(".MemberCheckbox").bind "click", this, ->
      if $(this).attr("checked")
        nPersonID = $.Replace(@id, "Checked", "", "ALL")
        $("#PersonRow" + nPersonID).css "background-color", "#FFD"
      else
        nPersonID = $.Replace(@id, "Checked", "", "ALL")
        $("#PersonRow" + nPersonID).css "background-color", "#FFF"

    #App.logInfo "init: faculty"