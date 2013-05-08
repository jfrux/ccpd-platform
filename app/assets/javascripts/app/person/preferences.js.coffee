###
* PERSON > PREFERENCES
###
App.module "Person.Preferences", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
  FormState = null
  $base = null
  $specialtiesList = null
  nDegree = null
  @on "before:start", ->
    App.logInfo "starting: Person.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      $base = $("#js-person-preferences")
      _init()
      App.logInfo "started: Person.#{Self.moduleName}"
    return
  @on "stop", ->
    App.logInfo "stopped: Person.#{Self.moduleName}"
    FormState = null
    return

  @on "personSpecialties:ready", (specialties) ->
    $.each specialties, (i, item) ->
      $("#Specialty" + item.SPECIALTYID).attr "checked", true
      updateSpecialtyOption item.SPECIALTYID
    App.logDebug "person specialties displayed!"
    return

  @on "specialties:ready", (specialties) ->
    App.logDebug "specialties list is ready"
    specialtyMarkup = ' <label id="specialty-<%=SPECIALTYID%>" for="Specialty<%=SPECIALTYID%>" class="checkbox specialtyOption" data-key="<%=SPECIALTYID%>">
                          <input type="checkbox" 
                               name="Specialties" 
                               id="Specialty<%=SPECIALTYID%>" 
                               value="<%=SPECIALTYID%>" />
                          <%=NAME%>
                        </label>'

    specialtyTemplate = _.template(specialtyMarkup)
    $.each specialties, (i, item) ->
      $specialtiesList.append specialtyTemplate(item)

    getPersonSpecialties nPerson
    return

  _init = () ->
    $specialtiesList = $base.find(".js-specialties > .controls")
    
    getSpecialties()

    Self.once "personSpecialties:ready",->
      FormState = new App.Components.FormState
        el:'#js-person-preferences .js-formstate'
        saved: true
    updateDegreeOption nDegree
    
    $(".specialtyOption").on "change", ->
      nSpecialty = $.ListGetAt(@id, 2, "-")
      updateSpecialtyOption nSpecialty

    # $(".degreeid").on "click", ->
    #   nDegree = $.ListGetAt(@id, 2, "-")
    #   $.ajax 
    #     url:sRootPath + "/_com/AJAX_Person.cfc"
    #     data:
    #       method: "saveDegree"
    #       PersonID: nPerson
    #       DegreeID: nDegree
    #       returnFormat: "plain"
    #     success: (data) ->
    #       if data.STATUS
    #         updateDegreeOption nDegree
    #         addMessage data.STATUSMSG, 250, 6000, 4000
    #       else
    #         addError data.STATUSMSG, 250, 6000, 4000
    #       return
    #   return
    return
  # GATHERS PERSON SPECIALTIES
  getPersonSpecialties = (nPerson) ->
    $.ajax 
      url:sRootPath + "/_com/AJAX_person.cfc"
      dataType:'json'
      type:'get'
      data:
        method: "getPersonSpecialties"
        personId: nPerson
        returnFormat: "plain"
      success: (data) ->
        Self.trigger "personSpecialties:ready",data.PAYLOAD
        return
    return


  # GATHERS SPECIALTIES
  getSpecialties = ->
    $.ajax 
      url: sRootPath + "/_com/AJAX_activity.cfc"
      dataType:'json'
      type:'get'
      data:
        method: "getSpecialties"
        returnFormat: "plain"
      success: (data) ->
        Self.trigger "specialties:ready",data.PAYLOAD
        return
    return

  # STYLIZES THE DEGREE DIVS
  updateDegreeOption = (nId) ->
    $(".degreeOption").removeClass "formOptionSelected"
    $("#degree-" + nId).addClass "formOptionSelected"
    return

  # STYLIZES THE SPECIALTY DIVS
  updateSpecialtyOption = (nId) ->
    if $("#specialty-" + nId).is(".formOptionSelected")
      $("#specialty-" + nId).removeClass "formOptionSelected"
    else
      $("#specialty-" + nId).addClass "formOptionSelected"
    return
