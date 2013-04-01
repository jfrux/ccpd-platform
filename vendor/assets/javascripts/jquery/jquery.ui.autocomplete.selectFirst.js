/*
 * jQuery UI Autocomplete Select First Extension
 *
 * Copyright 2010, Scott González (http://scottgonzalez.com)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 *
 * http://github.com/scottgonzalez/jquery-ui-extensions
 */
(function( $ ) {

$( ".ui-autocomplete-input" ).live( "autocompleteopen", function() {
  var autocomplete = $( this ).data( "autocomplete" ),
    menu = autocomplete.menu;

  if ( !autocomplete.options.selectFirst ) {
    return;
  }
  //the requested term no longer matches the search, so drop out of this now
  if(autocomplete.term != $(this).val()){
    //console.log("mismatch! "+autocomplete.term+'|'+$(this).val());
    return;
  }
  //hack to prevent clearing of value on mismatch
  menu.options.blur = function(event,ui){return}
  menu.activate( $.Event({ type: "mouseenter" }), menu.element.children().first() );

});


}( jQuery ));