defineVars = (oRecord) ->
  oPerson = new Object()
  oPerson.oLink = $(oRecord)
  oPerson.oPersonRow = oPerson.oLink.parents(".AllAttendees")
  oPerson.nAttendee = oPerson.oPersonRow.find(".personId").val()
  oPerson.nPerson = oPerson.oPersonRow.find(".personId").val()
  oPerson.nAttendee = oPerson.oPersonRow.find(".attendeeId").val()
  oPerson.sAction = oPerson.oLink.parent("li, span").attr("class").replace("-action", "")
  sPersonNameTemp = oPerson.oPersonRow.find(".PersonLink").html()
  oPerson.sPersonName = $.Trim($.ListGetAt(sPersonNameTemp, 2, ",")) + " " + $.Trim($.ListGetAt(sPersonNameTemp, 1, ","))
  oPerson

$.fn.isPerson = ->
  @each ->
    oPersonRow = $(this)
    oPersonActionMenu = oPersonRow.find(".user-actions .action-menu button").isPersonActionMenu()


$.fn.isPersonActionLink = ->
  @each ->
    $(this).click (J) ->
      oPerson = defineVars(this)
      switch oPerson.sAction
        when "assess"
          $.post sMyself + "Activity.AttendeeDetailAHAH",
            ActivityID: nActivity
            PersonID: oPerson.nPerson
            AttendeeID: oPerson.nAttendee
          , (data) ->
            $("#PersonDetailContent").html data

          # custom top position 
          # custom left position
          # some expose tweaks suitable for facebox-looking dialogs
          # you might also consider a "transparent" color for the mask 
          # load mask a little faster
          # highly transparent 
          # disable this for modal dialog-type of overlays 
          # we want to use the programming API 
          $("#PersonDetailContainer").overlay(
            top: 100
            left: 50
            expose:
              color: "#333"
              loadSpeed: 200
              opacity: 0.9

            closeOnClick: false
            onClose: ->
              updateRegistrants nId
              $("#PersonDetailContent").html ""

            api: true
          ).load()
        when "pifform"
          # REMOVED TO PREVENT PULLING UP PREVIOUS PERSON's DATA
          $.post sMyself + "Activity.AttendeeCDC",
            ActivityID: nActivity
            PersonID: oPerson.nPerson
            AttendeeID: oPerson.nAttendee
          , (data) ->
            $("#pifForm").html data

          
          # PIF DIALOG
          $("#pifDialog").dialog
            title: "PIF Form"
            modal: true
            autoOpen: false
            position: [40, 40]
            height: 450
            width: 750
            resizable: true
            dragStop: (ev, ui) ->

            buttons:
              Save: ->
                $("#frmCDC").ajaxSubmit()
                addMessage "PIF successfully updated.", 250, 6000, 4000
                $(this).dialog "close"

              Cancel: ->
                $(this).dialog "close"

            overlay:
              opacity: 0.5
              background: "black"

            close: ->
              $("#pifForm").html ""

            resizeStop: (ev, ui) ->
              $("#pifForm").css "height", ui.size.height - 73 + "px"

          
          # OPEN PIF DIALOG
          $("#pifDialog").dialog "open"
        when "eCMECert"
          $.post sMyself + "Activity.emailCert",
            ActivityID: nActivity
            PersonID: oPerson.nPerson
            AttendeeID: oPerson.nAttendee
          , (data) ->
            $("#email-cert-dialog").html data

          
          # EMAIL CERT DIALOG
          $("#email-cert-dialog").dialog
            title: "Email Certificate"
            modal: true
            autoOpen: true
            height: 300
            width: 400
            resizable: false
            overlay:
              opacity: 0.5
              background: "black"

            buttons:
              Save: ->
                $("#frmEmailCert").ajaxSubmit success: (data) ->
                  addMessage "Emailed certificate successfully.", 250, 6000, 4000

                updateActions()
                $(this).dialog "close"

              Preview: ->
                window.open "Report.CMECert?ActivityID=" + nActivity + "&ReportID=5&SelectedMembers=" + oPerson.nPerson

              Cancel: ->
                $(this).dialog "close"

            open: ->

            close: ->
              $("#email-cert-dialog").html ""
              oPerson.nPerson = ""

          
          # OPEN EMAIL CERT DIALOG
          $("#email-cert-dialog").dialog "open"
        when "pCMECert"
          window.open "Report.CMECert?ActivityID=" + nActivity + "&ReportID=5&SelectedMembers=" + oPerson.nPerson
        when "CNECert"
          window.open "Report.CNECert?ActivityID=" + nActivity + "&ReportID=6&SelectedMembers=" + oPerson.nPerson
        when "credits"
          $.post sMyself + "Activity.AdjustCredits",
            ActivityID: nActivity
            PersonID: oPerson.nPerson
            AttendeeID: oPerson.nAttendee
          , (data) ->
            $("#CreditsDialog").html data

          
          # CREDITS DIALOG
          $("#CreditsDialog").dialog
            title: "Adjust Credits"
            modal: true
            autoOpen: true
            height: 175
            width: 400
            resizable: false
            overlay:
              opacity: 0.5
              background: "black"

            buttons:
              Save: ->
                $("#formAdjustCredits").ajaxSubmit()
                addMessage "Credits successfully updated.", 250, 6000, 4000
                updateActions()
                $(this).dialog "close"

              Cancel: ->
                $(this).dialog "close"

            open: ->

            close: ->
              $("#CreditsDialog").html ""
              oPerson.nPerson = ""

          
          # OPEN CREDITS DIALOG
          $("#CreditsDialog").dialog "open"
        when "togglemd"
          if $("#MDNonMD" + oPerson.nAttendee).html() is "Yes"
            Result = "N"
          else Result = "Y"  if $("#MDNonMD" + oPerson.nAttendee).html() is "No"
          $.post sRootPath + "/_com/AJAX_Activity.cfc",
            method: "updateMDStatus"
            PersonID: oPerson.nPerson
            AttendeeID: oPerson.nAttendee
            ActivityID: nActivity
            MDNonMD: Result
            returnFormat: "plain"
          , (returnData) ->
            cleanData = $.trim(returnData)
            status = $.ListGetAt(cleanData, 1, "|")
            statusMsg = $.ListGetAt(cleanData, 2, "|")
            if status is "Success"
              addMessage statusMsg, 250, 6000, 4000
              updateActions()
              updateStats()
            else
              addError statusMsg, 250, 6000, 4000

          if $("#MDNonMD" + oPerson.nAttendee).html() is "Yes"
            $("#MDNonMD" + oPerson.nAttendee).html "No"
          else $("#MDNonMD" + oPerson.nAttendee).html "Yes"  if $("#MDNonMD" + oPerson.nAttendee).html() is "No"
        when "sendCertificate"
          if confirm("Are you sure you want to send " + oPerson.sPersonName + " a copy of their ceritificate?")
            $.ajax
              url: sRootPath + "/_com/AJAX_Activity.cfc"
              type: "post"
              data:
                method: "sendCertificate"
                activityId: nActivity
                PersonID: oPerson.nPerson
                AttendeeID: oPerson.nAttendee
                returnFormat: "plain"

              dataType: "json"
              success: (data) ->
                if data.STATUS
                  addMessage data.STATUSMSG, 250, 6000, 4000
                else
                  addError data.STATUSMSG, 250, 6000, 4000

        when "reset"
          if confirm("Are you sure you want to reset the attendee record for " + oPerson.sPersonName + "?")
            if confirm("Do you want to clear all payment information attached to current attendee record for " + oPerson.sPersonName + "?")
              resetAttendee nActivity, oPerson.nAttendee, "Y"
            else
              resetAttendee nActivity, oPerson.nAttendee, "N"
        when "remove"
          if confirm("Are you sure you would like to remove " + oPerson.sPersonName + " from this activity?")
            $.ajax
              url: sRootPath + "/_com/AJAX_Activity.cfc"
              type: "post"
              data:
                method: "removeCheckedAttendees"
                AttendeeList: oPerson.nAttendee
                ActivityID: nActivity
                returnFormat: "plain"

              dataType: "json"
              success: (data) ->
                if data.STATUS
                  $("#attendeeRow-" + oPerson.nAttendee).fadeOut "medium"
                  addMessage data.STATUSMSG, 250, 6000, 4000
                  updateActions()
                  updateStats()
                else
                  addError data.STATUSMSG, 250, 6000, 4000
                  updateRegistrants nId
                  updateActions()
                  updateStats()

      J.preventDefault()



$.fn.isPersonActionMenu = ->
  $actionMenu = $("#action_menu")
  @one "click", ->
    oPerson = defineVars(this)
    sMenuHTML = $actionMenu.html()
    
    # REPLACE VARIABLES 
    sMenuHTML = $.Replace(sMenuHTML, "{personid}", oPerson.nPerson, "ALL") #PersonID
    sMenuHTML = $.Replace(sMenuHTML, "{activityid}", nActivity, "ALL") #ActivityID
    $("body").click()
    oPerson.oLink.addClass("clicked").after sMenuHTML
    oPerson.oLink.siblings("ul").find("a").find("span").html(oPerson.sPersonName).end().isPersonActionLink()
    $("html").one "click", ->
      oPerson.oLink.removeClass("clicked").blur().siblings("ul").remove().end().isPersonActionMenu()
      false

    false
