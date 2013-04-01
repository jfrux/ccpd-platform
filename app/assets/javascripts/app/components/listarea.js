// CEAuth - Form Field: Typeahead (kind of a combobox without predefined items)

;(function($){
    var debug = true;
    var methods = {
        /* INITIAL SETTINGS / HTML INJECTION */
        init : function( options ) {
            var settings = $.extend(
                                {},
                                $.uiListing.defaults,
                                options
                            );
            
            return this.each(function () {
             var listing =  new $.uiListing(this, settings);
            });
        }
    };
    /* METHOD CALLS */
    $.fn.uiListing = function(method) {
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if ( typeof method === 'object' || ! method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'Method ' +  method + ' does not exist on uiListing' );
		}
    };
    
    /* TYPEAHEAD - Internal core logic */
    $.uiListing = function(elem,settings) {
        /*log(input);
        log(settings);*/
        var KEY = {
            BACKSPACE: 8,
            TAB: 9,
            RETURN: 13,
            ESC: 27,
            LEFT: 37,
            UP: 38,
            RIGHT: 39,
            DOWN: 40,
            COMMA: 188,
            ENTER: 13,
			DELETE: 46
        };
		
    }
	
	$.uiListing.defaults = {
		ajaxUrl:null,
		ajaxParams:{},
		ajaxType:'get',
		filters:null,
		allowSearch:false,
		bucketed:true,
		bucketType:'prettydates'
	};
	
	function log() {
		if(jQuery.log) {
			$.log(arguments);
		}
	};
	
	/*var typingTimeout;
	function startTypingTimer(input_field)
	{	
		if (typingTimeout != undefined) 
			clearTimeout(typingTimeout);
		typingTimeout = setTimeout( function()
					{				
						eval(input_field.attr("onfinishinput"));
					}
		, 500);
	}*/
	


})(jQuery);