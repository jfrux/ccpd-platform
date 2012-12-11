// CEAuth - Form Field: Tokenizer Input

;(function($){
    var debug = true;
    
    var methods = {
        /* INITIAL SETTINGS / HTML INJECTION */
        init : function( options ) {
            var settings = $.extend(
                                {},
                                $.ceaForm.defaults,
                                options
                            );
            
            return this.each(function () {
                var ceaForm = new $.ceaForm(this, settings);
            });
        }
    };
    
    /* METHOD CALLS */
	$.fn.ceaForm = function(method) {
		if ( methods[method] ) {
		  return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if ( typeof method === 'object' || ! method ) {
		  return methods.init.apply( this, arguments );
		} else {
		  $.error( 'Method ' +  method + ' does not exist on ceaForm' );
		}
	};
	
    $.ceaForm = function(form,settings) {
		
		var $form = form;
	}
	
	$.ceaForm.defaults = {
	 
	}
	
	function log() {
        if(jQuery.log) {
            $.log(arguments);
        }
    };

})(jQuery);