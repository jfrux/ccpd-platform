###
* ACTIVITY > CREATE FORM
###
App.module "Activity.Create", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  FormState = null
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
    #FormState.stop()
    FormState = null
    return

  updateStateProvince = (countryId) ->
    #App.logInfo countryId
    if parseInt(countryId) == 230
      #App.logInfo("is united states")
      $(".stateField").show()
      $(".provinceField").hide()
    else
      #App.logInfo("is not united states")
      $(".stateField").hide().css display: "none"
      $(".provinceField").show()
  setSessionType = (sSessionType) ->
    if sSessionType is "M"
      $(".Sessions").fadeIn()
      $(".SingleSession").fadeOut()
    else
      $(".Sessions").fadeOut()
      $(".SingleSession").fadeIn()
  setActivityType = (nActivityType) ->
    if parseInt(nActivityType) is 1
      $("#Grouping").html LiveOptions
      $("#Groupings").show()
      $(".Location").show()
    else if parseInt(nActivityType) is 2
      $("#Groupings").show()
      $("#Grouping").html EMOptions
    else
      $("#Groupings").hide()
      $("#Grouping").html ""
      $(".Location").hide()
    updateStateProvince parseInt($("#Country").val())

  _init = () ->
    console.log('in');
    # $(".linkbar a").one "click",->
    #   Self.stop()
    #   return true
    FormState = new App.Components.FormState
      el:'#js-activity-detail .js-formstate'
      saved: true
      
    #App.logInfo "init: generalinfo
    #            \nactivity type: #{nActivityType}
    #            \nsession type: #{sSessionType}
    #            \ncountry: #{nCountryId}"

    updateStateProvince nCountryId

    $("#Country").change () ->
      updateStateProvince parseInt($(this).val())
      return

    # $("#Title").autocomplete sRootPath + "/_com/AJAX_Activity.cfc?method=AutoComplete&returnformat=plain"
    # $("#Sponsor").autocomplete sRootPath + "/_com/AJAX_Activity.cfc?method=JointlyAutoComplete&returnformat=plain"
    $("#ActivityType").bind "change", this, ->
      setActivityType parseInt($(this).val())

    $("#SessionType").change ->
      setSessionType $(this).val()

    if !!nActivityType
      $("#ActivityType").val parseInt(nActivityType)
      setActivityType parseInt(nActivityType)
      $("#Grouping").val parseInt(nGrouping)  if nGrouping
    if !!sSessionType
      $("#SessionType").val sSessionType
      setSessionType sSessionType
    
    # CHECK IF SPONSORSHIP IS JOINTLY OR DIRECTLY START 
    if $("#Sponsorship").val() is "J"
      $(".js-sponsorship-J").addClass "active"
      $("#JointlyTextFld").removeClass "hide"
    else
      $(".js-sponsorship-D").addClass "active"
      $("#JointlyTextFld").addClass "hide"
      
    $(".js-sponsorship-toggle").bind "click", (e) ->
      $this = $(this)
      if $this.hasClass("js-sponsorship-J")
        FormState.Unsaved()
        FormState.AddChange "Sponsorship", "J"
        FormState.AddChange "Sponsor", $("#Sponsor").val()
        $("#Sponsorship").val "J"
        $("#JointlyTextFld").removeClass "hide"
      else
        FormState.Unsaved()
        FormState.AddChange "Sponsorship", "D"
        $("#Sponsorship").val "D"
        $("#JointlyTextFld").addClass "hide"
      e.preventDefault()
      return
    return