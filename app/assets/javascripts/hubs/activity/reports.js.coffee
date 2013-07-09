###
* ACTIVITY > REPORTS
###
App.module "Activity.Reports", (Self, App, Backbone, Marionette, $) ->
  @startWithParent = false

  @on "before:start", ->
    App.logInfo "starting: #{Self.moduleName}"
    return
  @on "start", ->
    $(document).ready ->
      _init()
      App.logInfo "started: #{Self.moduleName}"
    return
  @on "stop", ->
    App.logInfo "stopped: #{Self.moduleName}"
    return

  _init =  (defaults) ->
    $reportArea = $("#js-activity-reports")
    $reportItems = $reportArea.find(".report-item")

    $reportItems.each ->
      $item = $(this)
      $itemForm = $item.find('form')
      $itemGroup = $item.parents('.report-group')
      $itemTitle = $item.find('.report-item-title')
      $itemTitle.wrapInner('<a href="javascript://"></a>')
      $itemLink = $item.find('.report-item-title > a')
      $itemCriteria = $item.find('.report-item-criteria')

      # $(document).on "click", () ->
      #   $item.removeClass('activated')
      #   return

      $itemLink.on 'click', (e) ->
        $item.siblings().removeClass('activated')
        $itemGroup.siblings().find('.report-item').removeClass('activated')
        $item.addClass('activated')
        e.preventDefault()
        return
      
      # $itemCriteria.on "click", (e) ->
      #   e.preventDefault()
      #   return
      return
    return

