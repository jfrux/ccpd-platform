###
* ACTIVITY > GENERAL INFORMATION
###
ce.activity.general = do ($) ->
  updateStateProvince = (countryId) ->
    if countryId is 230
      $(".stateField").show()
      $(".provinceField").hide()
    else
      $(".stateField").hide().css display: "none"
      $(".provinceField").show()
  setSessionType = (sSessionType) ->
    if sSessionType is "M"
      $(".Sessions").fadeIn()
      $(".SingleSession").fadeOut()
    else
      $(".Sessions").fadeOut()
      $(".SingleSession").fadeIn()
  setActivityType = (nActivity) ->
    if nActivity is 1
      $("#Grouping").html LiveOptions
      $("#Groupings").fadeIn()
      $(".Location").fadeIn()
    else if nActivity is 2
      $("#Groupings").fadeIn()
      $("#Grouping").html EMOptions
    else
      $("#Groupings").fadeOut()
      $("#Grouping").html ""
      $(".Location").fadeOut()
    updateStateProvince $("#Country").val()

  _init = ->
    updateStateProvince $("#Country").val()
    $("#Country").bind "change", this, ->
      updateStateProvince $(this).val()

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

    $("#Title").autocomplete sRootPath + "/_com/AJAX_Activity.cfc?method=AutoComplete&returnformat=plain"
    $("#Sponsor").autocomplete sRootPath + "/_com/AJAX_Activity.cfc?method=JointlyAutoComplete&returnformat=plain"
    $("#ActivityType").bind "change", this, ->
      setActivityType $(this).val()

    $("#SessionType").change ->
      setSessionType $(this).val()

    if nActivityType
      $("#ActivityType").val nActivityType
      setActivityType $("#ActivityType").val()
      $("#Grouping").val nGrouping  if nGrouping
    if sSessionType
      $("#SessionType").val sSessionType
      setSessionType $("#SessionType").val()
    
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