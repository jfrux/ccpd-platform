###
*  Project: Advanced Tokenizer
*  Description: Tokenizer for our projects amongst others that saves to server side.
*  Author: Joshua F. Rountree
*  License:
###

(($, window, document) ->
  pluginName = "uiTokenizer"
  defaults =
    ajaxSearchParams: null
    ajaxAddParams: null
    showImage: true
    allowAdd: true
    allowViewMore: false
    excludeItems: []
    clearable: true
    appendTo: null
    useExistingInput: false
    clearOnSelect: false
    size: "compact"
    bucketed: false
    shownCount: 5
    watermarkText: "Type in a search term"
    width: 384
    typeaheadClass: ""
    minChars: 1
    ajaxMethod: "get"
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

  # The actual plugin constructor
  class Tokenizer
    constructor: (@element, options) ->
      # jQuery has an extend method which merges the contents of two or
      # more objects, storing the result in the first object. The first object
      # is generally empty as we don't want to alter the default options for
      # future instances of the plugin
      @options = $.extend {}, defaults, options
      @_defaults = defaults
      @_name = pluginName
      @init()

    init: ->
      # Place initialization logic here
      # You already have access to the DOM element and the options via the instance,
      # e.g., @element and @options

    yourOtherFunction: ->
      # some logic

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(@, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))

)(jQuery, window, document)
