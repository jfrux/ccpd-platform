###
* ACTIVITY > COMMITTEE > AHAH
###
App.module "Activity.Committee.Ahah", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  Parent = App.Activity.Committee
  nPersonID = null
  sPersonName = null
  
  @on "before:start", ->
    App.logInfo "starting: Activity.Committee.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Activity.Committee.#{Self.moduleName}"
    return
  @on "stop", ->
    $("#CommitteeContainer").empty()
    App.logInfo "stopped: Activity.Committee.#{Self.moduleName}"
    return


  CurrPersonID = null
  _destroy = ->
    # $(".js-cv-box").tooltip 'hide'
    # $(".js-disclosure-box").tooltip 'hide'
    #$("#CommitteeContainer *").unbind()

    return
  _init = (defaults) ->
    $selectAll = $("#CommitteeContainer").find(".js-select-all")
    $selectOne = $("#CommitteeContainer").find(".js-select-one")

    $selectAll.on "click", ->
      App.logDebug "selectAll Clicked"
      if $selectAll.attr("checked")
        $selectOne.each ->
          $(this).attr "checked", true
          nPersonID = $.Replace(@id, "Checked", "", "ALL")
          Parent.addSelected
            person: nPersonID
          $(".js-select-all-rows").find('td').css "background-color", "#FFD"

      else
        $selectOne.each ->
          $(this).attr "checked", false
          nPersonID = $.Replace(@id, "Checked", "", "ALL")
          Parent.removeSelected
            person: nPersonID
          $(".js-select-all-rows").find('td').css "background-color", "#FFF"
      return

    $selectOne.on "click", ->
      App.logDebug "selectOne Clicked"
      if $(this).attr("checked")
        nPersonID = $.Replace(@id, "Checked", "", "ALL")
        Parent.addSelected
          person: nPersonID
        $("#PersonRow" + nPersonID).find('td').css "background-color", "#FFD"
      else
        nPersonID = $.Replace(@id, "Checked", "", "ALL")
        Parent.removeSelected
          person: nPersonID
        $("#PersonRow" + nPersonID).find('td').css "background-color", "#FFF"
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
        return
      close: ->
        return
      resizeStop: (ev, ui) ->

    $(".PersonLink").on "click", (e) ->
      $row = $(this).parents('.js-row')
      nPersonID = $row.data('key')
      sPersonName = $row.data('name')
      $("#PersonDetail").dialog "open",
      e.preventDefault()
      return false

    
    return