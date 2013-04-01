###
* ACTIVITY > FOLDERS
###
App.activity.folders = do (activity = App.activity,{App,$,Backbone} = window) ->
  _init = (defaults) ->
    console.log "init: folders"

    $(".js-tokenizer-list").uiTokenizer
      listLocation: "top"
      type: "list"
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
      defaultValue: defaults

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
      #updateContainers();
      #updateActions();
      else addError statusMsg, 250, 6000, 4000  if status is "Fail"



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
          updateContainers()
          updateActions()
          addMessage data.STATUSMSG, 250, 6000, 4000
          $("#CatRow" + CatID).remove()
          $("#CatAdder").val ""
        else
          addMessage data.STATUSMSG, 250, 6000, 4000

  pub =
    init: _init