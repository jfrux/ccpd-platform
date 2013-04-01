###
* ACTIVITY > GENERAL INFORMATION
###
App.activity.general = do (activity = App.activity,{App,$,Backbone} = window) ->
  updateStateProvince = (countryId) ->
    #console.log countryId
    if parseInt(countryId) == 230
      #console.log("is united states")
      $(".stateField").show()
      $(".provinceField").hide()
    else
      #console.log("is not united states")
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

  _init = ->
    App.components.formstate.init()
    console.log "init: generalinfo
                \nactivity type: #{nActivityType}
                \nsession type: #{sSessionType}
                \ncountry: #{nCountryId}"

    updateStateProvince nCountryId

    $("#Country").change () ->
      updateStateProvince parseInt($(this).val())
      return

    $(".DatePicker").datepicker
      showOn: "button"
      buttonImage: "/admin/_images/icons/calendar.png"
      buttonImageOnly: true
      showButtonPanel: true
      changeMonth: true
      changeYear: true
      onSelect: ->
        Unsaved()
        AddChange $("label[for='" + @id + "']").html(), $(this).val()

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
        Unsaved()
        AddChange $("#SponsorshipJ").attr("name"), "SponsorshipJ"
        $("#Sponsorship").val "J"
        $("#JointlyTextFld").removeClass "hide"
      else
        Unsaved()
        AddChange $("#SponsorshipD").attr("name"), "SponsorshipD"
        $("#Sponsorship").val "D"
        $("#JointlyTextFld").addClass "hide"
      e.preventDefault()
  pub =
    init: _init