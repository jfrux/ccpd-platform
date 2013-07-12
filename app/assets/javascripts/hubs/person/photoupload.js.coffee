###
* PERSON > PHOTOUPLOAD
###
App.module "Person.PhotoUpload", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  
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
    return

  _init = () ->
    $uploadField = $('.js-upload-field')
    $uploadForm = $('.js-upload-form')
    $uploadObj = $('.profile-picture')

    $uploadField.on 'change', (e) ->
        e.preventDefault

        $uploadForm.ajaxSubmit(
            url: '/admin/_com/ajax_person.cfc?method=saveprimaryphoto&PersonID=' + App.Person.model.get('id')
            target: '.profile-photo .photo-container'
            dataType: 'json'
            beforeSubmit: (formData, jqForm, options) ->
                queryString = $.param formData

                # ADD FADE CLASS TO IMAGE
                $uploadObj.addClass 'faded'

                # RESET PROGRESS BAR
                # $uploadProgressStats.text('0MB / 0MB');
                # $uploadProgressBar.css('width', '0%');

                # REVEAL PROGRESS BAR
                #$uploadProgressContainer.removeClass('visuallyhidden');

                return true;
            uploadProgress: (e, pos, tot, perc) ->
              console.log 'testing'
                # UPDATE PERCENTAGE BAR
                #$uploadProgressBar.css('width', perc + '%');

                # UPDATE NUMBERS
                #$uploadProgressStats.text(getReadableFileSizeString(pos) + ' / ' + getReadableFileSizeString(tot));
            success: (data) ->
              # REMOVE FADE CLASS TO IMAGE
              $uploadObj.removeClass 'faded'

              # HIDE PROGRESS BAR
              #$uploadProgressContainer.addClass('visuallyhidden');

              if data.STATUS
                addMessage data.STATUSMSG, 250, 6000, 4000
                $uploadObj.css 'background-image', 'url("' + data.DATASET.path + data.DATASET.hash + '.jpg")'
            error: (data) ->
                #$uploadProgressContainer.addClass('visuallyhidden');

                # REMOVE FADE CLASS TO IMAGE
                $uploadObj.removeClass 'faded'
            reset: true
        );
    return

  