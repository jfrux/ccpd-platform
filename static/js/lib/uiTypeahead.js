// CEAuth - Form Field: Typeahead (kind of a combobox without predefined items)

;(function($){
    var debug = true;
    var methods = {
        /* INITIAL SETTINGS / HTML INJECTION */
        init : function( options ) {
            var settings = $.extend(
                                {},
                                $.uiTypeahead.defaults,
                                options
                            );
            
            return this.each(function () {
             var typeahead =  new $.uiTypeahead(this, settings);
            });
        },
		reset:function() {
			$.uiTypeahead.clear(this);
		}
    };
    /* METHOD CALLS */
    $.fn.uiTypeahead = function(method) {
		if ( methods[method] ) {
			return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
		} else if ( typeof method === 'object' || ! method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'Method ' +  method + ' does not exist on uiTypeahead' );
		}
    };
    
    /* TYPEAHEAD - Internal core logic */
    $.uiTypeahead = function(input,settings) {
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
		
		var searchTypes = 3
		var resultsPerType = 4;
		var maxResults = searchTypes * resultsPerType;
		var heightEach = 68;
		var headerHeight = 18;
		
		var currTotalResults = 0;
		var currTotalTypes = 0;
		var curr_types = [];
		
		var maxItems = $(window).height() / heightEach;
		var itemsPerType = 4;
		var totalHeight = (currTotalResults * heightEach)+(currTotalTypes*headerHeight)+39;
		var heightEachReal = totalHeight / maxResults;
		
		if(settings.bucketed) {
			$(window).resize(function() {
				resize_math();
				search_resizer();
			});
		}
		
        // ORIGINAL INPUT - hidden
        var $hiddenInput = $(input)
								.addClass('hide')
								.focus(function () { })
								.blur(function () { 
									$input.blur(); 
								});
        
		var fieldName = $hiddenInput.attr('name');
        var origWidth = $hiddenInput.width();
		
		if($hiddenInput.has('.hide')) {
		}
		
		// NEW INPUT ELEMENT
        var $input = $("<input/>")
						.attr({
							type:"text",
							autocomplete:"off",
							spellcheck:false
						})
                        .addClass('inputtext textInput')
                        .click(function () {
							if($(this).val().length > 0 && $hiddenInput.val().length == 0) {
								$input.autocomplete('widget').show()
							}
                        })
						.width(origWidth)
                        .blur(function () {
                            //hide_dropdown();
                        })
                        .keydown(function (event) {
                            var previous_token;
                            var next_token;
                
                            switch(event.keyCode) {
                                case KEY.LEFT:
                                case KEY.RIGHT:
                                case KEY.UP:
                                case KEY.DOWN:
                                    
                                    break;
            
                                case KEY.BACKSPACE:
									item_deselect();
                                    break;
                                case KEY.TAB:
                                case KEY.RETURN:
                                case KEY.COMMA:
                                  
                                  break;
                
                                case KEY.ESC:
                                
                                  return true;
                            }
                        });
        // TOKENIZER WRAPPER - contains all elements for this instance of the tokenizer
        var $typeahead = $('<div/>')
							.addClass('uiTypeahead')
							.addClass(settings.typeaheadClass)
							.width(origWidth);
		
		var $wrap = $('<div/>')
						.addClass('wrap')
						.appendTo($typeahead);
		
		if(settings.showImage) {
			$typeahead.addClass('imageTypeahead');	
			var $img = $("<img/>").addClass('photo img').appendTo($wrap);
		}
		
		if(settings.clearable) {
			$typeahead.addClass('uiClearableTypeahead');
			var $clearer = $('<label/>').addClass('clear uiCloseButton').prependTo($wrap);
			var $removeBtn = $('<input/>')
							.attr({ type:'button', title:'Remove' })
							.click(function() {
								clear_typeahead();
							})
							.appendTo($clearer);
		}
		
        // AUTOCOMPLETE container element
        $input.appendTo($wrap);
		
		var $typeaheadView = $('<div/>')
				.addClass('uiTypeaheadView')
				.appendTo($typeahead);
		
		
        // AUTOCOMPLETE (requires jQuery UI autocomplete widget
        if($.isFunction($.fn.autocomplete)) {
			
            $input.autocomplete({
                //define callback to format results
                selectFirst:true,
				appendTo:($typeaheadView),
                source: function(req, add){
					if($.trim(req.term).length) {
						$.ajax({
							url: settings.ajaxSearchURL,
							type:settings.ajaxSearchType,
							dataType: "json",
							data: $.extend({},
										   settings.ajaxSearchParams,
											{
											q:req.term
											}),
							success: function( data ) {
								//create array for response objects
								var suggestions = [];
								var curr_type = '';
								var curr_type_friendly = '';
								currTotalResults = 0;
								currTotalTypes = 0;
								//process response
								$.each(data.PAYLOAD.DATASET, function(i, val){
									currTotalResults++;
									if(curr_type != data.PAYLOAD.DATASET[i].TYPE) {
										//new type
										currTotalTypes++;
										curr_type = data.PAYLOAD.DATASET[i].TYPE;
										curr_types.push(curr_type);
										//friendly names
										switch(curr_type) {
											case 'activity':
												curr_type_friendly = 'Activities';
											break;
											case 'entity':
												curr_type_friendly = 'Entities';
											break;
											case 'person':
												curr_type_friendly = 'People';
											break;
											default:
												curr_type_friendly = 'Other';
										}
										
										if(settings.bucketed) {
											anItem = {
												label:curr_type_friendly,
												value:0,
												image:'',
												ITEM_ID:0,
												TEXT:curr_type_friendly,
												SUBTEXT1:'',
												IMAGE: '',
												classes:'header',
												ignored:true,
												isHeader:true,
												callToAction:false
											}
											suggestions.push(anItem);
										}
									}
									var anItem = data.PAYLOAD.DATASET[i];
									anItem.label = data.PAYLOAD.DATASET[i].TEXT;
									
									if(anItem.label.length > 70) {
										anItem.label = anItem.label.substr(0,67) + '...';	
									}
									
									anItem.value = data.PAYLOAD.DATASET[i].ITEM_ID;
									anItem.image = data.PAYLOAD.DATASET[i].IMAGE;
									anItem.type = data.PAYLOAD.DATASET[i].TYPE;
									anItem.link = data.PAYLOAD.DATASET[i].LINK;
									anItem.classes = data.PAYLOAD.DATASET[i].TYPE;
									anItem.callToAction = false;
									anItem.ignored = false;
									suggestions.push(anItem);
								});
								
								if(settings.allowViewMore) {
									anItem = {
										label:'See more results for &quot;' + $input.val() + '&quot;',
										value:0,
										image:'',
										ITEM_ID:0,
										TEXT:'See more results for &quot;' + $input.val() + '&quot;',
										SUBTEXT1:'Displaying top ' + data.PAYLOAD.DATASET.length + ' results',
										IMAGE: '',
										ignored:false,
										callToAction:true
									}
									
									suggestions.push(anItem);
								}
								
								if(settings.allowAdd) {
									anItem = {
										label:'Add &quot;' + $input.val() + '&quot;',
										value:0,
										image:'',
										ITEM_ID:0,
										TEXT:'Add &quot;' + $input.val() + '&quot;',
										IMAGE: '',
										classes:'',
										ignored:false,
										callToAction:true
									}
									suggestions.push(anItem);
								}
															
								$(this).data('suggestions',suggestions);
								//pass array to callback
								add(suggestions);
							}
						});
					}
                },
				focus:function(e,ui) {
					return false;
				},
                delay:100,
				search:function(e,ui) {
					item_deselect();
					//console.log(suggestions);
					//startTypingTimer($input);
				},
                //define select handler
                select: function(e, ui) {
					item_select(ui.item);
					return false;
                },
                
                //define select handler
                change: function() {
                    //prevent 'to' field being updated and correct position
                    //$input.val("").css("top", 2);
					
					return false;
                }
            }).data( "autocomplete" )._renderMenu = function( ul, items ) {
				$(ul).addClass(settings.size);
				
				
				if(settings.bucketed) {
					resize_math();
				}
				
				$.each(items,function(index,item) {
					var subtext1 = $("<span/>").addClass('fcg fsm clearfix').text(item.SUBTEXT1);
					var subtext2 = $("<span/>").addClass('fcg fsm clearfix').text(item.SUBTEXT2);
					
					var li = $( "<li></li>" )
						.data( "item.autocomplete", item )
						.appendTo( ul );
					
					var label = $("<a></a>")
								.html("<div>" + item.label + "</div>")
								.appendTo(li);
						
					var img = $("<img/>")
									.attr({ src:item.image })
									.prependTo(label);
					
					if(item.ignored) {
						label.click(function() {
						//disable click
						 return false;
						 });
					}
				
					if(item.SUBTEXT1) {
						label.append(subtext1);	
					}
					
					if(item.SUBTEXT2) {
						label.append(subtext2);	
					}
					
					if(item.classes) {
						li.addClass(item.classes);
					}
					
					if(item.ignored) {
						li.addClass('ignore');
					}
					
					if(item.isHeader) {
						img.remove();
					}
					
					if(item.callToAction) {
						img.remove();
						li.addClass('calltoaction');
					}
				});
				
				if(settings.bucketed) {
				search_resizer();
				}
			};
            
            //log("autocomplete plugin is installed.");
        }
        
        // INJECT ALL OF THE HTML INTO THE PAGE
        $typeahead.insertAfter($hiddenInput);
        
		if(settings.appendTo) {
			$typeahead.prependTo(settings.appendTo);	
		}
		
        // if you want to use watermarkText then JQUERY.WATERMARK PLUGIN NEEDED
        if(jQuery.watermark) {
            //log("watermark plugin is installed.");
            $input.watermark(settings.watermarkText);
        }
        
        load_default();
        
		function load_default() {
			if(settings.defaultValue) {
				item_select(settings.defaultValue);
			}
		}
        
		function item_focus(item) {
			
		}
		
		function search_resizer() {
			var items = $('.uiSearchInput ul li');
			//console.log(items);
			$(curr_types).each(function() {
				var typeItems = items.filter('.' + this);
				//console.log(typeItems);
				$(typeItems).slice(0,itemsPerType-1).show()
				$(typeItems).slice(itemsPerType).hide();
				//console.log($(typeItems).slice(itemsPerType));
			});
		}
		
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
		
		function resize_math() {
			totalHeight = (currTotalResults * heightEach)+(currTotalTypes*headerHeight)+39;
			heightEachReal = totalHeight / currTotalResults;
			maxItems = $(window).height() / heightEachReal;
			if(currTotalTypes) {
				itemsPerType = Math.floor(maxItems / currTotalTypes);
			}	
		}
		
		function item_add(name,method) {
			$.ajax({
				url: settings.ajaxAddURL,
				type:settings.ajaxAddType,
				dataType: "json",
				async:false,
				data: $.extend(settings.ajaxAddParams,{ 'name':name}),
				success: function( returnData ) {
					var data = returnData.PAYLOAD;
					
					data.label = data.TEXT;
					data.value = data.ITEM_ID;
					//data.image = "/static/images/no-photo/" +  + "_i.png";
					
					//settings.onAdd(item);
					
					item_select(data);
					
					return true;
				}
			});
		}
		
        function item_select(item) {
			if(!(item.value == 0))  {
				if(!settings.clearOnSelect) {
					$hiddenInput.val(item.value.toString());
					$hiddenInput.keyup();
					$input.val(item.label);
					$img.attr('src',item.image);
					$wrap.addClass('selected');
					$hiddenInput.keyup();
					
					settings.onSelect(item);
					
					settings.excludeItems.push(item.value);
				} else {
					settings.onSelect(item);
					clear_typeahead();
				}
			} else {
				if(settings.allowAdd) {
					item_add($input.val(),settings.ajaxSearchParams.method);
				}
			}
        }
		
		function item_deselect() {
			$hiddenInput.val('');
			$input.focus();
			$wrap.removeClass('selected');
		}
		
		function set_image(item) {
			$img
		}
		
		function clear_typeahead() {
			$hiddenInput.val('');
			$input.val('');
			$input.focus();
			$wrap.removeClass('selected');
		}
		
		function get_wikiImage(item) {
			$.ajax({
			   url:'/admin/_com/ajax/typeahead.cfc',
			   type:'get',
			   data:{
				   method: 'wikipedia_image',
				   q:item.label
			   },
			   success:function(data) {
					$img.attr('src',$.trim(data));
			   }
		   });
		}
		
        $(this).data('hiddenInput',$hiddenInput);
        $(this).data('input',$input);
        $(this).data('typeahead',$input);
        $(this).data('wrap',$input);
		
		return $input;
    }
	
	$.uiTypeahead.clear = function() {
		
	}
	
	$.uiTypeahead.defaults = {
		ajaxSearchParams:null,
		ajaxAddParams:null,
		showImage: true,
		allowAdd: true,
		allowViewMore: false,
		excludeItems: [],
		clearable:true,
		appendTo:null,
		useExistingInput:false,
		clearOnSelect:false,
		allowAdd:true,
		size:'compact',
		bucketed:false,
		shownCount: 5,
		watermarkText: "Type in a search term",
		width: 384,
		typeaheadClass:'',
		minChars: 1,
		ajaxMethod:'get',
		type:'token',
		tokenLimit: null,
		jsonContainer: null,
		method: "GET",
		contentType: "json",
		autocomplete:null,
		queryParam: "q",
		onResult: null,
		selectFirst: true,
		autoFill: false,
		defaultValue:null,
		onAdd:function(item) { return true; },
		onSelect:function(item) { return true; }
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