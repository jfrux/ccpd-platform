;(function($){
    var debug = true;
    var methods = {
        /* INITIAL SETTINGS / HTML INJECTION */
        init : function( options ) {
            var settings = $.extend(
                                {},
                                $.uiCreditForm.defaults,
                                options
                            );
            
            return this.each(function () {
             var creditForm =  new $.uiCreditForm(this, settings);
            });
        },
		reset:function() {
			$.uiCreditForm.clear(this);
		}
    };
    /* METHOD CALLS */
    $.fn.uiCreditForm = function(method) {
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if ( typeof method === 'object' || ! method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'Method ' +  method + ' does not exist on uiCreditForm' );
		}
    };
    
    /* TYPEAHEAD - Internal core logic */
    $.uiCreditForm = function(elem,settings) {
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
		var curr_credits = [];
		
        var $form = $(elem);
		var $submitBtn = $form.find('.btnConfirm');
		
		/* SETUP EXISTING CREDIT ROWS */
		var $creditRows = $form.find('.creditRow');
		
		/* CREDIT ROW TEMPLATE */
		var creditRow
		
		$creditRows.each(function() {
			var elements = {
				$refNo: $(this).find(".creditAdderRefNo"),
				$amount:  $(this).find(".creditAdderAmt"),
				$credit:  $(this).find(".creditAdder"),
				$creditName:  $(this).find(".creditName"),
				$creditProvider:  $(this).find(".creditProvider"),
				$creditBody:  $(this).find(".creditBody")
			};
			
			var creditItem = {
				refNo: elements.$refNo.val(),
				amount: elements.$amount.val(),
				creditId: elements.$credit.val(),
				name: elements.$creditName.val(),
				providerId: elements.$creditProvider.val(),
				bodyId: elements.$creditBody.val()
			}
			
			elements.$refNo.watermark("Reference No.");
			elements.$amount.watermark("0.0");
			
			elements.$credit.uiTypeahead({
				watermarkText:'Type in name or keyword of credit type...',
				queryParam:'q',
				defaultValue:{
					value:creditItem.creditId,
					label:creditItem.name,
					image:'/static/images/no-photo/none_i.png'
				},
				allowAdd:false,
				ajaxSearchURL:"/admin/_com/ajax/typeahead.cfc",
				ajaxSearchType:"GET",
				ajaxSearchParams:{
					method:'search',
					max:4,
					type:'credits'
				},
				typeaheadClass:'lfloat',
				type:'listImage',
				onSelect:function($token,data) {
					var neededData = {
						providerId:0,
						bodyId:0,
						creditId:0,
						activityId:0
					}
					
					elements.$amount.attr({ 'name':'CreditAmount' + $token. });
				},
				onRemove:function($token,data) {
					
				}
			});
			
			creditItem.elems = elements;
			
			curr_credits.push(creditItem);
		});
		
		var $creditLink = $form
							.find('.creditAddLink')
							.click(function() {
								
							});
		
		console.log($form);
		console.log($creditRows);
		console.log($creditLink);
        
		
		function alreadyExists(value) {
			var doesExist = false;
			$(settings.excludeItems).each(function() {
				if(this == value) {
					doesExist = true;
					return false;
				}
			});
			
			return doesExist;
		}
		
		function item_add(name,method) {
			
		}
		
        function item_select(item) {
			
        }
		
		function item_deselect() {
			
		}

    }
	
	$.uiCreditForm.defaults = {
		
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