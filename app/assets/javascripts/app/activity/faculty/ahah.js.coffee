###
* ACTIVITY > FACULTY
###
App.module "Activity.Faculty.Ahah", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  Parent = App.Activity.Faculty
  nPersonID = null
  sPersonName = null
  @on "before:start", ->
    App.logInfo "starting: Activity.Faculty.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Activity.Faculty.#{Self.moduleName}"
    return
  @on "stop", ->
    $("#FacultyContainer").empty()
    App.logInfo "stopped: Activity.Faculty.#{Self.moduleName}"
    return


  CurrPersonID = null
  _destroy = ->
    # $(".js-cv-box").tooltip 'hide'
    # $(".js-disclosure-box").tooltip 'hide'
    #$("#FacultyContainer *").unbind()

    return
  _init = (defaults) ->
    $selectAll = $("#FacultyContainer").find(".js-select-all")
    $selectOne = $("#FacultyContainer").find(".js-select-one")
    $cvBtn = $(".js-cv-btn")
    $discBtn = $(".js-disclosure-btn")

    $cvBtn.tooltip
      placement: 'bottom'
      trigger:'hover focus'
      container: '#FacultyContainer'
      title: ->
        $(this).attr('data-tooltip-title')
    

    $discBtn.tooltip
      placement: 'bottom'
      trigger:'hover focus'
      container: '#FacultyContainer'
      title: ->
        $(this).attr('data-tooltip-title')

    $selectAll.on "click", ->
      App.logDebug "selectAll Clicked"
      if $selectAll.attr("checked")
        $selectOne.each ->
          $(this).attr "checked", true
          nPersonID = $.Replace(@id, "Checked", "", "ALL")
          Parent.addSelected
            person: nPersonID
          $(".AllFaculty").css "background-color", "#FFD"

      else
        $selectOne.each ->
          $(this).attr "checked", false
          nPersonID = $.Replace(@id, "Checked", "", "ALL")
          Parent.removeSelected
            person: nPersonID
          $(".AllFaculty").css "background-color", "#FFF"
      return

    $selectOne.on "click", ->
      App.logDebug "selectOne Clicked"
      if $(this).attr("checked")
        nPersonID = $.Replace(@id, "Checked", "", "ALL")
        Parent.addSelected
          person: nPersonID
        $("#PersonRow" + nPersonID).css "background-color", "#FFD"
      else
        nPersonID = $.Replace(@id, "Checked", "", "ALL")
        Parent.removeSelected
          person: nPersonID
        $("#PersonRow" + nPersonID).css "background-color", "#FFF"
      return

    $("#PersonDetail").dialog
      title: "Person Detail"
      modal: true
      autoOpen: false
      height: 550
      width: 855
      resizable: false
      dragStop: (ev, ui) ->

      open: ->
        $(this).find('iframe').attr "src", sMyself + "Person.Detail?PersonID=" + nPersonID + "&Mini=1"

      close: ->

      resizeStop: (ev, ui) ->

    $(".PersonLink").on "click", (e) ->
      $row = $(this).parents('.js-row')
      nPersonID = $row.data('key')
      sPersonName = $row.data('name')
      $("#PersonDetail").dialog "open",
      e.preventDefault()
      return false


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
    $(".UploadFile").on "click", ->
      CurrPersonID = $.ListGetAt(@id, 2, "|")
      App.logDebug(CurrPersonID)
      $("#FileUploader").dialog "open"
      return

    # FACULTY FILE APPROVAL 
    $(".approveFile").on "click", ->
      sApprovalType = $.ListGetAt(@id, 1, "|")
      sFileType = $.ListGetAt(@id, 2, "|")
      nPersonID = $.ListGetAt(@id, 3, "|")
      $.ajax
        url: sRootPath + "/_com/AJAX_Activity.cfc"
        type:'post'
        dataType:'json'
        data:
          method: "approveFacultyFile"
          ActivityID: nActivity
          PersonID: nPersonID
          FileType: sFileType
          Mode: sApprovalType
          returnFormat: "plain"
        success: (data) ->
          console.log "hello"
          if data.STATUS
            App.Activity.Faculty.refresh()
            addMessage data.STATUSMSG, 250, 6000, 4000
          else
            App.Activity.Faculty.refresh()
            addError data.STATUSMSG, 250, 6000, 4000
          return
      return

    # // END NOTES DIALOG 

    # PHOTO UPLOAD DIALOG 
    # $("#PhotoUpload").dialog
    #   title: "Upload Photo"
    #   modal: false
    #   autoOpen: false
    #   height: 120
    #   width: 450
    #   resizable: false
    #   open: ->
    #     $("#PhotoUpload").show()

    # $("img.PersonPhoto").click ->
    #   nPersonID = $.Replace(@id, "Photo", "", "ALL")
    #   $("#frmUpload").attr "src", sMyself + "Person.PhotoUpload?PersonID=" + nPersonID + "&ElementID=" + @id
    #   $("#PhotoUpload").dialog "open"


    # // END PHOTO UPLOAD DIALOG 



    

    #App.logInfo "init: faculty"