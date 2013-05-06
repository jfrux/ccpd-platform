###
* PERSON > ADDRESSES
###
App.module "Person.Emails", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
  $base = null
  $ahahContainer = null
  $ahahLoading = null
  $addBox = null
  $addForm = null
  $emailField = null
  $cancelLink = null
  $saveLink = null

  nId = 0
  currElem = null

  @on "before:start", ->
    App.logInfo "starting: Person.#{Self.moduleName}"
    return

  @on "start", ->
    $(document).ready ->
      $base = $("#js-person-email")
      _init()
      App.logInfo "started: Person.#{Self.moduleName}"
    return
  
  @on "stop", ->
    $base.empty().remove()
    App.logInfo "stopped: Person.#{Self.moduleName}"
    return
  
  @on "ahah:ready", (markup) ->
    $ahahContainer.html markup
    $ahahLoading.hide()

    $(".view-row").each ->
      $row = $(this)
      email_id = $row.data('key')
      $tooltips = $row.find('[data-tooltip-title]')
      $delete = $row.find(".delete-link")
      $verify = $row.find(".isverified-link")
      $primary = $row.find(".makeprimary-link")
      $login = $row.find(".allowlogin-link")

      $delete.on "click", ->
        deleteFunc email_id,$row
        return

      $primary.on "click", ->
        setPrimaryEmail email_id
        return

      $verify.on "click", ->
        verifyFunc email_id
        return

      $login.on "click", ->
        action = $(this).data('button-action')
        if action == 'enable'
          theVal = 1
        else
          theVal = 0
        allowLoginFunc email_id, theVal

        return

      # TOOLTIPS
      $tooltips.tooltip
        placement: 'top'
        html: 'true'
        trigger: 'hover focus'
        title: (e)->
          $(this).attr('data-tooltip-title')
        container: $ahahContainer

      $row.hover ->
        $(this).addClass('hovered')
      , ->
        $(this).removeClass('hovered')

  _init = () ->
    $ahahContainer = $base.find("#EmailContainer")
    $ahahLoading = $base.find("#EmailLoading")
    
    $addBox = $base.find('.js-email-add')
    $addForm = $base.find('form')
    $emailField = $addForm.find('.email_address')
    $cancelLink = $addForm.find(".cancel-link")
    $saveLink = $addForm.find(".save-link")
    $addLink = $base.find('#addEmailAddress')
    
    $cancelLink.click ->
      $emailField.val('')
      $addBox.hide()
      return

    $addForm.submit (e) ->
      $addForm.ajaxSubmit
        type: "post"
        dataType: "json"
        success: (data) ->
          if data.STATUS
            addMessage data.STATUSMSG, 250, 6000, 4000
            currElem = ""
            refresh()
          else
            if data.ERRORS.length > 0
              $.each data.ERRORS, (i, item) ->
                addError item.MESSAGE, 250, 6000, 4000

            else
              addError data.STATUSMSG, 250, 6000, 4000
          return
      false

    refresh()

    $addLink.click ->
      addEmail()

    # $("input,select").live "keyup", (e) ->
    #   saveFunc currElem  if e.keyCode is 13
    #   false
    return

  addEmail = ->
    $addBox.show()
    $emailField.focus()

  deleteFunc = (email_id,$row) ->
    emailId = email_id
    $viewRow = $row
    emailAddress = $viewRow.find(".email-address").text()
    if confirm("Are you sure you want to delete the email address '" + emailAddress + "'?  It will be permanently removed from the database.")
      unless emailId is 0
        $.ajax
          url: sRootPath + "/_com/ajax_person.cfc"
          type: "post"
          data:
            method: "deleteEmail"
            person_id: nPerson
            email_id: emailId
            returnFormat: "plain"

          dataType: "json"
          success: (data) ->
            if data.STATUS
              addMessage data.STATUSMSG, 250, 6000, 4000
              refresh()
            else
              if data.ERRORS.length > 0
                $.each data.ERRORS, (i, item) ->
                  addError item.MESSAGE, 250, 6000, 4000

              else
                addError data.STATUSMSG, 250, 6000, 4000

        $row.remove()

  setPrimaryEmail = (email_id) ->
    emailId = email_id
    $.ajax
      url: sRootPath + "/_com/ajax_person.cfc"
      type: "post"
      data:
        method: "setPrimaryEmail"
        email_id: emailId
        person_id: nPerson
        returnFormat: "plain"

      dataType: "json"
      success: (data) ->
        if data.STATUS
          addMessage data.STATUSMSG, 250, 6000, 4000
          refresh()
        else
          addError data.STATUSMSG, 250, 6000, 4000

  refresh = Self.refresh = ->
    $.ajax
      url:sMyself + "Person.EmailAHAH"
      type:'get'
      dataType:'html'
      data:
        PersonID: nPerson
      success: (data) ->
        Self.trigger "ahah:ready",data

  allowLoginFunc = (email_id,value) ->
    emailId = email_id
    $.ajax
      url: sRootPath + "/_com/ajax_person.cfc"
      type: "post"
      data:
        method: "setAllowLogin"
        email_id: emailId
        value: value
        returnFormat: "plain"

      dataType: "json"
      success: (data) ->
        if data.STATUS
          refresh()
          addMessage data.STATUSMSG, 250, 6000, 4000
        else
          addError data.STATUSMSG, 250, 6000, 4000
    return

  verifyFunc = (email_id) ->
    emailId = email_id
    $.ajax
      url: sRootPath + "/_com/ajax_person.cfc"
      type: "post"
      data:
        method: "sendVerificationEmail"
        email_id: emailId
        returnFormat: "plain"

      dataType: "json"
      success: (data) ->
        if data.STATUS
          addMessage data.STATUSMSG, 250, 6000, 4000
        else
          addError data.STATUSMSG, 250, 6000, 4000
    return
  return