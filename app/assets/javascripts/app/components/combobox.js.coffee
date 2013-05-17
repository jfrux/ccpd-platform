$.widget "custom.combobox",
  _create: ->
    @wrapper = $("<span>").addClass("").insertAfter(@element)
    @element.hide()
    @_createAutocomplete()
    @_createShowAllButton()

  _createAutocomplete: ->
    selected = @element.children(":selected")
    value = (if selected.val() then selected.text() else "")
    @input = $("<input>").appendTo(@wrapper).val(value).attr("placeholder", "Type a Folder").addClass("input-block-level ui-widget ui-widget-content ui-state-default").autocomplete(
      delay: 0
      autoFocus: true
      minLength: 0
      source: $.proxy(this, "_source")
    ).tooltip(tooltipClass: "ui-state-highlight")
    @_on @input,
      autocompleteselect: (event, ui) ->
        ui.item.option.selected = true
        @_trigger "select", event,
          item: ui.item.option


      autocompletechange: "_removeIfInvalid"


  _createShowAllButton: ->
    input = @input
    wasOpen = false
    $("<a>").attr("tabIndex", -1).attr("title", "Show All Items").tooltip().appendTo(@wrapper).button(
      icons:
        primary: "ui-icon-triangle-1-s"

      text: false
    ).removeClass("ui-corner-all").addClass("custom-combobox-toggle ui-corner-right").mousedown(->
      wasOpen = input.autocomplete("widget").is(":visible")
    ).click ->
      input.focus()
      
      # Close if already visible
      return  if wasOpen
      
      # Pass empty string as value to search for, displaying all results
      input.autocomplete "search", ""


  _source: (request, response) ->
    matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i")
    response @element.children("option").map(->
      text = $(this).text()
      if @value and (not request.term or matcher.test(text))
        label: text
        value: text
        option: this
    )

  _removeIfInvalid: (event, ui) ->
    
    # Selected an item, nothing to do
    return  if ui.item
    
    # Search for a match (case-insensitive)
    value = @input.val()
    valueLowerCase = value.toLowerCase()
    valid = false
    @element.children("option").each ->
      if $(this).text().toLowerCase() is valueLowerCase
        @selected = valid = true
        false

    
    # Found a match, nothing to do
    return  if valid
    
    # Remove invalid value
    @input.val("").attr("title", value + " didn't match any item").tooltip "open"
    @element.val ""
    @_delay (->
      @input.tooltip("close").attr "title", ""
    ), 2500
    @input.data("ui-autocomplete").term = ""

  _destroy: ->
    @wrapper.remove()
    @element.show()