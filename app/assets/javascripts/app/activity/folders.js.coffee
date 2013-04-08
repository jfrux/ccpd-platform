###
* ACTIVITY > FOLDERS
###
App.module "Activity.Folders", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = true
  
  $containersBox = null

  @on "before:start", ->
    console.log "starting: #{Self.moduleName}"
    return
  @on "start", (defaultFolders) ->
    $(document).ready ->
      _init(defaultFolders)
      console.log "started: #{Self.moduleName}"
    return
  @on "stop", ->
    console.log "stopped: #{Self.moduleName}"
    return

  refresh = Self.refresh = (callback) ->
    cb = callback
    $.post sMyself + "Activity.Container",
      ActivityID: nActivity
    , (data) ->
      $containersBox.html data
      cb(true)

  _init = (defaults) ->
    $containersBox = $("#Containers")
    refresh ->
      $(".js-tokenizer-list").uiTokenizer
        listLocation: "top"
        type: "list"
        showImage:false
        watermarkText: "Type to Add Folder"
        ajaxAddURL: "/admin/_com/AJAX_Activity.cfc"
        ajaxAddParams:
          method: "createCategory"
        ajaxSearchURL: "/admin/_com/ajax/typeahead.cfc"
        ajaxSearchParams:
          method: "search"
          type: "folders"
        onSelect: (i, e) ->
          saveActCat e
          true
        onAdd: (i, e) ->
          #createNewCat(e);
          true
        onRemove: (i, e) ->
          removeCat e
          true
        defaultValue: App.Activity.data.folders
    return

  saveActCat = (oCategory) ->
    $.post sRootPath + "/_com/AJAX_Activity.cfc",
      method: "saveCategory"
      ActivityID: nActivity
      CategoryID: oCategory.value
      returnFormat: "plain"
    , (data) ->
      cleanData = $.trim(data)
      status = $.ListGetAt(cleanData, 1, "|")
      statusMsg = $.ListGetAt(cleanData, 2, "|")
      if status is "Success"
        addMessage statusMsg, 250, 6000, 4000
      
      #$("#Containers").html("");
      #refresh();
      #updateActions();
      else addError statusMsg, 250, 6000, 4000  if status is "Fail"
    return


  #$("#CatAdder").val("");
  createNewCat = (oCategory) ->
    CatTitle = prompt("Container Name:", "")
    if CatTitle
      $.post sRootPath + "/_com/AJAX_Activity.cfc",
        method: "createCategory"
        Name: CatTitle
        ReturnFormat: "plain"
      , (data) ->
        if data.STATUS
          #$("#CatAdder").addOption data.DATASET[0].CATEGORYID, CatTitle
          #$("#CatAdder").val data.DATASET[0].CATEGORYID
          saveActCat oCategory
        else
          addError statusMsg, 250, 6000, 4000
    return

  removeCat = (oCategory) ->
    # console.log "removing category:"
    # console.log oCategory
    CatID = oCategory.value
    CatName = oCategory.label
    if confirm("Are you sure you want to remove the activity from the container '" + CatName + "'?")
      $.post sRootPath + "/_com/AJAX_Activity.cfc",
        method: "deleteCategory"
        ActivityID: nActivity
        CategoryID: CatID
        returnFormat: "plain"
      , (data) ->
        if data.STATUS
          #refresh()
          #updateActions()
          addMessage data.STATUSMSG, 250, 6000, 4000
          $("#CatRow" + CatID).remove()
          $("#CatAdder").val ""
        else
          addMessage data.STATUSMSG, 250, 6000, 4000
    return