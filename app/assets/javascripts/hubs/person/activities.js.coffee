###
* PERSON > ACTIVITIES
###
App.module "Person.Activities", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  $base = null
  $transcriptDates = null
  @config =
    transcript:
      height:50
      width:50

  moveMarkup = '<div class="js-move-activities modal">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                      <h3 id="myModalLabel">Move Activities</h3>
                  </div>
                  <div class="modal-body">
                    <form action="" method="post" name="formMoveActivities" class="form-horizontal">
                      <div class="control-group">
                        <label class="control-label">From</label>
                        <div class="controls">
                          <input type="text" name="moveFromPersonID" class="js-typeahead-person-from" />
                        </div>
                      </div>
                      <div class="control-group">
                        <label class="control-label">Move To</label>
                        <div class="controls">
                          <input type="text" name="moveToPersonID" class="js-typeahead-person-to" />
                        </div>
                      </div>
                      <div class="control-group">
                        <div class="controls"><input type="submit" value="Move Activities" /></div>
                      </div>
                    </form>
                  </div>
                  <div class="modal-footer">
                    <button class="btn btn-primary">Move Now</button>
                    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
                  </div>
                </div>'
  

  @on "before:start", ->
    App.logInfo "starting: Person.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      $base = $("#js-person-activities")
      _init()
      App.logInfo "started: Person.#{Self.moduleName}"
    return
  @on "stop", ->
    App.logInfo "stopped: Person.#{Self.moduleName}"
    return

  _init = () ->
    $transcriptMenu = $base.find ".js-transcript-menu"
    $transcriptDates = $base.find ".js-transcript-date"
    $transcriptStart = $($transcriptDates[0])
    $transcriptEnd = $($transcriptDates[1])
    $transcriptButton = $base.find ".js-transcript-button"

    $moveScreen = $(moveMarkup)
    $moveForm = $moveScreen.find('form')
    $moveFromInput = $($moveForm.find(".js-typeahead-person-from"))
    $moveToInput = $($moveForm.find(".js-typeahead-person-to"))
    $moveFromInput.uiTypeahead
          showImage: false
          allowAdd: false
          # ajaxAddURL: "/admin/_com/AJAX_System.cfc"
          # ajaxAddParams:
          #   method: "saveSupporter"
          #   returnformat: "plain"
          ajaxSearchURL: "/admin/_com/ajax/typeahead.cfc"
          ajaxSearchParams:
            method: "search"
            type: "person"
          defaultValue:
            id: App.Person.model.get('id')
            label: App.Person.model.get('name')
            value: App.Person.model.get('id')
    $moveToInput.uiTypeahead
          showImage: false
          allowAdd: false
          # ajaxAddURL: "/admin/_com/AJAX_System.cfc"
          # ajaxAddParams:
          #   method: "saveSupporter"
          #   returnformat: "plain"
          ajaxSearchURL: "/admin/_com/ajax/typeahead.cfc"
          ajaxSearchParams:
            method: "search"
            type: "person"
    $moveForm.submit ->

      return false
    $moveModal = $moveScreen.modal
      backdrop:true
      keyboard:true
      show:false

    $transcriptButton.on "click", ->
      startDate = Date.parseString $transcriptStart.val()
      endDate = Date.parseString $transcriptEnd.val()

      unless _.isDate(startDate) and _.isDate(endDate)
        return addError "Please ensure you have specified a valid Start and End Date."

      formattedStartDate = startDate.format 'MM/dd/yyyy'
      formattedEndDate = endDate.format 'MM/dd/yyyy'

      openTranscript formattedStartDate,formattedEndDate
    
    $moveBtn = $base.find(".js-moveactivities")

    $moveBtn.on "click", ->
      $moveModal.modal "show"
      return
    #prevents fields from closing menu
    $transcriptMenu.next().find("form").on "click", (e) ->
      e.stopPropagation()

      return

    #sets up jqui datepicker
    $transcriptDates.datepicker
      showOn: "button"
      buttonImage: "/admin/_images/icons/calendar.png"
      buttonImageOnly: true
      showButtonPanel: true
      changeMonth: true
      changeYear: true
    return

  openTranscript = (start,end) ->
    cfg = Self.config.transcript
    windowSettings = "height=#{cfg.height},width=#{cfg.width},location=0,menubar=0,resizable=no,scrollbars=0,status=0,centerscreen=yes"
    urlPath = "#{App.config.get('apiUrl')}/users/#{App.Person.data.id}/transcript?startdate=#{start}&enddate=#{end}"
    transcriptWindow = window.open(
      urlPath,
      "transcript_show",
      windowSettings
    )

    transcriptWindow.focus() if window.focus
    false
  moveActivities = ->
    unless $("#MoveActivitiesID").val() is ""
      bMove = confirm("Are you sure you want to move the activites from " + sFullName + " to" + $.ListGetAt($("#MoveActivitiesName").val(), 2, ",") + $.ListGetAt($("#MoveActivitiesName").val(), 1, ",") + "?")
      if bMove
        nPersonID = $("#MoveActivitiesID").val()
        sPersonName = $.ListGetAt($("#MoveActivitiesName").val(), 2, ",") + $.ListGetAt($("#MoveActivitiesName").val(), 1, ",")
        $.getJSON sRootPath + "/_com/AJAX_Person.cfc",
          method: "moveActivities"
          MoveToPersonID: nPersonID
          MoveToName: sPersonName
          MoveFromPersonID: nPerson
          MoveFromName: sFullName
          returnFormat: "plain"
        , (data) ->
          window.location = sMyself + "Person.Activities?PersonID=" + nPersonID + "&Message=" + data.STATUSMSG
