# CEAuth - Form Field: Typeahead (kind of a combobox without predefined items)
(($) ->
  debug = true
  log = ->
    App.logInfo arguments if debug
  methods =
    init: (options) ->
      settings = $.extend({}, $.uiTypeahead.defaults, options)
      @each ->
        typeahead = new $.uiTypeahead(this, settings)


    reset: ->
      $.uiTypeahead.clear this

  $.fn.uiTypeahead = (method) ->
    if methods[method]
      methods[method].apply this, Array::slice.call(arguments, 1)
    else if typeof method is "object" or not method
      methods.init.apply this, arguments
    else
      $.error "Method " + method + " does not exist on uiTypeahead"

  $.uiTypeahead = (input, settings) ->
    load_default = ->
      item_select settings.defaultValue  if settings.defaultValue
    item_focus = (item) ->
    search_resizer = ->
      items = $(".uiSearchInput ul li")
      $(curr_types).each ->
        typeItems = items.filter("." + this)
        $(typeItems).slice(0, itemsPerType - 1).show()
        $(typeItems).slice(itemsPerType).hide()

    alreadyExists = (value) ->
      doesExist = false
      $(settings.excludeItems).each ->
        if this is value
          doesExist = true
          false

      doesExist
    resize_math = ->
      totalHeight = (currTotalResults * heightEach) +
        (currTotalTypes * headerHeight) + 39
      heightEachReal = totalHeight / currTotalResults
      maxItems = $(window).height() / heightEachReal
      itemsPerType = Math.floor(maxItems / currTotalTypes)  if currTotalTypes
    item_add = (name, method) ->
      $.ajax
        url: settings.ajaxAddURL
        type: settings.ajaxAddMethod
        dataType: "json"
        async: false
        data: $.extend settings.ajaxAddParams,
          name: name
        success: (returnData) ->
          data = returnData.PAYLOAD
          data.label = data.name
          data.value = data.id
          data.ITEM_ID = data.id
          item_select data
          true

    item_select = (item) ->
      #console.log(item);
      unless item.value is 0
        unless settings.clearOnSelect
          $hiddenInput.val item.value.toString()
          $hiddenInput.keyup()
          $input.val item.label
          #$img.attr "src", item.image
          $wrap.addClass "selected"
          $hiddenInput.keyup()
          settings.onSelect item
          settings.excludeItems.push item.value
        else
          settings.onSelect item
          clear_typeahead()
      else
        if settings.allowAdd
          item_add $input.val(), settings.ajaxSearchParams.method
    item_deselect = ->
      $hiddenInput.val ""
      $input.focus()
      $wrap.removeClass "selected"
    set_image = (item) ->
      $img
    clear_typeahead = ->
      $hiddenInput.val ""
      $input.val ""
      $input.focus()
      $wrap.removeClass "selected"
    get_wikiImage = (item) ->
      $.ajax
        url: "/admin/_com/ajax/typeahead.cfc"
        type: "get"
        data:
          method: "wikipedia_image"
          q: item.label

        success: (data) ->
          $img.attr "src", $.trim(data)

    KEY =
      BACKSPACE: 8
      TAB: 9
      RETURN: 13
      ESC: 27
      LEFT: 37
      UP: 38
      RIGHT: 39
      DOWN: 40
      COMMA: 188
      ENTER: 13
      DELETE: 46

    searchTypes = 3
    resultsPerType = 4
    maxResults = searchTypes * resultsPerType
    heightEach = 68
    headerHeight = 18
    currTotalResults = 0
    currTotalTypes = 0
    curr_types = []
    maxItems = $(window).height() / heightEach
    itemsPerType = 4
    totalHeight = (currTotalResults * heightEach)+
    (currTotalTypes * headerHeight) + 39
    heightEachReal = totalHeight / maxResults
    if settings.bucketed
      $(window).resize ->
        resize_math()
        search_resizer()

    $hiddenInput = $(input).addClass("hide").focus(->
    ).blur(->
      $input.blur()
    )

    
    fieldName = $hiddenInput.attr("name")
    origWidth = $hiddenInput.width()
    $hiddenInput.has(".hide")
    $input = $("<input/>").attr(
      type: "text"
      autocomplete: "off"
      spellcheck: false
    ).addClass("inputtext textInput").click(->
      if $(this).val().length > 0 and $hiddenInput.val().length is 0
        $input.autocomplete("widget").show()
    ).blur(->
    ).keydown((event) ->
      previous_token = undefined
      next_token = undefined
      switch event.keyCode
        when KEY.LEFT,KEY.RIGHT,KEY.UP,KEY.DOWN,KEY.BACKSPACE
          item_deselect()
          break
        when KEY.TAB,KEY.RETURN,KEY.COMMA,KEY.ESC
          true
    )
    $typeahead = $("<div/>").addClass("uiTypeahead")
                            .addClass(settings.typeaheadClass)
    $wrap = $("<div/>").addClass("wrap").appendTo($typeahead)
    if settings.clearable
      $typeahead.addClass "uiClearableTypeahead"
      $clearer = $("<label/>").addClass("clear uiCloseButton").prependTo($wrap)
      $removeBtn = $("<input/>").attr(
        type: "button"
        title: "Remove"
      ).click(->
        clear_typeahead()
      ).appendTo($clearer)
    $input.appendTo $wrap
    $typeaheadView = $("<div/>")
                      .addClass("uiTypeaheadView")
                      .appendTo($typeahead)
    if $.isFunction($.fn.autocomplete)
      $input.autocomplete(
        autoFocus: true
        appendTo: ($typeaheadView)
        source: (req, add) ->
          if $.trim(req.term).length
            $.ajax
              url: settings.ajaxSearchURL
              type: settings.ajaxSearchType
              dataType: "json"
              data: $.extend({}, settings.ajaxSearchParams,
                q: req.term
              )
              success: (data) ->
                suggestions = []
                curr_type = ""
                curr_type_friendly = ""
                currTotalResults = 0
                currTotalTypes = 0
                $.each data.PAYLOAD.DATASET, (i, val) ->
                  currTotalResults++
                  unless curr_type is data.PAYLOAD.DATASET[i].TYPE
                    currTotalTypes++
                    curr_type = data.PAYLOAD.DATASET[i].TYPE
                    curr_types.push curr_type
                    switch curr_type
                      when "activity"
                        curr_type_friendly = "Activities"
                      when "entity"
                        curr_type_friendly = "Entities"
                      when "person"
                        curr_type_friendly = "People"
                      else
                        curr_type_friendly = "Other"
                    if settings.bucketed
                      anItem =
                        label: curr_type_friendly
                        value: 0
                        image: ""
                        ITEM_ID: 0
                        TEXT: curr_type_friendly
                        SUBTEXT1: ""
                        IMAGE: ""
                        classes: "header"
                        ignored: true
                        isHeader: true
                        callToAction: false

                      suggestions.push anItem
                  anItem = data.PAYLOAD.DATASET[i]
                  anItem.label = data.PAYLOAD.DATASET[i].TEXT
                  if anItem.label.length > 70
                    anItem.label = anItem.label.substr(0, 67) + "..."
                  anItem.value = data.PAYLOAD.DATASET[i].ITEM_ID
                  anItem.image = data.PAYLOAD.DATASET[i].IMAGE
                  anItem.type = data.PAYLOAD.DATASET[i].TYPE
                  anItem.link = data.PAYLOAD.DATASET[i].LINK
                  anItem.classes = data.PAYLOAD.DATASET[i].TYPE
                  anItem.callToAction = false
                  anItem.ignored = false
                  suggestions.push anItem

                if settings.allowViewMore
                  anItem =
                    label: "See more results for '#{$input.val()}'"
                    value: 0
                    image: ""
                    ITEM_ID: 0
                    TEXT: "See more results for '#{$input.val()}'"
                    SUBTEXT1: "Displaying top " +
                      data.PAYLOAD.DATASET.length +
                      " results"
                    IMAGE: ""
                    ignored: false
                    callToAction: true

                  suggestions.push anItem
                if settings.allowAdd
                  anItem =
                    label: "Add '#{$input.val()}'"
                    value: 0
                    image: ""
                    ITEM_ID: 0
                    TEXT: "Add '#{$input.val()}'"
                    IMAGE: ""
                    classes: ""
                    ignored: false
                    callToAction: true

                  suggestions.push anItem
                $(this).data "suggestions", suggestions
                add suggestions
                return


        focus: (e, ui) ->
          false

        delay: 100
        search: (e, ui) ->
          item_deselect()
          return

        select: (e, ui) ->
          #App.logInfo ui
          item_select ui.item
          false

        change: ->
          false
      )
      .data("ui-autocomplete")._renderMenu = (ul, items) ->
        that = this
        #.addClass settings.size
        #lis = $(ul)
        $.each items, (index, item) ->
          $li = that._renderItemData(ul,item)
          $li.html('')
          App.logInfo $li
          $subtext1 = $("<span></span>").addClass("fcg fsm clearfix").text(item.SUBTEXT1)
          $subtext2 = $("<span></span>").addClass("fcg fsm clearfix").text(item.SUBTEXT2)
          $label = $("<a></a>").html("<div>#{item.label}</div>").appendTo($li)
          $img = $("<img/>").attr('src',item.image).prependTo($label)

          # # if item.ignored
          # #   $label.click ->
          # #     false

          $label.append $subtext1  if item.SUBTEXT1
          $label.append $subtext2  if item.SUBTEXT2
          
          $li.addClass "ignore"  if item.ignored
          $img.remove()  if item.isHeader
          if item.callToAction
            $img.remove()
            $li.addClass "calltoaction"
          # #ul.append $li
          return

    $typeahead.insertAfter $hiddenInput
    $typeahead.prependTo settings.appendTo  if settings.appendTo
    $input.watermark settings.watermarkText  if jQuery.watermark
    load_default()
    $(this).data "hiddenInput", $hiddenInput
    $(this).data "input", $input
    $(this).data "typeahead", $input
    $(this).data "wrap", $input
    $input

  $.uiTypeahead.clear = ->
    clear_typeahead()
    return

  $.uiTypeahead.defaults =
    ajaxSearchParams: null
    ajaxAddParams: null
    ajaxAddMethod: "POST"
    showImage: true
    allowAdd: true
    allowViewMore: false
    excludeItems: []
    clearable: true
    appendTo: null
    useExistingInput: false
    clearOnSelect: false
    allowAdd: true
    size: "compact"
    bucketed: false
    shownCount: 5
    watermarkText: "Type in a search term"
    width: 384
    typeaheadClass: ""
    minChars: 1
    ajaxMethod: "POST"
    type: "token"
    tokenLimit: null
    jsonContainer: null
    method: "GET"
    contentType: "json"
    autocomplete: null
    queryParam: "q"
    onResult: null
    selectFirst: true
    autoFill: false
    defaultValue: null
    onAdd: (item) ->
      true
    onSelect: (item) ->
      true

) jQuery