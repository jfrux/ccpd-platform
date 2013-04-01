###
*  Project: Advanced Tokenizer
*  Description: Tokenizer for our projects amongst others that saves to server side.
*  Author: Joshua F. Rountree
*  License:
###

(($, window, document) ->
  debug = true
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

  
)(jQuery, window, document)
