###
* PERSON > GENERAL INFORMATION
###
App.module "Person.GeneralInfo", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false

  FormState = null
  $base = null
  $form = null
  $firstName = null
  $middleName = null
  $lastName = null
  $suffix = null
  $displayName = null
  $certName = null
  $suggestionsList = null

  NameTmpls = []

  suggestionItem = _.template('<div class="item" data-suggestion="<%=suggestion%>"><a href="#"><%=suggestion%></a></div>')

  makeCertName = (str) ->
    _.template(str)

  #John Frankfort Smith, MD.
  NameTmpls.push makeCertName("<% if (firstname) { %><%= firstname %><% } %><% if (middlename) { %> <%= middlename %><% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>")

  #John F. Smith, MD.
  NameTmpls.push makeCertName("<% if (firstname) { %><%= firstname %><% } %><% if (middlename) { %> <%= middlename.substring(0,1) %>.<% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>")

  #J. Frankfort Smith, MD.
  NameTmpls.push makeCertName("<% if (firstname) { %><%= firstname.substring(0,1) %>.<% } %><% if (middlename) { %> <%= middlename %><% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>")
  
  #J. F. Smith, MD.
  NameTmpls.push makeCertName("<% if (firstname) { %><%= firstname.substring(0,1) %>.<% } %><% if (middlename) { %> <%= middlename.substring(0,1) %>.<% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>")
  
  #John Smith, MD.
  NameTmpls.push makeCertName("<% if (firstname) { %><%= firstname %><% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>")
  
  #J. Smith, MD.
  NameTmpls.push makeCertName("<% if (firstname) { %><%= firstname.substring(0,1) %>.<% } %><% if (lastname) { %> <%= lastname %><% } %><% if (suffix) { %>, <%= suffix %><% } %>")

  @on "before:start", ->
    App.logInfo "starting: Person.#{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Person.#{Self.moduleName}"
    return
  @on "stop", ->
    App.logInfo "stopped: Person.#{Self.moduleName}"
    #FormState.stop()
    FormState = null
    return

  _init = () ->
    $base = $("#js-person-detail")
    $form = $base.find('.js-formstate')
    
    $firstName = $form.find("[name='firstname']")
    $middleName = $form.find("[name='middlename']")
    $lastName = $form.find("[name='lastname']")
    $suffix = $form.find("[name='suffix']")
    $certName = $form.find("[name='certname']")
    $displayName = $form.find(".js-displayname-input")
    $suggestionsList = $form.find(".js-suggestions-list")

    $suggestionInputs = $(".js-suggest-input")

    FormState = new App.Components.FormState
      el:'#js-person-detail .js-formstate'
      saved: true

    FormState.on "beforeSave", ->
      $certName.val($displayName.val())
      return
    updateSuggestions()
    
    # TRIES TO FIND A MATCHING DISPLAYNAME OPTION FOR THE CURRENTLY SELECTED DISPLAY NAME
    $(".certname").click ->
      updateCertNameValue $(this).val()

    $("#certnamecustom").keyup ->
      updateCertNameValue $(this).val()

    # MAKES SURE THE DISPLAY NAME FIELD IS SELECTED ONTO AN OPTION
    if $(".certname").attr("checked") is false and sCertName isnt ""
      $("#certnamecustom").val sCertName
      $("#certname-7").attr "checked", true
    
    # KEEPS DISPLAYNAME OPTIONS UP TO DATE
    $suggestionInputs.on "keyup", ->
      updateSuggestions()

    return


  updateSuggestions = ->
    $suggestionsList.empty()
    context =
      'firstname':$.trim($firstName.val())
      'middlename':$.trim($middleName.val())
      'lastname':$.trim($lastName.val())
      'suffix':$.trim($suffix.val())

    suggestions = _.map(NameTmpls,(suggestion,i,newList) ->
      suggestion(context)
    )

    suggestions = _.unique(suggestions)
    
    _.each suggestions,(suggestion) ->
      $suggestion = $(suggestionItem({ 'suggestion': suggestion}))
      $suggestion.on "click", (e) ->
        suggestText = $(this).data('suggestion')
        $displayName.val(suggestText).keyup()
        e.preventDefault()
        return
      $suggestionsList.append($suggestion)

    if $.trim($displayName.val()) == "" && !_.isEmpty(suggestions)
      $displayName.val(suggestions[0])
    return

  updateCertNameValue = (sName) ->
    $("#certnamecustom").val sName
    $("#certname-7").val sName
    return
