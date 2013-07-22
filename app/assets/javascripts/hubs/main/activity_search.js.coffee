###
* ACTIVITY > SEARCH
###
App.module "User.ActivitySearch", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false
  Self = @
  $base = null
  @search = null

  $releaseDate = null
  $title = null
  $activityType = null
  $grouping = null

  @on "before:start", ->
    App.logInfo "starting: Activity.#{Self.moduleName}"
    return

  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: Activity.#{Self.moduleName}"
    return
    
  @on "stop", ->
    App.logInfo "stopped: Activity.#{Self.moduleName}"
    return
  
  _init =  (settings) ->
    searchSettings = settings
    Self.search = new App.Components.Search({
      el:"#js-main-activities"
    })
    $base = Self.search.$base
    $releaseDate = $base.find("#ReleaseDate")
    $title = $base.find("#Title")
    $activityType = $base.find("#ActivityTypeID")
    $grouping = $base.find("#Grouping")
    $category = $base.find("#CategoryID")

    $category.combobox()

    $releaseDate.mask "99/99/9999"
    $title.unbind "keydown"
    $title.focus()

    setActivityType parseInt($activityType.val())
    $activityType.on "change", ->
      setActivityType parseInt($(this).val())
    return
  
  setActivityType = (nActivityType) ->
    if nActivityType is 1
      console.log searchSettings.liveOptions
      $grouping.html searchSettings.liveOptions
      $grouping.attr "disabled", false
    else if nActivityType is 2
      console.log searchSettings.emOptions
      $grouping.html searchSettings.emOptions
      $grouping.attr "disabled", false
    else
      console.log searchSettings.noOptions
      $grouping.html searchSettings.noOptions
      $grouping.attr "disabled", true

  