###
* ACTIVITY > Participants > AHAH
###
App.module "Activity.Participants.Ahah", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  Parent = App.Activity.Participants
  nPersonID = null
  sPersonName = null
  
  @on "before:start", ->
    App.logInfo "starting: Activity.Participants.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Activity.Participants.#{Self.moduleName}"
    return
  @on "stop", ->
    $("#ParticipantsContainer").empty()
    App.logInfo "stopped: Activity.Participants.#{Self.moduleName}"
    return
    
  CurrPersonID = null
  _destroy = ->
    # $(".js-cv-box").tooltip 'hide'
    # $(".js-disclosure-box").tooltip 'hide'
    #$("#ParticipantsContainer *").unbind()

    return
  _init = (defaults) ->
    $selectAll = $("#ParticipantsContainer").find(".js-select-all")
    $selectOne = $("#ParticipantsContainer").find(".js-select-one")
    
    $selectAll.on "click", ->
      App.logDebug "selectAll Clicked"
      if $selectAll.attr("checked")
        $selectOne.each ->
          $this = $(this)
          $row = $this.parents('.js-row')
          $this.attr "checked", true
          id = $row.data('key')
          Parent.addSelected id
          $(".js-select-all-rows").find('td').css "background-color", "#FFD"
      else
        $selectOne.each ->
          $this = $(this)
          $row = $this.parents('.js-row')
          $this.attr "checked", false
          id = $row.data('key')
          Parent.removeSelected id
          $(".js-select-all-rows").find('td').css "background-color", "#FFF"
      return

    $selectOne.on "click", ->
      $this = $(this)
      $row = $this.parents('.js-row')
      App.logDebug "selectOne Clicked"
      if $this.attr("checked")
        id = $row.data('key')
        Parent.addSelected id
        $("#PersonRow" + nPersonID).find('td').css "background-color", "#FFD"
      else
        id = $row.data('key')
        Parent.removeSelected id
        $("#PersonRow" + nPersonID).find('td').css "background-color", "#FFF"
      return

    

    $(".js-row").each ->
      $row = $(this)
      row_id = $row.data('key')
      person_id = $row.data('personkey')

      if(person_id > 0)
        $personLink = $row.find('.PersonLink')
      
        $personLink.on "click", (e) ->
          id = $row.data('key')
          name = $row.data('name')
          $("#PersonDetail").dialog "open",
          e.preventDefault()
          return false
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
            return
          close: ->
            return
          resizeStop: (ev, ui) ->
      else
        $deleteLink = $row.find(".deleteLink")
        $deleteLink.one "click", ->
          $.ajax
            type: "post"
            url: "/admin/_com/ajax_activity.cfc"
            dataType: "json"
            data:
              method: "removeAttendeeByID"
              attendeeId: row_id
            async: false
            success: (data) ->
              $row.remove()  if data.STATUS

      $row.find('.StatusDate .label').popover
        placement: 'top',
        trigger: 'hover',
        html:true,
        container:'body'
    
    App.logInfo("binding records")
    
    # UPDATED SELECTED MEMBER COUNT
    $(".js-status-selected-count").text(SelectedCount)
    
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
    return